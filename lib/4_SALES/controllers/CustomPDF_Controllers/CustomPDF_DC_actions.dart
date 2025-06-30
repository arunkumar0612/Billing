import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/models/constants/CustomPDF_constants/CustomPDF_dc_constants.dart';
import 'package:ssipl_billing/4_SALES/models/entities/CustomPDF_entities/CustomPDF_Product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

class CustomPDF_DcController extends GetxController {
  var pdfModel = CustomPDF_DcModel().obs;

  /// Initializes the necessary components and states for the module.
  ///
  /// This includes:
  /// - Setting up all required text controllers.
  /// - Initializing checkbox states.
  /// - Adding default or initial notes.
  ///
  /// Note: The `finalCalc()` method call is currently commented out and not invoked.
  void intAll() {
    initializeTextControllers();
    initializeCheckboxes();
    add_Note();
    // finalCalc();
  }

  /// Determines the message type code based on the selection status of WhatsApp and Gmail.
  ///
  /// Returns:
  /// - 3 if both WhatsApp and Gmail are selected.
  /// - 2 if only WhatsApp is selected.
  /// - 1 if only Gmail is selected.
  /// - 0 if neither is selected.
  int fetch_messageType() {
    if (pdfModel.value.whatsapp_selectionStatus.value && pdfModel.value.gmail_selectionStatus.value) return 3;
    if (pdfModel.value.whatsapp_selectionStatus.value) return 2;
    if (pdfModel.value.gmail_selectionStatus.value) return 1;

    return 0;
  }

  /// Initializes the checkbox states for the product list.
  void initializeCheckboxes() {
    pdfModel.value.checkboxValues.assignAll(List.generate(pdfModel.value.manualDcproducts.length, (index) => false));
  }

  /// Triggers validation for the form using its key.
  void validate() {
    pdfModel.value.allData_key.value.currentState?.validate();
  }

  /// Adds an empty note and a new text controller to the list.
  void add_Note() {
    pdfModel.value.notecontent.add(""); // Add empty note
    pdfModel.value.noteControllers.add(TextEditingController()); // Add controller
    pdfModel.refresh();
  }

  /// Toggles the visibility of the CC email input.
  void toggleCCemailvisibility(bool value) {
    pdfModel.value.CCemailToggle.value = value;
  }

  /// Sets the loading state for PDF generation.
  void setpdfLoading(bool value) {
    pdfModel.value.ispdfLoading.value = value;
  }

