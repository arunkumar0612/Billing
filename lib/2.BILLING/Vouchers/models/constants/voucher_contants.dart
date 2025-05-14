import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  final amountCleared_controller = TextEditingController().obs;
  final transactionDetails_controller = TextEditingController().obs;
  final feedback_controller = TextEditingController().obs;
  final TextEditingController closedDateController = TextEditingController();
  final RxString closedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
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
    closedDateController.text = closedDate.value;

    // Sync RxString when controller changes (optional)
    closedDateController.addListener(() {
      closedDate.value = closedDateController.text;
    });

    // Sync controller when RxString changes
    ever(closedDate, (_) {
      if (closedDateController.text != closedDate.value) {
        closedDateController.text = closedDate.value;
      }
    });
  }
}
