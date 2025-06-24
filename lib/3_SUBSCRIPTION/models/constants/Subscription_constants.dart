import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/Subscription_entities.dart';

/// This model class is used to manage the state of the subscription-related data
/// It extends GetxController to leverage the reactive state management features of the GetX package
class SubscriptionModel extends GetxController with GetSingleTickerProviderStateMixin {
  var processcustomerList = <Processcustomer>[].obs;
  var recurredcustomerList = <Recurredcustomer>[].obs;
  var ApprovalQueue_customerList = <ApprovalQueue_customer>[].obs;
  var companyList = CompanyResponse(companyList: []).obs;
  var GlobalPackage = Global_package(globalPackageList: []).obs;
  var processList = <Process>[].obs;
  final showcustomerprocess = Rxn<int>();
  final customerId = Rxn<int>();
  final pdfFile = Rxn<File>();
  final custom_pdfFile = Rxn<File>();
  // final pdfFile = Rxn<File>();
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
  var ApprovalQueue_list = <ApprovalQueueInvoice_List>[].obs;

  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final CCemailController = TextEditingController().obs;
  var feedbackController = TextEditingController().obs;
  // var filePathController = TextEditingController().obs;
  var CCemailToggle = false.obs;

  //  GLOBALPAGE VARIABLES
  // In your SubscriptionController or relevant controller
  final packageSearchController = TextEditingController().obs;
  final isSearchingPackages = false.obs;
  final filteredPackages = <Global_packageList>[].obs;
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
