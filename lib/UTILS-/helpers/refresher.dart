import 'package:ssipl_billing/3.SUBSCRIPTION/services/subscription_service.dart';
import 'package:ssipl_billing/4.SALES/services/sales_service.dart';

class Refresher with SalesServices, SubscriptionServices {
  static final Refresher _instance = Refresher._internal();
  factory Refresher() => _instance;
  Refresher._internal();

  Future<void> refreshAll() async {
    await sales_refresh();
    await subscription_refresh();
  }
}
