import 'package:get/get.dart';

import 'package:ssipl_billing/models/constants/SUBSCRIPTION_constants/Subscription_constants.dart';

class SubscriptionController extends GetxController {
  var subscriptionModel = SubscriptionModel();
  var subscriptionfilteredModel = SubscriptionModel();
  void updatesalesperiod(String value) {
    subscriptionModel.subscriptionperiod.value = value;
  }
}
//  customername.replaceAll(RegExp(r'[^A-Z]'), '').length>=2?customername.replaceAll(RegExp(r'[^A-Z]'), '').substring(0, 2):customername.replaceAll(RegExp(r'[^A-Z]'), '').length==1?customername.replaceAll(RegExp(r'[^A-Z]'), ''):customername.isNotEmpty?customername[0].toUpperCase():"?",
