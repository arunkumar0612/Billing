import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/product_entities.dart';
import '../entities/Credit_entities.dart';

class CreditModel {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var Credit_client_addr_name = "".obs;
  var Credit_client_addr = "".obs;
  var Credit_bill_addr_name = "".obs;
  var Credit_bill_addr = "".obs;
  var Credit_no = "".obs;
  var Credit_title = "".obs;
  var Credit_table_heading = "".obs;
  var Credit_noteList = <Note>[].obs;
  var Credit_recommendationList = <Recommendation>[].obs;
  var Credit_products = <CreditProduct>[].obs;
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
