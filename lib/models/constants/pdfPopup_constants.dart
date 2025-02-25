import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/PDFpopup_entities.dart';
import 'package:ssipl_billing/models/entities/SALES/product_entities.dart';

class PDFpopupModel {
  final date = TextEditingController().obs;
  final invoiceNo = TextEditingController().obs;
  final clientName = TextEditingController().obs;
  final clientAddressName = TextEditingController().obs;
  final billingName = TextEditingController().obs;
  final billingAddressName = TextEditingController().obs;

  final subTotal = TextEditingController().obs;
  final CGST = TextEditingController().obs;
  final SGST = TextEditingController().obs;
  final roundOff = TextEditingController().obs;
  final Total = TextEditingController().obs;
  var roundoffDiff = Rxn<String>();
  var Invoice_products = <InvoiceProduct>[].obs;
  var products = <ManualProduct>[
    ManualProduct(sNo: "1", description: "Laptop", hsn: "8471", gst: "18", price: "1000", quantity: "2", total: "2000"),
    ManualProduct(sNo: "2", description: "Mouse", hsn: "8472", gst: "18", price: "50", quantity: "5", total: "250"),
  ].obs;
  final notecontent = <String>[
    // 'Delivery within 30 working days from the date of issuing the PO.',
    // 'Payment terms : 100% along with PO.',
    // 'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
  ].obs;

  var checkboxValues = <bool>[].obs;
  var textControllers = <List<TextEditingController>>[].obs;

  var noteControllers = <TextEditingController>[].obs;
}
