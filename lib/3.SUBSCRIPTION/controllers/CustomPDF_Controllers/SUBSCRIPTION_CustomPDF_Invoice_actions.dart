import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/constants/CustomPDF_constants/SUBSCRIPTION_CustomPDF_invoice_constants.dart';
// import 'package:ssipl_billing/models/entities/SUBSCRIPTION/CustomPDF_entities/CustomPDF_Site_entities.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/CustomPDF_entities/CustomPDF_invoice_entities.dart';

import '../../../UTILS-/helpers/support_functions.dart';

class SUBSCRIPTION_CustomPDF_InvoiceController extends GetxController {
  var pdfModel = SUBSCRIPTION_CustomPDF_InvoiceModel().obs;
  void intAll() {
    initializeTextControllers();
    initializeCheckboxes();
    add_Note();
    finalCalc();
  }

  void initializeCheckboxes() {
    pdfModel.value.checkboxValues.assignAll(List.generate(pdfModel.value.manualInvoicesites.length, (index) => false));
  }

  void validate() {
    pdfModel.value.allData_key.value.currentState?.validate();
  }

  void add_Note() {
    pdfModel.value.notecontent.add(""); // Add empty note
    pdfModel.value.noteControllers.add(TextEditingController()); // Add controller
    pdfModel.refresh();
  }

  void toggleCCemailvisibility(bool value) {
    pdfModel.value.CCemailToggle.value = value;
  }

