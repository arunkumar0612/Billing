import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/Subscription_entities.dart';

class SubscriptionModel extends GetxController with GetSingleTickerProviderStateMixin {
  var customerList = <Customer>[].obs;
  var processcustomerList = <Processcustomer>[].obs;
  var companyList = CompanyResponse(companyList: []).obs;
  var GlobalPackage = Global_package(globalPackageList: []).obs;
  var processList = <Process>[].obs;
  final showcustomerprocess = Rxn<int>();
  final customerId = Rxn<int>();
  final pdfFile = Rxn<File>();
  final selectedIndices = <int>[].obs;
  final RxBool isAllSelected = false.obs;
  final type = 0.obs;
  final RxBool isprofilepage = false.obs;
  // var searchQuery = ''.obs;
  var searchQuery = "".obs;
  Rxn<Subscriptiondata> subscriptiondata = Rxn<Subscriptiondata>(); // Nullable
  var subscriptionperiod = 'monthly'.obs;
  Rxn<Clientprofiledata> Clientprofile = Rxn<Clientprofiledata>(); // Nullable
  late AnimationController animationController;
  var customPdfList = <CustomerPDF_List>[].obs;
  var reccuringInvoice_list = <RecurringInvoice_List>[].obs;

  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final CCemailController = TextEditingController().obs;
  var feedbackController = TextEditingController().obs;
  // var filePathController = TextEditingController().obs;
  var CCemailToggle = false.obs;

  //  GLOBALPAGE VARIABLES
  var packageselectedID = RxnInt();
  var packageisEditing = false.obs;
  final editingPackage = Rx<dynamic>(null);
  var packagesubscriptionID = RxnInt();
  final packagecamerasController = TextEditingController().obs;
  final packageadditionalcamerasController = TextEditingController().obs;
  final packagedescController = TextEditingController().obs;
  final packagenameController = TextEditingController().obs;
  final packagedevicesController = TextEditingController().obs;
  final packageamountController = TextEditingController().obs;
  final selectedPackagessubscriptionID = <int>[].obs;
  RxnInt editpackagesubscriptionID = RxnInt();
  final editpackagecamerasController = TextEditingController().obs;
  final editpackageadditionalcamerasController = TextEditingController().obs;
  final editpackagedescController = TextEditingController().obs;
  final editpackagenameController = TextEditingController().obs;
  final editpackagedevicesController = TextEditingController().obs;
  final editpackageamountController = TextEditingController().obs;
}
