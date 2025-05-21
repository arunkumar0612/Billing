import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';

class Account_LedgerModel extends GetxController with GetSingleTickerProviderStateMixin {
  var account_Ledger_list = AccountLedgerSummary(
    balanceAmount: 0.0,
    creditAmount: 0.0,
    debitAmount: 0.0,
    ledgerList: [],
  ).obs;
  var filteredAccount_Ledgers = AccountLedgerSummary(
    balanceAmount: 0.0,
    creditAmount: 0.0,
    debitAmount: 0.0,
    ledgerList: [],
  ).obs;

  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final CCemailController = TextEditingController().obs;
  var feedbackController = TextEditingController().obs;
  // var filePathController = TextEditingController().obs;
  var CCemailToggle = false.obs;
}
