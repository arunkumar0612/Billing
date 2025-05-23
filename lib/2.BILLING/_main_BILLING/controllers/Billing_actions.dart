import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/constants/Billing_constants.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';

class MainBilling_Controller extends GetxController {
  var billingModel = BillingModel();
   var subscriptionFilteredModel = BillingModel().subscriptionInvoiceList;
   var salesFilteredModel=BillingModel().salesInvoiceList;
   var vendorFilteredModel=BillingModel().vendorInvoiceList;


  void addto_SubscriptionInvoiceList(SubscriptionInvoice element) {
    billingModel.subscriptionInvoiceList.add(element);
    billingModel.allSubscriptionInvoices.add(element);
  }

  void addto_SalesInvoiceList(SalesInvoice element) {
    billingModel.salesInvoiceList.add(element);
     billingModel.allSalesInvoices.add(element);
  }

  void addto_VenorInvoiceList(SubscriptionInvoice element) {
    billingModel.subscriptionInvoiceList.add(element);
     billingModel.allSubscriptionInvoices.add(element);
  }

  void setActiveTab(String tabName) {
    billingModel.activeTab.value=tabName;
    billingModel.searchQuery.value ='';
    search('');
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
      var filtered= billingModel.allSubscriptionInvoices.where((item) => 
        item.clientAddressName.toLowerCase().contains(query.toLowerCase()) ||
        item.invoiceNo.toLowerCase().contains(query.toLowerCase())
        );
        billingModel.subscriptionInvoiceList.assignAll(filtered);
  } 

  if (billingModel.activeTab.value == 'Sales') {
    var filtered = billingModel.allSalesInvoices.where((item) =>
      item.clientAddressName.toLowerCase().contains(query.toLowerCase()) ||
      item.invoiceNumber.toLowerCase().contains(query.toLowerCase()));
    billingModel.salesInvoiceList.assignAll(filtered);
  }

  if (billingModel.activeTab.value == 'Vendor') {
    var filtered = billingModel.allSubscriptionInvoices.where((item) =>
      item.clientAddressName.toLowerCase().contains(query.toLowerCase()) ||
      item.invoiceNo.toLowerCase().contains(query.toLowerCase()));
    billingModel.subscriptionInvoiceList.assignAll(filtered);
  }
} 
}
