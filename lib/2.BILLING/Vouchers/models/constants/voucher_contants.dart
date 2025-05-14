import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';

class VoucherModel extends GetxController with GetSingleTickerProviderStateMixin {
  var voucher_list = <InvoicePaymentVoucher>[].obs;
  var filteredVouchers = <InvoicePaymentVoucher>[].obs;

  // var voucherlist = Voucher_List(VoucherList: []).obs;

  var selectedItems = <bool>[].obs;
  var selectAll = false.obs;
  var showDeleteButton = false.obs;

  // Filter related variables
  var clientNames = <String>[].obs;
  var productTypes = <String>[].obs;

  var selectedpaymentStatus = 'Show All'.obs;
  var selectedQuickFilter = 'Show All'.obs;
  var selectedInvoiceType = 'Show All'.obs;
  var showCustomDateRange = false.obs;
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
    clientNames.value = voucher_list.map((v) => v.clientName).toSet().toList();
    productTypes.value = voucher_list.map((v) => v.voucherType).toSet().toList();
  }
}
