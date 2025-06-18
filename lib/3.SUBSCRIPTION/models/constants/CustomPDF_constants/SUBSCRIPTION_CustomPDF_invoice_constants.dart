import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../entities/CustomPDF_entities/CustomPDF_invoice_entities.dart';

class SUBSCRIPTION_CustomPDF_InvoiceModel {
  final date = TextEditingController().obs;
  final manualinvoiceNo = TextEditingController().obs;
  final billingName = TextEditingController().obs;
  final billingAddress = TextEditingController().obs;
  final installation_serviceName = TextEditingController().obs;
  final installation_serviceAddres = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final Email = TextEditingController().obs;
  final feedback = TextEditingController().obs;
  final filePathController = TextEditingController().obs;
  final subTotal = TextEditingController().obs;
  final CGST = TextEditingController().obs;
  final SGST = TextEditingController().obs;
  final IGST = TextEditingController().obs;
  final roundOff = TextEditingController().obs;
  final Total = TextEditingController().obs;
  final CCemailController = TextEditingController().obs;
  var noteControllers = <TextEditingController>[].obs;
  final planname = TextEditingController().obs;
  final customertype = TextEditingController().obs;
  final plancharges = TextEditingController().obs;
  final internetcharges = TextEditingController().obs;
  final billperiod = TextEditingController().obs;
  // final billdate = TextEditingController().obs;
  final duedate = TextEditingController().obs;
  final relationshipID = TextEditingController().obs;
  // final billnumber = TextEditingController().obs;
  final customerGSTIN = TextEditingController().obs;
  final customerPO = TextEditingController().obs;
  final HSNcode = TextEditingController().obs;
  final contactperson = TextEditingController().obs;
  final contactnumber = TextEditingController().obs;
  final previousdues = TextEditingController().obs;
  final payment = TextEditingController().obs;
  final adjustments_deduction = TextEditingController().obs;
  var ispendingamount = false.obs;
  final totaldueamount = TextEditingController().obs;
  var roundoffDiff = Rxn<String>();
  var textControllers = <List<TextEditingController>>[].obs;
  // var manualInvoice_gstTotals = <SUBSCRIPTION_invoiceInvoiceGSTtotals>[].obs;
  var manualInvoicesites = <Site>[].obs;

  final notecontent = <String>[].obs;
  var progress = 0.0.obs;
  var checkboxValues = <bool>[].obs;
  var ispdfLoading = false.obs;
  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  var isLoading = false.obs;
  var CCemailToggle = false.obs;
  var isGST_local = true.obs;

  var genearatedPDF = Rxn<File>();
  late AnimationController animationController;
  late Animation<double> animation;
  final allData_key = GlobalKey<FormState>().obs;
}
