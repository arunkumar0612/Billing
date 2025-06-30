import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Invoice_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

import '../models/constants/Invoice_constants.dart';

class InvoiceController extends GetxController {
  var invoiceModel = InvoiceModel();

  /// Initializes the TabController for tab navigation in the invoice model.
  void initializeTabController(TabController tabController) {
    invoiceModel.tabController.value = tabController;
  }

  /// Navigates to the next tab if not on the last tab.
  void nextTab() {
    if (invoiceModel.tabController.value!.index < invoiceModel.tabController.value!.length - 1) {
      invoiceModel.tabController.value!.animateTo(invoiceModel.tabController.value!.index + 1);
    }
  }

  /// Navigates to the previous tab if not on the first tab.
  void backTab() {
    if (invoiceModel.tabController.value!.index > 0) {
      invoiceModel.tabController.value!.animateTo(invoiceModel.tabController.value!.index - 1);
    }
  }

  /// Updates the product name in the product name controller.
  void updateProductName(String productName) {
    invoiceModel.productNameController.value.text = productName;
  }

  /// Updates the HSN code in the HSN controller.
  void updateHSN(int hsn) {
    invoiceModel.hsnController.value.text = hsn.toString();
  }

  /// Updates the product price in the price controller.
  void updatePrice(double price) {
    invoiceModel.priceController.value.text = price.toString();
  }

  /// Updates the product quantity in the quantity controller.
  void updateQuantity(int quantity) {
    invoiceModel.quantityController.value.text = quantity.toString();
  }

  /// Updates the GST value in the GST controller.
  void updateGST(double gst) {
    invoiceModel.gstController.value.text = gst.toString();
  }

  /// Updates the currently edited note index.
  void updateNoteEditindex(int? index) {
    invoiceModel.note_editIndex.value = index;
  }

  // void updateChallanTableHeading(String tableHeading) {
  //   invoiceModel.Invoice_table_heading.value = tableHeading;
  // }

  /// Updates a note in the note list at the specified index.
  void updateNoteList(String value, int index) {
    invoiceModel.Invoice_noteList[invoiceModel.note_editIndex.value!] = invoiceModel.notecontentController.value.text;
  }

  /// Updates the TabController used for navigating tabs.F
  void updateTabController(TabController tabController) {
    invoiceModel.tabController.value = tabController;
  }

  /// Updates the title field in the invoice.
  void updateTitle(String text) {
    invoiceModel.TitleController.value.text = text;
  }

  /// Updates the invoice number value.
  void updateInvoicenumber(String text) {
    invoiceModel.Invoice_no.value = text;
  }

  /// Updates the GST number field.
  void updateGSTnumber(String text) {
    invoiceModel.gstNumController.value.text = text;
  }

  /// Updates the client's name in the address section.
  void updateClientAddressName(String text) {
    invoiceModel.clientAddressNameController.value.text = text;
  }

  /// Updates the client's address.
  void updateClientAddress(String text) {
    invoiceModel.clientAddressController.value.text = text;
  }

  /// Updates the billing address name field.
  void updateBillingAddressName(String text) {
    invoiceModel.billingAddressNameController.value.text = text;
  }

  /// Updates the billing address.
  void updateBillingAddress(String text) {
    invoiceModel.billingAddressController.value.text = text;
  }

  /// Updates the phone number field.
  void updatePhone(String phone) {
    invoiceModel.phoneController.value.text = phone;
  }

  /// Updates the email address field.
  void updateEmail(String email) {
    invoiceModel.emailController.value.text = email;
  }

  /// Updates the CC (carbon copy) email field.
  void updatCC(String CC) {
    invoiceModel.CCemailController.value.text = CC;
  }

  /// Toggles the visibility of the CC email field.
  void toggleCCemailvisibility(bool value) {
    invoiceModel.CCemailToggle.value = value;
  }

  /// Updates the currently edited recommendation index.
  void updateRecommendationEditindex(int? index) {
    invoiceModel.recommendation_editIndex.value = index;
  }

  /// Updates the text in the note content controller.
  void updateNoteContentControllerText(String text) {
    invoiceModel.notecontentController.value.text = text;
  }

  /// Updates the text in the recommendation heading controller.
  void updateRec_HeadingControllerText(String text) {
    invoiceModel.recommendationHeadingController.value.text = text;
  }

