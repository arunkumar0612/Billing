import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4.SALES/models/entities/ClientReq_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/product_entities.dart';

class ClientReqModel {
  var MOR_uploadedPath = Rxn<String>();
  var customer_id = 0.obs;
  final Rxn<TabController> tabController = Rxn<TabController>();
  final Rx<File> selectedPdf = File('E://Client_requirement.pdf').obs;
//######################################################################################################################################
//DETAILS
  final detailsformKey = GlobalKey<FormState>().obs;
  var clientNameController = TextEditingController().obs;
  var titleController = TextEditingController().obs;
  var clientAddressController = TextEditingController().obs;
  var billingAddressNameController = TextEditingController().obs;
  var billingAddressController = TextEditingController().obs;
  var morController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var gstController = TextEditingController().obs;
  var Org_Controller = Rxn<String>();
  var Company_Controller = Rxn<String>();
  var Branch_Controller = Rxn<String>();
  var pickedFile = Rxn<FilePickerResult>();
  var morFile = Rxn<File>();
  var organizationList = <Organization>[].obs;
  var CompanyList = <Company>[].obs;
  var BranchFullList = <Branch>[].obs;
  var BranchList_valueModel = <DropDownValueModel>[].obs;
  var selected_branchList = <int>[].obs;
  final cntMulti = MultiValueDropDownController().obs;
//######################################################################################################################################
//PRODUCTS
  var clientReq_productSuggestion = <ProductSuggestion>[].obs;
  final productFormkey = GlobalKey<FormState>().obs;
  final productNameController = TextEditingController().obs;
  final quantityController = TextEditingController().obs;
  final product_editIndex = Rxn<int>();
  var clientReqProductDetails = <ClientreqProduct>[].obs;
//######################################################################################################################################
//NOTES
  final noteFormKey = GlobalKey<FormState>().obs;
  final noteContentController = TextEditingController().obs;
  final Rec_HeadingController = TextEditingController().obs;
  final Rec_KeyController = TextEditingController().obs;
  final Rec_ValueController = TextEditingController().obs;
  final noteEditIndex = Rxn<int>();
  final Rec_EditIndex = Rxn<int>();
  var clientReqNoteList = [].obs;
  var clientReqRecommendationList = <ClientReq_recommendation>[].obs;
  var noteLength = 0.obs;
  var Rec_Length = 0.obs;
  var noteContent = <String>[
    'Delivery within 30 working days from the date of issuing the PO.',
    'Payment terms: 100% along with PO.',
    'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
  ].obs;
}
