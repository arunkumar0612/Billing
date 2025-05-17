import 'package:get/get.dart';

import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';

class GST_LedgerModel extends GetxController with GetSingleTickerProviderStateMixin {
  var gst_Ledger_list = <AccountLedger>[].obs;
  var filteredGST_Ledgers = <AccountLedger>[].obs;

  @override
  void onInit() {
    super.onInit();
  }
}