  /// Updates the text in the recommendation key controller.
  void updateRec_KeyControllerText(String text) {
    invoiceModel.recommendationKeyController.value.text = text;
  }

  /// Updates the text in the recommendation value controller.
  void updateRec_ValueControllerText(String text) {
    invoiceModel.recommendationValueController.value.text = text;
  }

  /// Adds a new note to the note suggestion list.
  void addNoteToList(String note) {
    invoiceModel.noteSuggestion.add(note);
  }

  /// Updates the currently edited product index.
  void addProductEditindex(int? index) {
    invoiceModel.product_editIndex.value = index;
  }

  /// Sets the process ID for tracking the current process.
  void setProcessID(int processid) {
    invoiceModel.processID.value = processid;
  }

  /// Updates the selected PDF file in the model.
  void updateSelectedPdf(File file) {
    invoiceModel.selectedPdf.value = file;
  }

  /// Sets the loading state of the UI.
  void setLoading(bool value) {
    invoiceModel.isLoading.value = value;
  }

  /// Sets the loading state specifically for PDF operations.
  void setpdfLoading(bool value) {
    invoiceModel.ispdfLoading.value = value;
  }

  /// Toggles the WhatsApp selection status.
  void toggleWhatsApp(bool value) {
    invoiceModel.whatsapp_selectionStatus.value = value;
  }

  /// Toggles the Gmail selection status.
  void toggleGmail(bool value) {
    invoiceModel.gmail_selectionStatus.value = value;
  }

  /// Updates the phone number in the phone controller.
  void updatePhoneNumber(String phoneNumber) {
    invoiceModel.phoneController.value.text = phoneNumber;
  }

  /// Updates the feedback text in the feedback controller.
  void updateFeedback(String feedback) {
    invoiceModel.feedbackController.value.text = feedback;
  }

  /// Updates the file path in the file path controller.
  void updateFilePath(String filePath) {
    invoiceModel.filePathController.value.text = filePath;
  }

  /// Updates the total invoice amount.
  void update_invoiceAmount(double amount) {
    invoiceModel.invoice_amount.value = amount;
  }

  /// Updates the invoice subtotal amount.
  void update_invoiceSubTotal(double amount) {
    invoiceModel.invoice_subTotal.value = amount;
  }

  /// Updates the CGST amount for the invoice.
  void update_invoiceCGSTAmount(double amount) {
    invoiceModel.invoice_CGSTamount.value = amount;
  }

  /// Updates the SGST amount for the invoice.
  void update_invoiceSGSTAmount(double amount) {
    invoiceModel.invoice_SGSTamount.value = amount;
  }

  /// Updates the IGST amount for the invoice.
  void update_invoiceIGSTAmount(double amount) {
    invoiceModel.invoice_IGSTamount.value = amount;
  }

