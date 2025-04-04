import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/Subscription_entities.dart';

class SubscriptionModel extends GetxController with GetSingleTickerProviderStateMixin {
  var customerList = <Customer>[].obs;
  var processcustomerList = <Processcustomer>[].obs;
  var companyList = CompanyResponse(companyList: []).obs;
  var GloabalPackage = Global_package(globalPackageList: []).obs;
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
}
