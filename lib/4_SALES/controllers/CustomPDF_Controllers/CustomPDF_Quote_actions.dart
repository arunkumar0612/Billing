import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/models/constants/CustomPDF_constants/CustomPDF_quote_constants.dart';
import 'package:ssipl_billing/4_SALES/models/entities/CustomPDF_entities/CustomPDF_Product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

class CustomPDF_QuoteController extends GetxController {
  var pdfModel = CustomPDF_QuoteModel().obs;

  /// Performs all initial setup tasks for the invoice module.
  ///
  /// This includes:
  /// - Initializing text controllers for invoice product fields.
  /// - Setting up checkbox states.
  /// - Adding default notes.
  /// - Calculating final totals and GST amounts.
  void intAll() {
    initializeTextControllers();
    initializeCheckboxes();
    add_Note();
    finalCalc();
  }

  /// Updates the total amount in the PDF model.
  void update_totalAmount(double amount) {
    pdfModel.value.Total_amount.value = amount;
  }

  /// Initializes checkboxes for quote product selection.
  void initializeCheckboxes() {
    pdfModel.value.checkboxValues.assignAll(List.generate(pdfModel.value.manualQuoteproducts.length, (index) => false));
  }

  /// Triggers form field validation using the form key.
  void validate() {
    pdfModel.value.allData_key.value.currentState?.validate();
  }

  /// Adds an empty note and a corresponding text controller.
  void add_Note() {
    pdfModel.value.notecontent.add(""); // Add empty note
    pdfModel.value.noteControllers.add(TextEditingController()); // Add controller
    pdfModel.refresh();
  }

  /// Toggles the visibility of the CC email input field.
  void toggleCCemailvisibility(bool value) {
    pdfModel.value.CCemailToggle.value = value;
  }

  /// Sets the PDF generation loading state.
  void setpdfLoading(bool value) {
    pdfModel.value.ispdfLoading.value = value;
  }

