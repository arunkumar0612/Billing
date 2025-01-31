import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/product_entities.dart';
import '../entities/Debit_entities.dart';

class DebitModel {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var Debit_client_addr_name = "".obs;
  var Debit_client_addr = "".obs;
  var Debit_bill_addr_name = "".obs;
  var Debit_bill_addr = "".obs;
  var Debit_no = "".obs;
  var Debit_title = "".obs;
  var Debit_table_heading = "".obs;
  var Debit_noteList = <Note>[].obs;
  var Debit_recommendationList = <Recommendation>[].obs;
  var Debit_products = <DebitProduct>[].obs;
//######################################################################################################################################
//DETAILS
  final TitleController = TextEditingController().obs;
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
  final gstController = TextEditingController().obs;
//######################################################################################################################################
//NOTES
  final noteformKey = GlobalKey<FormState>().obs;
  // var notelength = 0.obs;
  // var notetablelength = 0.obs;
  var note_editIndex = Rxn<int>();
  final notecontentController = TextEditingController().obs;
  var recommendation_editIndex = Rxn<int>();
  final recommendationHeadingController = TextEditingController().obs;
  final recommendationKeyController = TextEditingController().obs;
  final recommendationValueController = TextEditingController().obs;
  // var selectedheadingType = Rxn<String>();
  final notecontent = <String>[
    'Delivery within 30 working days from the date of issuing the PO.',
    'Payment terms : 100% along with PO.',
    'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
  ].obs;
  // final noteType = [
  //   'With Heading',
  //   'Without Heading',
  // ].obs;
}
