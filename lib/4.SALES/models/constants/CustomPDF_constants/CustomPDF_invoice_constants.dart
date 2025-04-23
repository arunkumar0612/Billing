import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4.SALES/models/entities/CustomPDF_entities/CustomPDF_Product_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Invoice_entities.dart';

class CustomPDF_InvoiceModel {
  final date = TextEditingController().obs;
  final manualinvoiceNo = TextEditingController().obs;
  final clientName = TextEditingController().obs;
  final clientAddress = TextEditingController().obs;
  final billingName = TextEditingController().obs;
  final billingAddres = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final Email = TextEditingController().obs;
  final GSTnumber = TextEditingController().obs;
  final feedback = TextEditingController().obs;
  final filePathController = TextEditingController().obs;
  final subTotal = TextEditingController().obs;
  final CGST = TextEditingController().obs;
  final SGST = TextEditingController().obs;
  final IGST = TextEditingController().obs;
  final roundOff = TextEditingController().obs;
  final Total = TextEditingController().obs;
  var Total_amount = 0.0.obs;
  final CCemailController = TextEditingController().obs;
  var noteControllers = <TextEditingController>[].obs;

  var roundoffDiff = Rxn<String>();
  var textControllers = <List<TextEditingController>>[].obs;
  var manualInvoice_gstTotals = <InvoiceGSTtotals>[].obs;
  var manualInvoiceproducts = <CustomPDF_InvoiceProduct>[
    CustomPDF_InvoiceProduct(
        sNo: "1",
        description: "Laptop",
        hsn: "8471",
        gst: "18",
        price: "1000",
        quantity: "2",
        total: "2000"),
    CustomPDF_InvoiceProduct(
        sNo: "2",
        description: "Mouse",
        hsn: "8472",
        gst: "18",
        price: "50",
        quantity: "5",
        total: "250"),
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
  var isGST_local = true.obs;
}
