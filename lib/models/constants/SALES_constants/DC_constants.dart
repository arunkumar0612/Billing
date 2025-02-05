import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/SALES/product_entities.dart';
import '../../entities/SALES/DC_entities.dart';

class DCModel {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var Delivery_challan_products = <DCProduct>[].obs;
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
  final quantityController = TextEditingController().obs;
//######################################################################################################################################
//NOTES
  final noteformKey = GlobalKey<FormState>().obs;
  var Delivery_challan_no = "".obs;
  var Delivery_challan_table_heading = "".obs;
  var Delivery_challan_noteList = <Note>[].obs;
  var Delivery_challan_recommendationList = <Recommendation>[].obs;
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
