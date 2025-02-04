import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/product_entities.dart';
import '../entities/Credit_entities.dart';

class CreditModel {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var Credit_no = "".obs;
  var Credit_table_heading = "".obs;
//######################################################################################################################################
//DETAILS
  final clientAddressNameController = TextEditingController().obs;
  final clientAddressController = TextEditingController().obs;
  final billingAddressNameController = TextEditingController().obs;
  final billingAddressController = TextEditingController().obs;
  final detailsKey = GlobalKey<FormState>().obs;
//######################################################################################################################################
//PRODUCTS
  final productKey = GlobalKey<FormState>().obs;
  final product_editIndex = Rxn<int>();
  final productNameController = TextEditingController().obs;
  final hsnController = TextEditingController().obs;
  final priceController = TextEditingController().obs;
  final quantityController = TextEditingController().obs;
  final remarksController = TextEditingController().obs;
  final gstController = TextEditingController().obs;
  var Credit_products = <CreditProduct>[].obs;
  var Credit_gstTotals = <CreditGSTtotals>[].obs;
//######################################################################################################################################
//NOTES
  final noteformKey = GlobalKey<FormState>().obs;
  var note_editIndex = Rxn<int>();
  final notecontentController = TextEditingController().obs;
  var recommendation_editIndex = Rxn<int>();
  final recommendationHeadingController = TextEditingController().obs;
  final recommendationKeyController = TextEditingController().obs;
  final recommendationValueController = TextEditingController().obs;
  var Credit_noteList = <Note>[].obs;
  var Credit_recommendationList = <Recommendation>[].obs;
  final notecontent = <String>[
    'Delivery within 30 working days from the date of issuing the PO.',
    'Payment terms : 100% along with PO.',
    'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
  ].obs;
}
