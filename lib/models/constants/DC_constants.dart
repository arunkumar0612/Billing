import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/product_entities.dart';

import '../entities/DC_entities.dart';

class DCModel {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var Delivery_challan_client_addr_name = "".obs;
  var Delivery_challan_client_addr = "".obs;
  var Delivery_challan_bill_addr_name = "".obs;
  var Delivery_challan_bill_addr = "".obs;
  var Delivery_challan_no = "".obs;
  var Delivery_challan_title = "".obs;
  var Delivery_challan_table_heading = "".obs;
  var Delivery_challan_noteList = <Map<String, dynamic>>[].obs;
  var Delivery_challan_recommendationList = <Recommendation>[].obs;
  var Delivery_challan_productDetails = <Map<String, dynamic>>[].obs;
  var Delivery_challan_products = <Product>[].obs;
//######################################################################################################################################
  final TitleController = TextEditingController().obs;
  final clientAddressNameController = TextEditingController().obs;
  final clientAddressController = TextEditingController().obs;
  final billingAddressNameController = TextEditingController().obs;
  final billingAddressController = TextEditingController().obs;
  final formKey1 = GlobalKey<FormState>().obs;
//######################################################################################################################################
  final editIndex1 = Rxn<int>();
  final productKey = GlobalKey<FormState>().obs;
  final productNameController = TextEditingController().obs;
  final hsnController = TextEditingController().obs;
  final priceController = TextEditingController().obs;
  final quantityController = TextEditingController().obs;
  final gstController = TextEditingController().obs;
//######################################################################################################################################
  final noteformKey = GlobalKey<FormState>().obs;
  var notelength = 0.obs;
  var notetablelength = 0.obs;
  var noteeditIndex = Rxn<int>();
  var notetable_editIndex = Rxn<int>();
  final notecontentController = TextEditingController().obs;
  final tableHeadingController = TextEditingController().obs;
  final tableKeyController = TextEditingController().obs;
  final tableValueController = TextEditingController().obs;
  var selectedheadingType = Rxn<String>();
  final notecontent = <String>[
    'Delivery within 30 working days from the date of issuing the PO.',
    'Payment terms : 100% along with PO.',
    'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
  ].obs;
  final noteType = [
    'With Heading',
    'Without Heading',
  ].obs;
}
