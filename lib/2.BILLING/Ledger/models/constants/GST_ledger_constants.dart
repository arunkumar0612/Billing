import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/GST_ledger_entities.dart';

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
}
