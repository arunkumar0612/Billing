import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/constants/CustomPDF_constants/SUBSCRIPTION_CustomPDF_invoice_constants.dart';
// import 'package:ssipl_billing/models/entities/SUBSCRIPTION/CustomPDF_entities/CustomPDF_Site_entities.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/CustomPDF_entities/CustomPDF_invoice_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

import '../../../UTILS/helpers/support_functions.dart';

class SUBSCRIPTION_CustomPDF_InvoiceController extends GetxController {
  var pdfModel = SUBSCRIPTION_CustomPDF_InvoiceModel().obs;
  void intAll() {
    initializeTextControllers();
    initializeCheckboxes();
    add_Note();
    finalCalc();
    totalcaculationTable();
  }

  // Initialize checkboxes for each site
  /// This function initializes the checkbox values for each site in the manual Invoice sites list
  void initializeCheckboxes() {
    pdfModel.value.checkboxValues.assignAll(List.generate(pdfModel.value.manualInvoicesites.length, (index) => false));
  }

// Function to validate the form
  /// This function validates the form using the GlobalKey<FormState> stored in pdfModel
  void validate() {
    pdfModel.value.allData_key.value.currentState?.validate();
  }

// Function to add a new note
  /// This function adds a new note to the pdfModel and initializes a TextEditingController for it
  void add_Note() {
    pdfModel.value.notecontent.add(""); // Add empty note
    pdfModel.value.noteControllers.add(TextEditingController()); // Add controller
    pdfModel.refresh();
  }

// Function to toggle the visibility of the CC email field
  /// This function toggles the visibility of the CC email field based on the provided value
  void toggleCCemailvisibility(bool value) {
    pdfModel.value.CCemailToggle.value = value;
  }

// Function to set the loading state for PDF generation
  /// This function sets the loading state for PDF generation
  void setpdfLoading(bool value) {
    pdfModel.value.ispdfLoading.value = value;
  }

// Function to pick a file using the FilePicker package
  /// This function allows the user to pick a file using the FilePicker package.
  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'png',
          'jpg',
          'jpeg',
        ],
        lockParentWindow: true);
    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        // File exceeds 2 MB size limit
        if (kDebugMode) {
          print('Selected file exceeds 2MB in size.');
        }
        // Show Alert Dialog
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');
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
  /// This function sets the loading state for PDF generation.
  /// It updates the isLoading property of the pdfModel to the provided value.
  void setLoading(bool value) {
    pdfModel.value.isLoading.value = value;
  }

// Function to check if the GSTIN is valid for local GST
  /// This function checks if the provided GSTIN is valid for local GST.
  void setGSTtype(bool value) {
    pdfModel.value.isGST_local.value = value;
  }

