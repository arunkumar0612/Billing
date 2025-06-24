import 'dart:io';

import 'package:get/get.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/models/constants/Subscription_constants.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/models/entities/Subscription_entities.dart';

import '../../COMPONENTS-/Response_entities.dart';

class SubscriptionController extends GetxController {
  var subscriptionModel = SubscriptionModel();
  var subscriptionfilteredModel = SubscriptionModel();

  // Function to add company data
  /// This function adds company data to the subscription model.
  /// It converts the CMDmResponse to a CompanyResponse object and assigns it to the companyList property of the subscription model.
  /// The companyList contains information about the companies associated with the subscription.
  void add_Comp(CMDmResponse value) {
    subscriptionModel.companyList.value = CompanyResponse.fromJson(value.data);
  }

// Function to add Global Package data
  /// This function adds the global package data to the subscription model.
  /// It converts the CMDlResponse to a Global_package object and assigns it to the GlobalPackage property of the subscription model.
  void add_GlobalPackage(CMDlResponse value) {
    subscriptionModel.GlobalPackage.value = Global_package.fromCMDlResponse(value);
  }

// Function to handle the PDF file data
  /// This function processes the CMDmResponse, extracts the PDF file data, and updates the model.
  /// It converts the CMDmResponse to a PDFfileData object and extracts the File object from it.
  /// The PDF file data is then used to update the pdfFile property in the subscription model.
  Future<void> custom_PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await update_customPDFfile(binaryData);
  }

  Future<void> pdfFileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

// Function to add customer data
  /// This function adds customer data to the subscription model.
  /// It iterates through the data in the CMDlResponse and adds each customer to the customerList.
  void addToProcesscustomerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.processcustomerList.add(Processcustomer.fromJson(value, i));
    }
    subscriptionfilteredModel.processcustomerList.assignAll(subscriptionModel.processcustomerList);
    // print('object');
  }

// Function to add recurred customer data
  /// This function adds recurred customer data to the subscription model.
  /// It iterates through the data in the CMDlResponse and adds each recurred customer to the recurredcustomerList.
  void addToRecurredcustomerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.recurredcustomerList.add(Recurredcustomer.fromJson(value, i));
    }
    subscriptionfilteredModel.recurredcustomerList.assignAll(subscriptionModel.recurredcustomerList);
    // print('object');
  }

  void addTo_ApprovalQueue_customerList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.ApprovalQueue_customerList.add(ApprovalQueue_customer.fromJson(value, i));
    }
    subscriptionfilteredModel.ApprovalQueue_customerList.assignAll(subscriptionModel.ApprovalQueue_customerList);
    // print('object');
  }

  void addToProcessList(CMDlResponse value) {
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.processList.add(Process.fromJson(value, i));
    }
    subscriptionfilteredModel.processList.assignAll(subscriptionModel.processList);
  }

// Function to update the customer ID
  /// This function updates the customer ID in the subscription model.
  /// It sets the customerId property to the provided value.
  /// The customerId is used to identify the customer associated with the subscription.
  void updatecustomerId(int value) {
    subscriptionModel.customerId.value = value;
  }

// Function to update the show customer process value
  /// This function updates the show customer process value in the subscription model.
  /// It sets the showcustomerprocess property to the provided value.
  /// The showcustomerprocess is used to determine whether to show the customer process or not.
  void updateshowcustomerprocess(int? value) {
    subscriptionModel.showcustomerprocess.value = value;
  }

// Function to update the PDF file
  /// This function updates the PDF file in the subscription model.
  /// It processes the CMDmResponse, extracts the PDF file data, and updates the pdfFile property in the subscription model.
  /// The PDF file is used for various purposes in the subscription model.
  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

// Function to update the PDF file in the model
  /// This function updates the PDF file in the subscription model.
  /// It sets the pdfFile property to the provided File value.
  Future<void> updatePDFfile(File value) async {
    subscriptionModel.pdfFile.value = value;
  }

// Function to update the custom PDF file in the model
  /// This function updates the custom PDF file in the subscription model.
  /// It sets the custom_pdfFile property to the provided File value.
  /// The custom PDF file is used for specific customizations in the subscription model.
  Future<void> update_customPDFfile(File value) async {
    subscriptionModel.custom_pdfFile.value = value;
  }

  // Future<void> update_recurredPDFfile(File value) async {
  //   subscriptionModel.pdfFile.value = value;
  // }

