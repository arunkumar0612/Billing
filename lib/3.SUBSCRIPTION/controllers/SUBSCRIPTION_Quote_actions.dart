import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/constants/SUBSCRIPTION_Quote_constants.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class SUBSCRIPTION_QuoteController extends GetxController {
  var quoteModel = SUBSCRIPTION_QuoteModel();
// Initialize the tab controller with external reference.
  /// This method is used to set the TabController for the client request model.
  /// It allows the controller to manage tab navigation within the client request process.
  void initializeTabController(TabController tabController) {
    quoteModel.tabController.value = tabController;
  }

// Function to handle the next tab action
  /// This function navigates to the next tab in the tab controller if it exists and is not the last tab.
  /// If the current tab is the last one, it does nothing.
  void nextTab() {
    if (quoteModel.tabController.value!.index < quoteModel.tabController.value!.length - 1) {
      quoteModel.tabController.value!.animateTo(quoteModel.tabController.value!.index + 1);
    }
  }

// Function to handle the back tab action
  /// This function navigates to the previous tab in the tab controller if it exists and is not the first tab.
  /// If the current tab is the first one, it does nothing.
  void backTab() {
    if (quoteModel.tabController.value!.index > 0) {
      quoteModel.tabController.value!.animateTo(quoteModel.tabController.value!.index - 1);
    }
  }

// Function to update the site name in the quote model
  /// This function updates the site name in the quote model's siteNameController.
  /// It sets the text of the siteNameController to the provided siteName.
  /// This method is used to update the site name in the quote model.
  void updatesiteName(String siteName) {
    quoteModel.siteNameController.value.text = siteName;
  }

// Function to update the site edit index in the quote model
  /// This function updates the site edit index in the quote model.
  /// It sets the site_editIndex to the provided index.
  /// This method is used to set the index of the site being edited in the quote model.
  void addSiteEditindex(int? index) {
    quoteModel.site_editIndex.value = index;
  }

// Function to update the site name in the quote model
  /// This function updates the site name in the quote model's siteNameController.
  /// It sets the text of the siteNameController to the provided siteName.
  /// This method is used to update the site name in the quote model.
  void updateSiteName(String siteName) {
    quoteModel.siteNameController.value.text = siteName;
  }

  // Function to update the camera quantity in the quote model
  /// This function updates the camera quantity in the quote model's cameraquantityController.
  /// It sets the text of the cameraquantityController to the provided quantity.
  void updateQuantity(int quantity) {
    quoteModel.cameraquantityController.value.text = quantity.toString();
  }

  // Function to update the address in the quote model
  /// This function updates the address in the quote model's addressController.
  /// It sets the text of the addressController to the provided address.
  void updateAddressName(String address) {
    quoteModel.addressController.value.text = address;
  }

// removeFromProductList
  /// This function removes a product from the product list at the specified index.
  /// It uses the index to identify which product to remove from the QuoteSiteDetails list in the quote model.
  void removeFromProductList(index) {
    quoteModel.QuoteSiteDetails.removeAt(index);
  }

//updateNoteEditindex
  /// This function updates the note edit index in the quote model.
  /// It sets the note_editIndex to the provided index.
  void updateNoteEditindex(int? index) {
    quoteModel.note_editIndex.value = index;
  }

//updateChallanTableHeading
  /// This function updates the table heading in the quote model.
  /// It sets the Quote_table_heading to the provided tableHeading.
  void updateChallanTableHeading(String tableHeading) {
    quoteModel.Quote_table_heading.value = tableHeading;
  }

// updateNoteList
  /// This function updates the note list in the quote model.
  /// It sets the content of the note at the specified index in the Quote_noteList to the text from the notecontentController.
  /// This method is used to update the content of a specific note in the note list.
  void updateNoteList(String value, int index) {
    quoteModel.Quote_noteList[quoteModel.note_editIndex.value!] = quoteModel.notecontentController.value.text;
  }

  // Function to update the tab controller in the quote model
  /// This function updates the tab controller in the quote model.
  /// It sets the tabController to the provided TabController instance.
  /// This method is used to update the tab controller for managing tab navigation in the quote model.
  void updateTabController(TabController tabController) {
    quoteModel.tabController.value = tabController;
  }

  // Function to update the title in the quote model
  /// This function updates the title in the quote model's TitleController.
  /// It sets the text of the TitleController to the provided text.
  void updateTitle(String text) {
    quoteModel.TitleController.value.text = text;
  }

  // Function to update the quote number in the quote model
  /// This function updates the quote number in the quote model's Quote_no.
  /// It sets the Quote_no to the provided text.
  /// This method is used to update the quote number in the quote model.
  void updateQuotenumber(String text) {
    quoteModel.Quote_no.value = text;
  }

  // Function to update the GST number in the quote model
  /// This function updates the GST number in the quote model's gstNumController.
  /// It sets the text of the gstNumController to the provided text.
  /// This method is used to update the GST number in the quote model.
  void updateGSTnumber(String text) {
    quoteModel.gstNumController.value.text = text;
  }

  // Function to update the client address name in the quote model
  /// This function updates the client address name in the quote model's clientAddressNameController.
  /// It sets the text of the clientAddressNameController to the provided text.
  /// This method is used to update the client address name in the quote model.
  void updateClientAddressName(String text) {
    quoteModel.clientAddressNameController.value.text = text;
  }

  // Function to update the client address in the quote model
  /// This function updates the client address in the quote model's clientAddressController.
  /// It sets the text of the clientAddressController to the provided text.
  /// This method is used to update the client address in the quote model.
  void updateClientAddress(String text) {
    quoteModel.clientAddressController.value.text = text;
  }

  // Function to update the billing address name in the quote model
  /// This function updates the billing address name in the quote model's billingAddressNameController.
  /// It sets the text of the billingAddressNameController to the provided text.
  /// This method is used to update the billing address name in the quote model.
  void updateBillingAddressName(String text) {
    quoteModel.billingAddressNameController.value.text = text;
  }

  // Function to update the billing address in the quote model
  /// This function updates the billing address in the quote model's billingAddressController.
  /// It sets the text of the billingAddressController to the provided text.
  /// This method is used to update the billing address in the quote model.
  void updateBillingAddress(String text) {
    quoteModel.billingAddressController.value.text = text;
  }

  // Function to update the phone number in the quote model
  /// This function updates the phone number in the quote model's phoneController.
  /// It sets the text of the phoneController to the provided phone number.
  /// This method is used to update the phone number in the quote model.
  void updatePhone(String phone) {
    quoteModel.phoneController.value.text = phone;
  }

  // Function to update the email in the quote model
  /// This function updates the email in the quote model's emailController.
  /// It sets the text of the emailController to the provided email.
  /// This method is used to update the email in the quote model.
  void updateEmail(String email) {
    quoteModel.emailController.value.text = email;
  }

  // Function to update the CC email in the quote model
  /// This function updates the CC email in the quote model's CCemailController.
  /// It sets the text of the CCemailController to the provided CC email.
  void updatCC(String CC) {
    quoteModel.CCemailController.value.text = CC;
  }

  // Function to toggle the visibility of CC email in the quote model
  /// This function toggles the visibility of the CC email in the quote model's CCemailToggle.
  /// It sets the value of CCemailToggle to the provided boolean value.
  void toggleCCemailvisibility(bool value) {
    quoteModel.CCemailToggle.value = value;
  }

  // Function to update the recommendation edit index in the quote model
  /// This function updates the recommendation edit index in the quote model.
  /// It sets the recommendation_editIndex to the provided index.
  /// This method is used to set the index of the recommendation being edited in the quote model.
  void updateRecommendationEditindex(int? index) {
    quoteModel.recommendation_editIndex.value = index;
  }

  // Function to update the note content in the quote model
  /// This function updates the note content in the quote model's notecontentController.
  /// It sets the text of the notecontentController to the provided text.
  /// This method is used to update the content of a note in the quote model.
  void updateNoteContentControllerText(String text) {
    quoteModel.notecontentController.value.text = text;
  }

  // Function to update the recommendation heading text in the quote model
  /// This function updates the recommendation heading text in the quote model's recommendationHeadingController.
  /// It sets the text of the recommendationHeadingController to the provided text.
  /// This method is used to update the heading of a recommendation in the quote model.
  void updateRec_HeadingControllerText(String text) {
    quoteModel.recommendationHeadingController.value.text = text;
  }

// updateRec_KeyControllerText
  /// This function updates the recommendation key text in the quote model's recommendationKeyController.
  /// It sets the text of the recommendationKeyController to the provided text.
  /// This method is used to update the key of a recommendation in the quote model.
  void updateRec_KeyControllerText(String text) {
    quoteModel.recommendationKeyController.value.text = text;
  }

//updateRec_ValueControllerText
  /// This function updates the recommendation value text in the quote model's recommendationValueController.
  /// It sets the text of the recommendationValueController to the provided text.
  /// This method is used to update the value of a recommendation in the quote model.
  void updateRec_ValueControllerText(String text) {
    quoteModel.recommendationValueController.value.text = text;
  }

  // Function to add a note to the list in the quote model
  /// This function adds a note to the note list in the quote model.
  /// It appends the provided note to the notecontent list in the quote model.
  /// This method is used to add a note to the list of notes in the quote model.
  void addNoteToList(String note) {
    quoteModel.notecontent.add(note);
  }

  // Function to update the process ID in the quote model
  /// This function updates the process ID in the quote model.
  /// It sets the processID to the provided integer value.
  void setProcessID(int processid) {
    quoteModel.processID.value = processid;
  }

  // Function to update the selected package in the quote model
  /// This function updates the selected package in the quote model.
  /// It sets the selectedPackage to the provided package name.
  void updateSelectedPdf(File file) {
    quoteModel.selectedPdf.value = file;
  }

// setLoading
  /// This function sets the loading state in the quote model.
  /// It updates the isLoading property to the provided boolean value.
  void setLoading(bool value) {
    quoteModel.isLoading.value = value;
  }

  // Function to set the PDF loading state in the quote model
  /// This function sets the PDF loading state in the quote model.
  /// It updates the ispdfLoading property to the provided boolean value.
  void setpdfLoading(bool value) {
    quoteModel.ispdfLoading.value = value;
  }

  // Function to update the company ID in the quote model
  /// This function updates the company ID in the quote model.
  /// It sets the companyid to the provided integer value.
  /// This method is used to update the company ID in the quote model.
  void update_companyID(int value) {
    quoteModel.companyid.value = value;
  }

//toggleWhatsApp
  /// This function toggles the WhatsApp selection status in the quote model.
  /// It sets the whatsapp_selectionStatus to the provided boolean value.
  /// This method is used to toggle the WhatsApp selection status in the quote model.
  void toggleWhatsApp(bool value) {
    quoteModel.whatsapp_selectionStatus.value = value;
  }

  //toggleGmail
  /// This function toggles the Gmail selection status in the quote model.
  /// It sets the gmail_selectionStatus to the provided boolean value.
  /// This method is used to toggle the Gmail selection status in the quote model.
  void toggleGmail(bool value) {
    quoteModel.gmail_selectionStatus.value = value;
  }

//updatePhoneNumber
  /// This function updates the phone number in the quote model's phoneController.
  /// It sets the text of the phoneController to the provided phone number.
  /// This method is used to update the phone number in the quote model.
  void updatePhoneNumber(String phoneNumber) {
    quoteModel.phoneController.value.text = phoneNumber;
  }

  // Update feedback text
  /// This function updates the feedback text in the quote model's feedbackController.
  /// It sets the text of the feedbackController to the provided feedback.
  void updateFeedback(String feedback) {
    quoteModel.feedbackController.value.text = feedback;
  }

  // Update file path text
  /// This function updates the file path in the quote model's filePathController.
  /// It sets the text of the filePathController to the provided file path.
  void updateFilePath(String filePath) {
    quoteModel.filePathController.value.text = filePath;
  }

// Function to remove a site from the site list in the quote model
  /// This function removes a site from the site list at the specified index.
  /// It uses the index to identify which site to remove from the QuoteSiteDetails list in the quote model.
  void removeFromsiteList(index) {
    quoteModel.QuoteSiteDetails.removeAt(index);
  }

  // Function to update the billing type in the quote model
  /// This function updates the billing type in the quote model's Billingtype_Controller.
  /// It sets the value of the Billingtype_Controller to the provided billing type.
  void updateBillingtype(String billingtype) {
    quoteModel.Billingtype_Controller.value = billingtype;
  }

  // Function to update the mail type in the quote model
  /// This function updates the mail type in the quote model's Mailtype_Controller.
  /// It sets the value of the Mailtype_Controller to the provided mail type.
  void updateMailtype(String mailtype) {
    quoteModel.Mailtype_Controller.value = mailtype;
  }

// Function to pick a file using the FilePicker
  /// This function allows the user to pick a file using the FilePicker.
  /// It opens a file picker dialog and allows the user to select a file with specific extensions (png, jpg, jpeg).
  /// If a file is selected, it checks the file size and updates the quoteModel with the selected file.
  /// If the file exceeds 2 MB, it shows an error dialog and resets the picked file and selected PDF in the quoteModel.
  /// If the file is successfully picked, it updates the quoteModel with the selected file and prints the file name in debug mode.
  /// If no file is selected, it does nothing.
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

  // Function to fetch the message type based on WhatsApp and Gmail selection status
  /// This function determines the message type based on the WhatsApp and Gmail selection status.
  int fetch_messageType() {
    if (quoteModel.whatsapp_selectionStatus.value && quoteModel.gmail_selectionStatus.value) return 3;
    if (quoteModel.whatsapp_selectionStatus.value) return 2;
    if (quoteModel.gmail_selectionStatus.value) return 1;

    return 0;
  }
// Function to start the progress indicator
  /// This function simulates a progress indicator by incrementally updating the progress value from 0 to 1.0 (100%).
  /// It sets the loading state to true at the start and false at the end.
  Future<void> startProgress() async {
    setLoading(true);
    quoteModel.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      quoteModel.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  // Function to add a recommendation to the recommendation list in the quote model
  /// This function adds a recommendation to the recommendation list in the quote model.
  /// It checks if the key and value are not empty before adding the recommendation.
  /// If either the key or value is empty, it prints an error message in debug mode.
  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      quoteModel.Quote_recommendationList.add(SUBSCRIPTION_QuoteRecommendation(key: key, value: value));
    } else {
      if (kDebugMode) {
        print('Key and value must not be empty');
      }
    }
  }
