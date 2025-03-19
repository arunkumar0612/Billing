import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/SALES/Invoice_entities.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/CustomPDF_entities/CustomPDF_Product_entities.dart';

class Subscription_CustomPDF_InvoiceModel {
  final date = TextEditingController().obs;
  final manualinvoiceNo = TextEditingController().obs;
  final clientName = TextEditingController().obs;
  final clientAddress = TextEditingController().obs;
  final billingName = TextEditingController().obs;
  final billingAddres = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final Email = TextEditingController().obs;

  final planname = TextEditingController().obs;
  final customertype = TextEditingController().obs;
  final plancharges = TextEditingController().obs;
  final internetcharges = TextEditingController().obs;
  final billperiod = TextEditingController().obs;
  final billdate = TextEditingController().obs;
  final duedate = TextEditingController().obs;
  final relationshipID = TextEditingController().obs;
  final billnumber = TextEditingController().obs;
  final customerGSTIN = TextEditingController().obs;
  final HSNcode = TextEditingController().obs;
  final customerPO = TextEditingController().obs;
  final contactperson = TextEditingController().obs;
  final contactnumber = TextEditingController().obs;
  final feedback = TextEditingController().obs;
  final filePathController = TextEditingController().obs;
  final subTotal = TextEditingController().obs;
  final CGST = TextEditingController().obs;
  final SGST = TextEditingController().obs;
  final roundOff = TextEditingController().obs;
  final Total = TextEditingController().obs;
  final CCemailController = TextEditingController().obs;
  var noteControllers = <TextEditingController>[].obs;

  var roundoffDiff = Rxn<String>();
  var textControllers = <List<TextEditingController>>[].obs;
  var manualInvoice_gstTotals = <InvoiceGSTtotals>[].obs;
  var manualInvoicesubscription = <Subscription_CustomPDF_Invoice>[
    Subscription_CustomPDF_Invoice(sNo: "1", siteID: "1", sitename: "Site1", address: "Address1", monthlycharges: "1000"),
    Subscription_CustomPDF_Invoice(sNo: "2", siteID: "2", sitename: "Site2", address: "Address2", monthlycharges: "2000")
  ].obs;

  final notecontent = <String>[].obs;
  var progress = 0.0.obs;
  var checkboxValues = <bool>[].obs;
  var ispdfLoading = false.obs;
  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  var isLoading = false.obs;
  var CCemailToggle = false.obs;

  var genearatedPDF = Rxn<File>();
  late AnimationController animationController;
  late Animation<double> animation;
  final allData_key = GlobalKey<FormState>().obs;
}