// Function to update the all selected status
  /// This function updates the isAllSelected status in the subscription model.
  /// It sets the isAllSelected property to the provided value.
  /// The isAllSelected property indicates whether all items are selected or not.
  void updateisAllSelected(bool value) {
    subscriptionModel.isAllSelected.value = value;
  }

// Function to update the selected indices
  /// This function updates the selected indices in the subscription model.
  /// It sets the selectedIndices property to the provided list of indices.
  /// The selectedIndices property is used to keep track of which items are selected.
  void updateselectedIndices(List<int> value) {
    subscriptionModel.selectedIndices.value = value;
  }

// Function to update the type
  /// This function updates the type in the subscription model.
  /// It sets the type property to the provided value.
  /// The type property is used to differentiate between different types of subscriptions.
  void updatetype(int value) {
    subscriptionModel.type.value = value;
  }

// Function to update the profile page visibility
  /// This function updates the isprofilepage visibility in the subscription model.
  /// It sets the isprofilepage property to the provided value.
  /// The isprofilepage property indicates whether the profile page is currently being displayed or not.
  void updateprofilepage(bool value) {
    subscriptionModel.isprofilepage.value = value;
  }

// Function to update the search query
  /// This function updates the search query in the subscription model.
  /// It sets the searchQuery property to the provided value.
  /// The searchQuery property is used to filter the subscription data based on the user's input.
  /// @param query The search query entered by the user.
  /// This function updates the subscription model's search query and filters the process list, recurring invoice list, and customer lists based on the query.
  void search(String query) {
    subscriptionModel.searchQuery.value = query;

    if (query.isEmpty) {
      subscriptionModel.processList.assignAll(subscriptionfilteredModel.processList);
      subscriptionModel.reccuringInvoice_list.assignAll(subscriptionfilteredModel.reccuringInvoice_list);
      subscriptionModel.ApprovalQueue_list.assignAll(subscriptionfilteredModel.ApprovalQueue_list);

      subscriptionModel.processcustomerList.assignAll(subscriptionfilteredModel.processcustomerList);
      subscriptionModel.recurredcustomerList.assignAll(subscriptionfilteredModel.recurredcustomerList);
      subscriptionModel.ApprovalQueue_customerList.assignAll(subscriptionfilteredModel.ApprovalQueue_customerList);
    } else {
      var filteredProcesses = subscriptionfilteredModel.processList.where((process) =>
          process.title.toLowerCase().contains(query.toLowerCase()) ||
          process.customer_name.toLowerCase().contains(query.toLowerCase()) ||
          process.Process_date.toLowerCase().contains(query.toLowerCase()));

      var filteredCustomers = subscriptionfilteredModel.processcustomerList.where((customer) =>
          customer.customerName.toLowerCase().contains(query.toLowerCase()) ||
          customer.customer_phoneno.toLowerCase().contains(query.toLowerCase()) ||
          customer.customer_gstno.toLowerCase().contains(query.toLowerCase()));

      var filteredRecurred_invoices = subscriptionfilteredModel.reccuringInvoice_list.where((recurred) =>
          recurred.date.toLowerCase().contains(query.toLowerCase()) ||
          recurred.clientAddressName.toLowerCase().contains(query.toLowerCase()) ||
          recurred.date.toLowerCase().contains(query.toLowerCase()) ||
          recurred.invoiceNo.toLowerCase().contains(query.toLowerCase()));

      var filteredQueue_invoices = subscriptionfilteredModel.ApprovalQueue_list.where((queue) =>
          queue.billDate.toLowerCase().contains(query.toLowerCase()) ||
          queue.clientAddressName.toLowerCase().contains(query.toLowerCase()) ||
          queue.invoiceNumber.toLowerCase().contains(query.toLowerCase()));

      var filteredRecurred_clients = subscriptionfilteredModel.recurredcustomerList.where((customer) =>
          customer.customerName.toLowerCase().contains(query.toLowerCase()) ||
          customer.customer_phoneno.toLowerCase().contains(query.toLowerCase()) ||
          customer.customer_gstno.toLowerCase().contains(query.toLowerCase()));

      var filteredQueue_clients = subscriptionfilteredModel.ApprovalQueue_customerList.where((customer) =>
          customer.customerName.toLowerCase().contains(query.toLowerCase()) ||
          customer.customer_phoneno.toLowerCase().contains(query.toLowerCase()) ||
          customer.customer_gstno.toLowerCase().contains(query.toLowerCase()));

      subscriptionModel.reccuringInvoice_list.assignAll(filteredRecurred_invoices);
      subscriptionModel.recurredcustomerList.assignAll(filteredRecurred_clients);

      subscriptionModel.ApprovalQueue_list.assignAll(filteredQueue_invoices);
      subscriptionModel.ApprovalQueue_customerList.assignAll(filteredQueue_clients);

      subscriptionModel.processList.assignAll(filteredProcesses);
      subscriptionModel.processcustomerList.assignAll(filteredCustomers);
    }
  }