// Function to start the progress indicator
  /// This function simulates a progress indicator by updating the progress value from 0 to 1 over a period of time.
  Future<void> startProgress() async {
    setLoading(true);
    pdfModel.value.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      pdfModel.value.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

// Function to initialize text controllers for each site
  /// This function initializes text controllers for each site in the manualInvoicesites list.
  void initializeTextControllers() {
    pdfModel.value.textControllers.assignAll(
      pdfModel.value.manualInvoicesites.asMap().entries.map((entry) {
        int index = entry.key + 1; // index starts from 1
        Site site = entry.value;

        return [
          TextEditingController(text: index.toString()), // S.No (Serial Number)
          TextEditingController(text: site.siteName),
          TextEditingController(text: site.address),
          TextEditingController(text: site.siteID),
          TextEditingController(text: site.monthlyCharges.toString()), // Monthly charges
        ];
      }).toList(),
    );
  }

// Function to update the note content at a specific index
  /// This function updates the note content at the specified index in the notecontent list.
  void update_noteCotent(value, index) {
    pdfModel.value.notecontent[index] = value;
  }

// Function to update the note controller text at a specific index
  /// This function updates the text of the note controller at the specified index.
  void deleteNote(int index) {
    pdfModel.value.noteControllers.removeAt(index);
    pdfModel.value.notecontent.removeAt(index);
    pdfModel.refresh();
  }

// Function to update a cell in the manualInvoicesites list
  /// This function updates a specific cell in the manualInvoicesites list based on the row and column index.
  void updateCell(int rowIndex, int colIndex, String value) {
    final site = pdfModel.value.manualInvoicesites[rowIndex];

    switch (colIndex) {
      case 0: // S.No
        site.serialNo = value;
        break;
      case 1: // Site ID
        site.siteID = value;
        break;
      case 2: // Site Name
        site.siteName = value;
        break;
      case 3: // Address
        site.address = value;
        break;
      case 4: // Monthly Charges
        final parsedValue = double.tryParse(value) ?? 0.0;
        site.monthlyCharges = parsedValue;
        // Don't update the controller text here to avoid cursor jumping
        break;
    }

    // Only recalculate if monthly charges changed
    if (colIndex == 4) {
      finalCalc();
      totalcaculationTable();
    }

    pdfModel.refresh();
  }

// Function to calculate the total for a specific row
  /// This function calculates the total for a specific row based on the monthly charges.
  void calculateTotal(int rowIndex) {
    final site = pdfModel.value.manualInvoicesites[rowIndex];
    final newTotal = site.monthlyCharges;
    site.monthlyCharges = newTotal;
    pdfModel.value.textControllers[rowIndex][4].text = newTotal.toString();
    finalCalc();
    totalcaculationTable();
    pdfModel.refresh();
  }

// Function to fetch the message type based on selection status
  /// This function determines the message type based on the selection status of WhatsApp and Gmail.
  int fetch_messageType() {
    if (pdfModel.value.whatsapp_selectionStatus.value && pdfModel.value.gmail_selectionStatus.value) return 3;
    if (pdfModel.value.whatsapp_selectionStatus.value) return 2;
    if (pdfModel.value.gmail_selectionStatus.value) return 1;
    return 0;
  }

// Function to format currency with rounded paisa
  /// This function formats the given amount to a currency string with rounded paisa.
  void finalCalc() {
    double addedSubTotal = 0.0;
    double addedIGST = 0.0;
    double addedCGST = 0.0;
    double addedSGST = 0.0;
    double addedRoundoff = 0.0;

    for (var product in pdfModel.value.manualInvoicesites) {
      double subTotal = double.tryParse(product.monthlyCharges.toString()) ?? 0.0;
      double price = double.tryParse(product.monthlyCharges.toString()) ?? 0.0;
      double gst = double.tryParse('18') ?? 0.0;
      double cgst = (price / 100) * gst / 2;
      double sgst = (price / 100) * gst / 2;
      double igst = (price / 100) * gst;

      addedIGST += igst;
      addedCGST += cgst;
      addedSGST += sgst;
      addedSubTotal += subTotal;
    }
    if (isGST_Local(pdfModel.value.customerGSTIN.value.text)) {
      addedRoundoff = addedSubTotal + addedCGST + addedSGST;
    } else {
      addedRoundoff = addedSubTotal + addedIGST;
    }

    pdfModel.value.subTotal.value.text = addedSubTotal.toStringAsFixed(2);
    pdfModel.value.IGST.value.text = addedIGST.toStringAsFixed(2);
    pdfModel.value.CGST.value.text = addedCGST.toStringAsFixed(2);
    pdfModel.value.SGST.value.text = addedSGST.toStringAsFixed(2);
    pdfModel.value.roundOff.value.text = formatCurrencyRoundedPaisa(addedRoundoff);
    pdfModel.value.roundoffDiff.value = calculateFormattedDifference(addedRoundoff);
    pdfModel.value.Total.value.text = formatCurrencyRoundedPaisa(addedRoundoff);
    totalcaculationTable();
    pdfModel.refresh();
  }

// Function to calculate the difference between the rounded off value and the total
  /// This function calculates the difference between the rounded off value and the total amount.
  void totalcaculationTable() {
    // Parse values with proper error handling
    final previousdues = double.tryParse(pdfModel.value.previousdues.value.text.replaceAll(',', '')) ?? 0;
    final payment = double.tryParse(pdfModel.value.payment.value.text.replaceAll(',', '')) ?? 0;
    final adjustments = double.tryParse(pdfModel.value.adjustments_deduction.value.text.replaceAll(',', '')) ?? 0;
    final currentcharges = double.tryParse(pdfModel.value.Total.value.text.replaceAll(',', '')) ?? 0;

    // Calculate total with proper rounding
    final total = (previousdues - payment + adjustments + currentcharges);

    // Format the result properly
    pdfModel.value.totaldueamount.value.text = formatCurrency(total); // Or total.toStringAsFixed(2)

    // Update UI
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
    totalcaculationTable();
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

  // void resetData() {
  //   pdfModel.value.date.value.clear();
  //   pdfModel.value.manualinvoiceNo.value.clear();
  //   pdfModel.value.billingName.value.clear();
  //   pdfModel.value.billingAddress.value.clear();
  //   pdfModel.value.billingName.value.clear();
  //   pdfModel.value.billingAddres.value.clear();
  //   pdfModel.value.phoneNumber.value.clear();
  //   pdfModel.value.Email.value.clear();
  //   pdfModel.value.feedback.value.clear();
  //   pdfModel.value.filePathController.value.clear();

  //   pdfModel.value.subTotal.value.clear();

  //   pdfModel.value.CGST.value.clear();
  //   pdfModel.value.SGST.value.clear();
  //   pdfModel.value.roundOff.value.clear();
  //   pdfModel.value.Total.value.clear();
  //   pdfModel.value.roundoffDiff.value = null;

  //   // pdfModel.value.manualInvoice_gstTotals.clear();

  //   pdfModel.value.manualInvoicesites.assignAll([
  //     Site(siteName: 'siteName1', address: 'address1', siteID: 'siteID1', monthlyCharges: 100),
  //     Site(siteName: 'siteName2', address: 'address2', siteID: 'siteID2', monthlyCharges: 200),
  //   ]);

  //   pdfModel.value.notecontent.clear();
  //   pdfModel.value.checkboxValues.clear();
  //   pdfModel.value.textControllers.clear();
  //   pdfModel.value.genearatedPDF.value = null;

  //   for (var controller in pdfModel.value.noteControllers) {
  //     controller.clear();
  //   }
  //   pdfModel.value.noteControllers.clear();

  //   pdfModel.value.whatsapp_selectionStatus.value = true;
  //   pdfModel.value.gmail_selectionStatus.value = true;
  //   pdfModel.value.CCemailController.value.clear();
  //   pdfModel.value.progress.value = 0.0;
  //   pdfModel.value.isLoading.value = false;
  //   pdfModel.value.CCemailToggle.value = false;

  //   pdfModel.value.allData_key.value = GlobalKey<FormState>();
  // }
// Function to validate the data before submission
  /// This function checks if any of the required fields are empty or null.
  bool postDatavalidation() {
    return (pdfModel.value.billingName.value.text.isEmpty ||
        pdfModel.value.billingAddress.value.text.isEmpty ||
        pdfModel.value.installation_serviceName.value.text.isEmpty ||
        pdfModel.value.installation_serviceAddres.value.text.isEmpty ||
        pdfModel.value.planname.value.text.isEmpty ||
        (pdfModel.value.gmail_selectionStatus.value && pdfModel.value.Email.value.text.isEmpty) ||
        (pdfModel.value.whatsapp_selectionStatus.value && pdfModel.value.phoneNumber.value.text.isEmpty) ||
        pdfModel.value.Total.value.text.isEmpty ||
        pdfModel.value.manualinvoiceNo.value.text.isEmpty ||
        pdfModel.value.date.value.text.isEmpty);
  } // If any one is empty or null, then it returns true

// Function to reset all data in the pdfModel
  /// This function resets all data in the pdfModel to their initial values.
  void resetData() {
    pdfModel.value.date.value.clear();
    pdfModel.value.manualinvoiceNo.value.clear();
    pdfModel.value.billingName.value.clear();
    pdfModel.value.billingAddress.value.clear();
    pdfModel.value.installation_serviceName.value.clear();
    pdfModel.value.installation_serviceAddres.value.clear();
    pdfModel.value.phoneNumber.value.clear();
    pdfModel.value.Email.value.clear();
    pdfModel.value.feedback.value.clear();
    pdfModel.value.filePathController.value.clear();
    pdfModel.value.subTotal.value.clear();
    pdfModel.value.CGST.value.clear();
    pdfModel.value.SGST.value.clear();
    pdfModel.value.roundOff.value.clear();
    pdfModel.value.Total.value.clear();
    pdfModel.value.CCemailController.value.clear();
    pdfModel.value.planname.value.clear();
    pdfModel.value.customertype.value.clear();
    pdfModel.value.plancharges.value.clear();
    pdfModel.value.internetcharges.value.clear();
    pdfModel.value.billperiod.value.clear();
    // pdfModel.value.billdate.value.clear();
    pdfModel.value.duedate.value.clear();
    pdfModel.value.relationshipID.value.clear();
    // pdfModel.value.billnumber.value.clear();
    pdfModel.value.customerGSTIN.value.clear();
    pdfModel.value.customerPO.value.clear();
    pdfModel.value.HSNcode.value.clear();
    pdfModel.value.contactperson.value.clear();
    pdfModel.value.contactnumber.value.clear();
    pdfModel.value.previousdues.value.clear();
    pdfModel.value.payment.value.clear();
    pdfModel.value.adjustments_deduction.value.clear();
    pdfModel.value.totaldueamount.value.clear();
    pdfModel.value.ispendingamount.value = false;
    pdfModel.value.roundoffDiff.value = null;

    // Clear individual note controllers
    for (var controller in pdfModel.value.noteControllers) {
      controller.clear();
    }
    pdfModel.value.noteControllers.clear();

    // Clear matrix-style text controllers
    for (var controllerList in pdfModel.value.textControllers) {
      for (var controller in controllerList) {
        controller.clear();
      }
    }
    pdfModel.value.textControllers.clear();

    // Sites - reset to initial static list if needed
    pdfModel.value.manualInvoicesites.value = [
      Site(siteName: 'siteName1', address: 'address1', siteID: 'siteID1', monthlyCharges: 100),
      Site(siteName: 'siteName2', address: 'address2', siteID: 'siteID2', monthlyCharges: 200)
    ];

    pdfModel.value.notecontent.clear();
    pdfModel.value.progress.value = 0.0;
    pdfModel.value.checkboxValues.clear();
    pdfModel.value.ispdfLoading.value = false;
    pdfModel.value.whatsapp_selectionStatus.value = true;
    pdfModel.value.gmail_selectionStatus.value = true;
    pdfModel.value.isLoading.value = false;
    pdfModel.value.CCemailToggle.value = false;
    pdfModel.value.genearatedPDF.value = null;
    pdfModel.value.allData_key.value = GlobalKey<FormState>();
  }
}
