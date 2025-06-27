import 'dart:io';

import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Vouchers/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/2_BILLING/_main_BILLING/models/constants/Billing_constants.dart';
import 'package:ssipl_billing/2_BILLING/_main_BILLING/models/entities/Billing_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class MainBilling_Controller extends GetxController {
  var billingModel = BillingModel();
  // var subscriptionFilteredModel = BillingModel().subscriptionInvoiceList;
  var salesFilteredModel = BillingModel().salesInvoiceList;
  var vendorFilteredModel = BillingModel().vendorInvoiceList;

  void addto_SubscriptionInvoiceList(SubscriptionInvoice element) {
    billingModel.subscriptionInvoiceList.add(element);
    billingModel.allSubscriptionInvoices.add(element);
  }

  void addto_SalesInvoiceList(SalesInvoice element) {
    billingModel.salesInvoiceList.add(element);
    billingModel.allSalesInvoices.add(element);
    // print('object');
  }

  void addto_VenorInvoiceList(SubscriptionInvoice element) {
    billingModel.subscriptionInvoiceList.add(element);
    billingModel.allSubscriptionInvoices.add(element);
  }

  void setActiveTab(String tabName) {
    billingModel.activeTab.value = tabName;
    billingModel.searchQuery.value = '';
    search('');
  }

  void set_dashBoardData(DashboardStats value) {
    billingModel.dashBoard_data.value = value;
  }

  void update_dashBoardtype(String type) {
    billingModel.type.value = type;
  }

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

  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

  Future<void> updatePDFfile(File value) async {
    billingModel.pdfFile.value = value;
  }
}
