import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Vendor_entities.dart';

class VendorModel extends GetxController with GetSingleTickerProviderStateMixin {
  var processList = <Process>[].obs;
  var processcustomerList = <Active_vendorList>[].obs;
  final showvendorprocess = Rxn<int>();
  final vendorId = Rxn<int>();
  final pdfFile = Rxn<File>();
  final processID = Rxn<int>();
  var vendorList = <VendorList>[].obs;

  final selectedIndices = <int>[].obs;
  final RxBool isAllSelected = false.obs;
  final type = 0.obs;
  final RxBool isprofilepage = false.obs;
  // var searchQuery = ''.obs;
  var searchQuery = "".obs;
  Rxn<Vendordata> vendordata = Rxn<Vendordata>(); // Nullable
  var vendorperiod = 'monthly'.obs;
  Rxn<Clientprofiledata> Clientprofile = Rxn<Clientprofiledata>(); // Nullable
  late AnimationController animationController;

  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final CCemailController = TextEditingController().obs;
  var feedbackController = TextEditingController().obs;
  // var filePathController = TextEditingController().obs;
  var CCemailToggle = false.obs;
}
