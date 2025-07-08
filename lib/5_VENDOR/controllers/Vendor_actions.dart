import 'dart:io';

import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/constants/Vendor_constants.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Vendor_entities.dart';
import 'package:ssipl_billing/API/invoker.dart';

import '../../COMPONENTS-/Response_entities.dart';

class VendorController extends GetxController {
  var vendorModel = VendorModel();
  final Invoker apiController = Get.find<Invoker>();
  // final VendorController vendorController = Get.find<VendorController>();
  var vendorfilteredModel = VendorModel();

  void addToVendor_customerList(CMDlResponse value) {
    vendorModel.processcustomerList.clear();
    vendorfilteredModel.processcustomerList.clear();

    for (int i = 0; i < value.data.length; i++) {
      vendorModel.processcustomerList.add(Active_vendorList.fromJson(value, i));
      vendorfilteredModel.processcustomerList.add(Active_vendorList.fromJson(value, i));
    }
  }

  void update_showVendorProcess(int? value) {
    vendorModel.showvendorprocess.value = value;
  }

  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

  Future<void> updatePDFfile(File value) async {
    vendorModel.pdfFile.value = value;
  }

  void setProcessID(int processid) {
    vendorModel.processID.value = processid;
  }

  // void addToProcessvendorList(CMDlResponse value) {
  //   for (int i = 0; i < value.data.length; i++) {
  //     vendorModel.processvendorList.add(Processvendor.fromJson(value, i));
  //   }
  //   vendorfilteredModel.processvendorList.assignAll(vendorModel.processvendorList);
  //   // print('object');
  // }

  void addToProcessList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      vendorModel.processList.add(Process.fromJson(value, i));
    }
    vendorfilteredModel.processList.assignAll(vendorModel.processList);
  }

  void updatevendorId(int value) {
    vendorModel.vendorId.value = value;
  }

  // Future<void> PDFfileApiData(CMDmResponse value) async {
  //   var pdfFileData = await PDFfileData.fromJson(value); // Await async function
  //   var binaryData = pdfFileData.data; // Extract File object
  //   await updatePDFfile(binaryData);
  // }

  // Future<void> updatePDFfile(File value) async {
  //   vendorModel.pdfFile.value = value;
  // }

  void updateisAllSelected(bool value) {
    vendorModel.isAllSelected.value = value;
  }

  void updateselectedIndices(List<int> value) {
    vendorModel.selectedIndices.value = value;
  }

  void toggleCCemailvisibility(bool value) {
    vendorModel.CCemailToggle.value = value;
  }

  void updatetype(int value) {
    vendorModel.type.value = value;
  }

  void updateprofilepage(bool value) {
    vendorModel.isprofilepage.value = value;
  }

  void clear_sharedata() {
    vendorModel.emailController.value.clear();
    vendorModel.phoneController.value.clear();
    vendorModel.feedbackController.value.clear();
    vendorModel.CCemailController.value.clear();
    vendorModel.whatsapp_selectionStatus.value = false;
    vendorModel.gmail_selectionStatus.value = false;
  }

  void search(String query) {
    vendorModel.searchQuery.value = query;
    // vendorModel.searchQuery.value = query;

    if (query.isEmpty) {
      vendorModel.processList.assignAll(vendorfilteredModel.processList);
      vendorModel.processcustomerList.assignAll(vendorfilteredModel.processcustomerList);
    } else {
      var filteredProcesses = vendorfilteredModel.processList.where((process) =>
          process.title.toLowerCase().contains(query.toLowerCase()) ||
          process.vendor_name.toLowerCase().contains(query.toLowerCase()) ||
          process.Process_date.toLowerCase().contains(query.toLowerCase()));

      var filteredVendors = vendorfilteredModel.processcustomerList.where((vendor) => vendor.vendorName.toLowerCase().contains(query.toLowerCase()));

      vendorModel.processList.assignAll(filteredProcesses);
      vendorModel.processcustomerList.assignAll(filteredVendors);
    }
  }

  void updateVendorData(CMDmResponse value) {
    vendorModel.vendordata.value = Vendordata.fromJson(value);
  }

  void updateclientprofileData(CMDmResponse value) {
    vendorModel.Clientprofile.value = Clientprofiledata.fromJson(value);
  }

  void updatevendorperiod(String value) {
    vendorModel.vendorperiod.value = value;
  }

  void reset_shareData() {
    vendorModel.emailController.value.clear();
    vendorModel.phoneController.value.clear();
    vendorModel.feedbackController.value.clear();
    vendorModel.CCemailController.value.clear();
  }

  // void resetData() {
  //   // vendorModel.vendorList.clear();
  //   // vendorModel.processList.clear();
  //   // vendorModel.processvendorList.clear();
  //   // vendorModel.showvendorprocess.value = null;
  //   // vendorModel.vendorId.value = null;
  //   // vendorModel.pdfFile.value = null;
  //   // vendorModel.selectedIndices.clear();
  //   // vendorModel.isAllSelected.value = false;
  //   // vendorModel.type.value = 0;
  //   // vendorModel.isprofilepage.value = false;
  //   // vendorModel.searchQuery.value = '';
  //   // vendorModel.vendordata.value = null;
  //   // vendorModel.vendorperiod.value = 'monthly';
  //   // vendorModel.Clientprofile.value = null;
  // }

  void resetData() {
    // CLIENT DATA
    // vendorModel.vendorList.clear();
    vendorModel.processcustomerList.clear();
    vendorModel.processID.value = null;
    vendorModel.processList.clear();
    vendorModel.showvendorprocess.value = null;
    vendorModel.vendorId.value = null;
    vendorModel.pdfFile.value = null;

    vendorModel.selectedIndices.clear();
    vendorModel.isAllSelected.value = false;
    vendorModel.type.value = 0;
    vendorModel.isprofilepage.value = false;
    vendorModel.searchQuery.value = '';
    vendorModel.vendordata.value = null;
    vendorModel.vendorperiod.value = 'monthly';
    vendorModel.Clientprofile.value = null;

    // POST / CONTACT
    vendorModel.whatsapp_selectionStatus.value = true;
    vendorModel.gmail_selectionStatus.value = true;
    vendorModel.phoneController.value.clear();
    vendorModel.emailController.value.clear();
    vendorModel.CCemailController.value.clear();
    vendorModel.feedbackController.value.clear();
    vendorModel.CCemailToggle.value = false;
  }
}
//  vendorname.replaceAll(RegExp(r'[^A-Z]'), '').length>=2?vendorname.replaceAll(RegExp(r'[^A-Z]'), '').substring(0, 2):vendorname.replaceAll(RegExp(r'[^A-Z]'), '').length==1?vendorname.replaceAll(RegExp(r'[^A-Z]'), ''):vendorname.isNotEmpty?vendorname[0].toUpperCase():"?",
