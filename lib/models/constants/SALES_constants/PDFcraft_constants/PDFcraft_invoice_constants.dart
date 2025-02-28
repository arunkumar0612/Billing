import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/SALES/PDFcraft_entities/PDFcraft_Product_entities.dart';
import 'package:ssipl_billing/models/entities/SALES/Invoice_entities.dart';

class PDFcraft_InvoiceModel {
  final date = TextEditingController().obs;
  final manualinvoiceNo = TextEditingController().obs;
  final clientName = TextEditingController().obs;
  final clientAddress = TextEditingController().obs;
  final billingName = TextEditingController().obs;
  final billingAddres = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final Email = TextEditingController().obs;
  final feedback = TextEditingController().obs;
  final filePathController = TextEditingController().obs;

  final subTotal = TextEditingController().obs;
  final CGST = TextEditingController().obs;
  final SGST = TextEditingController().obs;
  final roundOff = TextEditingController().obs;
  final Total = TextEditingController().obs;
  var roundoffDiff = Rxn<String>();
  var manualInvoice_gstTotals = <InvoiceGSTtotals>[].obs;
  var manualInvoiceproducts = <PDFcraft_InvoiceProduct>[
    PDFcraft_InvoiceProduct(sNo: "1", description: "Laptop", hsn: "8471", gst: "18", price: "1000", quantity: "2", total: "2000"),
    PDFcraft_InvoiceProduct(sNo: "2", description: "Mouse", hsn: "8472", gst: "18", price: "50", quantity: "5", total: "250"),
  ].obs;
  final notecontent = <String>[].obs;
  var ispdfLoading = false.obs;
  var checkboxValues = <bool>[].obs;
  var textControllers = <List<TextEditingController>>[].obs;
  var genearatedPDF = Rxn<File>();

  var noteControllers = <TextEditingController>[].obs;

  late AnimationController animationController;
  late Animation<double> animation;
  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  final CCemailController = TextEditingController().obs;
  var progress = 0.0.obs;
  var isLoading = false.obs;
  var CCemailToggle = false.obs;
  final allData_key = GlobalKey<FormState>().obs;
}
