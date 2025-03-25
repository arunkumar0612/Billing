import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/constants/SUBSCRIPTION_constants/SUBSCRIPTION_invoice_constants.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Invoice_entities.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Sites_entities.dart';

class SUBSCRIPTION_InvoiceController extends GetxController {
  var invoiceModel = SUBSCRIPTION_InvoiceModel();

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

  void updateChallanTableHeading(String tableHeading) {
    invoiceModel.Invoice_table_heading.value = tableHeading;
  }

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
    if (invoiceModel.whatsapp_selectionStatus.value) return 1;
    if (invoiceModel.gmail_selectionStatus.value) return 2;

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
      invoiceModel.Invoice_recommendationList.add(SUBSCRIPTION_Recommendation(key: key, value: value));
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
        invoiceModel.Invoice_recommendationList[index] = SUBSCRIPTION_Recommendation(key: key, value: value);
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      invoiceModel.Invoice_products.add(
          SUBSCRIPTION_InvoiceSite(sno: (invoiceModel.Invoice_products.length + 1), siteName: productName, hsn: int.parse(hsn), gst: gst, price: price, quantity: quantity));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('An error occurred while adding the product.'),
        ),
      );
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= invoiceModel.Invoice_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      invoiceModel.Invoice_products[editIndex] = SUBSCRIPTION_InvoiceSite(sno: (editIndex + 1), siteName: productName, hsn: int.parse(hsn), gst: gst, price: price, quantity: quantity);

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('An error occurred while updating the product.'),
        ),
      );
    }
  }

  void add_productSuggestion(List<dynamic> suggestionList) {
    for (var item in suggestionList) {
      invoiceModel.Invoice_productSuggestion.add(SUBSCRIPTION_SiteSuggestion.fromJson(item));
      if (kDebugMode) {
        print(invoiceModel.Invoice_productSuggestion[0].siteName);
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
  void updateProducts(List<SUBSCRIPTION_InvoiceSite> products) {
    invoiceModel.Invoice_products.value = products;
  }

  void removeFromNoteList(int index) {
    invoiceModel.Invoice_noteList.removeAt(index);
  }

  void removeFromRecommendationList(int index) {
    invoiceModel.Invoice_recommendationList.removeAt(index);
    invoiceModel.Invoice_recommendationList.isEmpty ? invoiceModel.recommendationHeadingController.value.clear() : null;
  }

  void removeFromProductList(index) {
    invoiceModel.Invoice_products.removeAt(index);
  }

  void update_requiredData(CMDmResponse value) {
    SUBSCRIPTION_RequiredData instance = SUBSCRIPTION_RequiredData.fromJson(value);
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
    updateProducts(instance.site);
    // for(int i=0;i<instance.product.length;i++){
    //    invoiceController.addProduct(context: context, productName: invoiceController.invoiceModel.productNameController.value.text, hsn: invoiceController.invoiceModel.hsnController.value.text, price: double.parse(invoiceController.invoiceModel.priceController.value.text), quantity: int.parse(invoiceController.invoiceModel.quantityController.value.text), gst: double.parse(invoiceController.invoiceModel.gstController.value.text));

    // }
  }

  bool postDatavalidation() {
    return (invoiceModel.TitleController.value.text.isEmpty ||
        invoiceModel.processID.value == null ||
        invoiceModel.clientAddressNameController.value.text.isEmpty ||
        invoiceModel.clientAddressController.value.text.isEmpty ||
        invoiceModel.billingAddressNameController.value.text.isEmpty ||
        invoiceModel.billingAddressController.value.text.isEmpty ||
        invoiceModel.emailController.value.text.isEmpty ||
        invoiceModel.phoneController.value.text.isEmpty ||
        invoiceModel.gstNumController.value.text.isEmpty ||
        invoiceModel.Invoice_products.isEmpty ||
        invoiceModel.Invoice_noteList.isEmpty ||
        invoiceModel.Invoice_no.value == null);
  } // If any one is empty or null, then it returns true

  void resetData() {
    invoiceModel.tabController.value = null;
    invoiceModel.processID.value = null;
    invoiceModel.Invoice_no.value = null;
    invoiceModel.gstNumController.value.text = "";
    invoiceModel.Invoice_table_heading.value = "";

    invoiceModel.phoneController.value.text = "";
    invoiceModel.emailController.value.text = "";
    invoiceModel.CCemailToggle.value = false;
    invoiceModel.CCemailController.value.clear();
    // Reset details
    invoiceModel.TitleController.value.text = "";
    invoiceModel.clientAddressNameController.value.text = "";
    invoiceModel.clientAddressController.value.text = "";
    invoiceModel.billingAddressNameController.value.text = "";
    invoiceModel.billingAddressController.value.text = "";

    // Reset product details
    invoiceModel.product_editIndex.value = null;
    invoiceModel.productNameController.value.text = "";
    invoiceModel.hsnController.value.text = "";
    invoiceModel.priceController.value.text = "";
    invoiceModel.quantityController.value.text = "";
    invoiceModel.gstController.value.text = "";
    invoiceModel.Invoice_products.clear();
    invoiceModel.Invoice_gstTotals.clear();
    invoiceModel.Invoice_productSuggestion.clear();

    // Reset notes
    invoiceModel.note_editIndex.value = null;
    invoiceModel.notecontentController.value.text = "";
    invoiceModel.recommendation_editIndex.value = null;
    invoiceModel.recommendationHeadingController.value.text = "";
    invoiceModel.recommendationKeyController.value.text = "";
    invoiceModel.recommendationValueController.value.text = "";
    invoiceModel.Invoice_noteList.clear();
    invoiceModel.Invoice_recommendationList.clear();
    invoiceModel.noteSuggestion.clear();
  }
}