// Function to update a recommendation in the recommendation list in the quote model
  /// This function updates a recommendation in the recommendation list at the specified index.
  /// It checks if the index is valid and if the key and value are not empty before updating the recommendation.
  /// If the index is invalid or if either the key or value is empty, it prints an error message in debug mode.
  /// If the index is valid and both key and value are provided, it updates the recommendation at the specified index with the new key and value.
  /// If the index is invalid, it prints an error message in debug mode.
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

  // Function to add a site to the site list in the quote model
  /// This function adds a site to the site list in the quote model.
  /// It checks if the site name, camera quantity, and address are valid before adding the site.
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

  // Function to update a site in the site list in the quote model
  /// This function updates a site in the site list at the specified index.
  /// It checks if the site name, camera quantity, and address are valid before updating the site.
  /// If the editIndex is invalid, it shows an error message.
  /// If the input fields are valid, it updates the site details at the specified index.
  /// If any unexpected error occurs, it shows an error message.
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

  // Function to add a note to the note list in the quote model
  /// This function adds a note to the note list in the quote model.
  /// It checks if the note content is not empty before adding the note.
  /// If the note content is empty, it prints an error message in debug mode.
  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      quoteModel.Quote_noteList.add(noteContent);
    } else {
      if (kDebugMode) {
        print('Note content must not be empty');
      } // Handle empty input (optional)
    }
  }
