import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/view_ledger_entities.dart';

class View_LedgerModel extends GetxController with GetSingleTickerProviderStateMixin {
  // Filter related variables

  var selectedinvoiceType = 'Show All'.obs;
  var selectedGSTLedgerType = 'Consolidate'.obs;
  var selectedtransactiontype = 'Show All'.obs;
  var selectedPaymenttype = 'Show All'.obs;
  // var selectedInvoiceType = 'Show All'.obs;
  RxBool showGSTsummary = true.obs;
  // var showCustomDateRange = false.obs;
  // final dateController = TextEditingController().obs;
  // Add to your View_LedgerModel class
  RxString selectedMonth = 'None'.obs;
  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;
  final searchController = TextEditingController().obs;
  RxString selectedLedgerType = 'Account Ledger'.obs;
  RxList<String> ledgerTypeList = ['Account Ledger', 'GST Ledger', 'TDS Ledger'].obs;
  RxString selectedsalescustomer = 'None'.obs;
  RxString selectedsalescustomerID = ''.obs;
  RxString selectedsubcustomer = 'None'.obs;
  RxString selectedsubcustomerID = ''.obs;
  RxString selectedAccountLedgerType = ''.obs;
  var salesCustomerList = <CustomerInfo>[].obs;
  var subCustomerList = <CustomerInfo>[].obs;
}
