import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';

class BillingModel extends GetxController with GetSingleTickerProviderStateMixin {
  var subscriptionInvoiceList = <SubscriptionInvoice>[].obs;
  var salesInvoiceList = <SalesInvoice>[].obs;
}
