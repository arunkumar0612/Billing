import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/_main_BILLING/models/entities/Billing_entities.dart';

/// Controller for managing billing-related UI state, filters, and invoice data.
class BillingModel extends GetxController with GetSingleTickerProviderStateMixin {
  // ==========================
  // Animation
  // ==========================

  /// Animation controller for handling transitions or UI animations.
  late AnimationController animationController;

  // ==========================
  // File
  // ==========================

  /// Stores the exported PDF file (e.g., invoice).
  final pdfFile = Rxn<File>();

  // ==========================
  // Dashboard Date Controllers
  // ==========================

  /// Controller for the dashboard's start date input.
  final dashboard_startDateController = TextEditingController().obs;

  /// Controller for the dashboard's end date input.
  final dashboard_endDateController = TextEditingController().obs;

  // ==========================
  // General Date Controllers
  // ==========================

  /// Controller for the start date input (non-dashboard).
  final startDateController = TextEditingController().obs;

  /// Controller for the end date input (non-dashboard).
  final endDateController = TextEditingController().obs;

  // ==========================
  // Month Selection
  // ==========================

  /// Selected month for dashboard filtering.
  RxString dashboard_selectedMonth = 'None'.obs;

  /// Selected month for general filtering.
  RxString selectedMonth = 'None'.obs;

  // ==========================
  // Dropdown Filters
  // ==========================

  /// Payment status filter (e.g., Paid, Unpaid, Partial).
  var selectedpaymentstatus = 'Show All'.obs;

  /// Plan type filter (e.g., Monthly, Annual).
  var selectedplantype = 'Show All'.obs;

  /// Invoice type filter (e.g., Subscription or Sales).
  var selectedInvoiceType = 'Subscription'.obs;

  // ==========================
  // Customer Selections
  // ==========================

  /// Selected customer name for sales invoices.
  RxString selectedsalescustomer = 'None'.obs;

  /// Selected customer name for subscription invoices.
  RxString selectedsubcustomer = 'None'.obs;

  /// Selected customer ID (used for both types).
  RxString selectedcustomerID = ''.obs;

  // ==========================
  // Payment Status Options
  // ==========================

  /// List of available payment status filters.
  var paymentstatusList = ['Show All', 'Paid', 'Partial', 'Unpaid'].obs;

  // ==========================
  // UI Tab State
  // ==========================

  /// Currently active tab ("Subscription" or "Sales").
  var activeTab = 'Subscription'.obs;

  // ==========================
  // Search Input
  // ==========================

  /// Search query input value.
  var searchQuery = "".obs;

  // ==========================
  // Invoice Lists
  // ==========================

  /// Main list of subscription invoices.
  var subscriptionInvoiceList = <SubscriptionInvoice>[].obs;

  /// Main list of sales invoices.
  var salesInvoiceList = <SalesInvoice>[].obs;

  /// All available subscription invoices (unfiltered).
  var allSubscriptionInvoices = <SubscriptionInvoice>[].obs;

  /// All available sales invoices (unfiltered).
  var allSalesInvoices = <SalesInvoice>[].obs;

  // ==========================
  // Customer Lists
  // ==========================

  /// List of all customers for sales invoices.
  var salesCustomerList = <MainbillingCustomerInfo>[].obs;

  /// List of all customers for subscription invoices.
  var subCustomerList = <MainbillingCustomerInfo>[].obs;

  // ==========================
  // Dashboard Summary Data
  // ==========================

  /// Dashboard summary data (total, paid, and pending).
  var dashBoard_data = DashboardStats(
    totalInvoices: 0,
    totalAmount: null,
    paidInvoices: 0,
    paidAmount: null,
    pendingInvoices: 0,
    pendingAmount: null,
  ).obs;

  // ==========================
  // Type Filter
  // ==========================

  /// Invoice type filter (All, Subscription, or Sales).
  var type = 'All'.obs;

  // ==========================
  // Combined Filter Object
  // ==========================

  /// Combined object for managing all selected filters.
  Rx<MainbillingSelectedFilter> mainbilling_SelectedFilter = MainbillingSelectedFilter(
    plantype: 'Show All',
    invoicetype: 'Subscription',
    selectedsalescustomername: 'None',
    selectedcustomerid: '',
    selectedsubscriptioncustomername: 'None',
    paymentstatus: 'Show All',
    fromdate: '',
    todate: '',
    selectedmonth: 'None',
  ).obs;
}