  /// Opens a file picker to select an image file with extensions png, jpg, or jpeg.
  ///
  /// Parameters:
  /// - [context]: Used to display error dialogs.
  ///
  /// Process:
  /// - Allows selection of image files only.
  /// - Locks the parent window while file picker is active.
  /// - Checks the selected file size; if it exceeds 2MB, shows an error dialog and clears the generated PDF reference.
  /// - If file size is within limit, updates the generated PDF reference with the selected file.
  /// - Prints debug information about the selected file when in debug mode.
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
        // dcModel.pickedFile.value = null;
        pdfModel.value.genearatedPDF.value = null;
      } else {
        // dcModel.pickedFile.value = result;
        pdfModel.value.genearatedPDF.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  /// Sets the loading state for operations.
  void setLoading(bool value) {
    pdfModel.value.isLoading.value = value;
  }

  /// Simulates a progress update from 0% to 100% over a fixed duration.
  ///
  /// This function:
  /// - Sets a loading state to true at the start.
  /// - Initializes progress to 0.0.
  /// - Increments the progress value from 0 to 1 in steps of 1%,
  ///   waiting 20 milliseconds between each increment to simulate progress.
  /// - Sets the loading state to false after completion.
  Future<void> startProgress() async {
    setLoading(true);
    pdfModel.value.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      pdfModel.value.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  /// Initializes text controllers for each product in the manual DC products list.
  ///
  /// For each product, creates a list of TextEditingControllers initialized with:
  /// - Serial number (`sNo`)
  /// - Description
  /// - HSN code
  /// - Quantity
  ///
  /// Note:
  /// - Some fields like GST, price, and total are commented out and not initialized here.
  /// - The total field is considered read-only and therefore not assigned a controller.
  void initializeTextControllers() {
    pdfModel.value.textControllers.assignAll(
      pdfModel.value.manualDcproducts.map((product) {
        return [
          TextEditingController(text: product.sNo),
          TextEditingController(text: product.description),
          TextEditingController(text: product.hsn),
          // TextEditingController(text: product.gst),
          // TextEditingController(text: product.price),
          TextEditingController(text: product.quantity),
          // TextEditingController(text: product.total), // Total is read-only
        ];
      }).toList(),
    );
  }

  /// Updates note content at the specified index.
  void update_noteCotent(value, index) {
    pdfModel.value.notecontent[index] = value;
  }

  /// Deletes a note and its corresponding controller at the given index.
  void deleteNote(int index) {
    pdfModel.value.noteControllers.removeAt(index);
    pdfModel.value.notecontent.removeAt(index);
    pdfModel.refresh();
  }

  /// Updates the value of a specific cell in the manual DC products table.
  ///
  /// Parameters:
  /// - [rowIndex]: The index of the product row to update.
  /// - [colIndex]: The index of the column to update.
  /// - [value]: The new string value to set.
  ///
  /// Behavior:
  /// - For columns 0, 2, 3, 4, and 5, only allows numeric input; rejects non-numeric values.
  /// - Updates the corresponding field in the product based on the column index:
  ///   - 0: Serial number (`sNo`)
  ///   - 1: Description
  ///   - 2: HSN code
  ///   - 3: Quantity (note: GST update commented out)
  /// - Columns 4 and 5 are commented out (price and quantity), indicating they are not currently handled.
  /// - Refreshes the `pdfModel` after updating to trigger UI updates.
  /// - Calculation of total on certain columns is commented out.
  void updateCell(int rowIndex, int colIndex, String value) {
    final product = pdfModel.value.manualDcproducts[rowIndex];

    /// Allow only numeric values for specific columns
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
        product.quantity = value;
        // product.gst = value;
        break;
      // case 4:
      //   product.price = value;
      //   break;
      // case 5:
      //   product.quantity = value;
      // break;
    }

    // if (colIndex == 4 || colIndex == 5) {
    //   calculateTotal(rowIndex);
    // }

    pdfModel.refresh();
  }

  // void calculateTotal(int rowIndex) {
  //   final product = pdfModel.value.manualDcproducts[rowIndex];

  //   // double price = double.tryParse(product.price) ?? 0;
  //   double quantity = double.tryParse(product.quantity) ?? 0;
  //   // String newTotal = (price * quantity).toString();

  //   // product.total = newTotal;
  //   // pdfModel.value.textControllers[rowIndex][6].text = newTotal;
  //   // finalCalc();
  //   pdfModel.refresh();
  // }

  // void finalCalc() {
  //   double addedSubTotal = 0.0;
  //   double addedCGST = 0.0;
  //   double addedSGST = 0.0;
  //   double addedRoundoff = 0.0;

  //   for (var product in pdfModel.value.manualDcproducts) {
  //     // double subTotal = double.tryParse(product.total) ?? 0.0;
  //     // double price = double.tryParse(product.total) ?? 0.0;
  //     // double gst = double.tryParse(product.gst) ?? 0.0;
  //     double cgst = (price / 100) * gst / 2;
  //     double sgst = (price / 100) * gst / 2;

  //     addedCGST += cgst;
  //     addedSGST += sgst;
  //     addedSubTotal += subTotal;
  //   }
  //   addedRoundoff = addedSubTotal + addedCGST + addedSGST;

  //   pdfModel.value.subTotal.value.text = addedSubTotal.toStringAsFixed(2);
  //   pdfModel.value.CGST.value.text = addedCGST.toStringAsFixed(2);
  //   pdfModel.value.SGST.value.text = addedSGST.toStringAsFixed(2);
  //   pdfModel.value.roundOff.value.text = formatCurrencyRoundedPaisa(addedRoundoff);
  //   pdfModel.value.roundoffDiff.value = calculateFormattedDifference(addedRoundoff);
  //   pdfModel.value.Total.value.text = formatCurrencyRoundedPaisa(addedRoundoff);

  //   pdfModel.refresh();
  // }

  /// Deletes all rows from the product list where the checkbox is selected.
  void deleteRow() {
    for (int i = pdfModel.value.checkboxValues.length - 1; i >= 0; i--) {
      if (pdfModel.value.checkboxValues[i]) {
        pdfModel.value.manualDcproducts.removeAt(i);
        pdfModel.value.textControllers.removeAt(i);
        pdfModel.value.checkboxValues.removeAt(i);
      }
    }
    // finalCalc();
    pdfModel.refresh(); // Ensure UI updates
  }

  /// Adds a new empty product row with corresponding controllers and checkbox.
  void addRow() {
    pdfModel.value.textControllers.add(
      List.generate(7, (index) => TextEditingController()),
    );

    pdfModel.value.manualDcproducts.add(CustomPDF_DcProduct(
      sNo: "",
      description: "",
      hsn: "",
      // gst: "",
      // price: "",
      quantity: "",
      // total: "0.0",
    ));

    pdfModel.value.checkboxValues.add(false);

    pdfModel.refresh();
  }

  /// Validates all required fields before submitting the data.
  bool postDatavalidation() {
    return (pdfModel.value.clientName.value.text.isEmpty ||
        pdfModel.value.clientAddress.value.text.isEmpty ||
        pdfModel.value.billingName.value.text.isEmpty ||
        pdfModel.value.billingAddres.value.text.isEmpty ||
        (pdfModel.value.gmail_selectionStatus.value && pdfModel.value.Email.value.text.isEmpty) ||
        (pdfModel.value.whatsapp_selectionStatus.value && pdfModel.value.phoneNumber.value.text.isEmpty) ||
        pdfModel.value.GSTnumber.value.text.isEmpty ||
        pdfModel.value.manualDcproducts.isEmpty ||
        pdfModel.value.notecontent.isEmpty ||
        pdfModel.value.manualdcNo.value.text.isEmpty);
  }

  // void resetData() {
  // pdfModel.value.date.value.clear();
  // pdfModel.value.manualdcNo.value.clear();
  // pdfModel.value.clientName.value.clear();
  // pdfModel.value.clientAddress.value.clear();
  // pdfModel.value.billingName.value.clear();
  // pdfModel.value.billingAddres.value.clear();
  // pdfModel.value.phoneNumber.value.clear();
  // pdfModel.value.Email.value.clear();
  // pdfModel.value.feedback.value.clear();
  // pdfModel.value.filePathController.value.clear();

  // pdfModel.value.GSTnumber.value.clear();
  // pdfModel.value.manualDcproducts.assignAll([
  //   CustomPDF_DcProduct(
  //     sNo: "1",
  //     description: "Laptop",
  //     hsn: "8471",
  //     quantity: "2",
  //   ),
  //   CustomPDF_DcProduct(
  //     sNo: "2",
  //     description: "Mouse",
  //     hsn: "8472",
  //     quantity: "5",
  //   ),
  // ]);

  // pdfModel.value.notecontent.clear();
  // pdfModel.value.checkboxValues.clear();
  // pdfModel.value.textControllers.clear();
  // pdfModel.value.genearatedPDF.value = null;

  // for (var controller in pdfModel.value.noteControllers) {
  //   controller.clear();
  // }
  // pdfModel.value.noteControllers.clear();

  // pdfModel.value.whatsapp_selectionStatus.value = true;
  // pdfModel.value.gmail_selectionStatus.value = true;
  // pdfModel.value.CCemailController.value.clear();
  // pdfModel.value.progress.value = 0.0;
  // pdfModel.value.isLoading.value = false;
  // pdfModel.value.CCemailToggle.value = false;

  // pdfModel.value.allData_key.value = GlobalKey<FormState>();
  // }

  void clear_postFields() {
    pdfModel.value.phoneNumber.value.clear();
    pdfModel.value.Email.value.clear();
    pdfModel.value.feedback.value.clear();
    pdfModel.value.whatsapp_selectionStatus.value = true;
    pdfModel.value.gmail_selectionStatus.value = true;
    pdfModel.value.CCemailController.value.clear();
    pdfModel.value.CCemailToggle.value = false;
    pdfModel.value.filePathController.value.clear();
  }

  void resetData() {
    // TEXT CONTROLLERS
    pdfModel.value.date.value.clear();
    pdfModel.value.manualdcNo.value.clear();
    pdfModel.value.clientName.value.clear();
    pdfModel.value.clientAddress.value.clear();
    pdfModel.value.billingName.value.clear();
    pdfModel.value.billingAddres.value.clear();
    pdfModel.value.phoneNumber.value.clear();
    pdfModel.value.Email.value.clear();
    pdfModel.value.GSTnumber.value.clear();
    pdfModel.value.feedback.value.clear();
    pdfModel.value.filePathController.value.clear();
    pdfModel.value.CCemailController.value.clear();

    // NOTES
    for (var controller in pdfModel.value.noteControllers) {
      controller.clear();
    }
    pdfModel.value.noteControllers.clear();

    // TABLE TEXT CONTROLLERS
    for (var row in pdfModel.value.textControllers) {
      for (var controller in row) {
        controller.clear();
      }
    }
    pdfModel.value.textControllers.clear();

    // PRODUCTS
    pdfModel.value.manualDcproducts.clear();

    // NOTE TEXTS
    pdfModel.value.notecontent.clear();

    // STATE
    pdfModel.value.progress.value = 0.0;
    pdfModel.value.checkboxValues.clear();
    pdfModel.value.ispdfLoading.value = false;
    pdfModel.value.whatsapp_selectionStatus.value = true;
    pdfModel.value.gmail_selectionStatus.value = true;
    pdfModel.value.isLoading.value = false;
    pdfModel.value.CCemailToggle.value = false;

    // PDF
    pdfModel.value.genearatedPDF.value = null;
  }
}
