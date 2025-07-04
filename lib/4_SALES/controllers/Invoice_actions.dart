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

  void initializeTabController(TabController tabController) {
    invoiceModel.tabController.value = tabController;
  }

  void nextTab() {
    if (invoiceModel.tabController.value!.index < invoiceModel.tabController.value!.length - 1) {
      invoiceModel.tabController.value!.animateTo(invoiceModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (invoiceModel.tabController.value!.index > 0) {
      invoiceModel.tabController.value!.animateTo(invoiceModel.tabController.value!.index - 1);
    }
  }

  void updateProductName(String productName) {
    invoiceModel.productNameController.value.text = productName;
  }

  void updateHSN(int hsn) {
    invoiceModel.hsnController.value.text = hsn.toString();
  }

  void updatePrice(double price) {
    invoiceModel.priceController.value.text = price.toString();
  }

  void updateQuantity(int quantity) {
    invoiceModel.quantityController.value.text = quantity.toString();
  }

  void updateGST(double gst) {
    invoiceModel.gstController.value.text = gst.toString();
  }

  void updateNoteEditindex(int? index) {
    invoiceModel.note_editIndex.value = index;
  }

  // void updateChallanTableHeading(String tableHeading) {
  //   invoiceModel.Invoice_table_heading.value = tableHeading;
  // }

  void updateNoteList(String value, int index) {
    invoiceModel.Invoice_noteList[invoiceModel.note_editIndex.value!] = invoiceModel.notecontentController.value.text;
  }

  void updateTabController(TabController tabController) {
    invoiceModel.tabController.value = tabController;
  }

  void updateTitle(String text) {
    invoiceModel.TitleController.value.text = text;
  }

  void updateInvoicenumber(String text) {
    invoiceModel.Invoice_no.value = text;
  }

  void updateGSTnumber(String text) {
    invoiceModel.gstNumController.value.text = text;
  }

  void updateClientAddressName(String text) {
    invoiceModel.clientAddressNameController.value.text = text;
  }

  void updateClientAddress(String text) {
    invoiceModel.clientAddressController.value.text = text;
  }

  void updateBillingAddressName(String text) {
    invoiceModel.billingAddressNameController.value.text = text;
  }

  void updateBillingAddress(String text) {
    invoiceModel.billingAddressController.value.text = text;
  }

  void updatePhone(String phone) {
    invoiceModel.phoneController.value.text = phone;
  }

  void updateEmail(String email) {
    invoiceModel.emailController.value.text = email;
  }

  void updatCC(String CC) {
    invoiceModel.CCemailController.value.text = CC;
  }

  void toggleCCemailvisibility(bool value) {
    invoiceModel.CCemailToggle.value = value;
  }

  void updateRecommendationEditindex(int? index) {
    invoiceModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    invoiceModel.notecontentController.value.text = text;
  }

  void updateRec_HeadingControllerText(String text) {
    invoiceModel.recommendationHeadingController.value.text = text;
  }

  void updateRec_KeyControllerText(String text) {
    invoiceModel.recommendationKeyController.value.text = text;
  }

  void updateRec_ValueControllerText(String text) {
    invoiceModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    invoiceModel.noteSuggestion.add(note);
  }

  void addProductEditindex(int? index) {
    invoiceModel.product_editIndex.value = index;
  }

  void setProcessID(int processid) {
    invoiceModel.processID.value = processid;
  }

  void updateSelectedPdf(File file) {
    invoiceModel.selectedPdf.value = file;
  }

  // Toggle loading state
  void setLoading(bool value) {
    invoiceModel.isLoading.value = value;
  }

  void setpdfLoading(bool value) {
    invoiceModel.ispdfLoading.value = value;
  }

  // Toggle WhatsApp state
  void toggleWhatsApp(bool value) {
    invoiceModel.whatsapp_selectionStatus.value = value;
  }

  // Toggle Gmail state
  void toggleGmail(bool value) {
    invoiceModel.gmail_selectionStatus.value = value;
  }

  // Update phone number text
  void updatePhoneNumber(String phoneNumber) {
    invoiceModel.phoneController.value.text = phoneNumber;
  }

  // Update feedback text
  void updateFeedback(String feedback) {
    invoiceModel.feedbackController.value.text = feedback;
  }

  // Update file path text
  void updateFilePath(String filePath) {
    invoiceModel.filePathController.value.text = filePath;
  }

  void update_invoiceAmount(double amount) {
    invoiceModel.invoice_amount.value = amount;
  }

  void update_invoiceSubTotal(double amount) {
    invoiceModel.invoice_subTotal.value = amount;
  }

  void update_invoiceCGSTAmount(double amount) {
    invoiceModel.invoice_CGSTamount.value = amount;
  }

  void update_invoiceSGSTAmount(double amount) {
    invoiceModel.invoice_SGSTamount.value = amount;
  }

  void update_invoiceIGSTAmount(double amount) {
    invoiceModel.invoice_IGSTamount.value = amount;
  }

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

  int fetch_messageType() {
    if (invoiceModel.whatsapp_selectionStatus.value && invoiceModel.gmail_selectionStatus.value) return 3;
    if (invoiceModel.whatsapp_selectionStatus.value) return 2;
    if (invoiceModel.gmail_selectionStatus.value) return 1;

    return 0;
  }

  Future<void> startProgress() async {
    setLoading(true);
    invoiceModel.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      invoiceModel.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      invoiceModel.Invoice_recommendationList.add(Recommendation(key: key, value: value));
    } else {
      if (kDebugMode) {
        print('Key and value must not be empty');
      }
    }
  }

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

  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      invoiceModel.Invoice_noteList.add(noteContent);
    } else {
      if (kDebugMode) {
        print('Note content must not be empty');
      } // Handle empty input (optional)
    }
  }

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

  void add_productSuggestion(List<dynamic> suggestionList) {
    for (var item in suggestionList) {
      invoiceModel.Invoice_productSuggestion.add(ProductSuggestion.fromJson(item));
      if (kDebugMode) {
        print(invoiceModel.Invoice_productSuggestion[0].productName);
      }
    }
  }

  void add_noteSuggestion(Map<String, dynamic> suggestionList) {
    for (var item in suggestionList['notes']) {
      invoiceModel.noteSuggestion.add(item);
      if (kDebugMode) {
        print(invoiceModel.noteSuggestion[0]);
      }
    }
  }

  // Update products list
  void updateProducts(List<InvoiceProduct> products) {
    invoiceModel.Invoice_products.value = products;
  }

  void removeFromNoteList(int index) {
    invoiceModel.Invoice_noteList.removeAt(index);
    invoiceModel.note_editIndex.value = null;
  }

  void removeFromRecommendationList(int index) {
    invoiceModel.Invoice_recommendationList.removeAt(index);
    // invoiceModel.Invoice_recommendationList.isEmpty ? invoiceModel.recommendationHeadingController.value.clear() : null;
    invoiceModel.recommendation_editIndex.value = null;
  }

  void removeFromProductList(index) {
    invoiceModel.Invoice_products.removeAt(index);
    invoiceModel.product_editIndex.value = null;
  }

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
