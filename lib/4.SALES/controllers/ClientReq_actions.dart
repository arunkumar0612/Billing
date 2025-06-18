import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4.SALES/models/constants/ClientReq_constants.dart';
import 'package:ssipl_billing/4.SALES/models/entities/ClientReq_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class ClientreqController extends GetxController {
  var clientReqModel = ClientReqModel();

  /// Initializes the TabController for client request.
  void initializeTabController(TabController tabController) {
    clientReqModel.tabController.value = tabController;
  }

  /// Navigates to the next tab if available.
  void nextTab() {
    if (clientReqModel.tabController.value!.index < clientReqModel.tabController.value!.length - 1) {
      clientReqModel.tabController.value!.animateTo(clientReqModel.tabController.value!.index + 1);
    }
  }

  /// Navigates to the previous tab if available.
  void backTab() {
    if (clientReqModel.tabController.value!.index > 0) {
      clientReqModel.tabController.value!.animateTo(clientReqModel.tabController.value!.index - 1);
    }
  }

  /// Adds product suggestions to the model from a list of JSON objects
  void add_productSuggestion(List<dynamic> suggestionList) {
    for (var item in suggestionList) {
      clientReqModel.clientReq_productSuggestion.add(ProductSuggestion.fromJson(item));
    }
  }

  /// Creates and assigns a new TabController with the given length and vsync.
  void updateTabController(TickerProvider vsync, int length) {
    clientReqModel.tabController.value = TabController(length: length, vsync: vsync);
  }

  /// Updates the selected PDF file from file path.
  void updateSelectedPdf(String filePath) {
    clientReqModel.selectedPdf.value = File(filePath);
  }

  /// Updates the form key for client request form.
  void updateFormKey(GlobalKey<FormState> newKey) {
    clientReqModel.detailsformKey.value = newKey;
  }

  /// Sets the client name in the corresponding text controller.
  void updateClientName(String name) {
    clientReqModel.clientNameController.value.text = name;
  }

  /// Updates the organization name value.
  void updateOrgName(String org) {
    clientReqModel.Org_Controller.value = org;
  }

  /// Updates the company name value.
  void updateCompanyName(String comp) {
    clientReqModel.Company_Controller.value = comp;
  }

  /// Clears selected company and its list.
  void clear_CompanyData() async {
    clientReqModel.Company_Controller.value = null;
    clientReqModel.CompanyList.clear();
  }

  /// Clears selected branch and its list.
  void clear_BranchData() async {
    clientReqModel.Branch_Controller.value = null;
    clientReqModel.BranchList_valueModel.clear();
  }

  /// Updates the project title field.
  void updateTitle(String title) {
    clientReqModel.titleController.value.text = title;
  }

  /// Updates the client's address.
  void updateClientAddress(String address) {
    clientReqModel.clientAddressController.value.text = address;
  }

  /// Updates the billing address name.
  void updateBillingAddressName(String name) {
    clientReqModel.billingAddressNameController.value.text = name;
  }

  /// Updates the billing address details.
  void updateBillingAddress(String address) {
    clientReqModel.billingAddressController.value.text = address;
  }

  /// Updates the MOR (Mode of Requirement) value.
  void updateMOR(String morValue) {
    clientReqModel.morController.value.text = morValue;
  }

  /// Updates the client's phone number.
  void updatePhone(String phone) {
    clientReqModel.phoneController.value.text = phone;
  }

  /// Updates the client's email ID.
  void updateEmail(String email) {
    clientReqModel.emailController.value.text = email;
  }

  /// Updates the GST number value.
  void updateGST(String gst) {
    clientReqModel.gstController.value.text = gst;
  }

  // Update Table Heading and Client Req Number
  // void updateClientReqTableHeading(String heading) {
  //   clientReqModel.clientReqTableHeading.value = heading;
  // }

  /// Sets the index of the product being edited.
  void addProductEditindex(int? index) {
    clientReqModel.product_editIndex.value = index;
  }

  /// Updates the product name in the text controller.
  void updateProductName(String productName) {
    clientReqModel.productNameController.value.text = productName;
  }

  /// Updates the product quantity in the text controller.
  void updateQuantity(int quantity) {
    clientReqModel.quantityController.value.text = quantity.toString();
  }

  /// Updates the recommendation value text controller.
  void updateRec_ValueControllerText(String text) {
    clientReqModel.Rec_ValueController.value.text = text;
  }

  /// Updates the note at the specified index with the current note content.
  void updateNoteList(String value, int index) {
    clientReqModel.clientReqNoteList[clientReqModel.noteEditIndex.value!] = clientReqModel.noteContentController.value.text;
  }

  /// Sets the index of the note being edited.
  void updateNoteEditindex(int? index) {
    clientReqModel.noteEditIndex.value = index;
  }

  /// Sets the index of the recommendation being edited.
  void updateRecommendationEditindex(int? index) {
    clientReqModel.Rec_EditIndex.value = index;
  }

  /// Updates the note content text controller.
  void updateNoteContentControllerText(String text) {
    clientReqModel.noteContentController.value.text = text;
  }

  /// Updates the recommendation key text controller.
  void updateRec_KeyControllerText(String text) {
    clientReqModel.Rec_KeyController.value.text = text;
  }

  /// Removes a product from the product list and resets the edit index.
  void removeFromProductList(index) {
    clientReqModel.clientReqProductDetails.removeAt(index);
    clientReqModel.product_editIndex.value = null;
  }

  /// Removes a note from the note list and resets the edit index.
  void removeFromNoteList(int index) {
    clientReqModel.clientReqNoteList.removeAt(index);
    // clientReqModel.clientReqNoteList.isEmpty ? clientReqModel.noteContentController.value.clear() : null;
    clientReqModel.noteEditIndex.value = null;
  }

  /// Removes a recommendation from the list and resets the edit index.
  void removeFromRecommendationList(int index) {
    clientReqModel.clientReqRecommendationList.removeAt(index);
    // clientReqModel.clientReqRecommendationList.isEmpty ? clientReqModel.Rec_HeadingController.value.clear() : null;
    // clientReqModel.clientReqRecommendationList.isEmpty ? clientReqModel.Rec_KeyController.value.clear() : null;
    // clientReqModel.clientReqRecommendationList.isEmpty ? clientReqModel.Rec_ValueController.value.clear() : null;
    clientReqModel.Rec_EditIndex.value = null;
  }

  /// Updates the uploaded path for MOR from the CMDm response.
  void updateMOR_uploadedPath(CMDmResponse value) {
    clientReqModel.MOR_uploadedPath.value = MORpath.fromJson(value).path;
  }

  /// Adds a new recommendation to the list if both key and value are not empty.
  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      clientReqModel.clientReqRecommendationList.add(ClientReq_recommendation(key: key, value: value));
    }
  }

  /// Clears the selected files from the model.
  void clearPickedFiles() {
    clientReqModel.pickedFile.value = null;
    clientReqModel.morFile.value = null;
  }

  /// Opens a file picker for image files and updates the model if valid; shows error if file > 2MB.
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

  /// Updates an existing recommendation by index if valid.
  void updateRecommendation({
    required int index,
    required String key,
    required String value,
  }) {
    try {
      if (index >= 0 && index < clientReqModel.clientReqRecommendationList.length) {
        if (key.isNotEmpty && value.isNotEmpty) {
          clientReqModel.clientReqRecommendationList[index] = ClientReq_recommendation(key: key, value: value);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
    }
  }

  /// Adds a new note to the note list if content is not empty.
  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      clientReqModel.clientReqNoteList.add(noteContent);
    }
  }

  /// Adds a product to the list if valid, else shows a snackbar error.
  void addProduct({required BuildContext context, required String productName, required int quantity}) {
    try {
      if (productName.trim().isEmpty || quantity <= 0) {
        Error_SnackBar(context, 'Please provide valid product details.');

        return;
      }
      clientReqModel.clientReqProductDetails.add(ClientreqProduct((clientReqModel.clientReqProductDetails.length + 1).toString(), productName, quantity));
    } catch (e) {
      Error_SnackBar(context, 'An error occurred while adding the product.');
    }
  }

  /// Updates a product's name and quantity by index if valid; shows snackbar on error.
  void updateProduct({required BuildContext context, required int editIndex, required String productName, required int quantity}) {
    try {
      // Validate input fields
      if (productName.trim().isEmpty || quantity <= 0) {
        Error_SnackBar(context, 'Please provide valid product details.');

        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= clientReqModel.clientReqProductDetails.length) {
        Error_SnackBar(context, 'Invalid product index.');

        return;
      }

      // Update the product details at the specified index
      clientReqModel.clientReqProductDetails[editIndex] = ClientreqProduct((editIndex + 1).toString(), productName, quantity);

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
      // .updateProductDetails(creditController.clientReqModel.clientReq_productDetails);
    } catch (e) {
      // Handle unexpected errors
      Error_SnackBar(context, 'An error occurred while updating the product.');
    }
  }

  /// Updates the organization list using the parsed response data.
  void update_OrganizationList(CMDlResponse value) {
    clientReqModel.organizationList.clear();
    for (int i = 0; i < value.data.length; i++) {
      clientReqModel.organizationList.add(Organization.fromJson(value, i));
    }
  }

  /// Clears all KYC-related fields.
  void clear_KYC() {
    updateClientAddress("");
    updateBillingAddressName("");
    updateBillingAddress("");
    updateEmail("");
    updatePhone("");
    updateGST("");
  }

  /// Updates KYC-related fields with the given values or empty strings.
  void update_KYC(Claddress, Blname, Bladdress, email, phone, gst) {
    updateClientAddress(Claddress ?? "");
    updateBillingAddressName(Blname ?? "");
    updateBillingAddress(Bladdress ?? "");
    updateEmail(email ?? "");
    updatePhone(phone ?? "");
    updateGST(gst ?? "");
  }

  /// Retrieves the branch name by its ID from the value model list.
  String branchname_via_branchID(int id) {
    return clientReqModel.BranchList_valueModel.firstWhere(
      (x) => x.value == id.toString(),
    ).name;
  }

  /// Updates customer ID and KYC based on selected company or branch.
  void update_customerID(String? compName, String? branchName) {
    if (compName == null) {
      clientReqModel.customer_id.value = 0;
      var model = clientReqModel.BranchFullList.firstWhere(
        (x) => x.Branch_name == branchName,
      );
      update_KYC(model.client_address, model.billing_addressname, model.billing_address, model.emailid, model.contact_number, model.gst_number);
    } else {
      var model = clientReqModel.CompanyList.firstWhere(
        (x) => x.companyName == compName,
      );
      update_KYC(model.client_address, model.billing_addressname, model.billing_address, model.emailid, model.contact_number, model.gst_number);
      clientReqModel.customer_id.value = model.companyId!;
      updateClientName(compName);
    }
  }

  /// Updates the company list and resets related data.
  void update_CompanyList(CMDlResponse value) {
    clear_CompanyData();
    clear_BranchData();
    clear_KYC();
    for (int i = 0; i < value.data.length; i++) {
      clientReqModel.CompanyList.add(Company.fromJson(value, i));
    }
  }

  /// Updates the branch list and its dropdown value model after a delay.
  void update_BranchList(CMDlResponse value) async {
    clear_BranchData();
    await Future.delayed(const Duration(milliseconds: 1000));
    for (int i = 0; i < value.data.length; i++) {
      clientReqModel.BranchFullList.add(Branch.fromJson(value, i));
      clientReqModel.BranchList_valueModel.add(DropDownValueModel(
        name: Branch.fromJson(value, i).Branch_name ?? "Unknown", // Provide a default label if null
        value: Branch.fromJson(value, i).Branch_id?.toString() ?? "", // Convert ID to String
      ));
    }
  }

  /// Updates selected branch list and processes related customer data.
  void update_selectedBranches(List<dynamic> selectedList) {
    if (selectedList.isEmpty) {
      clientReqModel.selected_branchList.clear();
    } else {
      clientReqModel.selected_branchList.clear();
      for (int i = 0; i < selectedList.length; i++) {
        clientReqModel.selected_branchList.add(int.parse(selectedList[i].value));
      }
    }

    handle_customerID();
  }

  /// Sets customer info based on selected branches or company.
  void handle_customerID() {
    if (clientReqModel.selected_branchList.length == 1) {
      updateClientName(branchname_via_branchID(clientReqModel.selected_branchList[0]));
      update_customerID(null, branchname_via_branchID(clientReqModel.selected_branchList[0]));
    } else {
      updateClientName(clientReqModel.Company_Controller.value!);
      update_customerID(clientReqModel.Company_Controller.value!, null);
    }
  }

  /// Checks if any client data fields or selections have been populated.
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
        clientReqModel.Company_Controller.value != null ||
        clientReqModel.Branch_Controller.value != null ||
        clientReqModel.pickedFile.value != null ||
        clientReqModel.morFile.value != null ||
        // clientReqModel.organizationList.isNotEmpty ||
        // clientReqModel.CompanyList.isNotEmpty ||
        // clientReqModel.BranchFullList.isNotEmpty ||
        clientReqModel.BranchList_valueModel.isNotEmpty ||
        clientReqModel.selected_branchList.isNotEmpty ||
        clientReqModel.productNameController.value.text.isNotEmpty ||
        clientReqModel.quantityController.value.text.isNotEmpty ||
        clientReqModel.clientReqProductDetails.isNotEmpty ||
        clientReqModel.Rec_HeadingController.value.text.isNotEmpty ||
        clientReqModel.Rec_KeyController.value.text.isNotEmpty ||
        clientReqModel.Rec_ValueController.value.text.isNotEmpty ||
        clientReqModel.clientReqNoteList.isNotEmpty ||
        clientReqModel.clientReqRecommendationList.isNotEmpty);
  }

  /// Validates whether any required data is missing for submission.
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
  }

  /// Returns true if no data has been filled by the user.
  bool anyDontHavedata() {
    return !anyHavedata();
  }

  // void resetData() {
  //   clientReqModel.MOR_uploadedPath.value = null;

  //   // DETAILS
  //   clientReqModel.tabController.value = null;
  //   clientReqModel.selectedPdf.value = File('E://Client_requirement.pdf');
  //   clientReqModel.detailsformKey.value = GlobalKey<FormState>();
  //   clientReqModel.clientNameController.value.clear();
  //   clientReqModel.titleController.value.clear();
  //   clientReqModel.clientAddressController.value.clear();
  //   clientReqModel.billingAddressNameController.value.clear();
  //   clientReqModel.billingAddressController.value.clear();
  //   clientReqModel.morController.value.clear();
  //   clientReqModel.phoneController.value.clear();
  //   clientReqModel.emailController.value.clear();
  //   clientReqModel.gstController.value.clear();
  //   clientReqModel.Org_Controller.value = null;
  //   clientReqModel.Company_Controller.value = null;
  //   clientReqModel.Branch_Controller.value = null;
  //   clientReqModel.pickedFile.value = null;
  //   clientReqModel.morFile.value = null;
  //   clientReqModel.organizationList.clear();
  //   clientReqModel.CompanyList.clear();
  //   clientReqModel.BranchFullList.clear();
  //   clientReqModel.BranchList_valueModel.clear();
  //   clientReqModel.customer_id.value = 0;
  //   clientReqModel.selected_branchList.clear();

  //   // PRODUCTS
  //   clientReqModel.productFormkey.value = GlobalKey<FormState>();
  //   clientReqModel.productNameController.value.clear();
  //   clientReqModel.quantityController.value.clear();
  //   clientReqModel.product_editIndex.value = null;
  //   clientReqModel.clientReqProductDetails.clear();
  //   clientReqModel.clientReq_productSuggestion.clear();

  //   // NOTES
  //   clientReqModel.noteFormKey.value = GlobalKey<FormState>();
  //   clientReqModel.noteContentController.value.clear();
  //   clientReqModel.Rec_HeadingController.value.clear();
  //   clientReqModel.Rec_KeyController.value.clear();
  //   clientReqModel.Rec_ValueController.value.clear();
  //   clientReqModel.noteEditIndex.value = null;
  //   clientReqModel.Rec_EditIndex.value = null;
  //   clientReqModel.clientReqNoteList.clear();
  //   clientReqModel.clientReqRecommendationList.clear();
  //   clientReqModel.noteLength.value = 0;
  //   clientReqModel.Rec_Length.value = 0;
  // }

  void resetData() {
    clientReqModel.MOR_uploadedPath.value = null;
    clientReqModel.customer_id.value = 0;
    clientReqModel.tabController.value = null;
    clientReqModel.selectedPdf.value = File('E://Client_requirement.pdf'); // default value

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
    clientReqModel.Company_Controller.value = null;
    clientReqModel.Branch_Controller.value = null;
    clientReqModel.pickedFile.value = null;
    clientReqModel.morFile.value = null;
    clientReqModel.organizationList.clear();
    clientReqModel.CompanyList.clear();
    clientReqModel.BranchFullList.clear();
    clientReqModel.BranchList_valueModel.clear();
    clientReqModel.selected_branchList.clear();
    clientReqModel.clientReqProductDetails.clear();

    // SITES
    // clientReqModel.siteFormkey.value = GlobalKey<FormState>();
    // clientReqModel.siteNameController.value.clear();
    // clientReqModel.addressController.value.clear();
    // clientReqModel.cameraquantityController.value.clear();
    // clientReqModel.site_editIndex.value = null;
    // clientReqModel.clientReqSiteDetails.clear();

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

    clientReqModel.noteContent.value = [
      'Delivery within 30 working days from the date of issuing the PO.',
      'Payment terms: 100% along with PO.',
      'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
    ];
  }
}
