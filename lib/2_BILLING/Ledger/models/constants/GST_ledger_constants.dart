import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/models/entities/GST_ledger_entities.dart';

class GST_LedgerModel extends GetxController with GetSingleTickerProviderStateMixin {
  var gst_Ledger_list = GSTSummaryModel(
    gstList: [],
    inputGst: 0.0,
    outputGst: 0.0,
    totalGst: 0.0,
    startdate: null,
    enddate: null,
  ).obs;
  var ParentGST_Ledgers = GSTSummaryModel(
    gstList: [],
    inputGst: 0.0,
    outputGst: 0.0,
    totalGst: 0.0,
    startdate: null,
    enddate: null,
  ).obs;

  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final CCemailController = TextEditingController().obs;
  var feedbackController = TextEditingController().obs;
  // var filePathController = TextEditingController().obs;
  var CCemailToggle = false.obs;

  var selectedGSTtype = 'Consolidate'.obs;
  var selectedPlantype = 'Show All'.obs;
  var selectedInvoiceType = 'Show All'.obs;
  RxString selectedMonth = 'None'.obs;
  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;
  RxString selectedsalescustomer = 'None'.obs;
  // RxString selectedsalescustomerID = ''.obs;
  RxString selectedsubcustomer = 'None'.obs;
  RxString selectedcustomerID = ''.obs;
  var paymenttypeList = [
    'Show All',
    'Debit',
    'Credit',
  ].obs;

  Rx<GSTLedgerSelectedFilter> gst_LedgerSelectedFilter = GSTLedgerSelectedFilter(
          GSTtype: 'Consolidate',
          invoicetype: 'Show All',
          selectedsalescustomername: 'None',
          selectedcustomerid: '',
          selectedsubscriptioncustomername: 'None',
          fromdate: '',
          todate: '',
          selectedmonth: 'None')
      .obs;
}