// Function to remove a note from the note list in the quote model
  /// This function removes a note from the note list at the specified index.
  /// It uses the index to identify which note to remove from the Quote_noteList in the quote model.
  /// If the index is valid, it removes the note at that index.
  void removeFromNoteList(int index) {
    quoteModel.Quote_noteList.removeAt(index);
  }
// Function to remove a recommendation from the recommendation list in the quote model
  /// This function removes a recommendation from the recommendation list at the specified index.
  /// It uses the index to identify which recommendation to remove from the Quote_recommendationList in the quote model.
  /// If the index is valid, it removes the recommendation at that index.
  void removeFromRecommendationList(int index) {
    quoteModel.Quote_recommendationList.removeAt(index);
    quoteModel.Quote_recommendationList.isEmpty ? quoteModel.recommendationHeadingController.value.clear() : null;
  }
// Function to update the required data in the quote model
  /// This function updates the required data in the quote model based on the CMDmResponse value and event type.
  /// It checks the event type and updates the quote model with the relevant data.
  /// If the event type is 'revisedquotation', it stores the fetched packages.
  /// It also updates various fields in the quote model such as Quote_no, companyid, title, emailId, gst, phoneNo, client address name, client address, billing address name, and billing address.
  /// It prints the data in debug mode if kDebugMode is true.
  /// @param value The CMDmResponse value containing the data to be updated.
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
// Function to store fetched packages in the quote model
  /// This function stores the fetched packages in the quote model.
  /// It checks if the 'packagedetails' key exists in the data and if it does, it converts the package details into a list of Package objects.
  /// It also sets the selected package to the first package in the list if available.
  /// It iterates through the selected packages and their sites, creating Site objects and adding them to the QuoteSiteDetails list in the quote model.
  /// It prints the package details and selected packages in debug mode if kDebugMode is true.
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

  // Function to update company-based packages in the quote model
  /// This function updates the company-based packages in the quote model.
  /// It clears the existing package details and package list, then populates them with the company-based packages from the response data.
  /// It also adds a 'Custom Package' option to the package list.
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
// Function to validate data before generating a quote
  /// This function checks if any required fields are empty or null in the quote model.
  /// It returns true if any of the fields are empty or null, indicating that data validation has failed.

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

  // Function to check if any data is present in the quote model
  /// This function checks if any of the required fields in the quote model have data.
  /// It returns true if any of the fields have data, indicating that there is some information present in the quote model.
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
// Function to validate data after the quote has been generated
  /// This function checks if any required fields are empty or null in the quote model after the quote has been generated.
  /// It returns true if any of the fields are empty or null, indicating that data validation has failed after the quote generation.
  /// This function is used to ensure that all necessary information is provided before finalizing the quote
  /// and sending it to the client.
  /// It checks fields such as title, process ID, client address name, client address,
  /// billing address name, billing address, GST number, notes, selected packages, and quote number.
  /// If any of these fields are empty or null, it returns true, indicating that the data validation has failed.
  /// If all fields are filled, it returns false, indicating that the data validation has passed
  /// and the quote can be finalized and sent to the client.
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

  // Function to reset all data in the quote model
  /// This function resets all data in the quote model to its initial state.
  /// It clears all text controllers, resets lists, and sets various properties to their default values.
  /// This method is used to clear all data in the quote model, allowing for a fresh
  /// start when creating a new quote.
  /// It resets the tab controller, process ID, quote number, table heading, GST number,
  /// title, client address name, client address, billing address name, billing address,
  /// site details, selected packages, package list, custom package creation status,
  /// note form key, progress, loading state, note edit index, note content, recommendation
  /// edit index, recommendation heading, recommendation key, recommendation value,
  /// quote note list, quote recommendation list, picked file, selected PDF, PDF loading state,
  /// WhatsApp selection status, Gmail selection status, phone number, email, CC email,
  /// feedback, file path, and CC email toggle.
  /// It is typically called when starting a new quote or when clearing the current quote data.
  /// This function ensures that all data is reset to its initial state, allowing for a fresh start when creating a new quote.
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
