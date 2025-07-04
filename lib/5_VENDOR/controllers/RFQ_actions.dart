import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/constants/RFQ_constants.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/RFQ_entities.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class vendor_RfqController extends GetxController {
  var rfqModel = RfqModel();

  void initializeTabController(TabController tabController) {
    rfqModel.tabController.value = tabController;
  }

  void nextTab() {
    if (rfqModel.tabController.value!.index < rfqModel.tabController.value!.length - 1) {
      rfqModel.tabController.value!.animateTo(rfqModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (rfqModel.tabController.value!.index > 0) {
      rfqModel.tabController.value!.animateTo(rfqModel.tabController.value!.index - 1);
    }
  }

  void updateProductName(String productName) {
    rfqModel.productNameController.value.text = productName;
  }

  void updateQuantity(int quantity) {
    rfqModel.quantityController.value.text = quantity.toString();
  }

  void updateNoteEditindex(int? index) {
    rfqModel.note_editIndex.value = index;
  }

  // void updateChallanTableHeading(String tableHeading) {
  //   rfqModel.Rfq_table_heading.value = tableHeading;
  // }

  void updateNoteList(String value, int index) {
    rfqModel.Rfq_noteList[rfqModel.note_editIndex.value!] = rfqModel.notecontentController.value.text;
  }

  void updateTabController(TabController tabController) {
    rfqModel.tabController.value = tabController;
  }

  void updateTitle(String text) {
    rfqModel.TitleController.value.text = text;
  }

  void updateRfqnumber(String text) {
    rfqModel.Rfq_no.value = text;
  }

  // void updateGSTnumber(String text) {
  //   rfqModel.gstNumController.value.text = text;
  // }

  // void updateClientAddressName(String text) {
  //   rfqModel.clientAddressNameController.value.text = text;
  // }

  void updateAddress(String text) {
    rfqModel.AddressController.value.text = text;
  }

  // void updateBillingAddressName(String text) {
  //   rfqModel.billingAddressNameController.value.text = text;
  // }

  // void updateBillingAddress(String text) {
  //   rfqModel.billingAddressController.value.text = text;
  // }

  void updatePhone(String phone) {
    rfqModel.phoneController.value.text = phone;
  }

  void updateEmail(String email) {
    rfqModel.emailController.value.text = email;
  }

  void updatCC(String CC) {
    rfqModel.CCemailController.value.text = CC;
  }

  void toggleCCemailvisibility(bool value) {
    rfqModel.CCemailToggle.value = value;
  }

  void updateRecommendationEditindex(int? index) {
    rfqModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    rfqModel.notecontentController.value.text = text;
  }

  void updateRec_HeadingControllerText(String text) {
    rfqModel.recommendationHeadingController.value.text = text;
  }

  void updateRec_KeyControllerText(String text) {
    rfqModel.recommendationKeyController.value.text = text;
  }

  void updateRec_ValueControllerText(String text) {
    rfqModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    rfqModel.noteSuggestion.add(note);
  }

  void addProductEditindex(int? index) {
    rfqModel.product_editIndex.value = index;
  }

  void setProcessID(int processid) {
    rfqModel.processID.value = processid;
  }

  void updateSelectedPdf(File file) {
    rfqModel.selectedPdf.value = file;
  }

  // Toggle loading state
  void setLoading(bool value) {
    rfqModel.isLoading.value = value;
  }

  void setpdfLoading(bool value) {
    rfqModel.ispdfLoading.value = value;
  }

  // Toggle WhatsApp state
  void toggleWhatsApp(bool value) {
    rfqModel.whatsapp_selectionStatus.value = value;
  }

  // Toggle Gmail state
  void toggleGmail(bool value) {
    rfqModel.gmail_selectionStatus.value = value;
  }

  // Update phone number text
  void updatePhoneNumber(String phoneNumber) {
    rfqModel.phoneController.value.text = phoneNumber;
  }

  // Update feedback text
  void updateFeedback(String feedback) {
    rfqModel.feedbackController.value.text = feedback;
  }

  // Update file path text
  void updateFilePath(String filePath) {
    rfqModel.filePathController.value.text = filePath;
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
        rfqModel.pickedFile.value = null;
        rfqModel.selectedPdf.value = null;
      } else {
        rfqModel.pickedFile.value = result;
        rfqModel.selectedPdf.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  int fetch_messageType() {
    if (rfqModel.whatsapp_selectionStatus.value && rfqModel.gmail_selectionStatus.value) return 3;
    if (rfqModel.whatsapp_selectionStatus.value) return 2;
    if (rfqModel.gmail_selectionStatus.value) return 1;

    return 0;
  }

  Future<void> startProgress() async {
    setLoading(true);
    rfqModel.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      rfqModel.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      rfqModel.Rfq_recommendationList.add(Recommendation(key: key, value: value));
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
    if (index >= 0 && index < rfqModel.Rfq_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        rfqModel.Rfq_recommendationList[index] = Recommendation(key: key, value: value);
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
      rfqModel.Rfq_noteList.add(noteContent);
    } else {
      if (kDebugMode) {
        print('Note content must not be empty');
      } // Handle empty input (optional)
    }
  }

  void addProduct({
    required BuildContext context,
    required String productName,
    required int quantity,
  }) {
    try {
      if (productName.trim().isEmpty || quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      rfqModel.Rfq_products.add(RFQProduct(sno: (rfqModel.Rfq_products.length + 1), productName: productName, quantity: quantity));
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
    // required String hsn,
    // required double price,
    required int quantity,
    // required double gst,
  }) {
    try {
      // Validate input fields
      if (productName.trim().isEmpty || quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= rfqModel.Rfq_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      rfqModel.Rfq_products[editIndex] = RFQProduct(sno: (editIndex + 1), productName: productName, quantity: quantity);

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
      // .updateProductDetails(vendor_RfqController.rfqModel.Rfq_productDetails);
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
      rfqModel.Rfq_productSuggestion.add(ProductSuggestion.fromJson(item));
    }
  }

  void add_noteSuggestion(Map<String, dynamic> suggestionList) {
    for (var item in suggestionList['notes']) {
      rfqModel.noteSuggestion.add(item);
      if (kDebugMode) {
        print(rfqModel.noteSuggestion[0]);
      }
    }
  }

  // Update products list
  void updateProducts(List<RFQProduct> products) {
    rfqModel.Rfq_products.value = products;
  }

  void removeFromNoteList(int index) {
    rfqModel.Rfq_noteList.removeAt(index);
    rfqModel.note_editIndex.value = null;
  }

  void removeFromRecommendationList(int index) {
    rfqModel.Rfq_recommendationList.removeAt(index);
    // rfqModel.Rfq_recommendationList.isEmpty ? rfqModel.recommendationHeadingController.value.clear() : null;
    rfqModel.recommendation_editIndex.value = null;
  }

  void removeFromProductList(index) {
    rfqModel.Rfq_products.removeAt(index);
    rfqModel.product_editIndex.value = null;
  }

  void update_requiredData(CMDmResponse value) {
    RequiredData instance = RequiredData.fromJson(value);
    updateRfqnumber(instance.eventnumber);

    // updateRfqnumber(instance.eventnumber);
    // updateTitle(instance.title!);
    // updateEmail(instance.emailId!);
    // updateGSTnumber(instance.gst!);
    // updatePhone(instance.phoneNo!);
    // // updateClientAddressName(instance.name!);
    // updateClientAddress(instance.address!);
    // // updateBillingAddressName(instance.billingAddressName!);
    // // updateBillingAddress(instance.billingAddress!);
    // updateProducts(instance.product);
    // // for(int i=0;i<instance.product.length;i++){
    // //    vendor_RfqController.addProduct(context: context, productName: vendor_RfqController.rfqModel.productNameController.value.text, hsn: vendor_RfqController.rfqModel.hsnController.value.text, price: double.parse(vendor_RfqController.rfqModel.priceController.value.text), quantity: int.parse(vendor_RfqController.rfqModel.quantityController.value.text), gst: double.parse(vendor_RfqController.rfqModel.gstController.value.text));

    // // }
  }

  void on_vendorSelected() {}
  void update_vendorList(CMDlResponse value) {
    rfqModel.vendorList.clear();
    for (int i = 0; i < value.data.length; i++) {
      rfqModel.vendorList.add(VendorList.fromJson(value, i));
      if (kDebugMode) {
        print(rfqModel.vendorList);
      }
    }
    if (kDebugMode) {
      print(rfqModel.vendorList);
    }
  }

  void update_vendorCredentials_onSelect(VendorList selectedVendor) {
    rfqModel.vendorName.value = selectedVendor.vendorName;
    rfqModel.vendorID.value = selectedVendor.vendorID;
    rfqModel.AddressController.value.text = selectedVendor.vendorAddress;
    rfqModel.emailController.value.text = selectedVendor.vendorMail;
    rfqModel.phoneController.value.text = selectedVendor.vendorPhoneNo;
  }

  bool generate_Datavalidation() {
    return (rfqModel.TitleController.value.text.isEmpty ||
        rfqModel.processID.value == null ||
        rfqModel.vendorID.value == null ||
        rfqModel.vendorName.value == null ||
        rfqModel.AddressController.value.text.isEmpty ||
        rfqModel.Rfq_products.isEmpty ||
        rfqModel.Rfq_noteList.isEmpty);
  }

  bool postDatavalidation() {
    return (rfqModel.TitleController.value.text.isEmpty ||
        rfqModel.processID.value == null ||
        rfqModel.vendorID.value == null ||
        rfqModel.vendorName.value == null ||
        rfqModel.AddressController.value.text.isEmpty ||
        (rfqModel.gmail_selectionStatus.value && rfqModel.emailController.value.text.isEmpty) ||
        (rfqModel.whatsapp_selectionStatus.value && rfqModel.phoneController.value.text.isEmpty) ||
        rfqModel.Rfq_products.isEmpty ||
        rfqModel.Rfq_noteList.isEmpty);
  }
  // If any one is empty or null, then it returns true

  // void resetData() {
  //   rfqModel.tabController.value = null;
  //   rfqModel.processID.value = null;
  //   rfqModel.Rfq_no.value = null;
  //   rfqModel.vendorID.value = null;
  //   rfqModel.vendorName.value = null;
  //   // rfqModel.gstNumController.value.text = "";
  //   rfqModel.Rfq_table_heading.value = "";

  //   rfqModel.phoneController.value.text = "";
  //   rfqModel.emailController.value.text = "";
  //   rfqModel.CCemailToggle.value = false;
  //   rfqModel.CCemailController.value.clear();
  //   // Reset details
  //   rfqModel.TitleController.value.text = "";
  //   // rfqModel.clientAddressNameController.value.text = "";
  //   rfqModel.AddressController.value.text = "";
  //   // rfqModel.billingAddressNameController.value.text = "";
  //   // rfqModel.billingAddressController.value.text = "";

  //   // Reset product details
  //   rfqModel.product_editIndex.value = null;
  //   rfqModel.productNameController.value.text = "";
  //   // rfqModel.hsnController.value.text = "";
  //   // rfqModel.priceController.value.text = "";
  //   rfqModel.quantityController.value.text = "";
  //   // rfqModel.gstController.value.text = "";
  //   rfqModel.Rfq_products.clear();
  //   // rfqModel.Rfq_gstTotals.clear();
  //   rfqModel.Rfq_productSuggestion.clear();

  //   // Reset notes
  //   rfqModel.note_editIndex.value = null;
  //   rfqModel.notecontentController.value.text = "";
  //   rfqModel.recommendation_editIndex.value = null;
  //   rfqModel.recommendationHeadingController.value.text = "";
  //   rfqModel.recommendationKeyController.value.text = "";
  //   rfqModel.recommendationValueController.value.text = "";
  //   rfqModel.Rfq_noteList.clear();
  //   rfqModel.Rfq_recommendationList.clear();
  //   rfqModel.noteSuggestion.clear();
  // }

  void resetData() {
    // TAB, PROCESS & GENERAL
    rfqModel.tabController.value = null;
    rfqModel.processID.value = null;
    rfqModel.vendorID.value = null;
    rfqModel.vendorName.value = null;
    rfqModel.Rfq_no.value = null;
    // rfqModel.Rfq_table_heading.value = '';
    rfqModel.vendorList.clear();

    // DETAILS
    rfqModel.TitleController.value.clear();
    rfqModel.AddressController.value.clear();
    rfqModel.detailsKey.value = GlobalKey<FormState>();

    // PRODUCTS
    rfqModel.productKey.value = GlobalKey<FormState>();
    rfqModel.product_editIndex.value = null;
    rfqModel.productNameController.value.clear();
    rfqModel.quantityController.value.clear();
    rfqModel.Rfq_products.clear();
    rfqModel.Rfq_productSuggestion.clear();

    // NOTES
    rfqModel.noteformKey.value = GlobalKey<FormState>();
    rfqModel.progress.value = 0.0;
    rfqModel.isLoading.value = false;
    rfqModel.note_editIndex.value = null;
    rfqModel.notecontentController.value.clear();
    rfqModel.recommendation_editIndex.value = null;
    rfqModel.recommendationHeadingController.value.clear();
    rfqModel.recommendationKeyController.value.clear();
    rfqModel.recommendationValueController.value.clear();
    rfqModel.Rfq_noteList.clear();
    rfqModel.Rfq_recommendationList.clear();
    rfqModel.noteSuggestion.clear();

    // POST
    rfqModel.pickedFile.value = null;
    rfqModel.selectedPdf.value = null;
    rfqModel.ispdfLoading.value = false;
    rfqModel.whatsapp_selectionStatus.value = true;
    rfqModel.gmail_selectionStatus.value = true;
    rfqModel.phoneController.value.clear();
    rfqModel.emailController.value.clear();
    rfqModel.CCemailController.value.clear();
    rfqModel.feedbackController.value.clear();
    rfqModel.filePathController.value.clear();
    rfqModel.CCemailToggle.value = false;
  }
}
