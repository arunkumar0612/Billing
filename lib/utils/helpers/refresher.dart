import 'package:flutter/material.dart';
import 'package:ssipl_billing/services/SALES/sales_service.dart';
import 'package:ssipl_billing/services/SUBSCRIPTION/subscription_service.dart';

class Refresher extends StatefulWidget with SalesServices, SubscriptionServices {
  Refresher({super.key});

  @override
  State<Refresher> createState() => _RefresherState();
}

class _RefresherState extends State<Refresher> {
  void executer(context) {
    widget.sales_refresh(context);
    widget.subscription_refresh(context);
  }

  @override
  void initState() {
    super.initState();
    executer(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
