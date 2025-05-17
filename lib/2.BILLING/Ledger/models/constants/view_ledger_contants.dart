import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  RxList<String> ledgerTypeList = ['Account Ledger', 'GST Ledger'].obs;
  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data

    // Sync RxString when controller changes (optional)

    // Sync controller when RxString changes
  }
}
