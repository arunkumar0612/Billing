import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/constants/SALES_constants/PDFcraft_constants/PDFcraft_invoice_constants.dart';
import 'package:ssipl_billing/models/entities/SALES/PDFcraft_entities/PDFcraft_Product_entities.dart';
import 'package:ssipl_billing/utils/helpers/support_functions.dart';

class PDFcraft_InvoiceController extends GetxController {
  var pdfModel = PDFcraft_InvoiceModel().obs;
  void initializeCheckboxes() {
    pdfModel.value.checkboxValues.assignAll(List.generate(pdfModel.value.manualInvoiceproducts.length, (index) => false));
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
      pdfModel.value.manualInvoiceproducts.map((product) {
        return [
          TextEditingController(text: product.sNo),
          TextEditingController(text: product.description),
          TextEditingController(text: product.hsn),
          TextEditingController(text: product.gst),
          TextEditingController(text: product.price),
          TextEditingController(text: product.quantity),
          TextEditingController(text: product.total), // Total is read-only
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

  void updateCell(int rowIndex, int colIndex, String value) {
    final product = pdfModel.value.manualInvoiceproducts[rowIndex];

    // Allow only numeric values for specific columns
    if ([0, 2, 3, 4, 5].contains(colIndex) && !RegExp(r'^[0-9]*$').hasMatch(value)) {
      return;
    }

    switch (colIndex) {
      case 0:
        product.sNo = value;
        break;
      case 1:
        product.description = value;
        break;
      case 2:
        product.hsn = value;
        break;
      case 3:
        product.gst = value;
        break;
      case 4:
        product.price = value;
        break;
      case 5:
        product.quantity = value;
        break;
    }

    if (colIndex == 4 || colIndex == 5) {
      calculateTotal(rowIndex);
    }

    pdfModel.refresh();
  }

  void calculateTotal(int rowIndex) {
    final product = pdfModel.value.manualInvoiceproducts[rowIndex];

    double price = double.tryParse(product.price) ?? 0;
    double quantity = double.tryParse(product.quantity) ?? 0;
    String newTotal = (price * quantity).toString();

    product.total = newTotal;
    pdfModel.value.textControllers[rowIndex][6].text = newTotal;
    finalCalc();
    pdfModel.refresh();
  }

  void finalCalc() {
    double addedSubTotal = 0.0;
    double addedCGST = 0.0;
    double addedSGST = 0.0;
    double addedRoundoff = 0.0;

    for (var product in pdfModel.value.manualInvoiceproducts) {
      double subTotal = double.tryParse(product.total) ?? 0.0;
      double price = double.tryParse(product.price) ?? 0.0;
      double gst = double.tryParse(product.gst) ?? 0.0;
      double cgst = (gst / 100) * price / 2;
      double sgst = (gst / 100) * price / 2;

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
        pdfModel.value.manualInvoiceproducts.removeAt(i);
        pdfModel.value.textControllers.removeAt(i);
        pdfModel.value.checkboxValues.removeAt(i);
      }
    }

    pdfModel.refresh(); // Ensure UI updates
  }

  void addRow() {
    pdfModel.value.textControllers.add(
      List.generate(7, (index) => TextEditingController()),
    );

    pdfModel.value.manualInvoiceproducts.add(PDFcraft_InvoiceProduct(
      sNo: "",
      description: "",
      hsn: "",
      gst: "",
      price: "",
      quantity: "",
      total: "0.0",
    ));

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

    pdfModel.value.manualInvoice_gstTotals.clear();

    pdfModel.value.manualInvoiceproducts.assignAll([
      PDFcraft_InvoiceProduct(sNo: "1", description: "Laptop", hsn: "8471", gst: "18", price: "1000", quantity: "2", total: "2000"),
      PDFcraft_InvoiceProduct(sNo: "2", description: "Mouse", hsn: "8472", gst: "18", price: "50", quantity: "5", total: "250"),
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
}
