import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/models/constants/ClientReq_constants.dart';
import 'package:ssipl_billing/4_SALES/models/entities/ClientReq_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class ClientreqController extends GetxController {
  var clientReqModel = ClientReqModel();

  void initializeTabController(TabController tabController) {
    clientReqModel.tabController.value = tabController;
  }

  void nextTab() {
    if (clientReqModel.tabController.value!.index < clientReqModel.tabController.value!.length - 1) {
      clientReqModel.tabController.value!.animateTo(clientReqModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (clientReqModel.tabController.value!.index > 0) {
      clientReqModel.tabController.value!.animateTo(clientReqModel.tabController.value!.index - 1);
    }
  }

  void add_productSuggestion(List<dynamic> suggestionList) {
    for (var item in suggestionList) {
      clientReqModel.clientReq_productSuggestion.add(ProductSuggestion.fromJson(item));
    }
  }

  void updateTabController(TickerProvider vsync, int length) {
    clientReqModel.tabController.value = TabController(length: length, vsync: vsync);
  }

  // Update PDF File
  void updateSelectedPdf(String filePath) {
    clientReqModel.selectedPdf.value = File(filePath);
  }

  // Update Form Key
  void updateFormKey(GlobalKey<FormState> newKey) {
    clientReqModel.detailsformKey.value = newKey;
  }

  // Update Text Controllers
  void updateClientName(String name) {
    clientReqModel.clientNameController.value.text = name;
  }

  void updateOrgName(String org) {
    clientReqModel.Org_Controller.value = org;
  }

  void updateCompanyName(String comp) {
    clientReqModel.Company_Controller.value = comp;
  }

  void clear_CompanyData() async {
    clientReqModel.Company_Controller.value = null;
    clientReqModel.CompanyList.clear();
  }

  void clear_BranchData() async {
    clientReqModel.Branch_Controller.value = null;
    clientReqModel.BranchList_valueModel.clear();
  }

  void updateTitle(String title) {
    clientReqModel.titleController.value.text = title;
  }

  void updateClientAddress(String address) {
    clientReqModel.clientAddressController.value.text = address;
  }

  void updateBillingAddressName(String name) {
    clientReqModel.billingAddressNameController.value.text = name;
  }

  void updateBillingAddress(String address) {
    clientReqModel.billingAddressController.value.text = address;
  }

  void updateMOR(String morValue) {
    clientReqModel.morController.value.text = morValue;
  }

  void updatePhone(String phone) {
    clientReqModel.phoneController.value.text = phone;
  }

  void updateEmail(String email) {
    clientReqModel.emailController.value.text = email;
  }

  void updateGST(String gst) {
    clientReqModel.gstController.value.text = gst;
  }

  // Update Table Heading and Client Req Number
  // void updateClientReqTableHeading(String heading) {
  //   clientReqModel.clientReqTableHeading.value = heading;
  // }

  void addProductEditindex(int? index) {
    clientReqModel.product_editIndex.value = index;
  }

  void updateProductName(String productName) {
    clientReqModel.productNameController.value.text = productName;
  }

  void updateQuantity(int quantity) {
    clientReqModel.quantityController.value.text = quantity.toString();
  }

  void updateRec_ValueControllerText(String text) {
    clientReqModel.Rec_ValueController.value.text = text;
  }

  void updateNoteList(String value, int index) {
    clientReqModel.clientReqNoteList[clientReqModel.noteEditIndex.value!] = clientReqModel.noteContentController.value.text;
  }

  void updateNoteEditindex(int? index) {
    clientReqModel.noteEditIndex.value = index;
  }

  void updateRecommendationEditindex(int? index) {
    clientReqModel.Rec_EditIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    clientReqModel.noteContentController.value.text = text;
  }

  void updateRec_KeyControllerText(String text) {
    clientReqModel.Rec_KeyController.value.text = text;
  }

  void removeFromProductList(index) {
    clientReqModel.clientReqProductDetails.removeAt(index);
    clientReqModel.product_editIndex.value = null;
  }

  void removeFromNoteList(int index) {
    clientReqModel.clientReqNoteList.removeAt(index);
    // clientReqModel.clientReqNoteList.isEmpty ? clientReqModel.noteContentController.value.clear() : null;
    clientReqModel.noteEditIndex.value = null;
  }

  void removeFromRecommendationList(int index) {
    clientReqModel.clientReqRecommendationList.removeAt(index);
    // clientReqModel.clientReqRecommendationList.isEmpty ? clientReqModel.Rec_HeadingController.value.clear() : null;
    // clientReqModel.clientReqRecommendationList.isEmpty ? clientReqModel.Rec_KeyController.value.clear() : null;
    // clientReqModel.clientReqRecommendationList.isEmpty ? clientReqModel.Rec_ValueController.value.clear() : null;
    clientReqModel.Rec_EditIndex.value = null;
  }

  void updateMOR_uploadedPath(CMDmResponse value) {
    clientReqModel.MOR_uploadedPath.value = MORpath.fromJson(value).path;
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      clientReqModel.clientReqRecommendationList.add(ClientReq_recommendation(key: key, value: value));
    }
  }

  void clearPickedFiles() {
    clientReqModel.pickedFile.value = null;
    clientReqModel.morFile.value = null;
  }

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

  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      clientReqModel.clientReqNoteList.add(noteContent);
    }
  }

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

  void update_OrganizationList(CMDlResponse value) {
    clientReqModel.organizationList.clear();
    for (int i = 0; i < value.data.length; i++) {
      clientReqModel.organizationList.add(Organization.fromJson(value, i));
    }
  }

  void clear_KYC() {
    updateClientAddress("");
    updateBillingAddressName("");
    updateBillingAddress("");
    updateEmail("");
    updatePhone("");
    updateGST("");
  }

  void update_KYC(Claddress, Blname, Bladdress, email, phone, gst) {
    updateClientAddress(Claddress ?? "");
    updateBillingAddressName(Blname ?? "");
    updateBillingAddress(Bladdress ?? "");
    updateEmail(email ?? "");
    updatePhone(phone ?? "");
    updateGST(gst ?? "");
  }

  String branchname_via_branchID(int id) {
    return clientReqModel.BranchList_valueModel.firstWhere(
      (x) => x.value == id.toString(),
    ).name;
  }

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

  void update_CompanyList(CMDlResponse value) {
    clear_CompanyData();
    clear_BranchData();
    clear_KYC();
    for (int i = 0; i < value.data.length; i++) {
      clientReqModel.CompanyList.add(Company.fromJson(value, i));
    }
  }

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

  void handle_customerID() {
    if (clientReqModel.selected_branchList.length == 1) {
      updateClientName(branchname_via_branchID(clientReqModel.selected_branchList[0]));
      update_customerID(null, branchname_via_branchID(clientReqModel.selected_branchList[0]));
    } else {
      updateClientName(clientReqModel.Company_Controller.value!);
      update_customerID(clientReqModel.Company_Controller.value!, null);
    }
  }

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
