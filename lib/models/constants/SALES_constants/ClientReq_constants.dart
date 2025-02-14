import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:ssipl_billing/models/entities/SALES/ClientReq_entities.dart';

import '../../entities/SALES/product_entities.dart';

class ClientReqModel {
  var clientReqTableHeading = "".obs;
  var clientReqNo = '1'.obs;
  var Enq_ID = Rxn<String>();
  var MOR_uploadedPath = Rxn<String>();
//######################################################################################################################################
//DETAILS
  final Rxn<TabController> tabController = Rxn<TabController>();
  final Rx<File> selectedPdf = File('E://Client_requirement.pdf').obs;
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
  var customer_id = Rxn<int>();
  var selected_branchList = <int>[].obs;
//######################################################################################################################################
//PRODUCTS
  final productFormkey = GlobalKey<FormState>().obs;
  final productNameController = TextEditingController().obs;
  final quantityController = TextEditingController().obs;
  final product_editIndex = Rxn<int>();
  var clientReqProductDetails = <ClientreqProduct>[].obs;
//######################################################################################################################################
//NOTES
  final noteFormKey = GlobalKey<FormState>().obs;
  final noteContentController = TextEditingController().obs;
  final tableHeadingController = TextEditingController().obs;
  final tableKeyController = TextEditingController().obs;
  final tableValueController = TextEditingController().obs;
  final noteEditIndex = Rxn<int>();
  final noteTableEditIndex = Rxn<int>();
  var clientReqNoteList = <Note>[].obs;
  var clientReqRecommendationList = <Recommendation>[].obs;
  var noteLength = 0.obs;
  var noteTableLength = 0.obs;
  var selectedHeadingType = Rxn<String>();
  var noteContent = <String>[
    'Delivery within 30 working days from the date of issuing the PO.',
    'Payment terms: 100% along with PO.',
    'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
  ].obs;
}
