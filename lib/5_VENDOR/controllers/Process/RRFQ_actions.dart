import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/constants/RRFQ_constants.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/RRFQ_entities.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class vendor_RrfqController extends GetxController {
  var rrfqModel = RrfqModel();

  void initializeTabController(TabController tabController) {
    rrfqModel.tabController.value = tabController;
  }

  void nextTab() {
    if (rrfqModel.tabController.value!.index < rrfqModel.tabController.value!.length - 1) {
      rrfqModel.tabController.value!.animateTo(rrfqModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (rrfqModel.tabController.value!.index > 0) {
      rrfqModel.tabController.value!.animateTo(rrfqModel.tabController.value!.index - 1);
    }
  }

  void updateProductName(String productName) {
    rrfqModel.productNameController.value.text = productName;
  }

  void updateQuantity(int quantity) {
    rrfqModel.quantityController.value.text = quantity.toString();
  }

  void updateNoteEditindex(int? index) {
    rrfqModel.note_editIndex.value = index;
  }

  // void updateChallanTableHeading(String tableHeading) {
  //   rrfqModel.Rrfq_table_heading.value = tableHeading;
  // }

  void updateNoteList(String value, int index) {
    rrfqModel.Rrfq_noteList[rrfqModel.note_editIndex.value!] = rrfqModel.notecontentController.value.text;
  }

  void updateTabController(TabController tabController) {
    rrfqModel.tabController.value = tabController;
  }

  void updateRrfqnumber(String text) {
    rrfqModel.Rrfq_no.value = text;
  }

  // void updateGSTnumber(String text) {
  //   rrfqModel.gstNumController.value.text = text;
  // }

  // void updateClientAddressName(String text) {
  //   rrfqModel.clientAddressNameController.value.text = text;
  // }

  void updateAddress(String text) {
    rrfqModel.AddressController.value.text = text;
  }

  void updateGSTIN(String text) {
    rrfqModel.GSTIN_Controller.value.text = text;
  }

  void updatePAN(String text) {
    rrfqModel.PAN_Controller.value.text = text;
  }

  void update_contactPerson(String text) {
    rrfqModel.contactPerson_Controller.value.text = text;
  }

  // void updateBillingAddressName(String text) {
  //   rrfqModel.billingAddressNameController.value.text = text;
  // }

  // void updateBillingAddress(String text) {
  //   rrfqModel.billingAddressController.value.text = text;
  // }

  void updateEmail(String email) {
    rrfqModel.emailController.value.text = email;
  }

  void updatCC(String CC) {
    rrfqModel.CCemailController.value.text = CC;
  }

  void toggleCCemailvisibility(bool value) {
    rrfqModel.CCemailToggle.value = value;
  }

  void updateRecommendationEditindex(int? index) {
    rrfqModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    rrfqModel.notecontentController.value.text = text;
  }

  void updateRec_HeadingControllerText(String text) {
    rrfqModel.recommendationHeadingController.value.text = text;
  }

  void updateRec_KeyControllerText(String text) {
    rrfqModel.recommendationKeyController.value.text = text;
  }

  void updateRec_ValueControllerText(String text) {
    rrfqModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    rrfqModel.noteSuggestion.add(note);
  }

  void addProductEditindex(int? index) {
    rrfqModel.product_editIndex.value = index;
  }

  void updateSelectedPdf(File file) {
    rrfqModel.selectedPdf.value = file;
  }

  // Toggle loading state
  void setLoading(bool value) {
    rrfqModel.isLoading.value = value;
  }

  void setpdfLoading(bool value) {
    rrfqModel.ispdfLoading.value = value;
  }

  // Toggle WhatsApp state
  void toggleWhatsApp(bool value) {
    rrfqModel.whatsapp_selectionStatus.value = value;
  }

  // Toggle Gmail state
  void toggleGmail(bool value) {
    rrfqModel.gmail_selectionStatus.value = value;
  }

  // Update phone number text
  void updatePhoneNumber(String phoneNumber) {
    rrfqModel.phoneController.value.text = phoneNumber;
  }

  // Update feedback text
  void updateFeedback(String feedback) {
    rrfqModel.feedbackController.value.text = feedback;
  }

  void updateVendorID(int vendorID) {
    rrfqModel.vendorID.value = vendorID;
  }

  void updateVendorName(String vendorName) {
    rrfqModel.vendorName.value = vendorName;
  }

  // Update file path text
  void updateFilePath(String filePath) {
    rrfqModel.filePathController.value.text = filePath;
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
        rrfqModel.pickedFile.value = null;
        rrfqModel.selectedPdf.value = null;
      } else {
        rrfqModel.pickedFile.value = result;
        rrfqModel.selectedPdf.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  int fetch_messageType() {
    if (rrfqModel.whatsapp_selectionStatus.value && rrfqModel.gmail_selectionStatus.value) return 3;
    if (rrfqModel.whatsapp_selectionStatus.value) return 2;
    if (rrfqModel.gmail_selectionStatus.value) return 1;

    return 0;
  }

  Future<void> startProgress() async {
    setLoading(true);
    rrfqModel.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      rrfqModel.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      rrfqModel.Rrfq_recommendationList.add(Recommendation(key: key, value: value));
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
    if (index >= 0 && index < rrfqModel.Rrfq_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        rrfqModel.Rrfq_recommendationList[index] = Recommendation(key: key, value: value);
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
      rrfqModel.Rrfq_noteList.add(noteContent);
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

      rrfqModel.Rrfq_products.add(RRFQProduct(sno: (rrfqModel.Rrfq_products.length + 1), productName: productName, quantity: quantity));
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
      if (editIndex < 0 || editIndex >= rrfqModel.Rrfq_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      rrfqModel.Rrfq_products[editIndex] = RRFQProduct(sno: (editIndex + 1), productName: productName, quantity: quantity);

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
      // .updateProductDetails(vendor_RrfqController.rrfqModel.Rrfq_productDetails);
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

  // void add_productSuggestion(List<dynamic> suggestionList) {
  //   for (var item in suggestionList) {
  //     rrfqModel.Rrfq_productSuggestion.add(ProductSuggestion.fromJson(item));
  //   }
  // }

  void add_noteSuggestion(Map<String, dynamic> suggestionList) {
    for (var item in suggestionList['notes']) {
      rrfqModel.noteSuggestion.add(item);
    }
  }

  // Update products list
  void updateProducts(List<RRFQProduct> products) {
    rrfqModel.Rrfq_products.value = products;
  }

  void removeFromNoteList(int index) {
    rrfqModel.Rrfq_noteList.removeAt(index);
    rrfqModel.note_editIndex.value = null;
  }

  void removeFromRecommendationList(int index) {
    rrfqModel.Rrfq_recommendationList.removeAt(index);
    // rrfqModel.Rrfq_recommendationList.isEmpty ? rrfqModel.recommendationHeadingController.value.clear() : null;
    rrfqModel.recommendation_editIndex.value = null;
  }

  void removeFromProductList(index) {
    rrfqModel.Rrfq_products.removeAt(index);
    rrfqModel.product_editIndex.value = null;
  }

  void update_requiredData(CMDmResponse value) {
    RequiredData instance = RequiredData.fromJson(value.data);
    updateVendorID(instance.vendorRfqDetails.vendorId);
    updateVendorName(instance.vendorRfqDetails.vendorName);
    updateRrfqnumber(instance.rrfqId);
    updateAddress(instance.vendorRfqDetails.vendorAddress);
    updateGSTIN(instance.vendorRfqDetails.gstin);
    updatePAN(instance.vendorRfqDetails.pan);
    update_contactPerson(instance.vendorRfqDetails.contactPerson);
    updatePhoneNumber(instance.vendorRfqDetails.phoneNo);
    updateEmail(instance.vendorRfqDetails.emailId);
    updateProducts(instance.vendorRfqDetails.products);

    // updateRrfqnumber(instance.eventnumber);
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
    // //    vendor_RrfqController.addProduct(context: context, productName: vendor_RrfqController.rrfqModel.productNameController.value.text, hsn: vendor_RrfqController.rrfqModel.hsnController.value.text, price: double.parse(vendor_RrfqController.rrfqModel.priceController.value.text), quantity: int.parse(vendor_RrfqController.rrfqModel.quantityController.value.text), gst: double.parse(vendor_RrfqController.rrfqModel.gstController.value.text));

    // // }
  }

  // void on_vendorSelected() {}

  bool generate_Datavalidation() {
    return (rrfqModel.vendorID.value == null ||
        rrfqModel.vendorName.value == null ||
        rrfqModel.AddressController.value.text.isEmpty ||
        rrfqModel.Rrfq_products.isEmpty ||
        rrfqModel.Rrfq_noteList.isEmpty);
  }

  bool postDatavalidation() {
    return (rrfqModel.vendorID.value == null ||
        rrfqModel.vendorName.value == null ||
        rrfqModel.AddressController.value.text.isEmpty ||
        (rrfqModel.gmail_selectionStatus.value && rrfqModel.emailController.value.text.isEmpty) ||
        (rrfqModel.whatsapp_selectionStatus.value && rrfqModel.phoneController.value.text.isEmpty) ||
        rrfqModel.Rrfq_products.isEmpty ||
        rrfqModel.Rrfq_noteList.isEmpty);
  }

  void add_vendorProduct_suggestions(CMDlResponse value) {
    rrfqModel.VendorProduct_sugestions.clear();
    for (int i = 0; i < value.data.length; i++) {
      rrfqModel.VendorProduct_sugestions.add(VendorProduct_suggestions.fromJson(value.data[i]));
    }
  }

  // If any one is empty or null, then it returns true

  // void resetData() {
  //   rrfqModel.tabController.value = null;
  //   rrfqModel.processID.value = null;
  //   rrfqModel.Rrfq_no.value = null;
  //   rrfqModel.vendorID.value = null;
  //   rrfqModel.vendorName.value = null;
  //   // rrfqModel.gstNumController.value.text = "";
  //   rrfqModel.Rrfq_table_heading.value = "";

  //   rrfqModel.phoneController.value.text = "";
  //   rrfqModel.emailController.value.text = "";
  //   rrfqModel.CCemailToggle.value = false;
  //   rrfqModel.CCemailController.value.clear();
  //   // Reset details
  //   rrfqModel.TitleController.value.text = "";
  //   // rrfqModel.clientAddressNameController.value.text = "";
  //   rrfqModel.AddressController.value.text = "";
  //   // rrfqModel.billingAddressNameController.value.text = "";
  //   // rrfqModel.billingAddressController.value.text = "";

  //   // Reset product details
  //   rrfqModel.product_editIndex.value = null;
  //   rrfqModel.productNameController.value.text = "";
  //   // rrfqModel.hsnController.value.text = "";
  //   // rrfqModel.priceController.value.text = "";
  //   rrfqModel.quantityController.value.text = "";
  //   // rrfqModel.gstController.value.text = "";
  //   rrfqModel.Rrfq_products.clear();
  //   // rrfqModel.Rrfq_gstTotals.clear();
  //   rrfqModel.Rrfq_productSuggestion.clear();

  //   // Reset notes
  //   rrfqModel.note_editIndex.value = null;
  //   rrfqModel.notecontentController.value.text = "";
  //   rrfqModel.recommendation_editIndex.value = null;
  //   rrfqModel.recommendationHeadingController.value.text = "";
  //   rrfqModel.recommendationKeyController.value.text = "";
  //   rrfqModel.recommendationValueController.value.text = "";
  //   rrfqModel.Rrfq_noteList.clear();
  //   rrfqModel.Rrfq_recommendationList.clear();
  //   rrfqModel.noteSuggestion.clear();
  // }

  void resetData() {
    // TAB, PROCESS & GENERAL
    rrfqModel.tabController.value = null;
    rrfqModel.vendorID.value = null;
    rrfqModel.vendorName.value = null;
    rrfqModel.Rrfq_no.value = null;
    // rrfqModel.Rrfq_table_heading.value = '';

    // DETAILS

    rrfqModel.vendorID.value = null;
    rrfqModel.GSTIN_Controller.value.clear();
    rrfqModel.PAN_Controller.value.clear();
    rrfqModel.contactPerson_Controller.value.clear();
    rrfqModel.AddressController.value.clear();
    rrfqModel.detailsKey.value = GlobalKey<FormState>();

    // PRODUCTS
    rrfqModel.productKey.value = GlobalKey<FormState>();
    rrfqModel.product_editIndex.value = null;
    rrfqModel.productNameController.value.clear();
    rrfqModel.quantityController.value.clear();
    rrfqModel.Rrfq_products.clear();
    rrfqModel.VendorProduct_sugestions.clear();

    // NOTES
    rrfqModel.noteformKey.value = GlobalKey<FormState>();
    rrfqModel.progress.value = 0.0;
    rrfqModel.isLoading.value = false;
    rrfqModel.note_editIndex.value = null;
    rrfqModel.notecontentController.value.clear();
    rrfqModel.recommendation_editIndex.value = null;
    rrfqModel.recommendationHeadingController.value.clear();
    rrfqModel.recommendationKeyController.value.clear();
    rrfqModel.recommendationValueController.value.clear();
    rrfqModel.Rrfq_noteList.clear();
    rrfqModel.Rrfq_recommendationList.clear();
    rrfqModel.noteSuggestion.clear();

    // POST
    rrfqModel.pickedFile.value = null;
    rrfqModel.selectedPdf.value = null;
    rrfqModel.ispdfLoading.value = false;
    rrfqModel.whatsapp_selectionStatus.value = true;
    rrfqModel.gmail_selectionStatus.value = true;
    rrfqModel.phoneController.value.clear();
    rrfqModel.emailController.value.clear();
    rrfqModel.CCemailController.value.clear();
    rrfqModel.feedbackController.value.clear();
    rrfqModel.filePathController.value.clear();
    rrfqModel.CCemailToggle.value = false;
  }
}
