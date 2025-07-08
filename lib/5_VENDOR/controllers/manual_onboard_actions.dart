import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/constants/manual_onboard_constants.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

class ManualOnboardController extends GetxController {
  var manualOnboardModel = ManualOnboardModel();

  void initializeTabController(TabController tabController) {
    manualOnboardModel.tabController.value = tabController;
  }

  void nextTab() {
    if (manualOnboardModel.tabController.value!.index < manualOnboardModel.tabController.value!.length - 1) {
      manualOnboardModel.tabController.value!.animateTo(manualOnboardModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (manualOnboardModel.tabController.value!.index > 0) {
      manualOnboardModel.tabController.value!.animateTo(manualOnboardModel.tabController.value!.index - 1);
    }
  }

  void updateFormKey(GlobalKey<FormState> newKey) {
    manualOnboardModel.vendorKYCformKey.value = newKey;
  }

  // Update Text Controllers
  void updateVendorName(String value) {
    manualOnboardModel.vendorNameController.value.text = value;
  }

  void updateVendorAddress(String value) {
    manualOnboardModel.vendorAddressController.value.text = value;
  }

  void updateState(String value) {
    manualOnboardModel.vendorAddressStateController.value.text = value;
  }

  void updatePincode(String value) {
    manualOnboardModel.vendorAddressPincodeController.value.text = value;
  }

  void updateContactPersonName(String value) {
    manualOnboardModel.contactpersonName.value.text = value;
  }

  void updateContactPersonDesignation(String value) {
    manualOnboardModel.contactPersonDesignation.value.text = value;
  }

  void updateContactPersonPhoneNo(String value) {
    manualOnboardModel.contactPersonPhoneNumber.value.text = value;
  }

  void updateContactPersonEmail(String value) {
    manualOnboardModel.contactPersonEmail.value.text = value;
  }

  void updateTypeOfBusiness(String value) {
    manualOnboardModel.typeOfBusiness.value.text = value;
  }

  void updateYearOfEstablishment(String value) {
    manualOnboardModel.yearOfEstablishment.value.text = value;
  }

  void updateVendorGST(String value) {
    manualOnboardModel.vendorGstNo.value.text = value;
  }

  void updateVendorPAN(String value) {
    manualOnboardModel.vendorPanNo.value.text = value;
  }

  void updateAnnualturnover(String value) {
    manualOnboardModel.vendorAnnualTurnover.value.text = value;
  }

  // void updateListOfProducts(String value) {
  //   // Split by comma, trim spaces, and remove empty strings
  //   manualOnboardModel.vendorListOfProducts.value = value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  // }

  void updateProductInput(String value) {
    manualOnboardModel.productInputController.text = value;
  }

  void updateHSNcodeList(String value) {
    // Split by comma, trim spaces, and remove empty strings
    manualOnboardModel.vendorHSNCodeList.value = value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  void updateHSNcodeInput(String value) {
    manualOnboardModel.HSNcodeController.text = value;
  }

  void updateProductDescription(String value) {
    manualOnboardModel.descriptionOfProducts.value.text = value;
  }

  void updateISOCerti(String value) {
    manualOnboardModel.isoCertification.value.text = value;
  }

  void updateOtherCerti(String value) {
    manualOnboardModel.otherCertification.value.text = value;
  }

  void updateVendorBankName(String value) {
    manualOnboardModel.vendorBankName.value.text = value;
  }

  void updateVendorBankBranch(String value) {
    manualOnboardModel.vendorBankBranch.value.text = value;
  }

  void updateVendorBankAccountNo(String value) {
    manualOnboardModel.vendorBankAccountNumber.value.text = value;
  }

  void updateVendorBankIFSC(String value) {
    manualOnboardModel.vendorBankIfsc.value.text = value;
  }

  void updateVendorCompanyLogo(String filepath) {
    manualOnboardModel.selectedLogoPath.value = File(filepath);
  }

  void updateSelectedRegCerti(String filePath) {
    manualOnboardModel.selectedGSTregCertiFile.value = File(filePath);
  }

  void updateSelectedPAN(String filePath) {
    manualOnboardModel.selectedPANfile.value = File(filePath);
  }

  void updateSelectedCheque(String filePath) {
    manualOnboardModel.selectedCancelledChequeFile.value = File(filePath);
  }

  Future<bool> vendorLogoPickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg'], lockParentWindow: true);

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');

        manualOnboardModel.logoPickedFile.value = null;
        manualOnboardModel.uploadedLogo.value = null;
      } else {
        manualOnboardModel.logoPickedFile.value = result;
        manualOnboardModel.uploadedLogo.value = file;
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

        manualOnboardModel.GSTregCertiFile.value = null;
        manualOnboardModel.GSTregCertiFile.value = null;
      } else {
        manualOnboardModel.GSTregCertiPickedFile.value = result;
        manualOnboardModel.GSTregCertiFile.value = file;
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

        manualOnboardModel.vendorPANPickedFile.value = null;
        manualOnboardModel.vendorPANfile.value = null;
      } else {
        manualOnboardModel.vendorPANPickedFile.value = result;
        manualOnboardModel.vendorPANfile.value = file;
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

        manualOnboardModel.cancelledChequePickedFile.value = null;
        manualOnboardModel.cancelledChequeFile.value = null;
      } else {
        manualOnboardModel.cancelledChequePickedFile.value = result;
        manualOnboardModel.cancelledChequeFile.value = file;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  bool anyHavedata() {
    return manualOnboardModel.vendorNameController.value.text.isNotEmpty ||
        manualOnboardModel.vendorAddressController.value.text.isNotEmpty ||
        manualOnboardModel.vendorAddressStateController.value.text.isNotEmpty ||
        manualOnboardModel.vendorAddressPincodeController.value.text.isNotEmpty ||
        manualOnboardModel.contactpersonName.value.text.isNotEmpty ||
        manualOnboardModel.contactPersonDesignation.value.text.isNotEmpty ||
        manualOnboardModel.contactPersonPhoneNumber.value.text.isNotEmpty ||
        manualOnboardModel.contactPersonEmail.value.text.isNotEmpty ||
        manualOnboardModel.typeOfBusiness.value.text.isNotEmpty ||
        manualOnboardModel.yearOfEstablishment.value.text.isNotEmpty ||
        manualOnboardModel.vendorGstNo.value.text.isNotEmpty ||
        manualOnboardModel.vendorPanNo.value.text.isNotEmpty ||
        manualOnboardModel.vendorAnnualTurnover.value.text.isNotEmpty ||
        // manualOnboardModel.vendorListOfProducts.isNotEmpty ||
        manualOnboardModel.descriptionOfProducts.value.text.isNotEmpty ||
        manualOnboardModel.isoCertification.value.text.isNotEmpty ||
        manualOnboardModel.otherCertification.value.text.isNotEmpty ||
        manualOnboardModel.vendorBankName.value.text.isNotEmpty ||
        manualOnboardModel.vendorBankBranch.value.text.isNotEmpty ||
        manualOnboardModel.vendorBankAccountNumber.value.text.isNotEmpty ||
        manualOnboardModel.vendorBankIfsc.value.text.isNotEmpty ||
        manualOnboardModel.logoPickedFile.value != null ||
        manualOnboardModel.uploadedLogo.value != null ||
        manualOnboardModel.GSTregCertiPickedFile.value != null ||
        manualOnboardModel.vendorPANPickedFile.value != null ||
        manualOnboardModel.cancelledChequePickedFile.value != null ||
        manualOnboardModel.GSTregCertiFile.value != null ||
        manualOnboardModel.vendorPANfile.value != null ||
        manualOnboardModel.cancelledChequeFile.value != null;
  }

  bool anyDontHavedata() {
    return !anyHavedata();
  }

  void clearPickedFiles() {
    manualOnboardModel.logoPickedFile.value = null;
    manualOnboardModel.uploadedLogo.value = null;
    manualOnboardModel.GSTregCertiPickedFile.value = null;
    manualOnboardModel.GSTregCertiFile.value = null;
    manualOnboardModel.vendorPANPickedFile.value = null;
    manualOnboardModel.vendorPANfile.value = null;
    manualOnboardModel.cancelledChequePickedFile.value = null;
    manualOnboardModel.cancelledChequeFile.value = null;
  }

  bool postDataValidation() {
    return (manualOnboardModel.vendorNameController.value.text.isEmpty ||
        manualOnboardModel.vendorAddressController.value.text.isEmpty ||
        manualOnboardModel.vendorAddressStateController.value.text.isEmpty ||
        manualOnboardModel.vendorAddressPincodeController.value.text.isEmpty ||
        manualOnboardModel.contactpersonName.value.text.isEmpty ||
        manualOnboardModel.contactPersonDesignation.value.text.isEmpty ||
        manualOnboardModel.contactPersonPhoneNumber.value.text.isEmpty ||
        manualOnboardModel.contactPersonEmail.value.text.isEmpty ||
        manualOnboardModel.typeOfBusiness.value.text.isEmpty ||
        manualOnboardModel.yearOfEstablishment.value.text.isEmpty ||
        manualOnboardModel.vendorGstNo.value.text.isEmpty ||
        manualOnboardModel.vendorPanNo.value.text.isEmpty ||
        manualOnboardModel.vendorAnnualTurnover.value.text.isEmpty ||
        // manualOnboardModel.vendorListOfProducts.isEmpty ||
        manualOnboardModel.descriptionOfProducts.value.text.isEmpty ||
        manualOnboardModel.isoCertification.value.text.isEmpty ||
        manualOnboardModel.otherCertification.value.text.isEmpty ||
        manualOnboardModel.vendorBankName.value.text.isEmpty ||
        manualOnboardModel.vendorBankBranch.value.text.isEmpty ||
        manualOnboardModel.vendorBankAccountNumber.value.text.isEmpty ||
        manualOnboardModel.vendorBankIfsc.value.text.isEmpty ||
        manualOnboardModel.logoPickedFile.value == null ||
        manualOnboardModel.uploadedLogo.value == null ||
        manualOnboardModel.GSTregCertiPickedFile.value == null ||
        manualOnboardModel.vendorPANPickedFile.value == null ||
        manualOnboardModel.cancelledChequePickedFile.value == null ||
        manualOnboardModel.GSTregCertiFile.value == null ||
        manualOnboardModel.vendorPANfile.value == null ||
        manualOnboardModel.cancelledChequeFile.value == null);
  }

  void resetData() {
    manualOnboardModel.tabController.value = null;

    manualOnboardModel.selectedLogoPath.value = File('E://vendor_logo.png');
    manualOnboardModel.selectedGSTregCertiFile.value = File('E://reg_certi.pdf');
    manualOnboardModel.selectedPANfile.value = File('E://vendor_pan.pdf');
    manualOnboardModel.selectedCancelledChequeFile.value = File('E://cancelled_cheque.pdf');
    //KYC
    manualOnboardModel.vendorNameController.value.clear();
    manualOnboardModel.vendorAddressController.value.clear();
    manualOnboardModel.vendorAddressStateController.value.clear();
    manualOnboardModel.vendorAddressPincodeController.value.clear();
    manualOnboardModel.contactpersonName.value.clear();
    manualOnboardModel.contactPersonDesignation.value.clear();
    manualOnboardModel.contactPersonPhoneNumber.value.clear();
    manualOnboardModel.contactPersonEmail.value.clear();

    //Business details
    manualOnboardModel.typeOfBusiness.value.clear();
    manualOnboardModel.yearOfEstablishment.value.clear();
    manualOnboardModel.vendorGstNo.value.clear();
    manualOnboardModel.vendorPanNo.value.clear();
    manualOnboardModel.vendorAnnualTurnover.value.clear();
    // manualOnboardModel.vendorListOfProducts.clear();
    manualOnboardModel.descriptionOfProducts.value.clear();

    //Bank deails
    manualOnboardModel.isoCertification.value.clear();
    manualOnboardModel.otherCertification.value.clear();
    manualOnboardModel.vendorBankName.value.clear();
    manualOnboardModel.vendorBankBranch.value.clear();
    manualOnboardModel.vendorBankAccountNumber.value.clear();
    manualOnboardModel.vendorBankIfsc.value.clear();

    // Reset file pickers
    manualOnboardModel.logoPickedFile.value = null;
    manualOnboardModel.uploadedLogo.value = null;
    manualOnboardModel.GSTregCertiPickedFile.value = null;
    manualOnboardModel.GSTregCertiFile.value = null;
    manualOnboardModel.vendorPANPickedFile.value = null;
    manualOnboardModel.vendorPANfile.value = null;
    manualOnboardModel.cancelledChequePickedFile.value = null;
    manualOnboardModel.cancelledChequeFile.value = null;

    // Reset uploaded paths
    manualOnboardModel.uploadedLogo_path.value = null;
    manualOnboardModel.GSTregCerti_uploadedPath.value = null;
    manualOnboardModel.PAN_uploadedPath.value = null;
    manualOnboardModel.cheque_uploadedPath.value = null;
  }
}
