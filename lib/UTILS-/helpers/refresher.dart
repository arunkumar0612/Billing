import 'package:flutter/material.dart';

import '../../3.SUBSCRIPTION/services/subscription_service.dart';
import '../../4.SALES/services/sales_service.dart';

class Refresher with SalesServices, SubscriptionServices {
  static final Refresher _instance = Refresher._internal();
  factory Refresher() => _instance;
  Refresher._internal();

  Future<void> refreshAll(BuildContext context) async {
    await sales_refresh(context);
    await subscription_refresh(context);
  }
}
