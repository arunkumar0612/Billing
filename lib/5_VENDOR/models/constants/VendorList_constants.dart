import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Vendor_entities.dart';

class VendorListModel extends GetxController with GetSingleTickerProviderStateMixin {
  final Rxn<TabController> tabController = Rxn<TabController>();
  final mainData = Rxn<VendorList>();

  ///Manual onboard KYC Details
  var vendorId = 0.obs;
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
  final pdfFile = Rxn<File>();

  ///Bank details &uploads
  final isoCertification = TextEditingController().obs;
  final otherCertification = TextEditingController().obs;
  final vendorBankName = TextEditingController().obs;
  final vendorBankBranch = TextEditingController().obs;
  final vendorBankAccountNumber = TextEditingController().obs;
  final vendorBankIfsc = TextEditingController().obs;

  ///image upload constants
  // var logoPickedFile = Rxn<FilePickerResult>();
  var uploadedLogo = Rxn<File>();
  // var logoBytes = Rxn<Uint8List>();
  var uploadedLogo_path = Rxn<String>();
  var logoFileChanged = false.obs;
  // var selectedLogoPath = Rxn<File>();

  ///GST Reg Certi constants
  // var GSTregCertiPickedFile = Rxn<FilePickerResult>();
  var GSTregCertiFile = Rxn<File>();
  var GSTregCerti_uploadedPath = Rxn<String>();
  var gstRegFileChanged = false.obs;
  // var selectedGSTregCertiFile = Rxn<File>();

  /// PAN constants
  // var vendorPANPickedFile = Rxn<FilePickerResult>();
  var vendorPANfile = Rxn<File>();
  var PAN_uploadedPath = Rxn<String>();
  var panFileChanged = false.obs;

  // var selectedPANfile = Rxn<File>();

  /// CancelledCheue constants
  // var cancelledChequePickedFile = Rxn<FilePickerResult>();
  var cancelledChequeFile = Rxn<File>();
  var cheque_uploadedPath = Rxn<String>();
  var chequeFileChanged = false.obs;

  // var selectedCancelledChequeFile = Rxn<File>();

  ///FormKey
  final vendorKYCformKey = GlobalKey<FormState>().obs;
  final vendorBusinessInfoFormKey = GlobalKey<FormState>().obs;
  final vendorBankDetailsFormKey = GlobalKey<FormState>().obs;

  late Animation<Offset> slideAnimation;
  // late TabController tabController;
  var selectedtab = 0.obs;
  var searchQuery = "".obs;
  late AnimationController Vendor_controller;
  var Vendor_DataPageView = false.obs;
  var Vendor_cardCount = 5.obs;
  var selectedVendorDetails = VendorList().obs;
  var Vendorlist = <VendorList>[].obs;
  var backup_VendorList = <VendorList>[].obs;
  final vendorManagementFormKey = GlobalKey<FormState>().obs;
  var isFormEditable = false.obs;
}
