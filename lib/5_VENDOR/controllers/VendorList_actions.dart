import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/5_VENDOR/models/constants/VendorList_constants.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Vendor_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class VendorListController extends GetxController {
  var vendorListModel = VendorListModel();

  void initializeTabController(TabController tabController) {
    vendorListModel.tabController.value = tabController;
  }

  void nextTab() {
    if (vendorListModel.tabController.value!.index < vendorListModel.tabController.value!.length - 1) {
      vendorListModel.tabController.value!.animateTo(vendorListModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (vendorListModel.tabController.value!.index > 0) {
      vendorListModel.tabController.value!.animateTo(vendorListModel.tabController.value!.index - 1);
    }
  }

  void updateKYCformKey(GlobalKey<FormState> newKey) {
    vendorListModel.vendorKYCformKey.value = newKey;
  }

  void updateBusinessInfoFormKey(GlobalKey<FormState> newKey) {
    vendorListModel.vendorBusinessInfoFormKey.value = newKey;
  }

  void updateBankDetailsformKey(GlobalKey<FormState> newKey) {
    vendorListModel.vendorBankDetailsFormKey.value = newKey;
  }

  void updateVendorId(int value) {
    vendorListModel.vendorId.value = value;
  }

  // Update Text Controllers
  void updateVendorName(String value) {
    vendorListModel.vendorNameController.value.text = value;
  }

  void updateVendorAddress(String value) {
    vendorListModel.vendorAddressController.value.text = value;
  }

  void updateState(String value) {
    vendorListModel.vendorAddressStateController.value.text = value;
  }

  void updatePincode(String value) {
    vendorListModel.vendorAddressPincodeController.value.text = value;
  }

  void updateContactPersonName(String value) {
    vendorListModel.contactpersonName.value.text = value;
  }

  void updateContactPersonDesignation(String value) {
    vendorListModel.contactPersonDesignation.value.text = value;
  }

  void updateContactPersonPhoneNo(String value) {
    vendorListModel.contactPersonPhoneNumber.value.text = value;
  }

  void updateContactPersonEmail(String value) {
    vendorListModel.contactPersonEmail.value.text = value;
  }

  void updateTypeOfBusiness(String value) {
    vendorListModel.typeOfBusiness.value.text = value;
  }

  void updateYearOfEstablishment(String value) {
    vendorListModel.yearOfEstablishment.value.text = value;
  }

  void updateVendorGST(String value) {
    vendorListModel.vendorGstNo.value.text = value;
  }

  void updateVendorPAN(String value) {
    vendorListModel.vendorPanNo.value.text = value;
  }

  void updateAnnualturnover(String value) {
    vendorListModel.vendorAnnualTurnover.value.text = value;
  }

  // void updateListOfProducts(String value) {
  //   // Split by comma, trim spaces, and remove empty strings
  //   vendorListModel.vendorListOfProducts.value = value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  // }

  void updateProductInput(String value) {
    vendorListModel.productInputController.text = value;
  }

  void updateHSNcodeList(String value) {
    // Split by comma, trim spaces, and remove empty strings
    vendorListModel.vendorHSNCodeList.value = value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  void updateHSNcodeInput(String value) {
    vendorListModel.HSNcodeController.text = value;
  }

  void updateProductDescription(String value) {
    vendorListModel.descriptionOfProducts.value.text = value;
  }

  void updateISOCerti(String value) {
    vendorListModel.isoCertification.value.text = value;
  }

  void updateOtherCerti(String value) {
    vendorListModel.otherCertification.value.text = value;
  }

  void updateVendorBankName(String value) {
    vendorListModel.vendorBankName.value.text = value;
  }

  void updateVendorBankBranch(String value) {
    vendorListModel.vendorBankBranch.value.text = value;
  }

  void updateVendorBankAccountNo(String value) {
    vendorListModel.vendorBankAccountNumber.value.text = value;
  }

  void updateVendorBankIFSC(String value) {
    vendorListModel.vendorBankIfsc.value.text = value;
  }

  // void updateVendorCompanyLogo(File value) {
  //   vendorListModel.selectedLogoPath.value = value;
  // }

  // void updateSelectedRegCerti(String filePath) {
  //   vendorListModel.selectedGSTregCertiFile.value = File(filePath);
  // }

  // void updateSelectedPAN(String filePath) {
  //   vendorListModel.selectedPANfile.value = File(filePath);
  // }

  // void updateSelectedCheque(String filePath) {
  //   vendorListModel.selectedCancelledChequeFile.value = File(filePath);
  // }

  void updateGstRegCertiPath(String value) {
    vendorListModel.GSTregCerti_uploadedPath.value = value;
  }

  void updatePanPath(String value) {
    vendorListModel.PAN_uploadedPath.value = value;
  }

  void updateChequePath(String value) {
    vendorListModel.cheque_uploadedPath.value = value;
  }

  Future<void> updateVendorLogo(Uint8List logoBytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/vendor_logo.png');
    await file.writeAsBytes(logoBytes);
    vendorListModel.uploadedLogo.value = file;
  }

  Future<void> setUploadedLogo(File file) async {
    vendorListModel.uploadedLogo.value = file;
    // vendorListModel.logoBytes.value = await file.readAsBytes(); // Convert File -> Uint8List
  }

  Future<void> updateGstRegFile(Uint8List logoBytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/registration.png');
    await file.writeAsBytes(logoBytes);
    vendorListModel.GSTregCertiFile.value = file;
  }

  Future<void> updatePanFile(Uint8List logoBytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/pan.png');
    await file.writeAsBytes(logoBytes);
    vendorListModel.vendorPANfile.value = file;
  }

  Future<void> updateChequeFile(Uint8List logoBytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/cheque.png');
    await file.writeAsBytes(logoBytes);
    vendorListModel.cancelledChequeFile.value = file;
  }

  Future<bool> vendorLogoPickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg'], lockParentWindow: true);

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');

        vendorListModel.uploadedLogo_path.value = null;
        vendorListModel.uploadedLogo.value = null;
      } else {
        vendorListModel.uploadedLogo_path.value = result.files.single.path;
        vendorListModel.uploadedLogo.value = file;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  Future<bool> regCertiPickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], lockParentWindow: true);

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');

        vendorListModel.GSTregCerti_uploadedPath.value = null;
        vendorListModel.GSTregCertiFile.value = null;
      } else {
        vendorListModel.GSTregCerti_uploadedPath.value = result.files.single.path;
        vendorListModel.GSTregCertiFile.value = file;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  Future<bool> vendorPANpickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], lockParentWindow: true);

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');

        vendorListModel.PAN_uploadedPath.value = null;
        vendorListModel.vendorPANfile.value = null;
      } else {
        vendorListModel.PAN_uploadedPath.value = result.files.single.path;
        vendorListModel.vendorPANfile.value = file;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  Future<bool> cancelledChequePickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], lockParentWindow: true);

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');

        vendorListModel.cheque_uploadedPath.value = null;
        vendorListModel.cancelledChequeFile.value = null;
      } else {
        vendorListModel.cheque_uploadedPath.value = result.files.single.path;
        vendorListModel.cancelledChequeFile.value = file;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  void search(String query) {
    vendorListModel.searchQuery.value = query;
    // vendorListModel.searchQuery.value = query;

    if (query.isEmpty) {
      vendorListModel.Vendorlist.assignAll(vendorListModel.backup_VendorList);
    } else {
      var filtered_VendorLive = vendorListModel.backup_VendorList.where((liv) => liv.vendorName!.toLowerCase().contains(query.toLowerCase()));

      vendorListModel.Vendorlist.assignAll(filtered_VendorLive);
    }
    vendorListModel.Vendorlist.refresh();
  }

  void updateFormKey(GlobalKey<FormState> newKey) {
    vendorListModel.vendorManagementFormKey.value = newKey;
  }

  // void updateVendorId(int value) {
  //   vendorListModel.vendorId.value = value;
  // }

  void updateVendorList(CMDlResponse value) {
    try {
      vendorListModel.Vendorlist.clear();
      vendorListModel.backup_VendorList.clear();
      for (int i = 0; i < value.data.length; i++) {
        vendorListModel.Vendorlist.add(VendorList.fromJson(value.data[i]));
        vendorListModel.backup_VendorList.add(VendorList.fromJson(value.data[i]));
      }
    } catch (e) {
      print('$e');
    }
  }

  void enableEditMode() {
    vendorListModel.isFormEditable.value = true;
  }

  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

  Future<void> updatePDFfile(File value) async {
    vendorListModel.pdfFile.value = value;
  }

  // Future<void> UpdateVendorPDF(BuildContext context, CMDmResponse value, String type) async {
  //   var pdfFileData = await PDFfileData.fromJson(value);
  //   Uint8List binaryData = await pdfFileData.data.readAsBytes();
  //   if (type == 'registration') {
  //     await updateGstRegFile(binaryData);
  //     showPDF(context, type, vendorListModel.GSTregCertiFile.value);
  //   } else if (type == 'pan') {
  //     await updatePanFile(binaryData);
  //     showPDF(context, type, vendorListModel.vendorPANfile.value);
  //   } else if (type == 'cheque') {
  //     await updateChequeFile(binaryData);
  //     showPDF(context, type, vendorListModel.cancelledChequeFile.value);
  //   }
  // }

  void update_requiredData(
    VendorList value,
  ) async {
    updateVendorId(value.vendorId ?? 0);
    updateVendorName(value.vendorName ?? "");
    updateContactPersonEmail(value.email ?? "");
    updateContactPersonName(value.contactPersonName ?? "");
    updateContactPersonDesignation(value.contactPersonDesignation ?? "");
    updateContactPersonPhoneNo(value.contactPersonPhone ?? "");
    updateVendorAddress(value.address ?? "");
    updateState(value.state ?? "");
    updatePincode(value.pincode ?? "");
    updateTypeOfBusiness(value.businessType ?? "");
    updateYearOfEstablishment(value.yearOfEstablishment ?? "");
    updateVendorGST(value.gstNumber ?? "");
    updateVendorPAN(value.panNumber ?? "");
    updateAnnualturnover(value.annualTurnover ?? "");
    updateProductInput(value.productsServices ?? "");
    updateHSNcodeInput(value.hsnSacCode ?? "");
    updateProductDescription(value.description ?? "");
    updateISOCerti(value.isoCertification ?? "");
    updateOtherCerti(value.otherCertifications ?? "");
    updateVendorBankName(value.bankName ?? "");
    updateVendorBankAccountNo(value.accountNumber ?? "");
    updateVendorBankIFSC(value.ifscCode ?? "");
    updateVendorBankBranch(value.branchName ?? "");
    // updateVendorCompanyLogo(await File('${(await getTemporaryDirectory()).path}/vendor_logo.png').writeAsBytes(value.vendorLogo!));
    updateGstRegCertiPath(value.registrationCertificatePath ?? "");
    updatePanPath(value.panUploadPath ?? "");
    updateChequePath(value.cancelledChequePath ?? "");
    updateVendorLogo(value.vendorLogo ?? Uint8List(0));
    // updateGstRegFile( )
  }

  dynamic onVendorSelected(List<VendorList> data, int selectedIndex) async {
    List<VendorList> selectedList = data;

    if (selectedList[selectedIndex].isSelected) {
      onVendorDeselected(data);
      toggle_cardCount(5, "vendor");
      toggle_VendordataPageView(false);
      // await Future.delayed(const Duration(milliseconds: 2000));

      return;
    }

    // Deselect all vendores
    for (var vendor in data) {
      vendor.isSelected = false;
    }

    // Select the chosen vendor
    selectedList[selectedIndex].isSelected = true;
    injectVendorDetails(selectedIndex, selectedList);
    toggle_VendordataPageView(true);
    toggle_cardCount(4, "vendor");
    vendorListModel.Vendorlist.refresh();
  }

  dynamic onVendorDeselected(List<VendorList> data) {
    resetVendorDetails();

    for (var vendor in data) {
      vendor.isSelected = false;
    }

    vendorListModel.Vendorlist.refresh();
  }

  void injectVendorDetails(int index, List<VendorList> data) {
    vendorListModel.selectedVendorDetails.value = data[index];
  }

  void resetVendorDetails() {
    vendorListModel.selectedVendorDetails.value = VendorList();
  }

  void toggle_VendordataPageView(bool value) {
    vendorListModel.Vendor_DataPageView.value = value;
  }

  void toggle_cardCount(int value, String nature) {
    if (nature == "org") {
      // vendorListModel.Org_cardCount.value = value;
    } else if (nature == "comp") {
      // vendorListModel.Comp_cardCount.value = value;
    } else if (nature == "vendor") {
      vendorListModel.Vendor_cardCount.value = value;
    }
  }

  bool anyHavedata() {
    return vendorListModel.vendorNameController.value.text.isNotEmpty ||
        vendorListModel.vendorAddressController.value.text.isNotEmpty ||
        vendorListModel.vendorAddressStateController.value.text.isNotEmpty ||
        vendorListModel.vendorAddressPincodeController.value.text.isNotEmpty ||
        vendorListModel.contactpersonName.value.text.isNotEmpty ||
        vendorListModel.contactPersonDesignation.value.text.isNotEmpty ||
        vendorListModel.contactPersonPhoneNumber.value.text.isNotEmpty ||
        vendorListModel.contactPersonEmail.value.text.isNotEmpty ||
        vendorListModel.typeOfBusiness.value.text.isNotEmpty ||
        vendorListModel.yearOfEstablishment.value.text.isNotEmpty ||
        vendorListModel.vendorGstNo.value.text.isNotEmpty ||
        vendorListModel.vendorPanNo.value.text.isNotEmpty ||
        vendorListModel.vendorAnnualTurnover.value.text.isNotEmpty ||
        // vendorListModel.vendorListOfProducts.isNotEmpty ||
        vendorListModel.descriptionOfProducts.value.text.isNotEmpty ||
        vendorListModel.isoCertification.value.text.isNotEmpty ||
        vendorListModel.otherCertification.value.text.isNotEmpty ||
        vendorListModel.vendorBankName.value.text.isNotEmpty ||
        vendorListModel.vendorBankBranch.value.text.isNotEmpty ||
        vendorListModel.vendorBankAccountNumber.value.text.isNotEmpty ||
        vendorListModel.vendorBankIfsc.value.text.isNotEmpty ||
        vendorListModel.uploadedLogo_path.value != null ||
        vendorListModel.uploadedLogo.value != null ||
        vendorListModel.GSTregCerti_uploadedPath.value != null ||
        vendorListModel.PAN_uploadedPath.value != null ||
        vendorListModel.cheque_uploadedPath.value != null ||
        vendorListModel.GSTregCertiFile.value != null ||
        vendorListModel.vendorPANfile.value != null ||
        vendorListModel.cancelledChequeFile.value != null;
  }

  bool anyDontHavedata() {
    return !anyHavedata();
  }

  void clearPickedFiles() {
    vendorListModel.uploadedLogo_path.value = null;
    vendorListModel.uploadedLogo.value = null;
    vendorListModel.GSTregCerti_uploadedPath.value = null;
    vendorListModel.GSTregCertiFile.value = null;
    vendorListModel.PAN_uploadedPath.value = null;
    vendorListModel.vendorPANfile.value = null;
    vendorListModel.cheque_uploadedPath.value = null;
    vendorListModel.cancelledChequeFile.value = null;
  }

  bool postDataValidation(String type) {
    bool isEmpty = vendorListModel.vendorNameController.value.text.isEmpty ||
        vendorListModel.vendorAddressController.value.text.isEmpty ||
        vendorListModel.vendorAddressStateController.value.text.isEmpty ||
        vendorListModel.vendorAddressPincodeController.value.text.isEmpty ||
        vendorListModel.contactpersonName.value.text.isEmpty ||
        vendorListModel.contactPersonDesignation.value.text.isEmpty ||
        vendorListModel.contactPersonPhoneNumber.value.text.isEmpty ||
        vendorListModel.contactPersonEmail.value.text.isEmpty ||
        vendorListModel.typeOfBusiness.value.text.isEmpty ||
        vendorListModel.yearOfEstablishment.value.text.isEmpty ||
        vendorListModel.vendorGstNo.value.text.isEmpty ||
        vendorListModel.vendorPanNo.value.text.isEmpty ||
        vendorListModel.vendorAnnualTurnover.value.text.isEmpty ||
        vendorListModel.descriptionOfProducts.value.text.isEmpty ||
        vendorListModel.vendorBankName.value.text.isEmpty ||
        vendorListModel.vendorBankBranch.value.text.isEmpty ||
        vendorListModel.vendorBankAccountNumber.value.text.isEmpty ||
        vendorListModel.vendorBankIfsc.value.text.isEmpty ||
        vendorListModel.GSTregCerti_uploadedPath.value == null ||
        vendorListModel.PAN_uploadedPath.value == null ||
        vendorListModel.cheque_uploadedPath.value == null ||
        vendorListModel.uploadedLogo.value == null;

    // Additional file checks for non-update case
    if (type != 'update') {
      isEmpty = isEmpty || vendorListModel.GSTregCertiFile.value == null || vendorListModel.vendorPANfile.value == null || vendorListModel.cancelledChequeFile.value == null;
    }

    return isEmpty;
  }

  void resetData() {
    vendorListModel.tabController.value = null;

    // vendorListModel.selectedLogoPath.value = null;
    // vendorListModel.selectedGSTregCertiFile.value = null;
    // vendorListModel.selectedPANfile.value = null;
    // vendorListModel.selectedCancelledChequeFile.value = null;
    //KYC
    vendorListModel.vendorNameController.value.clear();
    vendorListModel.vendorAddressController.value.clear();
    vendorListModel.vendorAddressStateController.value.clear();
    vendorListModel.vendorAddressPincodeController.value.clear();
    vendorListModel.contactpersonName.value.clear();
    vendorListModel.contactPersonDesignation.value.clear();
    vendorListModel.contactPersonPhoneNumber.value.clear();
    vendorListModel.contactPersonEmail.value.clear();

    //Business details
    vendorListModel.typeOfBusiness.value.clear();
    vendorListModel.yearOfEstablishment.value.clear();
    vendorListModel.vendorGstNo.value.clear();
    vendorListModel.vendorPanNo.value.clear();
    vendorListModel.vendorAnnualTurnover.value.clear();
    // vendorListModel.vendorListOfProducts.clear();
    vendorListModel.descriptionOfProducts.value.clear();

    //Bank deails
    vendorListModel.isoCertification.value.clear();
    vendorListModel.otherCertification.value.clear();
    vendorListModel.vendorBankName.value.clear();
    vendorListModel.vendorBankBranch.value.clear();
    vendorListModel.vendorBankAccountNumber.value.clear();
    vendorListModel.vendorBankIfsc.value.clear();

    // Reset file pickers
    vendorListModel.uploadedLogo_path.value = null;
    vendorListModel.uploadedLogo.value = null;
    vendorListModel.GSTregCerti_uploadedPath.value = null;
    vendorListModel.GSTregCertiFile.value = null;
    vendorListModel.PAN_uploadedPath.value = null;
    vendorListModel.vendorPANfile.value = null;
    vendorListModel.cheque_uploadedPath.value = null;
    vendorListModel.cancelledChequeFile.value = null;

    // Reset uploaded paths
    vendorListModel.uploadedLogo_path.value = null;
    vendorListModel.GSTregCerti_uploadedPath.value = null;
    vendorListModel.PAN_uploadedPath.value = null;
    vendorListModel.cheque_uploadedPath.value = null;
  }
}
