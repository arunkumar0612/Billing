import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/constants/SUBSCRIPTION_ClientReq_constants.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/SUBSCRIPTION_ClientReq_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class SUBSCRIPTION_ClientreqController extends GetxController {
  var clientReqModel = SUBSCRIPTION_ClientReqModel();
// Initialize the tab controller with external reference.
  /// This method is used to set the TabController for the client request model.
  /// It allows the controller to manage tab navigation within the client request process.
  void initializeTabController(TabController tabController) {
    clientReqModel.tabController.value = tabController;
  }

  // Tab Navigation
  /// Navigates to the next tab in the client request process.
  /// If the current tab is not the last one, it animates to the next tab.
  /// This method is used to move forward in the client request workflow.
  void nextTab() {
    if (clientReqModel.tabController.value!.index < clientReqModel.tabController.value!.length - 1) {
      clientReqModel.tabController.value!.animateTo(clientReqModel.tabController.value!.index + 1);
    }
  }

  /// Navigates to the previous tab in the client request process.
  /// If the current tab is not the first one, it animates to the previous tab.
  /// This method is used to move backward in the client request workflow.
  void backTab() {
    if (clientReqModel.tabController.value!.index > 0) {
      clientReqModel.tabController.value!.animateTo(clientReqModel.tabController.value!.index - 1);
    }
  }

  // Update Tab Controller
  /// Updates the TabController for the client request model.
  /// This method is used to set a new TabController with the specified length and TickerProvider.
  /// It allows the controller to manage tab navigation dynamically.
  void updateTabController(TickerProvider vsync, int length) {
    clientReqModel.tabController.value = TabController(length: length, vsync: vsync);
  }

  // Update Selected PDF
  /// Updates the selected PDF file path in the client request model.
  /// This method is used to set the path of the PDF file that will be associated with the client request.
  /// It allows the controller to manage the selected PDF file for the client request.
  void updateSelectedPdf(String filePath) {
    clientReqModel.selectedPdf.value = File(filePath);
  }

  // Update Form Key
  /// Updates the form key for the client request details form.
  /// This method is used to set a new GlobalKey for the form state,
  /// allowing the controller to manage form validation and submission.
  void updateFormKey(GlobalKey<FormState> newKey) {
    clientReqModel.detailsformKey.value = newKey;
  }

  // Update updated client name
  /// Updates the client name in the client request model.
  /// This method is used to set the name of the client for the client request.
  void updateClientName(String name) {
    clientReqModel.clientNameController.value.text = name;
  }

  // Update organization name
  /// Updates the organization name in the client request model.
  /// This method is used to set the name of the organization associated with the client request.
  void updateOrgName(String org) {
    clientReqModel.Org_Controller.value = org;
  }

  // Update Company ID
  /// Updates the company ID in the client request model.
  /// This method is used to set the ID of the company associated with the client request.
  void updateCompanyID(int comp) {
    clientReqModel.CompanyID_Controller.value = comp;
  }

  // Update CustomerType
  /// Updates the customer type in the client request model.
  /// This method is used to set the type of customer for the client request.
  void update_CustomerType(String value) {
    clientReqModel.customerType.value = value;
  }

  // Update Company Name
  /// Updates the company name in the client request model.
  /// This method is used to set the name of the company associated with the client request.
  void updateCompanyName(String comp) {
    clientReqModel.Companyname_Controller.value = comp;
  }

//clear Company Data
  /// Clears the company data in the client request model.
  /// This method is used to reset the company-related fields in the client request model,
  /// including the company ID, name, and list of companies.
  void clear_CompanyData() async {
    clientReqModel.CompanyID_Controller.value = null;
    clientReqModel.Companyname_Controller.value = null;
    clientReqModel.CompanyList.clear();
  }

  // Update title
  /// Updates the title in the client request model.
  /// This method is used to set the title of the client request,
  /// allowing the controller to manage the title for the client request.
  void updateTitle(String title) {
    clientReqModel.titleController.value.text = title;
  }

  // Update client address
  /// Updates the client address in the client request model.
  /// This method is used to set the address of the client for the client request,
  /// it allows the controller to manage the address information for the client.
  void updateClientAddress(String address) {
    clientReqModel.clientAddressController.value.text = address;
  }

  // Update billing address name
  /// Updates the billing address name in the client request model.
  /// This method is used to set the name of the billing address associated with the client request.
  /// It allows the controller to manage the billing address name for the client.
  void updateBillingAddressName(String name) {
    clientReqModel.billingAddressNameController.value.text = name;
  }

  // Update billing address
  /// Updates the billing address in the client request model.
  /// This method is used to set the address of the billing address associated with the client request.
  /// It allows the controller to manage the billing address information for the client.
  void updateBillingAddress(String address) {
    clientReqModel.billingAddressController.value.text = address;
  }

  // Update MOR
  /// Updates the MOR (Mode of Receipt) in the client request model.
  /// This method is used to set the MOR value for the client request,
  /// it allows the controller to manage the MOR information for the client.
  void updateMOR(String morValue) {
    clientReqModel.morController.value.text = morValue;
  }

  // Update phone number
  /// Updates the phone number in the client request model.
  /// This method is used to set the phone number of the client for the client request,
  /// it allows the controller to manage the phone number information for the client.
  void updatePhone(String phone) {
    clientReqModel.phoneController.value.text = phone;
  }

  // Update email
  /// Updates the email in the client request model.
  /// This method is used to set the email address of the client for the client request,
  /// it allows the controller to manage the email information for the client.
  void updateEmail(String email) {
    clientReqModel.emailController.value.text = email;
  }

  // Update GST
  /// Updates the GST (Goods and Services Tax) number in the client request model.
  /// This method is used to set the GST number for the client request,
  /// it allows the controller to manage the GST information for the client.
  void updateGST(String gst) {
    clientReqModel.gstController.value.text = gst;
  }

  // addSiteEditindex
  /// Adds or updates the site edit index in the client request model.
  /// This method is used to set the index of the site being edited,
  /// it allows the controller to manage the editing state of sites.
  void addSiteEditindex(int? index) {
    clientReqModel.site_editIndex.value = index;
  }

  // Update site name
  /// Updates the site name in the client request model.
  /// This method is used to set the name of the site associated with the client request,
  /// it allows the controller to manage the site name for the client request.
  void updateSiteName(String siteName) {
    clientReqModel.siteNameController.value.text = siteName;
  }

  // Update camera quantity
  /// Updates the camera quantity in the client request model.
  /// This method is used to set the number of cameras for the site associated with the client request,
  /// it allows the controller to manage the quantity of cameras for the site.
  void updateQuantity(int quantity) {
    clientReqModel.cameraquantityController.value.text = quantity.toString();
  }

  // Update address name
  /// Updates the address name in the client request model.
  /// This method is used to set the name of the address associated with the site in the client request,
  /// it allows the controller to manage the address name for the site.
  void updateAddressName(String address) {
    clientReqModel.addressController.value.text = address;
  }

// updateRec_valueControllerText
  /// Updates the value in the recommendation value controller.
  /// This method is used to set the value of the recommendation in the client request model,
  /// it allows the controller to manage the text input for recommendations.
  void updateRec_ValueControllerText(String text) {
    clientReqModel.Rec_ValueController.value.text = text;
  }

//update note list
  /// Updates the note list in the client request model.
  /// This method is used to set the content of a note in the client request model,
  /// it allows the controller to manage the list of notes associated with the client request.
  void updateNoteList(String value, int index) {
    clientReqModel.clientReqNoteList[clientReqModel.noteEditIndex.value!] = clientReqModel.noteContentController.value.text;
  }

// update note edit index
  /// Updates the note edit index in the client request model.
  /// This method is used to set the index of the note being edited,
  /// it allows the controller to manage the editing state of notes.
  void updateNoteEditindex(int? index) {
    clientReqModel.noteEditIndex.value = index;
  }

//updateRecommendationEditindex
  /// Updates the recommendation edit index in the client request model.
  /// This method is used to set the index of the recommendation being edited,
  /// it allows the controller to manage the editing state of recommendations.
  void updateRecommendationEditindex(int? index) {
    clientReqModel.Rec_EditIndex.value = index;
  }

//updateNoteContentControllerText
  /// Updates the text in the note content controller.
  /// This method is used to set the content of the note being edited in the client request model,
  /// it allows the controller to manage the text input for notes.
  void updateNoteContentControllerText(String text) {
    clientReqModel.noteContentController.value.text = text;
  }

//updateRec_KeyControllerText
  /// Updates the text in the recommendation key controller.
  /// This method is used to set the key of the recommendation being edited in the client request model,
  void updateRec_KeyControllerText(String text) {
    clientReqModel.Rec_KeyController.value.text = text;
  }

//removeFromSiteList
  /// Removes a site from the site list in the client request model.
  /// This method is used to delete a site from the list of sites associated with the client request,
  /// and it also resets the site edit index.
  void removeFromSiteList(index) {
    clientReqModel.clientReqSiteDetails.removeAt(index);
    clientReqModel.site_editIndex.value = null;
  }

//removeFromNoteList
  /// Removes a note from the note list in the client request model.
  /// This method is used to delete a note from the list of notes associated with the client request,
  /// and it also resets the note edit index.
  void removeFromNoteList(int index) {
    clientReqModel.clientReqNoteList.removeAt(index);
    clientReqModel.noteEditIndex.value = null;
  }

//removeFromRecommendationList
  /// Removes a recommendation from the recommendation list in the client request model.
  /// This method is used to delete a recommendation from the list of recommendations associated with the client request,
  /// and it also resets the recommendation edit index.
  void removeFromRecommendationList(int index) {
    clientReqModel.clientReqRecommendationList.removeAt(index);

    clientReqModel.Rec_EditIndex.value = null;
  }

//updateMOR_uploadedPath
  /// Updates the uploaded path for the MOR (Mode of Receipt) in the client request model.
  /// This method is used to set the path of the uploaded MOR file,
  /// it allows the controller to manage the uploaded MOR file path for the client request.
  void updateMOR_uploadedPath(CMDmResponse value) {
    clientReqModel.MOR_uploadedPath.value = MORpath.fromJson(value).path;
  }

//addRecommendation
  /// Adds a recommendation to the recommendation list in the client request model.
  /// This method is used to create a new recommendation with a key and value,
  /// it allows the controller to manage the list of recommendations associated with the client request.
  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      clientReqModel.clientReqRecommendationList.add(Recommendation(key: key, value: value));
    }
  }

  // clearPickedFiles
  /// Clears the picked files in the client request model.
  /// This method is used to reset the picked file and MOR file,
  /// allowing the controller to manage the state of file selection for the client request.
  void clearPickedFiles() {
    clientReqModel.pickedFile.value = null;
    clientReqModel.morFile.value = null;
  }

  // pickFile
  /// Prompts the user to pick a file using the FilePicker package.
  /// This method allows the user to select a file with specific extensions (png, jpg, jpeg),
  /// and checks if the selected file exceeds 2MB in size.
  /// If the file is valid, it updates the picked file and MOR file in the client request model.
  Future<bool> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg'], lockParentWindow: true);

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');

        clientReqModel.pickedFile.value = null;
        clientReqModel.morFile.value = null;
      } else {
        clientReqModel.pickedFile.value = result;
        clientReqModel.morFile.value = file;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  // updateRecommendation
  /// Updates a recommendation in the recommendation list at a specified index.
  /// This method checks if the index is valid and if the key and value are not empty,
  /// it updates the recommendation at the specified index with the new key and value.
  void updateRecommendation({
    required int index,
    required String key,
    required String value,
  }) {
    try {
      if (index >= 0 && index < clientReqModel.clientReqRecommendationList.length) {
        if (key.isNotEmpty && value.isNotEmpty) {
          clientReqModel.clientReqRecommendationList[index] = Recommendation(key: key, value: value);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
    }
  }

  // addNote
  /// Adds a note to the note list in the client request model.
  /// This method checks if the note content is not empty,
  /// and if valid, it adds the note to the list of client request notes.
  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      clientReqModel.clientReqNoteList.add(noteContent);
    }
  }

  // addSite
  /// Adds a site to the site details list in the client request model.
  /// This method checks if the site name, camera quantity, and address are valid,
  /// and if valid, it creates a new site entry and adds it to the list of client request sites.
  void addSite({
    required BuildContext context,
    required String siteName,
    required int cameraquantity,
    required String address,
  }) {
    try {
      if (siteName.trim().isEmpty || cameraquantity <= 0 || address.trim().isEmpty) {
        Error_SnackBar(context, 'Please provide valid product details.');

        return;
      }
      clientReqModel.clientReqSiteDetails.add(SUBSCRIPTION_ClientreqSites((clientReqModel.clientReqSiteDetails.length + 1).toString(), siteName, cameraquantity, address));
    } catch (e) {
      Error_SnackBar(context, 'An error occurred while adding the product.');
    }
  }

  // updateSite
  /// Updates a site in the site details list at a specified index.
  /// This method checks if the site name, camera quantity, and address are valid,
  /// and if the edit index is valid, it updates the site details at the specified index.
  void updateSite({
    required BuildContext context,
    required int editIndex,
    required String siteName,
    required int cameraquantity,
    required String address,
  }) {
    try {
      // Validate input fields
      if (siteName.trim().isEmpty || cameraquantity <= 0 || address.trim().isEmpty) {
        Error_SnackBar(context, 'Please provide valid product details.');

        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= clientReqModel.clientReqSiteDetails.length) {
        Error_SnackBar(context, 'Invalid product index.');

        return;
      }
      // Update the product details at the specified index
      clientReqModel.clientReqSiteDetails[editIndex] = SUBSCRIPTION_ClientreqSites((editIndex + 1).toString(), siteName, cameraquantity, address);
    } catch (e) {
      // Handle unexpected errors
      Error_SnackBar(context, 'An error occurred while updating the product.');
    }
  }

  // update_OrganizationList
  /// Updates the organization list in the client request model.
  /// This method clears the existing organization list and populates it with new data from the CMDlResponse.
  void update_OrganizationList(CMDlResponse value) {
    clientReqModel.organizationList.clear();
    for (int i = 0; i < value.data.length; i++) {
      clientReqModel.organizationList.add(Organization.fromJson(value, i));
    }
  }

  // clear_KYC
  /// Clears the KYC (Know Your Customer) data in the client request model.
  /// This method resets the client address, billing address name, billing address,
  /// email, phone, and GST fields to their default values.
  /// It is used to reset the KYC-related information in the client request model.
  /// This method is useful when starting a new client request or when KYC information needs to be cleared.
  void clear_KYC() {
    updateClientAddress("");
    updateBillingAddressName("");
    updateBillingAddress("");
    updateEmail("");
    updatePhone("");
    updateGST("");
  }

  // update_KYC
  /// Updates the KYC (Know Your Customer) information in the client request model.
  /// This method sets the client name, client address, billing address name,
  /// billing address, email, phone, and GST fields with the provided values.
  /// It is used to update the KYC-related information in the client request model.
  /// This method is useful when the KYC information needs to be updated for a client request.
  void update_KYC(Clname, Claddress, Blname, Bladdress, email, phone, gst) {
    updateClientAddress(Claddress ?? "");
    updateBillingAddressName(Blname ?? "");
    updateBillingAddress(Bladdress ?? "");
    updateEmail(email ?? "");
    updatePhone(phone ?? "");
    updateGST(gst ?? "");
    updateClientName(Clname ?? "");
  }

  // update_CompanyList
  /// Updates the company list in the client request model.
  /// This method clears the existing company data and populates it with new data from the CMDlResponse.
  /// It is used to refresh the list of companies associated with the client request.
  void update_CompanyList(CMDlResponse value) async {
    clear_CompanyData();
    // clear_BranchData();
    clear_KYC();

    // await Future.delayed(const Duration(milliseconds: 1000));
    for (int i = 0; i < value.data.length; i++) {
      clientReqModel.CompanyList.add(Company.fromJson(value, i));
    }
  }

// anyHavedata
  /// Checks if any data is present in the client request model.
  /// This method returns true if any of the fields in the client request model have data,
  /// including uploaded paths, customer ID, client name, title, addresses, phone, email,
  /// GST, organization, company, branch, picked files, site details, notes, and recommendations.
  /// It is used to determine if there is any data entered in the client request form.
  /// If any of the fields have data, it returns true; otherwise, it returns false.
  bool anyHavedata() {
    return (clientReqModel.MOR_uploadedPath.value != null ||
        clientReqModel.customer_id.value != 0 ||
        clientReqModel.clientNameController.value.text.isNotEmpty ||
        clientReqModel.titleController.value.text.isNotEmpty ||
        clientReqModel.clientAddressController.value.text.isNotEmpty ||
        clientReqModel.billingAddressNameController.value.text.isNotEmpty ||
        clientReqModel.billingAddressController.value.text.isNotEmpty ||
        clientReqModel.morController.value.text.isNotEmpty ||
        clientReqModel.phoneController.value.text.isNotEmpty ||
        clientReqModel.emailController.value.text.isNotEmpty ||
        clientReqModel.gstController.value.text.isNotEmpty ||
        clientReqModel.Org_Controller.value != null ||
        clientReqModel.CompanyID_Controller.value != null ||
        clientReqModel.Branch_Controller.value != null ||
        clientReqModel.pickedFile.value != null ||
        clientReqModel.morFile.value != null ||
        clientReqModel.organizationList.isNotEmpty ||
        clientReqModel.CompanyList.isNotEmpty ||
        clientReqModel.siteNameController.value.text.isNotEmpty ||
        clientReqModel.cameraquantityController.value.text.isNotEmpty ||
        clientReqModel.addressController.value.text.isNotEmpty ||
        clientReqModel.clientReqSiteDetails.isNotEmpty ||
        clientReqModel.Rec_HeadingController.value.text.isNotEmpty ||
        clientReqModel.Rec_KeyController.value.text.isNotEmpty ||
        clientReqModel.Rec_ValueController.value.text.isNotEmpty ||
        clientReqModel.clientReqNoteList.isNotEmpty ||
        clientReqModel.clientReqRecommendationList.isNotEmpty);
  }

  // postDatavalidation
  /// Validates the data in the client request model before posting.
  /// This method checks if any of the required fields are empty or null,
  /// including the title, client name, email, phone, client address,
  /// GST, billing address name, billing address, MOR, and uploaded path.
  /// If any of these fields are empty or null, it returns true,
  /// indicating that the data is not valid for posting.
  /// If all required fields are filled, it returns false, indicating that the data is valid for posting.
  bool postDatavalidation() {
    return (clientReqModel.titleController.value.text.isEmpty ||
        clientReqModel.clientNameController.value.text.isEmpty ||
        clientReqModel.emailController.value.text.isEmpty ||
        clientReqModel.phoneController.value.text.isEmpty ||
        clientReqModel.clientAddressController.value.text.isEmpty ||
        clientReqModel.gstController.value.text.isEmpty ||
        clientReqModel.billingAddressNameController.value.text.isEmpty ||
        clientReqModel.billingAddressController.value.text.isEmpty ||
        clientReqModel.morController.value.text.isEmpty ||
        clientReqModel.MOR_uploadedPath.value == null);
  } // If any one is empty or null, then it returns true

  /// Checks if there is no data present in the client request model.
  /// This method returns true if none of the fields in the client request model have data,
  /// including uploaded paths, customer ID, client name, title, addresses, phone, email,
  /// GST, organization, company, branch, picked files, site details, notes, and recommendations.
  bool anyDontHavedata() {
    return !anyHavedata();
  }

  // resetData
  /// Resets all data in the client request model to its initial state.
  /// This method clears all fields in the client request model,
  /// including uploaded paths, customer ID, tab controller, selected PDF,
  /// details form key, client name, title, addresses, phone, email,
  /// GST, organization, company, branch, picked files, site details, notes,
  /// and recommendations.
  /// It is used to reset the client request model to its default state,
  /// allowing the user to start a new client request without any previous data.
  void resetData() {
    clientReqModel.MOR_uploadedPath.value = null;
    clientReqModel.customer_id.value = 0;
    clientReqModel.tabController.value = null;
    clientReqModel.selectedPdf.value = File('E://Client_requirement.pdf');

    // DETAILS
    clientReqModel.detailsformKey.value = GlobalKey<FormState>();
    clientReqModel.clientNameController.value.clear();
    clientReqModel.titleController.value.clear();
    clientReqModel.clientAddressController.value.clear();
    clientReqModel.billingAddressNameController.value.clear();
    clientReqModel.billingAddressController.value.clear();
    clientReqModel.morController.value.clear();
    clientReqModel.phoneController.value.clear();
    clientReqModel.emailController.value.clear();
    clientReqModel.gstController.value.clear();
    clientReqModel.Org_Controller.value = null;
    clientReqModel.CompanyID_Controller.value = null;
    clientReqModel.Companyname_Controller.value = null;
    clientReqModel.Branch_Controller.value = null;
    clientReqModel.pickedFile.value = null;
    clientReqModel.morFile.value = null;
    clientReqModel.organizationList.clear();
    clientReqModel.CompanyList.clear();
    // SITES
    clientReqModel.siteFormkey.value = GlobalKey<FormState>();
    clientReqModel.siteNameController.value.clear();
    clientReqModel.addressController.value.clear();
    clientReqModel.cameraquantityController.value.clear();
    clientReqModel.site_editIndex.value = null;
    clientReqModel.clientReqSiteDetails.clear();

    // NOTES
    clientReqModel.noteFormKey.value = GlobalKey<FormState>();
    clientReqModel.noteContentController.value.clear();
    clientReqModel.Rec_HeadingController.value.clear();
    clientReqModel.Rec_KeyController.value.clear();
    clientReqModel.Rec_ValueController.value.clear();
    clientReqModel.noteEditIndex.value = null;
    clientReqModel.Rec_EditIndex.value = null;
    clientReqModel.clientReqNoteList.clear();
    clientReqModel.clientReqRecommendationList.clear();
    clientReqModel.noteLength.value = 0;
    clientReqModel.Rec_Length.value = 0;
  }
}
