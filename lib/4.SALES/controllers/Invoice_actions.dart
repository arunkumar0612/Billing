import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Invoice_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/product_entities.dart';
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

  /// Opens a file picker dialog to select an image file.
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

  /// Starts a simulated progress animation from 0 to 100%.
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

  /// Updates a recommendation at a given index if valid and non-empty.
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

  /// Adds a product to the invoice if all fields are valid.
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

  /// Updates a product at the specified index if all fields are valid.
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
