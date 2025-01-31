import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/product_entities.dart';
import '../entities/RFQ_entities.dart';

class RFQModel {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var RFQ_client_addr_name = "".obs;
  var RFQ_client_addr = "".obs;
  var RFQ_bill_addr_name = "".obs;
  var RFQ_bill_addr = "".obs;
  var RFQ_no = "".obs;
  var RFQ_title = "".obs;
  var RFQ_table_heading = "".obs;
  var RFQ_noteList = <Note>[].obs;
  var RFQ_recommendationList = <Recommendation>[].obs;
  var RFQ_products = <RFQProduct>[].obs;
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
