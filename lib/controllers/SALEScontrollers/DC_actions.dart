import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/constants/SALES_constants/DC_constants.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/models/entities/SALES/DC_entities.dart';
import '../../models/entities/SALES/product_entities.dart';

class DcController extends GetxController {
  var dcModel = DcModel();
  void initializeTabController(TabController tabController) {
    dcModel.tabController.value = tabController;
  }

  void nextTab() {
    if (dcModel.tabController.value!.index < dcModel.tabController.value!.length - 1) {
      dcModel.tabController.value!.animateTo(dcModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (dcModel.tabController.value!.index > 0) {
      dcModel.tabController.value!.animateTo(dcModel.tabController.value!.index - 1);
    }
  }

  void updateProductName(String productName) {
    dcModel.productNameController.value.text = productName;
  }

  void updateHSN(int hsn) {
    dcModel.hsnController.value.text = hsn.toString();
  }

  void updatePrice(double price) {
    dcModel.priceController.value.text = price.toString();
  }

  void updateQuantity(int quantity) {
    dcModel.quantityController.value.text = quantity.toString();
  }

  void updateGST(double gst) {
    dcModel.gstController.value.text = gst.toString();
  }

  void updateNoteEditindex(int? index) {
    dcModel.note_editIndex.value = index;
  }

  void updateChallanTableHeading(String tableHeading) {
    dcModel.Dc_table_heading.value = tableHeading;
  }

  void updateNoteList(String value, int index) {
    dcModel.Dc_noteList[dcModel.note_editIndex.value!] = dcModel.notecontentController.value.text;
  }

  void updateTabController(TabController tabController) {
    dcModel.tabController.value = tabController;
  }

  void updateTitle(String text) {
    dcModel.TitleController.value.text = text;
  }

  void updateDcnumber(String text) {
    dcModel.Dc_no.value = text;
  }

  void updateGSTnumber(String text) {
    dcModel.gstNumController.value.text = text;
  }

  void updateClientAddressName(String text) {
    dcModel.clientAddressNameController.value.text = text;
  }

  void updateClientAddress(String text) {
    dcModel.clientAddressController.value.text = text;
  }

  void updateBillingAddressName(String text) {
    dcModel.billingAddressNameController.value.text = text;
  }

  void updateBillingAddress(String text) {
    dcModel.billingAddressController.value.text = text;
  }

  void updatePhone(String phone) {
    dcModel.phoneController.value.text = phone;
  }

  void updateEmail(String email) {
    dcModel.emailController.value.text = email;
  }

  void updatCC(String CC) {
    dcModel.CCemailController.value.text = CC;
  }

  void toggleCCemailvisibility(bool value) {
    dcModel.CCemailToggle.value = value;
  }

  void updateRecommendationEditindex(int? index) {
    dcModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    dcModel.notecontentController.value.text = text;
  }

  void updateRec_HeadingControllerText(String text) {
    dcModel.recommendationHeadingController.value.text = text;
  }

  void updateRec_KeyControllerText(String text) {
    dcModel.recommendationKeyController.value.text = text;
  }

  void updateRec_ValueControllerText(String text) {
    dcModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    dcModel.noteSuggestion.add(note);
  }

  void addProductEditindex(int? index) {
    dcModel.product_editIndex.value = index;
  }

  void setProcessID(int processid) {
    dcModel.processID.value = processid;
  }

  void updateSelectedPdf(File file) {
    dcModel.selectedPdf.value = file;
  }

  // Toggle loading state
  void setLoading(bool value) {
    dcModel.isLoading.value = value;
  }

  void setpdfLoading(bool value) {
    dcModel.ispdfLoading.value = value;
  }

  // Toggle WhatsApp state
  void toggleWhatsApp(bool value) {
    dcModel.whatsapp_selectionStatus.value = value;
  }

  // Toggle Gmail state
  void toggleGmail(bool value) {
    dcModel.gmail_selectionStatus.value = value;
  }

  void togglProduct_selectAll(bool value) {
    dcModel.selectall_status.value = value;
  }

  void toggleProduct_selection(bool value, int index) {
    dcModel.checkboxValues[index] = value;
  }

  void refactorSelection() {
    for (int i = 0; i < dcModel.checkboxValues.length; i++) {
      if (dcModel.selectall_status.value) {
        dcModel.checkboxValues[i] = true;
      } else {
        dcModel.checkboxValues[i] = false;
      }
    }
  }

  // Update phone number text
  void updatePhoneNumber(String phoneNumber) {
    dcModel.phoneController.value.text = phoneNumber;
  }

  // Update feedback text
  void updateFeedback(String feedback) {
    dcModel.feedbackController.value.text = feedback;
  }

  // Update file path text
  void updateFilePath(String filePath) {
    dcModel.filePathController.value.text = filePath;
  }

  void update_dcAmount(double amount) {
    dcModel.dc_amount.value = amount;
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
        dcModel.pickedFile.value = null;
        dcModel.selectedPdf.value = null;
      } else {
        dcModel.pickedFile.value = result;
        dcModel.selectedPdf.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  int fetch_messageType() {
    if (dcModel.whatsapp_selectionStatus.value && dcModel.gmail_selectionStatus.value) return 3;
    if (dcModel.whatsapp_selectionStatus.value) return 1;
    if (dcModel.gmail_selectionStatus.value) return 2;

    return 0;
  }

  Future<void> startProgress() async {
    setLoading(true);
    dcModel.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      dcModel.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      dcModel.Dc_recommendationList.add(Recommendation(key: key, value: value));
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
    if (index >= 0 && index < dcModel.Dc_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        dcModel.Dc_recommendationList[index] = Recommendation(key: key, value: value);
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
      dcModel.Dc_noteList.add(noteContent);
    } else {
      if (kDebugMode) {
        print('Note content must not be empty');
      } // Handle empty input (optional)
    }
  }

  // void addProduct({
  //   required BuildContext context,
  //   required String productName,
  //   required String hsn,
  //   required double price,
  //   required int quantity,
  //   required double gst,
  // }) {
  //   try {
  //     if (productName.trim().isEmpty || hsn.trim().isEmpty || price <= 0 || quantity <= 0 || gst < 0) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text('Please provide valid product details.'),
  //         ),
  //       );
  //       return;
  //     }

  //     dcModel.Dc_products.add(DcProduct(sno: (dcModel.Dc_products.length + 1), productName: productName, hsn: int.parse(hsn), gst: gst, price: price, quantity: quantity, productid: 0));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text('An error occurred while adding the product.'),
  //       ),
  //     );
  //   }
  // }

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
      if (editIndex < 0 || editIndex >= dcModel.Dc_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      dcModel.Dc_products[editIndex] = DcProduct(sno: (editIndex + 1), productName: productName, hsn: int.parse(hsn), gst: gst, price: price, quantity: quantity, productid: 0);

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
      // .updateProductDetails(dcController.dcModel.Dc_productDetails);
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
      dcModel.Dc_productSuggestion.add(ProductSuggestion.fromJson(item));
      if (kDebugMode) {
        print(dcModel.Dc_productSuggestion[0].productName);
      }
    }
  }

  void add_noteSuggestion(Map<String, dynamic> suggestionList) {
    for (var item in suggestionList['notes']) {
      dcModel.noteSuggestion.add(item);
      if (kDebugMode) {
        print(dcModel.noteSuggestion[0]);
      }
    }
  }

  // Update products list
  void updateProducts(List<DcProduct> products) {
    dcModel.Dc_products.value = products;
    dcModel.checkboxValues.clear();
    for (int i = 0; i < products.length; i++) {
      dcModel.checkboxValues.add(false);
    }
  }

  void removeFromNoteList(int index) {
    dcModel.Dc_noteList.removeAt(index);
  }

  void removeFromRecommendationList(int index) {
    dcModel.Dc_recommendationList.removeAt(index);
    dcModel.Dc_recommendationList.isEmpty ? dcModel.recommendationHeadingController.value.clear() : null;
  }

  void removeFromProductList(index) {
    dcModel.Dc_products.removeAt(index);
  }

  void update_requiredData(CMDmResponse value) {
    RequiredData instance = RequiredData.fromJson(value);
    dcModel.Dc_no.value = instance.eventnumber;
    updateDcnumber(instance.eventnumber);
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
    //    dcController.addProduct(context: context, productName: dcController.dcModel.productNameController.value.text, hsn: dcController.dcModel.hsnController.value.text, price: double.parse(dcController.dcModel.priceController.value.text), quantity: int.parse(dcController.dcModel.quantityController.value.text), gst: double.parse(dcController.dcModel.gstController.value.text));

    // }
  }

  bool postDatavalidation() {
    return (dcModel.TitleController.value.text.isEmpty ||
        dcModel.processID.value == null ||
        dcModel.clientAddressNameController.value.text.isEmpty ||
        dcModel.clientAddressController.value.text.isEmpty ||
        dcModel.billingAddressNameController.value.text.isEmpty ||
        dcModel.billingAddressController.value.text.isEmpty ||
        dcModel.emailController.value.text.isEmpty ||
        dcModel.phoneController.value.text.isEmpty ||
        dcModel.gstNumController.value.text.isEmpty ||
        dcModel.Dc_products.isEmpty ||
        dcModel.Dc_noteList.isEmpty ||
        dcModel.Dc_no.value == null);
  } // If any one is empty or null, then it returns true

  void resetData() {
    dcModel.tabController.value = null;
    dcModel.processID.value = null;
    dcModel.Dc_no.value = null;
    dcModel.gstNumController.value.text = "";
    dcModel.Dc_table_heading.value = "";

    dcModel.phoneController.value.text = "";
    dcModel.emailController.value.text = "";
    dcModel.CCemailToggle.value = false;
    dcModel.CCemailController.value.clear();
    // Reset details
    dcModel.TitleController.value.text = "";
    dcModel.clientAddressNameController.value.text = "";
    dcModel.clientAddressController.value.text = "";
    dcModel.billingAddressNameController.value.text = "";
    dcModel.billingAddressController.value.text = "";

    // Reset product details
    dcModel.product_editIndex.value = null;
    dcModel.productNameController.value.text = "";
    dcModel.hsnController.value.text = "";
    dcModel.priceController.value.text = "";
    dcModel.quantityController.value.text = "";
    dcModel.gstController.value.text = "";
    dcModel.Dc_products.clear();
    dcModel.Dc_gstTotals.clear();
    dcModel.Dc_productSuggestion.clear();

    // Reset notes
    dcModel.note_editIndex.value = null;
    dcModel.notecontentController.value.text = "";
    dcModel.recommendation_editIndex.value = null;
    dcModel.recommendationHeadingController.value.text = "";
    dcModel.recommendationKeyController.value.text = "";
    dcModel.recommendationValueController.value.text = "";
    dcModel.Dc_noteList.clear();
    dcModel.Dc_recommendationList.clear();
    dcModel.noteSuggestion.clear();
  }
}
