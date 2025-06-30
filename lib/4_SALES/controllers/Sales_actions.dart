import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/models/constants/Sales_constants.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';

import '../../COMPONENTS-/Response_entities.dart';

/// A GetX controller for managing sales-related data and actions.
/// This controller handles various lists like customers, processes, and PDF data.
/// It communicates with the API through the [Invoker] and updates the state of the sales model accordingly.
class SalesController extends GetxController {
  var salesModel = SalesModel();
  final Invoker apiController = Get.find<Invoker>();
  // final SalesController salesController = Get.find<SalesController>();
  var salesfilteredModel = SalesModel();

  /// Adds a list of customers from [CMDlResponse] to the [customerList].
  /// Iterates over the response and converts each entry to a [Customer].
  void addToCustomerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      salesModel.customerList.add(Customer.fromJson(value, i));
    }
  }

  /// Adds a list of processing customers from [CMDlResponse] to [processcustomerList]
  void addToProcesscustomerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      salesModel.processcustomerList.add(Processcustomer.fromJson(value, i));
    }
    salesfilteredModel.processcustomerList.assignAll(salesModel.processcustomerList);
    // print('object');
  }

  /// Adds a list of customer PDF records from [CMDlResponse] to both [customPdfList] and the filtered version.
  /// Clears previous entries before adding new ones.
  void addToCustompdfList(CMDlResponse value) {
    salesModel.customPdfList.clear();
    salesfilteredModel.customPdfList.clear();
    for (int i = 0; i < value.data.length; i++) {
      salesModel.customPdfList.add(CustomerPDF_List.fromJson(value.data[i]));
      salesfilteredModel.customPdfList.add(CustomerPDF_List.fromJson(value.data[i]));
    }
  }

  /// Adds a list of process records from [CMDlResponse] to [processList] and assigns it to the filtered model.
  void addToProcessList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      salesModel.processList.add(Process.fromJson(value, i));
    }
    salesfilteredModel.processList.assignAll(salesModel.processList);
  }

  /// Updates the selected customer ID in the sales model.
  void updatecustomerId(int value) {
    salesModel.customerId.value = value;
  }

  ///Updates the visibility state for the customer process UI.
  void updateshowcustomerprocess(int? value) {
    salesModel.showcustomerprocess.value = value;
  }

  /// Processes PDF data response [CMDmResponse] and stores the resulting file.
  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

  /// Updates the pdfFile in the sales model with a new File.
  Future<void> updatePDFfile(File value) async {
    salesModel.pdfFile.value = value;
  }

  /// Fetches and updates the custom PDF file from the given CMDmResponse.
  Future<void> custom_PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await update_customPDFfile(binaryData);
  }

  /// Updates the custom PDF file in the sales model.
  Future<void> update_customPDFfile(File value) async {
    salesModel.custom_pdfFile.value = value;
  }

  /// Updates the isAllSelected flag in the sales model.
  void updateisAllSelected(bool value) {
    salesModel.isAllSelected.value = value;
  }

  /// Updates the list of selected item indices.
  void updateselectedIndices(List<int> value) {
    salesModel.selectedIndices.value = value;
  }

  /// Toggles the visibility of the CC email input field.
  void toggleCCemailvisibility(bool value) {
    salesModel.CCemailToggle.value = value;
  }

  /// Updates the selected type value in the sales model.
  void updatetype(int value) {
    salesModel.type.value = value;
  }

  /// Updates the isprofilepage flag to show or hide profile page.
  void updateprofilepage(bool value) {
    salesModel.isprofilepage.value = value;
  }

  /// Clears all share-related fields and resets service selection status.
  void clear_sharedata() {
    salesModel.emailController.value.clear();
    salesModel.phoneController.value.clear();
    salesModel.feedbackController.value.clear();
    salesModel.CCemailController.value.clear();
    salesModel.whatsapp_selectionStatus.value = false;
    salesModel.gmail_selectionStatus.value = false;
  }

  /// Filters process and customer lists based on the search query.
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

  /// Filters the `customPdfList` based on a search query.
  ///
  /// This function takes a `query` string and filters the list of custom PDF
  /// documents displayed to the user. The search is case-insensitive and
  /// applies to the date, customer address name, customer address, and generated ID.
  ///
  /// **Logic Flow:**
  /// - **If `query` is empty:**
  ///   - The `salesModel.customPdfList` is reset to contain all items from
  ///     `salesfilteredModel.customPdfList`. This effectively clears any
  ///     active filter and shows the complete list.
  /// - **If `query` is not empty:**
  ///   - It filters `salesfilteredModel.customPdfList` (which is presumed
  ///     to hold the complete, unfiltered data).
  ///   - A `process` item is included in the `filteredList` if its `date`,
  ///     `customerAddressName`, `customerAddress`, or `genId` contains the
  ///     `query` string (case-insensitive).
  ///   - The `salesModel.customPdfList` is then updated to display only these
  ///     `filteredList` items, reflecting the search results in the UI.
  ///
  /// @param query The search string used to filter the custom PDF list. An empty
  ///              string will reset the list to its full, unfiltered state.
  void search_CustomPDF(String query) {
    // salesModel.searchQuery.value = query;

    if (query.isEmpty) {
      salesModel.customPdfList.assignAll(salesfilteredModel.customPdfList);
      // salesModel.processcustomerList.assignAll(salesfilteredModel.processcustomerList);
    } else {
      var filteredList = salesfilteredModel.customPdfList.where((process) =>
          process.date.toLowerCase().contains(query.toLowerCase()) ||
          process.customerAddressName.toLowerCase().contains(query.toLowerCase()) ||
          process.customerAddress.toLowerCase().contains(query.toLowerCase()) ||
          process.genId.toLowerCase().contains(query.toLowerCase()));

      salesModel.customPdfList.assignAll(filteredList);
    }
  }

  /// Updates the sales data from a CMDmResponse.
  void updateSalesData(CMDmResponse value) {
    salesModel.salesdata.value = Salesdata.fromJson(value);
  }

  /// Updates the client profile data from a CMDmResponse.
  void updateclientprofileData(CMDmResponse value) {
    salesModel.Clientprofile.value = Clientprofiledata.fromJson(value);
  }

  /// Updates the selected sales period string value.
  void updatesalesperiod(String value) {
    salesModel.salesperiod.value = value;
  }

  /// Clears all sharing input fields like email, phone, feedback, and CC email.
  void reset_shareData() {
    salesModel.emailController.value.clear();
    salesModel.phoneController.value.clear();
    salesModel.feedbackController.value.clear();
    salesModel.CCemailController.value.clear();
  }

  /// Fetches the custom PDF list data from the API and updates the model.
  Future<void> Get_salesCustomPDFLsit() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_salesCustompdf);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          addToCustompdfList(value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Processcustomer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }
  // void resetData() {
  //   // salesModel.customerList.clear();
  //   // salesModel.processList.clear();
  //   // salesModel.processcustomerList.clear();
  //   // salesModel.showcustomerprocess.value = null;
  //   // salesModel.customerId.value = null;
  //   // salesModel.pdfFile.value = null;
  //   // salesModel.selectedIndices.clear();
  //   // salesModel.isAllSelected.value = false;
  //   // salesModel.type.value = 0;
  //   // salesModel.isprofilepage.value = false;
  //   // salesModel.searchQuery.value = '';
  //   // salesModel.salesdata.value = null;
  //   // salesModel.salesperiod.value = 'monthly';
  //   // salesModel.Clientprofile.value = null;
  // }

  void resetData() {
    // CLIENT DATA
    salesModel.customerList.clear();
    salesModel.processcustomerList.clear();
    salesModel.customPdfList.clear();
    salesModel.processList.clear();
    salesModel.showcustomerprocess.value = null;
    salesModel.customerId.value = null;
    salesModel.pdfFile.value = null;
    salesModel.custom_pdfFile.value = null;
    salesModel.selectedIndices.clear();
    salesModel.isAllSelected.value = false;
    salesModel.type.value = 0;
    salesModel.isprofilepage.value = false;
    salesModel.searchQuery.value = '';
    salesModel.salesdata.value = null;
    salesModel.salesperiod.value = 'monthly';
    salesModel.Clientprofile.value = null;

    // POST / CONTACT
    salesModel.whatsapp_selectionStatus.value = true;
    salesModel.gmail_selectionStatus.value = true;
    salesModel.phoneController.value.clear();
    salesModel.emailController.value.clear();
    salesModel.CCemailController.value.clear();
    salesModel.feedbackController.value.clear();
    salesModel.CCemailToggle.value = false;
  }
}
//  customername.replaceAll(RegExp(r'[^A-Z]'), '').length>=2?customername.replaceAll(RegExp(r'[^A-Z]'), '').substring(0, 2):customername.replaceAll(RegExp(r'[^A-Z]'), '').length==1?customername.replaceAll(RegExp(r'[^A-Z]'), ''):customername.isNotEmpty?customername[0].toUpperCase():"?",
