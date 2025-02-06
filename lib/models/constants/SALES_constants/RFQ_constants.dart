import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/SALES/product_entities.dart';
import '../../entities/SALES/RFQ_entities.dart';

class RFQModel {
  final Rxn<TabController> tabController = Rxn<TabController>();

  var RFQ_no = "".obs;

//######################################################################################################################################
//DETAILS
  final vendor_address_controller = TextEditingController().obs;
  final vendor_phone_controller = TextEditingController().obs;
  final vendor_email_controller = TextEditingController().obs;
  var vendor_name_controller = TextEditingController().obs;
  final detailsKey = GlobalKey<FormState>().obs;
//######################################################################################################################################
//PRODUCTS
  final productKey = GlobalKey<FormState>().obs;
  final product_editIndex = Rxn<int>();
  final productNameController = TextEditingController().obs;
  final quantityController = TextEditingController().obs;
  var RFQ_products = <RFQProduct>[].obs;
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
  var RFQ_table_heading = "".obs;
  var RFQ_noteList = <Note>[].obs;
  var RFQ_recommendationList = <Recommendation>[].obs;
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