  /// Opens a file picker allowing the user to select an image file (png, jpg, jpeg).
  ///
  /// Parameters:
  /// - [context]: The BuildContext used for displaying error dialogs.
  ///
  /// Behavior:
  /// - Restricts file selection to the specified image types.
  /// - Locks the parent window during file selection.
  /// - Validates the selected file size; if it exceeds 2 MB, shows an error dialog and clears the generated PDF reference.
  /// - If the file size is acceptable, updates the generated PDF reference with the selected file.
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
        // pdfModel.value.pickedFile.value = null;
        pdfModel.value.genearatedPDF.value = null;
      } else {
        // pdfModel.value.pickedFile.value = result;
        pdfModel.value.genearatedPDF.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  /// Toggles the loading indicator.
  void setLoading(bool value) {
    pdfModel.value.isLoading.value = value;
  }

  /// Sets the GST type as local or interstate.
  void setGSTtype(bool value) {
    pdfModel.value.isGST_local.value = value;
  }

  /// Simulates progress loading by updating progress value gradually.
  Future<void> startProgress() async {
    setLoading(true);
    pdfModel.value.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      pdfModel.value.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  /// Initializes text editing controllers for each field in quote products.
  void initializeTextControllers() {
    pdfModel.value.textControllers.assignAll(
      pdfModel.value.manualQuoteproducts.map((product) {
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

  /// Returns message type based on WhatsApp and Gmail selection status.
  int fetch_messageType() {
    if (pdfModel.value.whatsapp_selectionStatus.value && pdfModel.value.gmail_selectionStatus.value) return 3;
    if (pdfModel.value.whatsapp_selectionStatus.value) return 2;
    if (pdfModel.value.gmail_selectionStatus.value) return 1;

    return 0;
  }

  /// Updates note content at a specified index.
  void update_noteCotent(value, index) {
    pdfModel.value.notecontent[index] = value;
  }

  /// Removes a note and its controller at the specified index.
  void deleteNote(int index) {
    pdfModel.value.noteControllers.removeAt(index);
    pdfModel.value.notecontent.removeAt(index);
    pdfModel.refresh();
  }

  /// Updates the value of a specific cell in the manual quote products list.
  ///
  /// Parameters:
  /// - [rowIndex]: The index of the product row to update.
  /// - [colIndex]: The index of the column to update.
  /// - [value]: The new string value to assign.
  ///
  /// Behavior:
  /// - For columns 0, 2, 3, 4, and 5, input is validated to allow only numeric values.
  /// - Updates the product field based on the column index:
  ///   - 0: Serial number (`sNo`)
  ///   - 1: Description
  ///   - 2: HSN code
  ///   - 3: GST percentage (`gst`)
  ///   - 4: Price
  ///   - 5: Quantity
  /// - Recalculates the total if price or quantity is updated.
  /// - Refreshes the `pdfModel` to update the UI.
  void updateCell(int rowIndex, int colIndex, String value) {
    final product = pdfModel.value.manualQuoteproducts[rowIndex];

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

  /// Calculates total for a specific row and updates the corresponding controller.
  void calculateTotal(int rowIndex) {
    final product = pdfModel.value.manualQuoteproducts[rowIndex];

    double price = double.tryParse(product.price) ?? 0;
    double quantity = double.tryParse(product.quantity) ?? 0;
    String newTotal = (price * quantity).toString();

    product.total = newTotal;
    pdfModel.value.textControllers[rowIndex][6].text = newTotal;
    finalCalc();
    pdfModel.refresh();
  }

  /// Calculates and updates the total price for a product in the manual quote.
  ///
  /// This function retrieves a specific [product] from the
  /// `pdfModel.value.manualQuoteproducts` list using the provided [rowIndex].
  /// It then parses the product's `price` and `quantity` from strings to
  /// `double` values. If parsing fails for either, it defaults to `0`.
  ///
  /// The **new total** is computed by multiplying the parsed `price` and `quantity`.
  /// This `newTotal` (as a `String`) is then assigned back to the `product.total`
  /// property.
  ///
  /// The calculated total is also updated in the corresponding `TextEditingController`
  /// at `pdfModel.value.textControllers[rowIndex][6]`, ensuring the UI reflects
  /// the change.
  ///
  /// Finally, `finalCalc()` is called to trigger any subsequent global calculations
  /// or updates, and `pdfModel.refresh()` is called to force a UI refresh.
  ///
  /// @param rowIndex The index of the product row for which the total needs to be calculated.
  void finalCalc() {
    double addedSubTotal = 0.0;
    double addedIGST = 0.0;
    double addedCGST = 0.0;
    double addedSGST = 0.0;
    double addedRoundoff = 0.0;

    for (var product in pdfModel.value.manualQuoteproducts) {
      double subTotal = double.tryParse(product.total) ?? 0.0;
      double price = double.tryParse(product.total) ?? 0.0;
      double gst = double.tryParse(product.gst) ?? 0.0;
      double cgst = (price / 100) * gst / 2;
      double sgst = (price / 100) * gst / 2;
      double igst = (price / 100) * gst;

      addedIGST += igst;
      addedCGST += cgst;
      addedSGST += sgst;
      addedSubTotal += subTotal;
    }
    if (isGST_Local(pdfModel.value.GSTnumber.value.text)) {
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

    pdfModel.refresh();
  }

  /// Deletes selected rows based on checkbox values.
  void deleteRow() {
    for (int i = pdfModel.value.checkboxValues.length - 1; i >= 0; i--) {
      if (pdfModel.value.checkboxValues[i]) {
        pdfModel.value.manualQuoteproducts.removeAt(i);
        pdfModel.value.textControllers.removeAt(i);
        pdfModel.value.checkboxValues.removeAt(i);
      }
    }
    finalCalc();
    pdfModel.refresh(); // Ensure UI updates
  }

  /// Adds a new, empty row to the manual quote product list.
  ///
  /// This function performs three key actions to prepare a new row for user input:
  ///
  /// 1.  **Initializes Text Controllers:** It adds a new list of seven `TextEditingController`
  ///     instances to `pdfModel.value.textControllers`. These controllers are essential
  ///     for managing user input in each cell of the new row in the UI.
  ///
  /// 2.  **Adds New Product Model:** A new `CustomPDF_QuoteProduct` object is instantiated
  ///     with all its properties (`sNo`, `description`, `hsn`, `gst`, `price`, `quantity`, `total`)
  ///     initialized as empty strings, except `total` which defaults to "0.0". This new
  ///     product object is then added to `pdfModel.value.manualQuoteproducts`, serving
  ///     as the data model for the new row.
  ///
  /// 3.  **Adds Checkbox Value:** A new `false` boolean value is added to
  ///     `pdfModel.value.checkboxValues`. This likely corresponds to a checkbox
  ///     associated with the newly added row, setting its initial state to unchecked.
  ///
  /// Finally, `pdfModel.refresh()` is called to trigger a UI update, making the
  /// newly added row visible and interactive to the user.
  void addRow() {
    pdfModel.value.textControllers.add(
      List.generate(7, (index) => TextEditingController()),
    );

    pdfModel.value.manualQuoteproducts.add(CustomPDF_QuoteProduct(
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

  /// Validates that all required post data fields are properly filled.
  bool postDatavalidation() {
    return (pdfModel.value.clientName.value.text.isEmpty ||
        pdfModel.value.clientAddress.value.text.isEmpty ||
        pdfModel.value.billingName.value.text.isEmpty ||
        pdfModel.value.billingAddres.value.text.isEmpty ||
        (pdfModel.value.gmail_selectionStatus.value && pdfModel.value.Email.value.text.isEmpty) ||
        (pdfModel.value.whatsapp_selectionStatus.value && pdfModel.value.phoneNumber.value.text.isEmpty) ||
        pdfModel.value.GSTnumber.value.text.isEmpty ||
        pdfModel.value.manualQuoteproducts.isEmpty ||
        pdfModel.value.notecontent.isEmpty ||
        pdfModel.value.manualquoteNo.value.text.isEmpty);
  }

  /// Clears fields related to post submission like email, feedback, and file path.
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
    pdfModel.value.date.value.clear();
    pdfModel.value.manualquoteNo.value.clear();
    pdfModel.value.clientName.value.clear();
    pdfModel.value.clientAddress.value.clear();
    pdfModel.value.billingName.value.clear();
    pdfModel.value.billingAddres.value.clear();
    pdfModel.value.phoneNumber.value.clear();
    pdfModel.value.Email.value.clear();
    pdfModel.value.feedback.value.clear();
    pdfModel.value.filePathController.value.clear();

    pdfModel.value.subTotal.value.clear();
    pdfModel.value.GSTnumber.value.clear();
    pdfModel.value.CGST.value.clear();
    pdfModel.value.SGST.value.clear();
    pdfModel.value.IGST.value.clear();
    pdfModel.value.roundOff.value.clear();
    pdfModel.value.Total.value.clear();
    pdfModel.value.roundoffDiff.value = null;

    pdfModel.value.manualQuote_gstTotals.clear();

    pdfModel.value.manualQuoteproducts.assignAll([
      CustomPDF_QuoteProduct(sNo: "1", description: "Laptop", hsn: "8471", gst: "18", price: "1000", quantity: "2", total: "2000"),
      CustomPDF_QuoteProduct(sNo: "2", description: "Mouse", hsn: "8472", gst: "18", price: "50", quantity: "5", total: "250"),
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
    pdfModel.value.isGST_local.value = true;
  }
}
