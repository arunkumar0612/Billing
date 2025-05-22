import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/view_ledger_entities.dart';

class View_LedgerModel extends GetxController with GetSingleTickerProviderStateMixin {
  // Filter related variables

  var selectedAccountLedgerType = 'Consolidate'.obs;
  var selectedGSTLedgerType = 'Consolidate'.obs;
  var selectedQuickFilter = 'Show All'.obs;
  var selectedInvoiceType = 'Show All'.obs;
  var showCustomDateRange = false.obs;
  final dateController = TextEditingController().obs;
  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;
  final searchController = TextEditingController().obs;
  RxString selectedLedgerType = 'Account Ledger'.obs;
  RxList<String> ledgerTypeList = ['Account Ledger', 'GST Ledger', 'TDS Ledger'].obs;

  var salesCustomerList = <CustomerInfo>[].obs;
  var subCustomerList = <CustomerInfo>[].obs;
}
