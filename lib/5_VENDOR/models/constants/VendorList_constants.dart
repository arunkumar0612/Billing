import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/VendorList_entities.dart';

class VendorListModel extends GetxController with GetSingleTickerProviderStateMixin {
  late Animation<Offset> slideAnimation;
  late TabController tabController;
  var selectedtab = 0.obs;
  var searchQuery = "".obs;
///////////////////////////////-----------------------------COMMON--------------------------------///////////////////////////////

  late AnimationController Vendor_controller;
  var Vendor_DataPageView = false.obs;
  var Vendor_cardCount = 5.obs;
  var selectedVendorDetails = VendorsData().obs;
  var VendorList = <VendorsData>[
    VendorsData(
        vendorId: 1,
        vendorName: 'Alpha Tech',
        vendorCode: 'VND1001',
        clientAddressName: 'Alpha HQ',
        clientAddress: '1 Tech Park',
        gstNumber: 'GSTIN0001',
        emailId: 'alpha@tech.com',
        contactNumber: '9876543210',
        contact_person: 'Alice',
        billingAddress: 'Alpha Billing',
        billingAddressName: 'Alpha Bill HQ',
        siteType: 'Urban',
        vendorLogo: Uint8List(0),
        subscriptionId: 501,
        billingPlan: 'Gold',
        billMode: 'Monthly',
        fromDate: '2025-01-01',
        toDate: '2025-12-31',
        amount: 5000,
        billingPeriod: 12),
    VendorsData(
        vendorId: 2,
        vendorName: 'Beta Soft',
        vendorCode: 'VND1002',
        clientAddressName: 'Beta Office',
        clientAddress: '2 Market Street',
        gstNumber: 'GSTIN0002',
        emailId: 'beta@soft.com',
        contactNumber: '9876543211',
        contact_person: 'Bob',
        billingAddress: 'Beta Billing',
        billingAddressName: 'Beta Bill HQ',
        siteType: 'Urban',
        vendorLogo: Uint8List(0),
        subscriptionId: 502,
        billingPlan: 'Silver',
        billMode: 'Quarterly',
        fromDate: '2025-02-01',
        toDate: '2025-11-30',
        amount: 3000,
        billingPeriod: 4),
    VendorsData(
        vendorId: 3,
        vendorName: 'Gamma Corp',
        vendorCode: 'VND1003',
        clientAddressName: 'Gamma Tower',
        clientAddress: '3 River Rd',
        gstNumber: 'GSTIN0003',
        emailId: 'gamma@corp.com',
        contactNumber: '9876543212',
        contact_person: 'Charlie',
        billingAddress: 'Gamma Billing',
        billingAddressName: 'Gamma Bill HQ',
        siteType: 'Rural',
        vendorLogo: Uint8List(0),
        subscriptionId: 503,
        billingPlan: 'Platinum',
        billMode: 'Yearly',
        fromDate: '2025-03-01',
        toDate: '2026-02-28',
        amount: 10000,
        billingPeriod: 1),
    VendorsData(
        vendorId: 4,
        vendorName: 'Delta Solutions',
        vendorCode: 'VND1004',
        clientAddressName: 'Delta Base',
        clientAddress: '4 Delta Lane',
        gstNumber: 'GSTIN0004',
        emailId: 'delta@solutions.com',
        contactNumber: '9876543213',
        contact_person: 'Diana',
        billingAddress: 'Delta Billing',
        billingAddressName: 'Delta Bill HQ',
        siteType: 'Urban',
        vendorLogo: Uint8List(0),
        subscriptionId: 504,
        billingPlan: 'Basic',
        billMode: 'Monthly',
        fromDate: '2025-04-01',
        toDate: '2026-03-31',
        amount: 1500,
        billingPeriod: 12),
    VendorsData(
        vendorId: 5,
        vendorName: 'Epsilon Ltd',
        vendorCode: 'VND1005',
        clientAddressName: 'Epsilon HQ',
        clientAddress: '5 Business Blvd',
        gstNumber: 'GSTIN0005',
        emailId: 'epsilon@ltd.com',
        contactNumber: '9876543214',
        contact_person: 'Edward',
        billingAddress: 'Epsilon Billing',
        billingAddressName: 'Epsilon Bill HQ',
        siteType: 'Metro',
        vendorLogo: Uint8List(0),
        subscriptionId: 505,
        billingPlan: 'Gold',
        billMode: 'Half-Yearly',
        fromDate: '2025-05-01',
        toDate: '2025-10-31',
        amount: 7000,
        billingPeriod: 6),
    VendorsData(
        vendorId: 6,
        vendorName: 'Zeta Works',
        vendorCode: 'VND1006',
        clientAddressName: 'Zeta HQ',
        clientAddress: '6 Zeta Road',
        gstNumber: 'GSTIN0006',
        emailId: 'zeta@works.com',
        contactNumber: '9876543215',
        contact_person: 'Zack',
        billingAddress: 'Zeta Billing',
        billingAddressName: 'Zeta Bill HQ',
        siteType: 'Rural',
        vendorLogo: Uint8List(0),
        subscriptionId: 506,
        billingPlan: 'Premium',
        billMode: 'Monthly',
        fromDate: '2025-06-01',
        toDate: '2026-05-31',
        amount: 4500,
        billingPeriod: 12),
    VendorsData(
        vendorId: 7,
        vendorName: 'Eta Systems',
        vendorCode: 'VND1007',
        clientAddressName: 'Eta Center',
        clientAddress: '7 Eta Place',
        gstNumber: 'GSTIN0007',
        emailId: 'eta@systems.com',
        contactNumber: '9876543216',
        contact_person: 'Elaine',
        billingAddress: 'Eta Billing',
        billingAddressName: 'Eta Bill HQ',
        siteType: 'Urban',
        vendorLogo: Uint8List(0),
        subscriptionId: 507,
        billingPlan: 'Enterprise',
        billMode: 'Yearly',
        fromDate: '2025-07-01',
        toDate: '2026-06-30',
        amount: 12000,
        billingPeriod: 1),
    VendorsData(
        vendorId: 8,
        vendorName: 'Theta Innovations',
        vendorCode: 'VND1008',
        clientAddressName: 'Theta Site',
        clientAddress: '8 Theta Street',
        gstNumber: 'GSTIN0008',
        emailId: 'theta@innovate.com',
        contactNumber: '9876543217',
        contact_person: 'Thomas',
        billingAddress: 'Theta Billing',
        billingAddressName: 'Theta Bill HQ',
        siteType: 'Metro',
        vendorLogo: Uint8List(0),
        subscriptionId: 508,
        billingPlan: 'Startup',
        billMode: 'Monthly',
        fromDate: '2025-08-01',
        toDate: '2025-08-31',
        amount: 1000,
        billingPeriod: 1),
    VendorsData(
        vendorId: 9,
        vendorName: 'Iota Devs',
        vendorCode: 'VND1009',
        clientAddressName: 'Iota Hub',
        clientAddress: '9 Dev Avenue',
        gstNumber: 'GSTIN0009',
        emailId: 'iota@devs.com',
        contactNumber: '9876543218',
        contact_person: 'Irene',
        billingAddress: 'Iota Billing',
        billingAddressName: 'Iota Bill HQ',
        siteType: 'Urban',
        vendorLogo: Uint8List(0),
        subscriptionId: 509,
        billingPlan: 'Standard',
        billMode: 'Quarterly',
        fromDate: '2025-09-01',
        toDate: '2025-11-30',
        amount: 2500,
        billingPeriod: 3),
    VendorsData(
        vendorId: 10,
        vendorName: 'Kappa Tech',
        vendorCode: 'VND1010',
        clientAddressName: 'Kappa Labs',
        clientAddress: '10 Tech Valley',
        gstNumber: 'GSTIN0010',
        emailId: 'kappa@tech.com',
        contactNumber: '9876543219',
        contact_person: 'Kevin',
        billingAddress: 'Kappa Billing',
        billingAddressName: 'Kappa Bill HQ',
        siteType: 'Urban',
        vendorLogo: Uint8List(0),
        subscriptionId: 510,
        billingPlan: 'Enterprise',
        billMode: 'Yearly',
        fromDate: '2025-10-01',
        toDate: '2026-09-30',
        amount: 15000,
        billingPeriod: 1),
  ].obs;
  var backup_VendorList = <VendorsData>[].obs;
  var vendor_IdController = TextEditingController().obs;
  var vendor_NameController = TextEditingController().obs;
  var vendor_CodeController = TextEditingController().obs;
  var vendor_clientAddressNameController = TextEditingController().obs;
  var vendor_clientAddressController = TextEditingController().obs;
  var vendor_gstNumberController = TextEditingController().obs;
  var vendor_emailIdController = TextEditingController().obs;
  var vendor_contactNumberController = TextEditingController().obs;
  var vendor_contact_personController = TextEditingController().obs;
  var vendor_billingAddressController = TextEditingController().obs;
  var vendor_billingAddressNameController = TextEditingController().obs;
  var vendor_siteTypeController = TextEditingController().obs;
  var vendor_subscriptionIdController = TextEditingController().obs;
  var vendor_billingPlanController = TextEditingController().obs;
  var vendor_billModeController = TextEditingController().obs;
  var vendor_fromDateController = TextEditingController().obs;
  var vendor_toDateController = TextEditingController().obs;
  var vendor_amountController = TextEditingController().obs;
  var vendor_billingPeriodController = TextEditingController().obs;

////////////////////////////////-----------------------------BRANCHES-------------------------------//////////////////////////////////

  void initTabController(TickerProvider tickerProvider, int length) {
    tabController = TabController(length: length, vsync: tickerProvider);
    tabController.addListener(() {
      selectedtab.value = tabController.index;
    });
  }
}
