import 'package:ssipl_billing/2.BILLING/Vouchers/services/voucher_service.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/services/subscription_service.dart';
import 'package:ssipl_billing/4.SALES/services/sales_service.dart';

class Refresher with SalesServices, SubscriptionServices, VoucherService {
  static final Refresher _instance = Refresher._internal();
  factory Refresher() => _instance;
  Refresher._internal();

  Future<void> refreshAll() async {
    await voucher_refresh();
    await sales_refresh();
    await subscription_refresh();
  }
}
