import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../entities/Process/SUBSCRIPTION_ClientReq_entities.dart';

class SUBSCRIPTION_ClientReqModel {
  var MOR_uploadedPath = Rxn<String>();
  var customerType = 'New'.obs;

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
  var CompanyID_Controller = Rxn<int>();
  var Companyname_Controller = Rxn<String>();
  var Branch_Controller = Rxn<String>();
  var pickedFile = Rxn<FilePickerResult>();
  var morFile = Rxn<File>();
  var organizationList = <Organization>[].obs;
  var CompanyList = <Company>[].obs;
  // var BranchFullList = <Branch>[].obs;
  // var BranchList_valueModel = <DropDownValueModel>[].obs;
  // var selected_branchList = <int>[].obs;
  // final cntMulti = MultiValueDropDownController().obs;
//######################################################################################################################################
//SITES
  final siteFormkey = GlobalKey<FormState>().obs;
  final siteNameController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final cameraquantityController = TextEditingController().obs;
  final site_editIndex = Rxn<int>();
  var clientReqSiteDetails = <SUBSCRIPTION_ClientreqSites>[].obs;
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
  var clientReqRecommendationList = <Recommendation>[].obs;
  var noteLength = 0.obs;
  var Rec_Length = 0.obs;
  var noteContent = <String>[
    'Delivery within 30 working days from the date of issuing the PO.',
    'Payment terms: 100% along with PO.',
    'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
  ].obs;
}
