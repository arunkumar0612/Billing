import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/constants/Billing_constants.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';

class MainBilling_Controller extends GetxController {
  var billingModel = BillingModel();
  void addto_SubscriptionInvoiceList(SubscriptionInvoice element) {
    billingModel.subscriptionInvoiceList.add(element);
  }

  void addto_SalesInvoiceList(SalesInvoice element) {
    billingModel.salesInvoiceList.add(element);
  }

    

}
