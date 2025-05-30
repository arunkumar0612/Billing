import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/TDS_ledger_entities.dart';

class TDS_LedgerModel extends GetxController with GetSingleTickerProviderStateMixin {
  var tds_Ledger_list = TDSSummaryModel(
    tdsList: [],
    totalTds: 0,
    totalPaid: 0,
    netTdsBalance: 0,
    totalReceivables: 0,
    totalPayables: 0,
    netTds: 0,
    startdate: null,
    enddate: null,
  ).obs;
  var ParentTDS_Ledgers = TDSSummaryModel(
    tdsList: [],
    totalTds: 0,
    totalPaid: 0,
    netTdsBalance: 0,
    totalReceivables: 0,
    totalPayables: 0,
    netTds: 0,
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
  var selectedTDStype = 'Show All'.obs;
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

  Rx<TDSLedgerSelectedFilter> tds_LedgerSelectedFilter = TDSLedgerSelectedFilter(
          TDStype: 'Show All',
          invoicetype: 'Show All',
          selectedsalescustomername: 'None',
          selectedcustomerid: '',
          selectedsubscriptioncustomername: 'None',
          fromdate: '',
          todate: '',
          selectedmonth: 'None')
      .obs;
}