  void setpdfLoading(bool value) {
    pdfModel.value.ispdfLoading.value = value;
  }

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        // File exceeds 2 MB size limit
        if (kDebugMode) {
          print('Selected file exceeds 2MB in size.');
        }
        // Show Alert Dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Selected file exceeds 2MB in size.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        // invoiceModel.pickedFile.value = null;
        pdfModel.value.genearatedPDF.value = null;
      } else {
        // invoiceModel.pickedFile.value = result;
        pdfModel.value.genearatedPDF.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  // Toggle loading state
  void setLoading(bool value) {
    pdfModel.value.isLoading.value = value;
  }

  Future<void> startProgress() async {
    setLoading(true);
    pdfModel.value.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      pdfModel.value.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  void initializeTextControllers() {
    pdfModel.value.textControllers.assignAll(
      pdfModel.value.manualInvoicesites.map((site) {
        return [
          TextEditingController(text: 1.toString()), // S.No is read-only
          TextEditingController(text: site.siteName),
          TextEditingController(text: site.address),
          TextEditingController(text: site.siteID),
          TextEditingController(text: site.monthlyCharges.toString()), // Total is read-only
        ];
      }).toList(),
    );
  }

  void update_noteCotent(value, index) {
    pdfModel.value.notecontent[index] = value;
  }

  void deleteNote(int index) {
    pdfModel.value.noteControllers.removeAt(index);
    pdfModel.value.notecontent.removeAt(index);
    pdfModel.refresh();
  }

  void updateCell(int rowIndex, int colIndex, dynamic value) {
    final site = pdfModel.value.manualInvoicesites[rowIndex];

    // Allow only numeric values for specific columns
    if ([0, 2, 3, 4, 5].contains(colIndex) && !RegExp(r'^[0-9]*$').hasMatch(value)) {
      return;
    }

    switch (colIndex) {
      case 0:
        site.serialNo = value;
        break;
      case 1:
        site.siteID = value;
        break;
      case 2:
        site.siteName = value;
        break;
      case 3:
        site.address = value;
        break;
      case 4:
        site.monthlyCharges = value.isNotEmpty ? int.parse(value) : 0;
        break;
    }

    if (colIndex == 4) {
      calculateTotal(rowIndex);
    }

    pdfModel.refresh();
  }

  void calculateTotal(int rowIndex) {
    final site = pdfModel.value.manualInvoicesites[rowIndex];

    final newTotal = site.monthlyCharges;

    site.monthlyCharges = newTotal;
    pdfModel.value.textControllers[rowIndex][4].text = newTotal.toString();
    finalCalc();
    pdfModel.refresh();
  }

  int fetch_messageType() {
    if (pdfModel.value.whatsapp_selectionStatus.value && pdfModel.value.gmail_selectionStatus.value) return 3;
    if (pdfModel.value.whatsapp_selectionStatus.value) return 1;
    if (pdfModel.value.gmail_selectionStatus.value) return 2;

    return 0;
  }

  void finalCalc() {
    double addedSubTotal = 0.0;
    double addedCGST = 0.0;
    double addedSGST = 0.0;
    double addedRoundoff = 0.0;

    for (var site in pdfModel.value.manualInvoicesites) {
      double subTotal = double.tryParse(site.monthlyCharges.toString()) ?? 0.0;
      double price = double.tryParse(site.monthlyCharges.toString()) ?? 0.0;
      double gst = double.tryParse('18') ?? 0.0;
      double cgst = (price / 100) * gst / 2;
      double sgst = (price / 100) * gst / 2;

      addedCGST += cgst;
      addedSGST += sgst;
      addedSubTotal += subTotal;
    }
    addedRoundoff = addedSubTotal + addedCGST + addedSGST;

    pdfModel.value.subTotal.value.text = addedSubTotal.toStringAsFixed(2);
    pdfModel.value.CGST.value.text = addedCGST.toStringAsFixed(2);
    pdfModel.value.SGST.value.text = addedSGST.toStringAsFixed(2);
    pdfModel.value.roundOff.value.text = formatCurrencyRoundedPaisa(addedRoundoff);
    pdfModel.value.roundoffDiff.value = calculateFormattedDifference(addedRoundoff);
    pdfModel.value.Total.value.text = formatCurrencyRoundedPaisa(addedRoundoff);

    pdfModel.refresh();
  }

  void deleteRow() {
    for (int i = pdfModel.value.checkboxValues.length - 1; i >= 0; i--) {
      if (pdfModel.value.checkboxValues[i]) {
        pdfModel.value.manualInvoicesites.removeAt(i);
        pdfModel.value.textControllers.removeAt(i);
        pdfModel.value.checkboxValues.removeAt(i);
      }
    }
    finalCalc();
    pdfModel.refresh(); // Ensure UI updates
  }

  void addRow() {
    pdfModel.value.textControllers.add(
      List.generate(7, (index) => TextEditingController()),
    );

    pdfModel.value.manualInvoicesites.add(Site(siteName: 'siteName', address: 'address', siteID: 'siteID', monthlyCharges: 100));

    pdfModel.value.checkboxValues.add(false);

    pdfModel.refresh();
  }

  void resetData() {
    pdfModel.value.date.value.clear();
    pdfModel.value.manualinvoiceNo.value.clear();
    pdfModel.value.clientName.value.clear();
    pdfModel.value.clientAddress.value.clear();
    pdfModel.value.billingName.value.clear();
    pdfModel.value.billingAddres.value.clear();
    pdfModel.value.phoneNumber.value.clear();
    pdfModel.value.Email.value.clear();
    pdfModel.value.feedback.value.clear();
    pdfModel.value.filePathController.value.clear();

    pdfModel.value.subTotal.value.clear();

    pdfModel.value.CGST.value.clear();
    pdfModel.value.SGST.value.clear();
    pdfModel.value.roundOff.value.clear();
    pdfModel.value.Total.value.clear();
    pdfModel.value.roundoffDiff.value = null;

    // pdfModel.value.manualInvoice_gstTotals.clear();

    pdfModel.value.manualInvoicesites.assignAll([
      Site(siteName: 'siteName1', address: 'address1', siteID: 'siteID1', monthlyCharges: 100),
      Site(siteName: 'siteName2', address: 'address2', siteID: 'siteID2', monthlyCharges: 200),
    ]);

    pdfModel.value.notecontent.clear();
    pdfModel.value.checkboxValues.clear();
    pdfModel.value.textControllers.clear();
    pdfModel.value.genearatedPDF.value = null;

    for (var controller in pdfModel.value.noteControllers) {
      controller.clear();
    }
    pdfModel.value.noteControllers.clear();

    pdfModel.value.whatsapp_selectionStatus.value = true;
    pdfModel.value.gmail_selectionStatus.value = true;
    pdfModel.value.CCemailController.value.clear();
    pdfModel.value.progress.value = 0.0;
    pdfModel.value.isLoading.value = false;
    pdfModel.value.CCemailToggle.value = false;

    pdfModel.value.allData_key.value = GlobalKey<FormState>();
  }

  bool postDatavalidation() {
    return pdfModel.value.clientName.value.text.isNotEmpty &&
        pdfModel.value.clientAddress.value.text.isNotEmpty &&
        pdfModel.value.billingName.value.text.isNotEmpty &&
        pdfModel.value.billingAddres.value.text.isNotEmpty &&
        pdfModel.value.planname.value.text.isNotEmpty &&
        pdfModel.value.Email.value.text.isNotEmpty &&
        pdfModel.value.CCemailController.value.text.isNotEmpty &&
        pdfModel.value.phoneNumber.value.text.isNotEmpty &&
        pdfModel.value.Total.value.text.isNotEmpty &&
        pdfModel.value.manualinvoiceNo.value.text.isNotEmpty &&
        pdfModel.value.date.value.text.isNotEmpty &&
        pdfModel.value.feedback.value.text.isNotEmpty;
  }
}