  /// Allows the user to pick an image file from their device, with a 2MB size limit.
  ///
  /// This asynchronous function leverages the `file_picker` package to present
  /// a file selection dialog to the user. It is specifically configured to allow
  /// the selection of common image formats (PNG, JPG, JPEG).
  ///
  /// **File Selection and Validation Process:**
  /// 1.  **Initiates File Picker:**
  ///     - `FilePicker.platform.pickFiles` is called.
  ///     - `type: FileType.custom` and `allowedExtensions: ['png', 'jpg', 'jpeg']`
  ///       restrict the selectable files to these image types.
  ///     - `lockParentWindow: true` ensures that the user's interaction is
  ///       focused solely on the file picker dialog until a selection is made
  ///       or the dialog is dismissed.
  /// 2.  **Handles User Selection:**
  ///     - If `result` is `null`, it means the user cancelled the file selection,
  ///       and the function returns without further action.
  ///     - If `result` is not `null`, indicating a file was selected:
  ///         - A `File` object is created from the `path` of the selected file.
  ///         - The `fileLength` (size in bytes) of the selected file is asynchronously retrieved.
  /// 3.  **Applies Size Limit:**
  ///     - The `fileLength` is compared against a **2 MB (2 * 1024 * 1024 bytes)** limit.
  ///     - **If the file size exceeds 2 MB:**
  ///         - A debug message (`print`) is issued, indicating the file is too large (only in `kDebugMode`).
  ///         - An `Error_dialog` is displayed to the user via the provided `context`,
  ///           informing them of the size restriction.
  ///         - `invoiceModel.pickedFile.value` and `invoiceModel.selectedPdf.value`
  ///           are explicitly set to `null` to clear any invalid selection from the model.
  ///     - **If the file size is within the 2 MB limit:**
  ///         - The `FilePickerResult` is stored in `invoiceModel.pickedFile.value`.
  ///         - The `File` object itself is stored in `invoiceModel.selectedPdf.value`.
  ///           (Note: The variable name `selectedPdf` might be a remnant from a previous
  ///           version that allowed PDFs, but current `allowedExtensions` only permit images).
  ///         - The name of the selected file is printed to the console (only in `kDebugMode`).
  ///
  /// @param context The `BuildContext` required for displaying the `Error_dialog`.
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
        invoiceModel.pickedFile.value = null;
        invoiceModel.selectedPdf.value = null;
      } else {
        invoiceModel.pickedFile.value = result;
        invoiceModel.selectedPdf.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  /// Returns the message type based on WhatsApp and Gmail selection status.
  int fetch_messageType() {
    if (invoiceModel.whatsapp_selectionStatus.value && invoiceModel.gmail_selectionStatus.value) return 3;
    if (invoiceModel.whatsapp_selectionStatus.value) return 2;
    if (invoiceModel.gmail_selectionStatus.value) return 1;

    return 0;
  }

  /// Simulates a loading progress bar from 0% to 100%.
  ///
  /// This asynchronous function is designed to visually represent a loading
  /// or processing operation by incrementally updating a progress indicator.
  ///
  /// **Process:**
  /// 1.  **Starts Loading State:**
  ///     - `setLoading(true)` is called at the beginning to set a loading
  ///       flag or state, typically to show a loading spinner or disable
  ///       user interaction.
  ///     - `invoiceModel.progress.value` is initialized to `0.0` to ensure
  ///       the progress bar starts from the beginning.
  /// 2.  **Simulates Progress Loop:**
  ///     - A `for` loop iterates from `0` to `100`.
  ///     - Inside the loop:
  ///         - `await Future.delayed(const Duration(milliseconds: 20))`
  ///           introduces a small delay of 20 milliseconds in each iteration.
  ///           This creates a visible progression effect.
  ///         - `invoiceModel.progress.value = i / 100;` updates the progress
  ///           value in the `invoiceModel`. The loop counter `i` is divided by 100
  ///           to convert it into a decimal percentage (e.g., 0.0, 0.01, ..., 1.0).
  ///           This value would typically be bound to a `LinearProgressIndicator`
  ///           or similar UI widget.
  /// 3.  **Ends Loading State:**
  ///     - After the loop completes (progress reaches 100%), `setLoading(false)`
  ///       is called to reset the loading flag, typically hiding the spinner
  ///       or re-enabling interaction.
  Future<void> startProgress() async {
    setLoading(true);
    invoiceModel.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      invoiceModel.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  /// Adds a recommendation to the list if key and value are not empty.
  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      invoiceModel.Invoice_recommendationList.add(Recommendation(key: key, value: value));
    } else {
      if (kDebugMode) {
        print('Key and value must not be empty');
      }
    }
  }

  /// Updates an existing recommendation entry in the `Invoice_recommendationList`.
  ///
  /// This function allows for modifying a specific recommendation within the
  /// `invoiceModel.Invoice_recommendationList` by its index. It requires a valid index,
  /// and non-empty `key` and `value` to perform the update.
  ///
  /// **Parameters:**
  /// - `index`: The zero-based index of the recommendation to be updated within the list.
  ///            This parameter is `required`.
  /// - `key`: The new key for the recommendation. This parameter is `required` and
  ///          must not be empty.
  /// - `value`: The new value for the recommendation. This parameter is `required` and
  ///            must not be empty.
  ///
  /// **Functionality:**
  /// 1.  **Index Validation:** It first checks if the provided `index` is within
  ///     the valid bounds of `invoiceModel.Invoice_recommendationList`.
  ///     - If the `index` is out of bounds, a debug message "Invalid index provided"
  ///       is printed (in debug mode), and no update occurs.
  /// 2.  **Key and Value Validation:** If the `index` is valid, it then checks
  ///     if both `key` and `value` are non-empty strings.
  ///     - If either `key` or `value` is empty, a debug message "Key and value must not be empty"
  ///       is printed (in debug mode), and no update occurs.
  /// 3.  **Recommendation Update:** If all validations pass (valid index, non-empty key and value),
  ///     a new `Recommendation` object is created with the provided `key` and `value`,
  ///     and it replaces the existing `Recommendation` at the specified `index`
  ///     in `invoiceModel.Invoice_recommendationList`.
  void updateRecommendation({
    required int index,
    required String key,
    required String value,
  }) {
    if (index >= 0 && index < invoiceModel.Invoice_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        invoiceModel.Invoice_recommendationList[index] = Recommendation(key: key, value: value);
      } else {
        if (kDebugMode) {
          print('Key and value must not be empty');
        }
      }
    } else {
      if (kDebugMode) {
        print('Invalid index provided');
      }
    }
  }

  /// Adds a note to the note list if the content is not empty.
  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      invoiceModel.Invoice_noteList.add(noteContent);
    } else {
      if (kDebugMode) {
        print('Note content must not be empty');
      } // Handle empty input (optional)
    }
  }

  /// Adds a new product to the invoice.
  ///
  /// This function attempts to add a new product to the `invoiceModel.Invoice_products` list.
  /// It performs validation on the provided product details to ensure they are valid
  /// before adding the product.
  ///
  /// **Parameters:**
  /// - `context`: The `BuildContext` used for displaying error messages via `Error_SnackBar`.
  /// - `productName`: The name of the product (required, must not be empty after trimming).
  /// - `hsn`: The HSN (Harmonized System of Nomenclature) code for the product (required, must not be empty after trimming, will be parsed as an integer).
  /// - `price`: The price per unit of the product (required, must be greater than 0).
  /// - `quantity`: The quantity of the product (required, must be greater than 0).
  /// - `gst`: The GST (Goods and Services Tax) percentage applicable to the product (required, must be 0 or greater).
  ///
  /// **Functionality:**
  /// 1.  **Input Validation:**
  ///     - It checks if `productName` or `hsn` are empty after trimming whitespace.
  ///     - It checks if `price` is less than or equal to 0.
  ///     - It checks if `quantity` is less than or equal to 0.
  ///     - It checks if `gst` is less than 0.
  ///     - If any of these conditions are true, an `Error_SnackBar` is displayed
  ///       with the message 'Please provide valid product details.', and the function returns,
  ///       preventing the addition of invalid product data.
  /// 2.  **Product Creation and Addition:**
  ///     - If all validations pass, a new `InvoiceProduct` object is created.
  ///     - The `sno` (serial number) is automatically generated by taking the
  ///       current length of `invoiceModel.Invoice_products` and adding 1.
  ///     - `hsn` is parsed to an `int`.
  ///     - The newly created `InvoiceProduct` is then added to the
  ///       `invoiceModel.Invoice_products` list.
  /// 3.  **Error Handling:**
  ///     - A `try-catch` block is used to catch any potential exceptions that
  ///       might occur during the process (e.g., `int.parse(hsn)` failing if `hsn`
  ///       is not a valid integer).
  ///     - If an error occurs, an `Error_SnackBar` is displayed with the message
  ///       'An error occurred while adding the product.'.
  void addProduct({
    required BuildContext context,
    required String productName,
    required String hsn,
    required double price,
    required int quantity,
    required double gst,
  }) {
    try {
      if (productName.trim().isEmpty || hsn.trim().isEmpty || price <= 0 || quantity <= 0 || gst < 0) {
        Error_SnackBar(context, 'Please provide valid product details.');

        return;
      }

      invoiceModel.Invoice_products.add(InvoiceProduct(sno: (invoiceModel.Invoice_products.length + 1), productName: productName, hsn: int.parse(hsn), gst: gst, price: price, quantity: quantity));
    } catch (e) {
      Error_SnackBar(context, 'An error occurred while adding the product.');
    }
  }

  /// Updates an existing product's details in the invoice.
  ///
  /// This function modifies the details of a product already present in the
  /// `invoiceModel.Invoice_products` list at a specified index. It includes
  /// robust validation for both the input data and the provided index.
  ///
  /// **Parameters:**
  /// - `context`: The `BuildContext` used for displaying error messages via `Error_SnackBar`.
  /// - `editIndex`: The zero-based index of the product to be updated in the list. This parameter is `required`.
  /// - `productName`: The new name of the product (required, must not be empty after trimming).
  /// - `hsn`: The new HSN (Harmonized System of Nomenclature) code for the product (required, must not be empty after trimming, will be parsed as an integer).
  /// - `price`: The new price per unit of the product (required, must be greater than 0).
  /// - `quantity`: The new quantity of the product (required, must be greater than 0).
  /// - `gst`: The new GST (Goods and Services Tax) percentage applicable to the product (required, must be 0 or greater).
  ///
  /// **Functionality:**
  /// 1.  **Input Data Validation:**
  ///     - It checks if `productName` or `hsn` are empty after trimming whitespace.
  ///     - It checks if `price` is less than or equal to 0.
  ///     - It checks if `quantity` is less than or equal to 0.
  ///     - It checks if `gst` is less than 0.
  ///     - If any of these conditions are true, an `Error_SnackBar` is displayed
  ///       with the message 'Please provide valid product details.', and the function returns.
  /// 2.  **Index Validation:**
  ///     - It verifies if `editIndex` is a valid index within the bounds of
  ///       `invoiceModel.Invoice_products`.
  ///     - If `editIndex` is less than 0 or greater than or equal to the list's length,
  ///       an `Error_SnackBar` is displayed with 'Invalid product index.', and the
  ///       function returns.
  /// 3.  **Product Update:**
  ///     - If all validations pass, a new `InvoiceProduct` object is created with the
  ///       provided updated details. The `sno` is regenerated based on the `editIndex`
  ///       (adding 1 to make it 1-based).
  ///     - This new `InvoiceProduct` object then **replaces** the existing product
  ///       at the specified `editIndex` in `invoiceModel.Invoice_products`.
  /// 4.  **Error Handling:**
  ///     - A `try-catch` block wraps the entire operation to gracefully handle
  ///       any unexpected errors, such as a `FormatException` if `hsn` cannot be
  ///       parsed to an integer.
  ///     - If an exception occurs, an `Error_SnackBar` is shown to the user with
  ///       the message 'An error occurred while updating the product.'.
  void updateProduct({
    required BuildContext context,
    required int editIndex,
    required String productName,
    required String hsn,
    required double price,
    required int quantity,
    required double gst,
  }) {
    try {
      // Validate input fields
      if (productName.trim().isEmpty || hsn.trim().isEmpty || price <= 0 || quantity <= 0 || gst < 0) {
        Error_SnackBar(context, 'Please provide valid product details.');

        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= invoiceModel.Invoice_products.length) {
        Error_SnackBar(context, 'Invalid product index.');

        return;
      }

      // Update the product details at the specified index
      invoiceModel.Invoice_products[editIndex] = InvoiceProduct(sno: (editIndex + 1), productName: productName, hsn: int.parse(hsn), gst: gst, price: price, quantity: quantity);

      // ProductDetail(
      //   productName: productName.trim(),
      //   hsn: hsn.trim(),
      //   price: price,
      //   quantity: quantity,
      //   gst: gst,
      // );

      // Notify success
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     backgroundColor: Colors.green,
      //     content: Text('Product updated successfully.'),
      //   ),
      // );

      // Optional: Update UI or state if needed
      // .updateProductDetails(invoiceController.invoiceModel.Invoice_productDetails);
    } catch (e) {
      // Handle unexpected errors
      Error_SnackBar(context, 'An error occurred while updating the product.');
    }
  }

  /// Adds product suggestions from a dynamic list to the model.
  void add_productSuggestion(List<dynamic> suggestionList) {
    for (var item in suggestionList) {
      invoiceModel.Invoice_productSuggestion.add(ProductSuggestion.fromJson(item));
      if (kDebugMode) {
        print(invoiceModel.Invoice_productSuggestion[0].productName);
      }
    }
  }

  /// Adds note suggestions from a map to the model.
  void add_noteSuggestion(Map<String, dynamic> suggestionList) {
    for (var item in suggestionList['notes']) {
      invoiceModel.noteSuggestion.add(item);
      if (kDebugMode) {
        print(invoiceModel.noteSuggestion[0]);
      }
    }
  }

  /// Replaces the existing invoice product list with a new list.
  void updateProducts(List<InvoiceProduct> products) {
    invoiceModel.Invoice_products.value = products;
  }

  /// Removes a note from the note list and resets the edit index.
  void removeFromNoteList(int index) {
    invoiceModel.Invoice_noteList.removeAt(index);
    invoiceModel.note_editIndex.value = null;
  }

  /// Removes a recommendation and resets its edit index.
  void removeFromRecommendationList(int index) {
    invoiceModel.Invoice_recommendationList.removeAt(index);
    // invoiceModel.Invoice_recommendationList.isEmpty ? invoiceModel.recommendationHeadingController.value.clear() : null;
    invoiceModel.recommendation_editIndex.value = null;
  }

  /// Removes a product from the list and resets the edit index.
  void removeFromProductList(index) {
    invoiceModel.Invoice_products.removeAt(index);
    invoiceModel.product_editIndex.value = null;
  }

  /// Updates invoice fields using data from the CMDmResponse object.
  void update_requiredData(CMDmResponse value) {
    RequiredData instance = RequiredData.fromJson(value);
    invoiceModel.Invoice_no.value = instance.eventnumber;
    updateInvoicenumber(instance.eventnumber);
    updateTitle(instance.title!);
    updateEmail(instance.emailId!);
    updateGSTnumber(instance.gst!);
    updatePhone(instance.phoneNo!);
    updateClientAddressName(instance.name!);
    updateClientAddress(instance.address!);
    updateBillingAddressName(instance.billingAddressName!);
    updateBillingAddress(instance.billingAddress!);
    updateProducts(instance.product);
    // for(int i=0;i<instance.product.length;i++){
    //    invoiceController.addProduct(context: context, productName: invoiceController.invoiceModel.productNameController.value.text, hsn: invoiceController.invoiceModel.hsnController.value.text, price: double.parse(invoiceController.invoiceModel.priceController.value.text), quantity: int.parse(invoiceController.invoiceModel.quantityController.value.text), gst: double.parse(invoiceController.invoiceModel.gstController.value.text));

    // }
  }

  /// Validates if all required fields are filled before generating data.
  bool generate_Datavalidation() {
    return (invoiceModel.TitleController.value.text.isEmpty ||
        invoiceModel.processID.value == null ||
        invoiceModel.clientAddressNameController.value.text.isEmpty ||
        invoiceModel.clientAddressController.value.text.isEmpty ||
        invoiceModel.billingAddressNameController.value.text.isEmpty ||
        invoiceModel.billingAddressController.value.text.isEmpty ||
        invoiceModel.gstNumController.value.text.isEmpty ||
        invoiceModel.Invoice_gstTotals.isEmpty ||
        invoiceModel.Invoice_noteList.isEmpty ||
        invoiceModel.Invoice_no.value == null);
  }

  /// Validates data before posting, including email/phone if selected.
  bool postDatavalidation() {
    return (invoiceModel.TitleController.value.text.isEmpty ||
        invoiceModel.processID.value == null ||
        invoiceModel.clientAddressNameController.value.text.isEmpty ||
        invoiceModel.clientAddressController.value.text.isEmpty ||
        invoiceModel.billingAddressNameController.value.text.isEmpty ||
        invoiceModel.billingAddressController.value.text.isEmpty ||
        (invoiceModel.gmail_selectionStatus.value && invoiceModel.emailController.value.text.isEmpty) ||
        (invoiceModel.whatsapp_selectionStatus.value && invoiceModel.phoneController.value.text.isEmpty) ||
        invoiceModel.gstNumController.value.text.isEmpty ||
        invoiceModel.Invoice_gstTotals.isEmpty ||
        invoiceModel.Invoice_gstTotals.isEmpty ||
        invoiceModel.Invoice_noteList.isEmpty ||
        invoiceModel.Invoice_no.value == null);
  }
  // If any one is empty or null, then it returns true

  // void resetData() {
  //   invoiceModel.tabController.value = null;
  //   invoiceModel.processID.value = null;
  //   invoiceModel.Invoice_no.value = null;
  //   invoiceModel.gstNumController.value.text = "";
  //   invoiceModel.Invoice_table_heading.value = "";

  //   invoiceModel.phoneController.value.text = "";
  //   invoiceModel.emailController.value.text = "";
  //   invoiceModel.CCemailToggle.value = false;
  //   invoiceModel.CCemailController.value.clear();
  //   // Reset details
  //   invoiceModel.TitleController.value.text = "";
  //   invoiceModel.clientAddressNameController.value.text = "";
  //   invoiceModel.clientAddressController.value.text = "";
  //   invoiceModel.billingAddressNameController.value.text = "";
  //   invoiceModel.billingAddressController.value.text = "";

  //   // Reset product details
  //   invoiceModel.product_editIndex.value = null;
  //   invoiceModel.productNameController.value.text = "";
  //   invoiceModel.hsnController.value.text = "";
  //   invoiceModel.priceController.value.text = "";
  //   invoiceModel.quantityController.value.text = "";
  //   invoiceModel.gstController.value.text = "";
  //   invoiceModel.Invoice_products.clear();
  //   invoiceModel.Invoice_gstTotals.clear();
  //   invoiceModel.Invoice_productSuggestion.clear();

  //   // Reset notes
  //   invoiceModel.note_editIndex.value = null;
  //   invoiceModel.notecontentController.value.text = "";
  //   invoiceModel.recommendation_editIndex.value = null;
  //   invoiceModel.recommendationHeadingController.value.text = "";
  //   invoiceModel.recommendationKeyController.value.text = "";
  //   invoiceModel.recommendationValueController.value.text = "";
  //   invoiceModel.Invoice_noteList.clear();
  //   invoiceModel.Invoice_recommendationList.clear();
  //   invoiceModel.noteSuggestion.clear();
  // }

  void resetData() {
    // TAB, PROCESS & GENERAL
    invoiceModel.tabController.value = null;
    invoiceModel.processID.value = null;
    invoiceModel.Invoice_no.value = null;
    // invoiceModel.Invoice_table_heading.value = '';
    invoiceModel.gstNumController.value.clear();
    invoiceModel.invoice_amount.value = null;
    invoiceModel.invoice_subTotal.value = null;
    invoiceModel.invoice_CGSTamount.value = null;
    invoiceModel.invoice_SGSTamount.value = null;
    invoiceModel.invoice_IGSTamount.value = null;

    // DETAILS
    invoiceModel.TitleController.value.clear();
    invoiceModel.clientAddressNameController.value.clear();
    invoiceModel.clientAddressController.value.clear();
    invoiceModel.billingAddressNameController.value.clear();
    invoiceModel.billingAddressController.value.clear();
    invoiceModel.detailsKey.value = GlobalKey<FormState>();

    // PRODUCTS
    invoiceModel.productKey.value = GlobalKey<FormState>();
    invoiceModel.product_editIndex.value = null;
    invoiceModel.productNameController.value.clear();
    invoiceModel.hsnController.value.clear();
    invoiceModel.priceController.value.clear();
    invoiceModel.quantityController.value.clear();
    invoiceModel.gstController.value.clear();
    invoiceModel.Invoice_products.clear();
    invoiceModel.Invoice_productSuggestion.clear();
    invoiceModel.Invoice_gstTotals.clear();

    // NOTES
    invoiceModel.noteformKey.value = GlobalKey<FormState>();
    invoiceModel.progress.value = 0.0;
    invoiceModel.isLoading.value = false;
    invoiceModel.note_editIndex.value = null;
    invoiceModel.notecontentController.value.clear();
    invoiceModel.recommendation_editIndex.value = null;
    invoiceModel.recommendationHeadingController.value.clear();
    invoiceModel.recommendationKeyController.value.clear();
    invoiceModel.recommendationValueController.value.clear();
    invoiceModel.Invoice_noteList.clear();
    invoiceModel.Invoice_recommendationList.clear();
    invoiceModel.noteSuggestion.clear();

    // POST
    invoiceModel.pickedFile.value = null;
    invoiceModel.selectedPdf.value = null;
    invoiceModel.ispdfLoading.value = false;
    invoiceModel.whatsapp_selectionStatus.value = true;
    invoiceModel.gmail_selectionStatus.value = true;
    invoiceModel.phoneController.value.clear();
    invoiceModel.emailController.value.clear();
    invoiceModel.CCemailController.value.clear();
    invoiceModel.feedbackController.value.clear();
    invoiceModel.filePathController.value.clear();
    invoiceModel.CCemailToggle.value = false;
    invoiceModel.isGST_local.value = true;
  }
}
