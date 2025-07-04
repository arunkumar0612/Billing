import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/models/constants/SUBSCRIPTION_Quote_constants.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

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

  // void addsiteEditindex(int? index) {
  //   quoteModel.site_editIndex.value = index;
  // }

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

  void update_companyID(int value) {
    quoteModel.companyid.value = value;
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

  void removeFromsiteList(index) {
    quoteModel.QuoteSiteDetails.removeAt(index);
  }

  void updateBillingtype(String billingtype) {
    quoteModel.Billingtype_Controller.value = billingtype;
  }

  void updateMailtype(String mailtype) {
    quoteModel.Mailtype_Controller.value = mailtype;
  }

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg'], lockParentWindow: true);

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
    if (quoteModel.whatsapp_selectionStatus.value) return 2;
    if (quoteModel.gmail_selectionStatus.value) return 1;

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

  void addSite({required BuildContext context, required String siteName, required int cameraquantity, required String address, required String billType, required String mailType}) {
    try {
      if (siteName.trim().isEmpty || cameraquantity <= 0 || address.trim().isEmpty) {
        Error_SnackBar(context, 'Please provide valid product details.');

        return;
      }
      quoteModel.QuoteSiteDetails.add(Site(
        sitename: siteName,
        address: address,
        // packageName: '',
        cameraquantity: cameraquantity,
        // Price: 100,
        billType: billType,
        mailType: mailType,
      ));
    } catch (e) {
      Error_SnackBar(context, 'An error occurred while adding the product.');
    }
  }

  void updateSite(
      {required BuildContext context, required int editIndex, required String siteName, required int cameraquantity, required String address, required String billType, required String mailType}) {
    try {
      // Validate input fields
      if (siteName.trim().isEmpty || cameraquantity <= 0 || address.trim().isEmpty) {
        Error_SnackBar(context, 'Please provide valid product details.');

        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= quoteModel.QuoteSiteDetails.length) {
        Error_SnackBar(context, 'Invalid product index.');

        return;
      }

      // Update the product details at the specified index
      quoteModel.QuoteSiteDetails[editIndex] = Site(
        sitename: siteName,
        address: address,
        cameraquantity: cameraquantity,
        billType: billType,
        mailType: mailType,
      );
    } catch (e) {
      // Handle unexpected errors
      Error_SnackBar(context, 'An error occurred while updating the product.');
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

  Future<void> update_requiredData(CMDmResponse value, String eventtype) async {
    if (kDebugMode) {
      print(value.data);
    }
    if (eventtype == 'revisedquotation') {
      storeFetchedPackages(value.data);
    }

    SubscriptionQuoteRequiredData instance = SubscriptionQuoteRequiredData.fromJson(value);
    quoteModel.Quote_no.value = instance.eventNumber;
    update_companyID(instance.companyid);
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

  void storeFetchedPackages(Map<String, dynamic> data) {
    if (data['packagedetails'] != null) {
      quoteModel.selectedPackagesList.value = List<Map<String, dynamic>>.from(data['packagedetails']).map((packageJson) => Package.fromJson(packageJson)).toList();
      if (quoteModel.selectedPackagesList.isNotEmpty) quoteModel.selectedPackage.value = quoteModel.selectedPackagesList[0].name.trim();

      for (int i = 0; i < quoteModel.selectedPackagesList.length; i++) {
        for (int j = 0; j < quoteModel.selectedPackagesList[i].sites.length; j++) {
          Site siteData = quoteModel.selectedPackagesList[i].sites[j];
          // quoteModel.QuoteSiteDetails.value = (Site.fromJson(List<Map<String, dynamic>>.from(json['sites']))
          quoteModel.QuoteSiteDetails.add(Site(
            sitename: siteData.sitename,
            address: siteData.address,
            cameraquantity: siteData.cameraquantity,
            billType: siteData.billType,
            mailType: siteData.mailType,
          ));
        }
      }
      List<Package> packages = quoteModel.packageDetails;
      List<Package> selected = quoteModel.selectedPackagesList;
      if (kDebugMode) {
        print("***************************${packages.map((p) => p.toJson()).toList()}");
      }
      if (kDebugMode) {
        print("***************************${selected.map((p) => p.toJson()).toList()}");
      }

      quoteModel.update();
    }
  }

  void update_companyBasedPackages(CMDlResponse response) {
    quoteModel.packageDetails.clear();
    quoteModel.packageList.clear();
    quoteModel.company_basedPackageList.value = CompanyBasedPackages.fromJsonList(response.data);
    if (kDebugMode) {
      print(quoteModel.company_basedPackageList);
    }

    for (int i = 0; i < quoteModel.company_basedPackageList.length; i++) {
      quoteModel.packageList.add(quoteModel.company_basedPackageList[i].subscriptionName ?? "");
      quoteModel.packageDetails.add(
        Package(
          name: quoteModel.company_basedPackageList[i].subscriptionName ?? "",
          subscriptionid: quoteModel.company_basedPackageList[i].subscriptionId ?? 0,
          description: quoteModel.company_basedPackageList[i].productDesc ?? "",
          cameracount: (quoteModel.company_basedPackageList[i].noOfCameras ?? "").toString(),
          amount: (quoteModel.company_basedPackageList[i].amount ?? "").toString(),
          // additionalCameras: (quoteModel.company_basedPackageList[i].addlCameras ?? "").toString(),
          subscriptiontype: 'global',
          sites: [], // Start with empty sites
        ),
      );
    }
    quoteModel.packageList.add('Custom Package');
  }

  bool generate_Datavalidation() {
    return (quoteModel.TitleController.value.text.isEmpty ||
        quoteModel.processID.value == null ||
        quoteModel.clientAddressNameController.value.text.isEmpty ||
        quoteModel.clientAddressController.value.text.isEmpty ||
        quoteModel.billingAddressNameController.value.text.isEmpty ||
        quoteModel.billingAddressController.value.text.isEmpty ||
        (quoteModel.gstNumController.value.text.isEmpty) || // Optional if needed later
        quoteModel.Quote_noteList.isEmpty ||
        quoteModel.selectedPackagesList.isEmpty ||
        quoteModel.Quote_no.value == null);
  } // If any one is empty or null, then it returns true

  bool anyHavedata() {
    return (quoteModel.TitleController.value.text.isNotEmpty ||
        quoteModel.processID.value != null ||
        quoteModel.clientAddressNameController.value.text.isNotEmpty ||
        quoteModel.clientAddressController.value.text.isNotEmpty ||
        quoteModel.billingAddressNameController.value.text.isNotEmpty ||
        quoteModel.billingAddressController.value.text.isNotEmpty ||
        (quoteModel.gmail_selectionStatus.value && quoteModel.emailController.value.text.isNotEmpty) ||
        (quoteModel.whatsapp_selectionStatus.value && quoteModel.phoneController.value.text.isNotEmpty) ||
        quoteModel.gstNumController.value.text.isNotEmpty ||
        quoteModel.Quote_noteList.isNotEmpty ||
        quoteModel.selectedPackagesList.isNotEmpty ||
        quoteModel.Quote_no.value != null);
  }

  bool postDatavalidation() {
    return (quoteModel.TitleController.value.text.isEmpty ||
        quoteModel.processID.value == null ||
        quoteModel.clientAddressNameController.value.text.isEmpty ||
        quoteModel.clientAddressController.value.text.isEmpty ||
        quoteModel.billingAddressNameController.value.text.isEmpty ||
        quoteModel.billingAddressController.value.text.isEmpty ||
        (quoteModel.gmail_selectionStatus.value && quoteModel.emailController.value.text.isEmpty) ||
        (quoteModel.whatsapp_selectionStatus.value && quoteModel.phoneController.value.text.isEmpty) ||
        (quoteModel.gstNumController.value.text.isEmpty) || // Optional if needed later
        quoteModel.Quote_noteList.isEmpty ||
        quoteModel.selectedPackagesList.isEmpty ||
        quoteModel.Quote_no.value == null);
  } // If any one is empty or null, then it returns true

  void resetData() {
    // GENERAL
    quoteModel.tabController.value = null;
    quoteModel.processID.value = null;
    quoteModel.Quote_no.value = null;
    quoteModel.Quote_table_heading.value = "";
    quoteModel.gstNumController.value.clear();

    // DETAILS
    quoteModel.TitleController.value.clear();
    quoteModel.clientAddressNameController.value.clear();
    quoteModel.clientAddressController.value.clear();
    quoteModel.billingAddressNameController.value.clear();
    quoteModel.billingAddressController.value.clear();
    quoteModel.detailsKey.value = GlobalKey<FormState>();

    // SITES
    quoteModel.QuoteSiteDetails.clear();
    quoteModel.siteFormkey.value = GlobalKey<FormState>();
    quoteModel.siteNameController.value.clear();
    quoteModel.addressController.value.clear();
    quoteModel.Billingtype_Controller.value = "individual";
    quoteModel.Mailtype_Controller.value = "individual";
    quoteModel.cameraquantityController.value.clear();
    quoteModel.site_editIndex.value = null;

    // PACKAGE
    quoteModel.selectedPackagesList.clear();
    quoteModel.packageList.clear();
    quoteModel.selectedPackage.value = null;
    quoteModel.company_basedPackageList.clear();
    quoteModel.customPackageCreated.value = false;
    quoteModel.packageDetails.clear();

    quoteModel.customNameControllers.value.clear();
    quoteModel.customDescControllers.value.clear();
    quoteModel.customCameraCountControllers.value.clear();
    quoteModel.customAmountControllers.value.clear();
    quoteModel.subscriptiontype.value = 'company';
    quoteModel.customPackage.value = null;

    // NOTES
    quoteModel.noteformKey.value = GlobalKey<FormState>();
    quoteModel.progress.value = 0.0;
    quoteModel.isLoading.value = false;
    quoteModel.note_editIndex.value = null;
    quoteModel.notecontentController.value.clear();
    quoteModel.recommendation_editIndex.value = null;
    quoteModel.recommendationHeadingController.value.clear();
    quoteModel.recommendationKeyController.value.clear();
    quoteModel.recommendationValueController.value.clear();
    quoteModel.Quote_noteList.clear();
    quoteModel.Quote_recommendationList.clear();
    quoteModel.notecontent.value = [
      'Delivery within 30 working days from the date of issuing the PO.',
      'Payment terms : 100% along with PO.',
      'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
    ];

    // POST
    quoteModel.pickedFile.value = null;
    quoteModel.selectedPdf.value = null;
    quoteModel.ispdfLoading.value = false;
    quoteModel.whatsapp_selectionStatus.value = true;
    quoteModel.gmail_selectionStatus.value = true;
    quoteModel.phoneController.value.clear();
    quoteModel.emailController.value.clear();
    quoteModel.CCemailController.value.clear();
    quoteModel.feedbackController.value.clear();
    quoteModel.filePathController.value.clear();
    quoteModel.CCemailToggle.value = false;
  }
}
