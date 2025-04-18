import 'dart:io';

import 'package:get/get.dart';
import 'package:ssipl_billing/4.SALES/models/constants/Sales_constants.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Sales_entities.dart';

import '../../COMPONENTS-/Response_entities.dart';

class SalesController extends GetxController {
  var salesModel = SalesModel();
  var salesfilteredModel = SalesModel();
  void addToCustomerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      salesModel.customerList.add(Customer.fromJson(value, i));
    }
  }

  void addToProcesscustomerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      salesModel.processcustomerList.add(Processcustomer.fromJson(value, i));
    }
    salesfilteredModel.processcustomerList.assignAll(salesModel.processcustomerList);
    // print('object');
  }

  void addToCustompdfList(CMDlResponse value) {
    salesModel.customPdfList.clear();
    salesfilteredModel.customPdfList.clear();
    for (int i = 0; i < value.data.length; i++) {
      salesModel.customPdfList.add(CustomerPDF_List.fromJson(value.data[i]));
      salesfilteredModel.customPdfList.add(CustomerPDF_List.fromJson(value.data[i]));
    }
  }

  void addToProcessList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      salesModel.processList.add(Process.fromJson(value, i));
    }
    salesfilteredModel.processList.assignAll(salesModel.processList);
  }

  void updatecustomerId(int value) {
    salesModel.customerId.value = value;
  }

  void updateshowcustomerprocess(int? value) {
    salesModel.showcustomerprocess.value = value;
  }

  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

  Future<void> updatePDFfile(File value) async {
    salesModel.pdfFile.value = value;
  }

  Future<void> custom_PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await update_customPDFfile(binaryData);
  }

  Future<void> update_customPDFfile(File value) async {
    salesModel.custom_pdfFile.value = value;
  }

  void updateisAllSelected(bool value) {
    salesModel.isAllSelected.value = value;
  }

  void updateselectedIndices(List<int> value) {
    salesModel.selectedIndices.value = value;
  }

  void toggleCCemailvisibility(bool value) {
    salesModel.CCemailToggle.value = value;
  }

  void updatetype(int value) {
    salesModel.type.value = value;
  }

  void updateprofilepage(bool value) {
    salesModel.isprofilepage.value = value;
  }

  void clear_sharedata() {
    salesModel.emailController.value.clear();
    salesModel.phoneController.value.clear();
    salesModel.feedbackController.value.clear();
    salesModel.CCemailController.value.clear();
    salesModel.whatsapp_selectionStatus.value = false;
    salesModel.gmail_selectionStatus.value = false;
  }

  void search(String query) {
    salesModel.searchQuery.value = query;
    // salesModel.searchQuery.value = query;

    if (query.isEmpty) {
      salesModel.processList.assignAll(salesfilteredModel.processList);
      salesModel.processcustomerList.assignAll(salesfilteredModel.processcustomerList);
    } else {
      var filteredProcesses = salesfilteredModel.processList.where((process) =>
          process.title.toLowerCase().contains(query.toLowerCase()) ||
          process.customer_name.toLowerCase().contains(query.toLowerCase()) ||
          process.Process_date.toLowerCase().contains(query.toLowerCase()));

      var filteredCustomers = salesfilteredModel.processcustomerList.where((customer) =>
          customer.customerName.toLowerCase().contains(query.toLowerCase()) ||
          customer.customer_phoneno.toLowerCase().contains(query.toLowerCase()) ||
          customer.customer_gstno.toLowerCase().contains(query.toLowerCase()));

      salesModel.processList.assignAll(filteredProcesses);
      salesModel.processcustomerList.assignAll(filteredCustomers);
    }
  }

  void search_CustomPDF(String query) {
    // salesModel.searchQuery.value = query;

    if (query.isEmpty) {
      salesModel.customPdfList.assignAll(salesfilteredModel.customPdfList);
      // salesModel.processcustomerList.assignAll(salesfilteredModel.processcustomerList);
    } else {
      var filteredList = salesfilteredModel.customPdfList.where((process) =>
          process.customerAddressName.toLowerCase().contains(query.toLowerCase()) ||
          process.customerAddress.toLowerCase().contains(query.toLowerCase()) ||
          process.genId.toLowerCase().contains(query.toLowerCase()));

      salesModel.customPdfList.assignAll(filteredList);
    }
  }

  void updateSalesData(CMDmResponse value) {
    salesModel.salesdata.value = Salesdata.fromJson(value);
  }

  void updateclientprofileData(CMDmResponse value) {
    salesModel.Clientprofile.value = Clientprofiledata.fromJson(value);
  }

  void updatesalesperiod(String value) {
    salesModel.salesperiod.value = value;
  }

  void resetData() {
    // salesModel.customerList.clear();
    // salesModel.processList.clear();
    // salesModel.processcustomerList.clear();
    // salesModel.showcustomerprocess.value = null;
    // salesModel.customerId.value = null;
    // salesModel.pdfFile.value = null;
    // salesModel.selectedIndices.clear();
    // salesModel.isAllSelected.value = false;
    // salesModel.type.value = 0;
    // salesModel.isprofilepage.value = false;
    // salesModel.searchQuery.value = '';
    // salesModel.salesdata.value = null;
    // salesModel.salesperiod.value = 'monthly';
    // salesModel.Clientprofile.value = null;
  }
}
//  customername.replaceAll(RegExp(r'[^A-Z]'), '').length>=2?customername.replaceAll(RegExp(r'[^A-Z]'), '').substring(0, 2):customername.replaceAll(RegExp(r'[^A-Z]'), '').length==1?customername.replaceAll(RegExp(r'[^A-Z]'), ''):customername.isNotEmpty?customername[0].toUpperCase():"?",
