import 'package:get/get.dart';

import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';

class Account_LedgerModel extends GetxController with GetSingleTickerProviderStateMixin {
  var account_Ledger_list = <AccountLedger>[].obs;
  var filteredAccount_Ledgers = <AccountLedger>[].obs;

  @override
  void onInit() {
    super.onInit();
  }
}
