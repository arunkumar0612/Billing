import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/constants/Process/PO_constants.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Process/PO_entities.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Process/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class vendor_PoController extends GetxController {
  var poModel = PoModel();

  void initializeTabController(TabController tabController) {
    poModel.tabController.value = tabController;
  }

  void nextTab() {
    if (poModel.tabController.value!.index < poModel.tabController.value!.length - 1) {
      poModel.tabController.value!.animateTo(poModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (poModel.tabController.value!.index > 0) {
      poModel.tabController.value!.animateTo(poModel.tabController.value!.index - 1);
    }
  }

  void updateProductName(String productName) {
    poModel.productNameController.value.text = productName;
  }

  void updateHsn(String hsn) {
    poModel.hsnController.value.text = hsn;
  }

  void updatePrice(double price) {
    poModel.priceController.value.text = price.toString();
  }

  void updateQuantity(int quantity) {
    poModel.quantityController.value.text = quantity.toString();
  }

  void updateNoteEditindex(int? index) {
    poModel.note_editIndex.value = index;
  }

  // void updateChallanTableHeading(String tableHeading) {
  //   poModel.Po_table_heading.value = tableHeading;
  // }

  void updateNoteList(String value, int index) {
    poModel.Po_noteList[poModel.note_editIndex.value!] = poModel.notecontentController.value.text;
  }

  void updateTabController(TabController tabController) {
    poModel.tabController.value = tabController;
  }

  void updatePonumber(String text) {
    poModel.Po_no.value = text;
  }

  // void updateGSTnumber(String text) {
  //   poModel.gstNumController.value.text = text;
  // }

  // void updateClientAddressName(String text) {
  //   poModel.clientAddressNameController.value.text = text;
  // }

  void updateAddress(String text) {
    poModel.AddressController.value.text = text;
  }

  // void updateBillingAddressName(String text) {
  //   poModel.billingAddressNameController.value.text = text;
  // }

  // void updateBillingAddress(String text) {
  //   poModel.billingAddressController.value.text = text;
  // }

  void updatePhone(String phone) {
    poModel.phoneController.value.text = phone;
  }

  void updateEmail(String email) {
    poModel.emailController.value.text = email;
  }

  void updatCC(String CC) {
    poModel.CCemailController.value.text = CC;
  }

  void toggleCCemailvisibility(bool value) {
    poModel.CCemailToggle.value = value;
  }

  void updateRecommendationEditindex(int? index) {
    poModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    poModel.notecontentController.value.text = text;
  }

  void updateRec_HeadingControllerText(String text) {
    poModel.recommendationHeadingController.value.text = text;
  }

  void updateRec_KeyControllerText(String text) {
    poModel.recommendationKeyController.value.text = text;
  }

  void updateRec_ValueControllerText(String text) {
    poModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    poModel.noteSuggestion.add(note);
  }

  void addProductEditindex(int? index) {
    poModel.product_editIndex.value = index;
  }

  void updateSelectedPdf(File file) {
    poModel.selectedPdf.value = file;
  }

  // Toggle loading state
  void setLoading(bool value) {
    poModel.isLoading.value = value;
  }

  void setpdfLoading(bool value) {
    poModel.ispdfLoading.value = value;
  }

  // Toggle WhatsApp state
  void toggleWhatsApp(bool value) {
    poModel.whatsapp_selectionStatus.value = value;
  }

  // Toggle Gmail state
  void toggleGmail(bool value) {
    poModel.gmail_selectionStatus.value = value;
  }

  // Update phone number text
  void updatePhoneNumber(String phoneNumber) {
    poModel.phoneController.value.text = phoneNumber;
  }

  // Update feedback text
  void updateFeedback(String feedback) {
    poModel.feedbackController.value.text = feedback;
  }

  // Update file path text
  void updateFilePath(String filePath) {
    poModel.filePathController.value.text = filePath;
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
        poModel.pickedFile.value = null;
        poModel.selectedPdf.value = null;
      } else {
        poModel.pickedFile.value = result;
        poModel.selectedPdf.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  int fetch_messageType() {
    if (poModel.whatsapp_selectionStatus.value && poModel.gmail_selectionStatus.value) return 3;
    if (poModel.whatsapp_selectionStatus.value) return 2;
    if (poModel.gmail_selectionStatus.value) return 1;

    return 0;
  }

  Future<void> startProgress() async {
    setLoading(true);
    poModel.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      poModel.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      poModel.Po_recommendationList.add(Recommendation(key: key, value: value));
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
    if (index >= 0 && index < poModel.Po_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        poModel.Po_recommendationList[index] = Recommendation(key: key, value: value);
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
      poModel.Po_noteList.add(noteContent);
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
  }) {
    try {
      if (productName.trim().isEmpty || hsn.trim().isEmpty || price <= 0 || quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      poModel.Po_products.add(POProduct(sno: (poModel.Po_products.length + 1), productName: productName, hsn: hsn, price: price, quantity: quantity));
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
    // required double gst,
  }) {
    try {
      // Validate input fields
      if (productName.trim().isEmpty || hsn.trim().isEmpty || price <= 0 || quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= poModel.Po_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      poModel.Po_products[editIndex] = POProduct(sno: (editIndex + 1), productName: productName, hsn: hsn, price: price, quantity: quantity);

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
      // .updateProductDetails(vendor_PoController.poModel.Po_productDetails);
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
  //     poModel.Po_productSuggestion.add(ProductSuggestion.fromJson(item));
  //   }
  // }

  void add_noteSuggestion(Map<String, dynamic> suggestionList) {
    for (var item in suggestionList['notes']) {
      poModel.noteSuggestion.add(item);
    }
  }

  // Update products list
  void updateProducts(List<POProduct> products) {
    poModel.Po_products.value = products;
  }

  void removeFromNoteList(int index) {
    poModel.Po_noteList.removeAt(index);
    poModel.note_editIndex.value = null;
  }

  void removeFromRecommendationList(int index) {
    poModel.Po_recommendationList.removeAt(index);
    // poModel.Po_recommendationList.isEmpty ? poModel.recommendationHeadingController.value.clear() : null;
    poModel.recommendation_editIndex.value = null;
  }

  void removeFromProductList(index) {
    poModel.Po_products.removeAt(index);
    poModel.product_editIndex.value = null;
  }

  void update_requiredData(CMDmResponse value) {
    RequiredData instance = RequiredData.fromJson(value);
    updatePonumber(instance.eventnumber);

    // updatePonumber(instance.eventnumber);
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
    // //    vendor_PoController.addProduct(context: context, productName: vendor_PoController.poModel.productNameController.value.text, hsn: vendor_PoController.poModel.hsnController.value.text, price: double.parse(vendor_PoController.poModel.priceController.value.text), quantity: int.parse(vendor_PoController.poModel.quantityController.value.text), gst: double.parse(vendor_PoController.poModel.gstController.value.text));

    // // }
  }

  // void on_vendorSelected() {}

  bool generate_Datavalidation() {
    return (poModel.vendorID.value == null || poModel.vendorName.value == null || poModel.AddressController.value.text.isEmpty || poModel.Po_products.isEmpty || poModel.Po_noteList.isEmpty);
  }

  bool postDatavalidation() {
    return (poModel.vendorID.value == null ||
        poModel.vendorName.value == null ||
        poModel.AddressController.value.text.isEmpty ||
        (poModel.gmail_selectionStatus.value && poModel.emailController.value.text.isEmpty) ||
        (poModel.whatsapp_selectionStatus.value && poModel.phoneController.value.text.isEmpty) ||
        poModel.Po_products.isEmpty ||
        poModel.Po_noteList.isEmpty);
  }

  void add_vendorProduct_suggestions(CMDlResponse value) {
    poModel.VendorProduct_sugestions.clear();
    for (int i = 0; i < value.data.length; i++) {
      poModel.VendorProduct_sugestions.add(VendorProduct_suggestions.fromJson(value.data[i]));
    }
  }

  // If any one is empty or null, then it returns true

  // void resetData() {
  //   poModel.tabController.value = null;
  //   poModel.processID.value = null;
  //   poModel.Po_no.value = null;
  //   poModel.vendorID.value = null;
  //   poModel.vendorName.value = null;
  //   // poModel.gstNumController.value.text = "";
  //   poModel.Po_table_heading.value = "";

  //   poModel.phoneController.value.text = "";
  //   poModel.emailController.value.text = "";
  //   poModel.CCemailToggle.value = false;
  //   poModel.CCemailController.value.clear();
  //   // Reset details
  //   poModel.TitleController.value.text = "";
  //   // poModel.clientAddressNameController.value.text = "";
  //   poModel.AddressController.value.text = "";
  //   // poModel.billingAddressNameController.value.text = "";
  //   // poModel.billingAddressController.value.text = "";

  //   // Reset product details
  //   poModel.product_editIndex.value = null;
  //   poModel.productNameController.value.text = "";
  //   // poModel.hsnController.value.text = "";
  //   // poModel.priceController.value.text = "";
  //   poModel.quantityController.value.text = "";
  //   // poModel.gstController.value.text = "";
  //   poModel.Po_products.clear();
  //   // poModel.Po_gstTotals.clear();
  //   poModel.Po_productSuggestion.clear();

  //   // Reset notes
  //   poModel.note_editIndex.value = null;
  //   poModel.notecontentController.value.text = "";
  //   poModel.recommendation_editIndex.value = null;
  //   poModel.recommendationHeadingController.value.text = "";
  //   poModel.recommendationKeyController.value.text = "";
  //   poModel.recommendationValueController.value.text = "";
  //   poModel.Po_noteList.clear();
  //   poModel.Po_recommendationList.clear();
  //   poModel.noteSuggestion.clear();
  // }

  void resetData() {
    // TAB, PROCESS & GENERAL
    poModel.tabController.value = null;
    poModel.vendorID.value = null;
    poModel.vendorName.value = null;
    poModel.Po_no.value = null;
    // poModel.Po_table_heading.value = '';

    // DETAILS

    poModel.vendorID.value = null;
    poModel.GSTIN_Controller.value.clear();
    poModel.PAN_Controller.value.clear();
    poModel.contactPerson_Controller.value.clear();
    poModel.AddressController.value.clear();
    poModel.detailsKey.value = GlobalKey<FormState>();

    // PRODUCTS
    poModel.productKey.value = GlobalKey<FormState>();
    poModel.product_editIndex.value = null;
    poModel.productNameController.value.clear();
    poModel.quantityController.value.clear();
    poModel.Po_products.clear();
    poModel.VendorProduct_sugestions.clear();

    // NOTES
    poModel.noteformKey.value = GlobalKey<FormState>();
    poModel.progress.value = 0.0;
    poModel.isLoading.value = false;
    poModel.note_editIndex.value = null;
    poModel.notecontentController.value.clear();
    poModel.recommendation_editIndex.value = null;
    poModel.recommendationHeadingController.value.clear();
    poModel.recommendationKeyController.value.clear();
    poModel.recommendationValueController.value.clear();
    poModel.Po_noteList.clear();
    poModel.Po_recommendationList.clear();
    poModel.noteSuggestion.clear();

    // POST
    poModel.pickedFile.value = null;
    poModel.selectedPdf.value = null;
    poModel.ispdfLoading.value = false;
    poModel.whatsapp_selectionStatus.value = true;
    poModel.gmail_selectionStatus.value = true;
    poModel.phoneController.value.clear();
    poModel.emailController.value.clear();
    poModel.CCemailController.value.clear();
    poModel.feedbackController.value.clear();
    poModel.filePathController.value.clear();
    poModel.CCemailToggle.value = false;
  }
}
