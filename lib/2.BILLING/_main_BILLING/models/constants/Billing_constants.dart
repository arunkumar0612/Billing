import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';

class BillingModel extends GetxController with GetSingleTickerProviderStateMixin {
  var subscriptionInvoiceList = <SubscriptionInvoice>[].obs;
  var salesInvoiceList = <SalesInvoice>[].obs;
  var vendorInvoiceList = <VendorInvoice>[].obs;
  final pdfFile = Rxn<File>();

  // Filter related variables
  var showCustomDateRange = false.obs;
  final dateController = TextEditingController().obs;
  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;
  final searchController = TextEditingController().obs;
  var selectedInvoiceType = 'Show All'.obs;
  var selectedPaymentStatus = 'Show All'.obs;
  var selectedQuickFilter = 'Show All'.obs;
  var selectedPackageName = 'Show All'.obs;
  late AnimationController animationController;

  RxString dashboard_selectedMonth = 'None'.obs;
  final dashboard_startDateController = TextEditingController().obs;
  final dashboard_endDateController = TextEditingController().obs;
  var type = 'All'.obs;
  // search customer variables
  var activeTab = 'Subscription'.obs;
  var searchQuery = "".obs;
  List<SubscriptionInvoice> allSubscriptionInvoices = [];
  List<SalesInvoice> allSalesInvoices = [];
  var dashBoard_data = DashboardStats(
    totalInvoices: 0,
    totalAmount: null,
    paidInvoices: 0,
    paidAmount: null,
    pendingInvoices: 0,
    pendingAmount: null,
  ).obs;
  // List<VendorInvoice> allVendorInvoices=[];
}