// Function to update the subscription data
  /// This function updates the subscription data in the subscription model.
  /// It sets the subscriptiondata property to the provided CMDmResponse value.
  /// The subscriptiondata property contains information about the subscription, such as its status, period, and other details.
  void updateSubscriptionData(CMDmResponse value) {
    subscriptionModel.subscriptiondata.value = Subscriptiondata.fromJson(value);
  }

// Function to update the client profile data
  /// This function updates the client profile data in the subscription model.
  /// It sets the Clientprofile property to the provided CMDmResponse value.
  /// The Clientprofile property contains information about the client's profile, such as their name, address, and contact details.
  void updateclientprofileData(CMDmResponse value) {
    subscriptionModel.Clientprofile.value = Clientprofiledata.fromJson(value);
  }

// Function to update the subscription period
  /// This function updates the subscription period in the subscription model.
  /// It sets the subscriptionperiod property to the provided value.
  /// The subscriptionperiod property indicates the duration of the subscription, such as monthly or yearly.
  void updatesubscriptionperiod(String value) {
    subscriptionModel.subscriptionperiod.value = value;
  }

// addToCustompdfList
  /// This function updates the custom PDF list in the subscription model.
  /// It clears the existing custom PDF list and adds new entries from the provided CMDlResponse value.
  /// The custom PDF list contains information about custom PDFs associated with the subscription.
  void addToCustompdfList(CMDlResponse value) {
    subscriptionModel.customPdfList.clear();
    subscriptionfilteredModel.customPdfList.clear();
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.customPdfList.add(CustomerPDF_List.fromJson(value.data[i]));
      subscriptionfilteredModel.customPdfList.add(CustomerPDF_List.fromJson(value.data[i]));
    }
  }

