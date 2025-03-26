import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/Subscription_entities.dart';

class SubscriptionModel extends GetxController with GetSingleTickerProviderStateMixin {
  var customerList = <Customer>[].obs;
  var processcustomerList = <Processcustomer>[].obs;
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
}
