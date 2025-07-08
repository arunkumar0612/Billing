import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManualOnboardModel extends GetxController with GetSingleTickerProviderStateMixin {
  final Rxn<TabController> tabController = Rxn<TabController>();

  ///Manual onboard KYC Details
  final vendorNameController = TextEditingController().obs;
  final vendorAddressController = TextEditingController().obs;
  final vendorAddressStateController = TextEditingController().obs;
  final vendorAddressPincodeController = TextEditingController().obs;
  final contactpersonName = TextEditingController().obs;
  final contactPersonDesignation = TextEditingController().obs;
  final contactPersonPhoneNumber = TextEditingController().obs;
  final contactPersonEmail = TextEditingController().obs;

  /// Business Info
  final typeOfBusiness = TextEditingController().obs;
  final yearOfEstablishment = TextEditingController().obs;
  final vendorGstNo = TextEditingController().obs;
  final vendorPanNo = TextEditingController().obs;
  final vendorAnnualTurnover = TextEditingController().obs;
  final productInputController = TextEditingController();
  // var vendorListOfProducts = <String>[].obs;
  final HSNcodeController = TextEditingController();
  var vendorHSNCodeList = <String>[].obs;
  final descriptionOfProducts = TextEditingController().obs;

  ///Bank details &uploads
  final isoCertification = TextEditingController().obs;
  final otherCertification = TextEditingController().obs;
  final vendorBankName = TextEditingController().obs;
  final vendorBankBranch = TextEditingController().obs;
  final vendorBankAccountNumber = TextEditingController().obs;
  final vendorBankIfsc = TextEditingController().obs;

  ///image upload constants
  var logoPickedFile = Rxn<FilePickerResult>();
  var uploadedLogo = Rxn<File>();
  var uploadedLogo_path = Rxn<String>();
  final Rx<File> selectedLogoPath = File('E://vendor_logo.png').obs;

  ///GST Reg Certi constants
  var GSTregCertiPickedFile = Rxn<FilePickerResult>();
  var GSTregCertiFile = Rxn<File>();
  var GSTregCerti_uploadedPath = Rxn<String>();
  final Rx<File> selectedGSTregCertiFile = File('E://reg_certi.pdf').obs;

  /// PAN constants
  var vendorPANPickedFile = Rxn<FilePickerResult>();
  var vendorPANfile = Rxn<File>();
  var PAN_uploadedPath = Rxn<String>();
  final Rx<File> selectedPANfile = File('E://vendor_pan.pdf').obs;

  /// CancelledCheue constants
  var cancelledChequePickedFile = Rxn<FilePickerResult>();
  var cancelledChequeFile = Rxn<File>();
  var cheque_uploadedPath = Rxn<String>();
  final Rx<File> selectedCancelledChequeFile = File('E://cancelled_cheque.pdf').obs;

  ///FormKey
  final vendorKYCformKey = GlobalKey<FormState>().obs;
  final vendorBusinessInfoFormKey = GlobalKey<FormState>().obs;
  final vendorBankDetailsFormKey = GlobalKey<FormState>().obs;
}
