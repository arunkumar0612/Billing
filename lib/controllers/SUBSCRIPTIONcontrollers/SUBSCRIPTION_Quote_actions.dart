import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/constants/SUBSCRIPTION_constants/SUBSCRIPTION_Quote_constants.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';

import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Sites_entities.dart';

class SUBSCRIPTION_QuoteController extends GetxController {
  var quoteModel = SUBSCRIPTION_QuoteModel();

  void initializeTabController(TabController tabController) {
    quoteModel.tabController.value = tabController;
  }

  void nextTab() {
    if (quoteModel.tabController.value!.index < quoteModel.tabController.value!.length - 1) {
      quoteModel.tabController.value!.animateTo(quoteModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (quoteModel.tabController.value!.index > 0) {
      quoteModel.tabController.value!.animateTo(quoteModel.tabController.value!.index - 1);
    }
  }

  void updatesiteName(String siteName) {
    quoteModel.siteNameController.value.text = siteName;
  }

  void addSiteEditindex(int? index) {
    quoteModel.site_editIndex.value = index;
  }

  void updateSiteName(String siteName) {
    quoteModel.siteNameController.value.text = siteName;
  }

  void updateQuantity(int quantity) {
    quoteModel.cameraquantityController.value.text = quantity.toString();
  }

  void updateAddressName(String address) {
    quoteModel.addressController.value.text = address;
  }

  void removeFromProductList(index) {
    quoteModel.QuoteSiteDetails.removeAt(index);
  }

  void updateNoteEditindex(int? index) {
    quoteModel.note_editIndex.value = index;
  }

  void updateChallanTableHeading(String tableHeading) {
    quoteModel.Quote_table_heading.value = tableHeading;
  }

  void updateNoteList(String value, int index) {
    quoteModel.Quote_noteList[quoteModel.note_editIndex.value!] = quoteModel.notecontentController.value.text;
  }

  void updateTabController(TabController tabController) {
    quoteModel.tabController.value = tabController;
  }

  void updateTitle(String text) {
    quoteModel.TitleController.value.text = text;
  }

  void updateQuotenumber(String text) {
    quoteModel.Quote_no.value = text;
  }

  void updateGSTnumber(String text) {
    quoteModel.gstNumController.value.text = text;
  }

  void updateClientAddressName(String text) {
    quoteModel.clientAddressNameController.value.text = text;
  }

  void updateClientAddress(String text) {
    quoteModel.clientAddressController.value.text = text;
  }

  void updateBillingAddressName(String text) {
    quoteModel.billingAddressNameController.value.text = text;
  }

  void updateBillingAddress(String text) {
    quoteModel.billingAddressController.value.text = text;
  }

  void updatePhone(String phone) {
    quoteModel.phoneController.value.text = phone;
  }

  void updateEmail(String email) {
    quoteModel.emailController.value.text = email;
  }

  void updatCC(String CC) {
    quoteModel.CCemailController.value.text = CC;
  }

  void toggleCCemailvisibility(bool value) {
    quoteModel.CCemailToggle.value = value;
  }

  void updateRecommendationEditindex(int? index) {
    quoteModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    quoteModel.notecontentController.value.text = text;
  }

  void updateRec_HeadingControllerText(String text) {
    quoteModel.recommendationHeadingController.value.text = text;
  }

  void updateRec_KeyControllerText(String text) {
    quoteModel.recommendationKeyController.value.text = text;
  }

  void updateRec_ValueControllerText(String text) {
    quoteModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    quoteModel.notecontent.add(note);
  }

  void addsiteEditindex(int? index) {
    quoteModel.site_editIndex.value = index;
  }

  void setProcessID(int processid) {
    quoteModel.processID.value = processid;
  }

  void updateSelectedPdf(File file) {
    quoteModel.selectedPdf.value = file;
  }

  // Toggle loading state
  void setLoading(bool value) {
    quoteModel.isLoading.value = value;
  }

  void setpdfLoading(bool value) {
    quoteModel.ispdfLoading.value = value;
  }

  // Toggle WhatsApp state
  void toggleWhatsApp(bool value) {
    quoteModel.whatsapp_selectionStatus.value = value;
  }

  // Toggle Gmail state
  void toggleGmail(bool value) {
    quoteModel.gmail_selectionStatus.value = value;
  }

  // Update phone number text
  void updatePhoneNumber(String phoneNumber) {
    quoteModel.phoneController.value.text = phoneNumber;
  }

  // Update feedback text
  void updateFeedback(String feedback) {
    quoteModel.feedbackController.value.text = feedback;
  }

  // Update file path text
  void updateFilePath(String filePath) {
    quoteModel.filePathController.value.text = filePath;
  }

  void resetPackageSelection() {
    quoteModel.selectedPackageController.value.text = '';
    quoteModel.customPackageDetails.value = null;
  }

  void updateSelectedPackage(String? package) {
    quoteModel.selectedPackageController.value.text = package ?? "";
    if (package != 'Custom') {
      quoteModel.customPackageDetails.value = null;
    }
  }

  void updateCustomPackageDetails(PackageDetails details) {
    quoteModel.customPackageDetails.value = details;
  }

  void removeFromsiteList(index) {
    quoteModel.QuoteSiteDetails.removeAt(index);
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
        quoteModel.pickedFile.value = null;
        quoteModel.selectedPdf.value = null;
      } else {
        quoteModel.pickedFile.value = result;
        quoteModel.selectedPdf.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  int fetch_messageType() {
    if (quoteModel.whatsapp_selectionStatus.value && quoteModel.gmail_selectionStatus.value) return 3;
    if (quoteModel.whatsapp_selectionStatus.value) return 1;
    if (quoteModel.gmail_selectionStatus.value) return 2;

    return 0;
  }

  Future<void> startProgress() async {
    setLoading(true);
    quoteModel.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      quoteModel.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      quoteModel.Quote_recommendationList.add(SUBSCRIPTION_QuoteRecommendation(key: key, value: value));
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
    if (index >= 0 && index < quoteModel.Quote_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        quoteModel.Quote_recommendationList[index] = SUBSCRIPTION_QuoteRecommendation(key: key, value: value);
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

  void addSite(
      {required BuildContext context, required String siteName, required int cameraquantity, required String address, required PackageDetails? packageDetails, required String selectedPackage}) {
    try {
      if (siteName.trim().isEmpty || cameraquantity <= 0 || address.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }
      quoteModel.QuoteSiteDetails.add(
          Site(siteName: siteName, address: address, packageName: '', camCount: cameraquantity, specialPrice: 100, basicPrice: 150, packageDetails: packageDetails, selectedPackage: selectedPackage));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('An error occurred while adding the product.'),
        ),
      );
    }
  }

  void updateSite(
      {required BuildContext context,
      required int editIndex,
      required String siteName,
      required int cameraquantity,
      required String address,
      required String selectedPackage,
      required PackageDetails? packageDetails}) {
    try {
      // Validate input fields
      if (siteName.trim().isEmpty || cameraquantity <= 0 || address.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= quoteModel.QuoteSiteDetails.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      quoteModel.QuoteSiteDetails[editIndex] =
          Site(siteName: siteName, address: address, packageName: '', camCount: cameraquantity, specialPrice: 100, basicPrice: 150, packageDetails: packageDetails, selectedPackage: selectedPackage);

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
      // .updateProductDetails(creditController.quoteModel.Quote_productDetails);
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

  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      quoteModel.Quote_noteList.add(noteContent);
    } else {
      if (kDebugMode) {
        print('Note content must not be empty');
      } // Handle empty input (optional)
    }
  }

  void removeFromNoteList(int index) {
    quoteModel.Quote_noteList.removeAt(index);
  }

  void removeFromRecommendationList(int index) {
    quoteModel.Quote_recommendationList.removeAt(index);
    quoteModel.Quote_recommendationList.isEmpty ? quoteModel.recommendationHeadingController.value.clear() : null;
  }

  void update_requiredData(CMDmResponse value) {
    SubscriptionQuoteRequiredData instance = SubscriptionQuoteRequiredData.fromJson(value);
    quoteModel.Quote_no.value = instance.eventNumber;
    updateQuotenumber(instance.eventNumber);
    updateTitle(instance.title!);
    updateEmail(instance.emailId!);
    updateGSTnumber(instance.gst!);
    updatePhone(instance.phoneNo!);
    updateClientAddressName(instance.name!);
    updateClientAddress(instance.address!);
    updateBillingAddressName(instance.billingAddressName!);
    updateBillingAddress(instance.billingAddress!);
  }

  bool postDatavalidation() {
    return (quoteModel.TitleController.value.text.isEmpty ||
        quoteModel.processID.value == null ||
        quoteModel.clientAddressNameController.value.text.isEmpty ||
        quoteModel.clientAddressController.value.text.isEmpty ||
        quoteModel.billingAddressNameController.value.text.isEmpty ||
        quoteModel.billingAddressController.value.text.isEmpty ||
        quoteModel.emailController.value.text.isEmpty ||
        // quoteModel.phoneController.value.text.isEmpty ||
        // quoteModel.gstNumController.value.text.isEmpty ||
        quoteModel.Quote_noteList.isEmpty ||
        quoteModel.Quote_no.value == null);
  } // If any one is empty or null, then it returns true

  void resetData() {
    quoteModel.tabController.value = null;
    quoteModel.processID.value = null;
    quoteModel.Quote_no.value = null;
    quoteModel.gstNumController.value.text = "";
    quoteModel.Quote_table_heading.value = "";

    quoteModel.phoneController.value.text = "";
    quoteModel.emailController.value.text = "";
    quoteModel.CCemailToggle.value = false;
    quoteModel.CCemailController.value.clear();
    // Reset details
    quoteModel.TitleController.value.text = "";
    quoteModel.clientAddressNameController.value.text = "";
    quoteModel.clientAddressController.value.text = "";
    quoteModel.billingAddressNameController.value.text = "";
    quoteModel.billingAddressController.value.text = "";

    // Reset site details
    quoteModel.site_editIndex.value = null;
    quoteModel.siteNameController.value.text = "";

    // Reset notes
    quoteModel.note_editIndex.value = null;
    quoteModel.notecontentController.value.text = "";
    quoteModel.recommendation_editIndex.value = null;
    quoteModel.recommendationHeadingController.value.text = "";
    quoteModel.recommendationKeyController.value.text = "";
    quoteModel.recommendationValueController.value.text = "";
    quoteModel.Quote_noteList.clear();
    quoteModel.Quote_recommendationList.clear();
  }
}