// Function to add to the recurring invoice list
  /// This function updates the recurring invoice list in the subscription model.
  /// It clears the existing recurring invoice list and adds new entries from the provided CMDlResponse value.
  /// The recurring invoice list contains information about recurring invoices associated with the subscription.
  void addTo_RecuuringInvoiceList(CMDlResponse value) {
    subscriptionModel.reccuringInvoice_list.clear();
    subscriptionfilteredModel.reccuringInvoice_list.clear();
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.reccuringInvoice_list.add(RecurringInvoice_List.fromJson(value.data[i]));
      subscriptionfilteredModel.reccuringInvoice_list.add(RecurringInvoice_List.fromJson(value.data[i]));
    }
  }

  void addTo_ApprovalQueue_InvoiceList(CMDlResponse value) {
    subscriptionModel.ApprovalQueue_list.clear();
    subscriptionfilteredModel.ApprovalQueue_list.clear();
    for (int i = 0; i < value.data.length; i++) {
      subscriptionModel.ApprovalQueue_list.add(ApprovalQueueInvoice_List.fromJson(value.data[i]));
      subscriptionfilteredModel.ApprovalQueue_list.add(ApprovalQueueInvoice_List.fromJson(value.data[i]));
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

// Function to search custom PDFs
  /// This function searches for custom PDFs in the subscription model based on the provided query.
  /// It filters the customPdfList based on the query and updates the customPdfList in the subscription model.
  void search_CustomPDF(String query) {
    // salesModel.searchQuery.value = query;

    if (query.isEmpty) {
      subscriptionModel.customPdfList.assignAll(subscriptionfilteredModel.customPdfList);
    } else {
      var filteredList = subscriptionfilteredModel.customPdfList.where((process) =>
          process.customerAddressName.toLowerCase().contains(query.toLowerCase()) ||
          process.customerAddress.toLowerCase().contains(query.toLowerCase()) ||
          process.genId.toLowerCase().contains(query.toLowerCase()));

      subscriptionModel.customPdfList.assignAll(filteredList);
    }
  }

// Function to toggle email visibility
  /// This function toggles the visibility of the CC email field in the subscription model.
  /// It sets the CCemailToggle property to the provided value.
  void toggleCCemailvisibility(bool value) {
    subscriptionModel.CCemailToggle.value = value;
  }

// Function to filter packages based on the query
  /// This function filters the global package list based on the provided query.
  /// It updates the isSearchingPackages status and the filteredPackages list in the subscription model.
  /// If the query is empty, it resets the filteredPackages list and sets isSearchingPackages to false.
  void filterPackages(String query) {
    if (query.isEmpty) {
      subscriptionModel.isSearchingPackages.value = false;
      subscriptionModel.filteredPackages.clear();
      return;
    }

    subscriptionModel.isSearchingPackages.value = true;
    subscriptionModel.filteredPackages.value =
        subscriptionModel.GlobalPackage.value.globalPackageList.where((package) => package.subscriptionName?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();
  }

// Function to reset package data
  /// This function resets the package data in the subscription model.
  /// It clears the values of various controllers related to package data, such as package name, amount, devices, cameras, and description.
  void reset_packageData() {
    subscriptionModel.packagenameController.value.clear();
    subscriptionModel.packageamountController.value.clear();
    subscriptionModel.packagedevicesController.value.clear();
    subscriptionModel.packagecamerasController.value.clear();
    subscriptionModel.packageadditionalcamerasController.value.clear();
    subscriptionModel.packagedescController.value.clear();
  }

// Function to reset the subscription data
  /// This function resets the subscription data in the subscription model.
  /// It clears various lists and values related to subscriptions, such as recurring invoices, customer lists, process lists, and selected indices.
  /// It also resets the profile page visibility, search query, subscription data, and client profile data.
  void resetData() {
    subscriptionModel.reccuringInvoice_list.clear();
    subscriptionModel.recurredcustomerList.clear();
    subscriptionModel.processcustomerList.clear();
    subscriptionModel.companyList.value = CompanyResponse(companyList: []);
    subscriptionModel.GlobalPackage.value = Global_package(globalPackageList: []);
    subscriptionModel.processList.clear();
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
    subscriptionModel.customPdfList.clear();
    subscriptionModel.reccuringInvoice_list.clear();
    subscriptionModel.whatsapp_selectionStatus.value = true;
    subscriptionModel.gmail_selectionStatus.value = true;
    subscriptionModel.phoneController.value.clear();
    subscriptionModel.emailController.value.clear();
    subscriptionModel.CCemailController.value.clear();
    subscriptionModel.feedbackController.value.clear();
    subscriptionModel.CCemailToggle.value = false;

    // GLOBALPAGE VARIABLES
    subscriptionModel.packageselectedID.value = null;
    subscriptionModel.packageisEditing.value = false;
    subscriptionModel.editingPackage.value = null;
    subscriptionModel.packagesubscriptionID.value = null;
    subscriptionModel.packagecamerasController.value.clear();
    subscriptionModel.packageadditionalcamerasController.value.clear();
    subscriptionModel.packagedescController.value.clear();
    subscriptionModel.packagenameController.value.clear();
    subscriptionModel.packagedevicesController.value.clear();
    subscriptionModel.packageamountController.value.clear();
    subscriptionModel.selectedPackagessubscriptionID.clear();
    subscriptionModel.editpackagesubscriptionID.value = null;
    subscriptionModel.editpackagecamerasController.value.clear();
    subscriptionModel.editpackageadditionalcamerasController.value.clear();
    subscriptionModel.editpackagedescController.value.clear();
    subscriptionModel.editpackagenameController.value.clear();
    subscriptionModel.editpackagedevicesController.value.clear();
    subscriptionModel.editpackageamountController.value.clear();
  }
}
