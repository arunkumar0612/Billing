import 'dart:io';

import 'package:get/get.dart';
import 'package:ssipl_billing/models/constants/SUBSCRIPTION_constants/Subscription_constants.dart';

import '../../models/entities/Response_entities.dart';
import '../../models/entities/SUBSCRIPTION/Subscription_entities.dart';

class SubscriptionController extends GetxController {
  var subscriptionModel = SubscriptionModel();
  var subscriptionfilteredModel = SubscriptionModel();
  void addToCustomerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.customerList.add(Customer.fromJson(value, i));
    }
  }

  void add_Comp(CMDmResponse value) {
    subscriptionModel.companyList.value = CompanyResponse.fromJson(value.data);
  }

  void add_GlobalPackage(CMDlResponse value) {
    subscriptionModel.GloabalPackage.value = Global_package.fromCMDlResponse(value);
  }

  void addToProcesscustomerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.processcustomerList.add(Processcustomer.fromJson(value, i));
    }
    subscriptionfilteredModel.processcustomerList.assignAll(subscriptionModel.processcustomerList);
    // print('object');
  }

  void addToProcessList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.processList.add(Process.fromJson(value, i));
    }
    subscriptionfilteredModel.processList.assignAll(subscriptionModel.processList);
  }

  void updatecustomerId(int value) {
    subscriptionModel.customerId.value = value;
  }

  void updateshowcustomerprocess(int? value) {
    subscriptionModel.showcustomerprocess.value = value;
  }

  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

  Future<void> updatePDFfile(File value) async {
    subscriptionModel.pdfFile.value = value;
  }

  void updateisAllSelected(bool value) {
    subscriptionModel.isAllSelected.value = value;
  }

  void updateselectedIndices(List<int> value) {
    subscriptionModel.selectedIndices.value = value;
  }

  void updatetype(int value) {
    subscriptionModel.type.value = value;
  }

  void updateprofilepage(bool value) {
    subscriptionModel.isprofilepage.value = value;
  }

  void search(String query) {
    // subscriptionModel.searchQuery.value = query;

    if (query.isEmpty) {
      subscriptionModel.processList.assignAll(subscriptionfilteredModel.processList);
      subscriptionModel.processcustomerList.assignAll(subscriptionfilteredModel.processcustomerList);
    } else {
      var filteredProcesses = subscriptionfilteredModel.processList.where((process) =>
          process.title.toLowerCase().contains(query.toLowerCase()) ||
          process.customer_name.toLowerCase().contains(query.toLowerCase()) ||
          process.Process_date.toLowerCase().contains(query.toLowerCase()));

      var filteredCustomers = subscriptionfilteredModel.processcustomerList.where((customer) =>
          customer.customerName.toLowerCase().contains(query.toLowerCase()) ||
          customer.customer_phoneno.toLowerCase().contains(query.toLowerCase()) ||
          customer.customer_gstno.toLowerCase().contains(query.toLowerCase()));

      subscriptionModel.processList.assignAll(filteredProcesses);
      subscriptionModel.processcustomerList.assignAll(filteredCustomers);
    }
  }

  void updateSubscriptionData(CMDmResponse value) {
    subscriptionModel.subscriptiondata.value = Subscriptiondata.fromJson(value);
  }

  void updateclientprofileData(CMDmResponse value) {
    subscriptionModel.Clientprofile.value = Clientprofiledata.fromJson(value);
  }

  void updatesubscriptionperiod(String value) {
    subscriptionModel.subscriptionperiod.value = value;
  }

  void addToCustompdfList(CMDlResponse value) {
    subscriptionModel.customPdfList.clear();
    subscriptionfilteredModel.customPdfList.clear();
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.customPdfList.add(CustomerPDF_List.fromJson(value.data[i]));
      subscriptionfilteredModel.customPdfList.add(CustomerPDF_List.fromJson(value.data[i]));
    }
  }

  void addTo_RecuuringInvoiceList(CMDlResponse value) {
    subscriptionModel.reccuringInvoice_list.clear();
    subscriptionfilteredModel.reccuringInvoice_list.clear();
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.reccuringInvoice_list.add(RecurringInvoice_List.fromJson(value.data[i]));
      subscriptionfilteredModel.reccuringInvoice_list.add(RecurringInvoice_List.fromJson(value.data[i]));
    }
  }

  void clear_sharedata() {
    subscriptionModel.emailController.value.clear();
    subscriptionModel.phoneController.value.clear();
    subscriptionModel.feedbackController.value.clear();
    subscriptionModel.CCemailController.value.clear();
    subscriptionModel.whatsapp_selectionStatus.value = false;
    subscriptionModel.gmail_selectionStatus.value = false;
  }

  void search_CustomPDF(String query) {
    // salesModel.searchQuery.value = query;

    if (query.isEmpty) {
      subscriptionModel.customPdfList.assignAll(subscriptionfilteredModel.customPdfList);
      // salesModel.processcustomerList.assignAll(salesfilteredModel.processcustomerList);
    } else {
      var filteredList = subscriptionfilteredModel.customPdfList.where((process) =>
          process.customerAddressName.toLowerCase().contains(query.toLowerCase()) ||
          process.customerAddress.toLowerCase().contains(query.toLowerCase()) ||
          process.genId.toLowerCase().contains(query.toLowerCase()));

      subscriptionModel.customPdfList.assignAll(filteredList);
    }
  }

  void toggleCCemailvisibility(bool value) {
    subscriptionModel.CCemailToggle.value = value;
  }

  void resetData() {
    subscriptionModel.customerList.clear();
    subscriptionModel.processList.clear();
    subscriptionModel.processcustomerList.clear();
    subscriptionModel.showcustomerprocess.value = null;
    subscriptionModel.customerId.value = null;
    subscriptionModel.pdfFile.value = null;
    subscriptionModel.selectedIndices.clear();
    subscriptionModel.isAllSelected.value = false;
    subscriptionModel.type.value = 0;
    subscriptionModel.isprofilepage.value = false;
    subscriptionModel.searchQuery.value = '';
    subscriptionModel.subscriptiondata.value = null;
    subscriptionModel.subscriptionperiod.value = 'monthly';
    subscriptionModel.Clientprofile.value = null;
  }
}
//  customername.replaceAll(RegExp(r'[^A-Z]'), '').length>=2?customername.replaceAll(RegExp(r'[^A-Z]'), '').substring(0, 2):customername.replaceAll(RegExp(r'[^A-Z]'), '').length==1?customername.replaceAll(RegExp(r'[^A-Z]'), ''):customername.isNotEmpty?customername[0].toUpperCase():"?",
