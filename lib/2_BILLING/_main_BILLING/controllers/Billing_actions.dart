import 'dart:io';

import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Vouchers/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/2_BILLING/_main_BILLING/models/constants/Billing_constants.dart';
import 'package:ssipl_billing/2_BILLING/_main_BILLING/models/entities/Billing_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

/// Controller for managing billing-related data and actions within the main billing module.
class MainBilling_Controller extends GetxController {
  /// The main billing model that holds all data and states.
  var billingModel = BillingModel();

  /// Reference to the list of filtered sales invoices.
  /// This list is updated based on the active search query and selected tab.
  var salesFilteredModel = BillingModel().salesInvoiceList;

  /// Adds a [SubscriptionInvoice] to both the filtered and complete subscription invoice lists.
  ///
  /// This is used to maintain consistency between visible and all data.
  void addto_SubscriptionInvoiceList(SubscriptionInvoice element) {
    billingModel.subscriptionInvoiceList.add(element);
    billingModel.allSubscriptionInvoices.add(element);
  }

  /// Adds a [SalesInvoice] to both the filtered and complete sales invoice lists.
  ///
  /// This ensures that sales data remains available in both filtered and full lists.
  void addto_SalesInvoiceList(SalesInvoice element) {
    billingModel.salesInvoiceList.add(element);
    billingModel.allSalesInvoices.add(element);
  }

  /// Adds a vendor [SubscriptionInvoice] entry.
  ///
  /// Functionally same as subscription but marked for vendor-specific usage.
  void addto_VenorInvoiceList(SubscriptionInvoice element) {
    billingModel.subscriptionInvoiceList.add(element);
    billingModel.allSubscriptionInvoices.add(element);
  }

  /// Sets the active tab in the billing dashboard and resets the search query.
  ///
  /// [tabName] can be `'Subscription'`, `'Sales'`, or `'Vendor'`.
  void setActiveTab(String tabName) {
    billingModel.activeTab.value = tabName;
    billingModel.searchQuery.value = '';
    search('');
  }

  /// Sets the overall dashboard statistics using a [DashboardStats] object.
  ///
  /// Used for updating total invoices, amounts, and summary data.
  void set_dashBoardData(DashboardStats value) {
    billingModel.dashBoard_data.value = value;
  }

  /// Updates the billing type shown on the dashboard (e.g., `'All'`, `'Paid'`, `'Unpaid'`).
  void update_dashBoardtype(String type) {
    billingModel.type.value = type;
  }

  /// Filters invoice lists based on the [query] string and the currently active tab.
  ///
  /// Supports filtering by client name, invoice number, and voucher number
  /// for both Subscription, Sales, and Vendor tabs.
  void search(String query) {
    billingModel.searchQuery.value = query;

    if (query.isEmpty) {
      if (billingModel.activeTab.value == 'Subscription') {
        billingModel.subscriptionInvoiceList.assignAll(billingModel.allSubscriptionInvoices);
      } else if (billingModel.activeTab.value == 'Sales') {
        billingModel.salesInvoiceList.assignAll(billingModel.allSalesInvoices);
      } else if (billingModel.activeTab.value == 'Vendor') {
        billingModel.subscriptionInvoiceList.assignAll(billingModel.allSubscriptionInvoices);
      }
      return;
    }

    if (billingModel.activeTab.value == 'Subscription') {
      var filtered = billingModel.allSubscriptionInvoices.where((item) =>
          item.clientAddressName.toLowerCase().contains(query.toLowerCase()) ||
          item.invoiceNo.toLowerCase().contains(query.toLowerCase()) ||
          item.voucher_number.toLowerCase().contains(query.toLowerCase()));
      billingModel.subscriptionInvoiceList.assignAll(filtered);
    }

    if (billingModel.activeTab.value == 'Sales') {
      var filtered =
          billingModel.allSalesInvoices.where((item) => item.clientAddressName.toLowerCase().contains(query.toLowerCase()) || item.invoiceNumber.toLowerCase().contains(query.toLowerCase()));
      billingModel.salesInvoiceList.assignAll(filtered);
    }

    if (billingModel.activeTab.value == 'Vendor') {
      var filtered = billingModel.allSubscriptionInvoices.where((item) =>
          item.clientAddressName.toLowerCase().contains(query.toLowerCase()) ||
          item.invoiceNo.toLowerCase().contains(query.toLowerCase()) ||
          item.voucher_number.toLowerCase().contains(query.toLowerCase()));
      billingModel.subscriptionInvoiceList.assignAll(filtered);
    }
  }

  /// Fetches PDF data from the [CMDmResponse] and updates the model.
  ///
  /// This is an asynchronous method that:
  /// - Converts response to a PDF data model.
  /// - Extracts binary file data.
  /// - Calls [updatePDFfile] to update the file in the model.
  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

  /// Updates the observable PDF file object in the billing model with [value].
  ///
  /// Used after retrieving or generating a file.
  Future<void> updatePDFfile(File value) async {
    billingModel.pdfFile.value = value;
  }
}
