import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/models/entities/voucher_entities.dart';

class VoucherModel extends GetxController with GetSingleTickerProviderStateMixin {
  var voucher_list = <Voucherdata>[].obs;
  var filteredVouchers = <Voucherdata>[].obs;
  var selectedItems = <bool>[].obs;
  var selectAll = false.obs;
  var showDeleteButton = false.obs;

  // Filter related variables
  var clientNames = <String>[].obs;
  var productTypes = <String>[].obs;
  var selectedClients = <String>[].obs;
  var selectedProductTypes = <String>[].obs;
  var selectedStatus = 'All'.obs;
  var selectedQuickFilter = 'Last week'.obs;
  var showCustomDateRange = false.obs;
  var selectedProductType = 'All'.obs;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  var fileName = RxnString();
  var selectedFile = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data

    selectedItems.value = List.filled(voucher_list.length, false);

    // Extract unique client names and product types for filters
    clientNames.value = voucher_list.map((v) => v.clientName!).toSet().toList();
    productTypes.value = voucher_list.map((v) => v.productType!).toSet().toList();
  }
}
