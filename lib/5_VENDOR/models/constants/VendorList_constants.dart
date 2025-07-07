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
      vendorName: 'Alpha Tech',
      address: '1 Tech Park',
      state: 'Tamil Nadu',
      pincode: '600001',
      contactPersonName: 'Alice',
      contactPersonDesignation: 'Manager',
      contactPersonPhone: '9876543210',
      email: 'alpha@tech.com',
      businessType: 'Manufacturer',
      yearOfEstablishment: '2010',
      gstNumber: 'GSTIN0001',
      panNumber: 'PAN0001',
      annualTurnover: '5000000',
      productOrServiceList: 'Electronics',
      hsnOrSacCode: '8542',
      productOrServiceDescription: 'Embedded Solutions',
      bankName: 'SBI',
      branch: 'T Nagar',
      accountNumber: '1234567890',
      ifscCode: 'SBIN0000001',
      registrationCertificate: Uint8List(0),
      panUpload: Uint8List(0),
      cancelledCheque: Uint8List(0),
    ),
    VendorsData(
      vendorName: 'Beta Soft',
      address: '2 Market Street',
      state: 'Karnataka',
      pincode: '560002',
      contactPersonName: 'Bob',
      contactPersonDesignation: 'Director',
      contactPersonPhone: '9876543211',
      email: 'beta@soft.com',
      businessType: 'Service Provider',
      yearOfEstablishment: '2015',
      gstNumber: 'GSTIN0002',
      panNumber: 'PAN0002',
      annualTurnover: '3000000',
      productOrServiceList: 'Software Services',
      hsnOrSacCode: '9983',
      productOrServiceDescription: 'Web & App Development',
      bankName: 'ICICI',
      branch: 'MG Road',
      accountNumber: '2345678901',
      ifscCode: 'ICIC0000002',
      registrationCertificate: Uint8List(0),
      panUpload: Uint8List(0),
      cancelledCheque: Uint8List(0),
    ),
    VendorsData(
      vendorName: 'Gamma Corp',
      address: '3 River Rd',
      state: 'Maharashtra',
      pincode: '400003',
      contactPersonName: 'Charlie',
      contactPersonDesignation: 'CEO',
      contactPersonPhone: '9876543212',
      email: 'gamma@corp.com',
      businessType: 'Distributor',
      yearOfEstablishment: '2008',
      gstNumber: 'GSTIN0003',
      panNumber: 'PAN0003',
      annualTurnover: '10000000',
      productOrServiceList: 'Networking Equipment',
      hsnOrSacCode: '8517',
      productOrServiceDescription: 'Routers, Switches',
      bankName: 'HDFC',
      branch: 'Bandra',
      accountNumber: '3456789012',
      ifscCode: 'HDFC0000003',
      registrationCertificate: Uint8List(0),
      panUpload: Uint8List(0),
      cancelledCheque: Uint8List(0),
    ),
    VendorsData(
      vendorName: 'Delta Solutions',
      address: '4 Delta Lane',
      state: 'Delhi',
      pincode: '110044',
      contactPersonName: 'Diana',
      contactPersonDesignation: 'Admin Head',
      contactPersonPhone: '9876543213',
      email: 'delta@solutions.com',
      businessType: 'Service Provider',
      yearOfEstablishment: '2012',
      gstNumber: 'GSTIN0004',
      panNumber: 'PAN0004',
      annualTurnover: '1500000',
      productOrServiceList: 'IT Support',
      hsnOrSacCode: '9983',
      productOrServiceDescription: 'System maintenance & AMC',
      bankName: 'Axis Bank',
      branch: 'Saket',
      accountNumber: '4567890123',
      ifscCode: 'UTIB0000004',
      registrationCertificate: Uint8List(0),
      panUpload: Uint8List(0),
      cancelledCheque: Uint8List(0),
    ),
    VendorsData(
      vendorName: 'Epsilon Ltd',
      address: '5 Business Blvd',
      state: 'Telangana',
      pincode: '500005',
      contactPersonName: 'Edward',
      contactPersonDesignation: 'Accounts Manager',
      contactPersonPhone: '9876543214',
      email: 'epsilon@ltd.com',
      businessType: 'Manufacturer',
      yearOfEstablishment: '2005',
      gstNumber: 'GSTIN0005',
      panNumber: 'PAN0005',
      annualTurnover: '8000000',
      productOrServiceList: 'Packaging Materials',
      hsnOrSacCode: '3923',
      productOrServiceDescription: 'Plastic & paper packaging',
      bankName: 'Kotak',
      branch: 'Ameerpet',
      accountNumber: '5678901234',
      ifscCode: 'KKBK0000005',
      registrationCertificate: Uint8List(0),
      panUpload: Uint8List(0),
      cancelledCheque: Uint8List(0),
    ),
    // New extra entries
    VendorsData(
      vendorName: 'Zeta Works',
      address: '6 Zeta Road',
      state: 'Kerala',
      pincode: '682001',
      contactPersonName: 'Zack',
      contactPersonDesignation: 'Operations Lead',
      contactPersonPhone: '9876543215',
      email: 'zeta@works.com',
      businessType: 'Others',
      yearOfEstablishment: '2011',
      gstNumber: 'GSTIN0006',
      panNumber: 'PAN0006',
      annualTurnover: '4500000',
      productOrServiceList: 'Consulting Services',
      hsnOrSacCode: '9983',
      productOrServiceDescription: 'Business Process Optimization',
      bankName: 'Federal Bank',
      branch: 'Ernakulam',
      accountNumber: '6789012345',
      ifscCode: 'FDRL0000006',
      registrationCertificate: Uint8List(0),
      panUpload: Uint8List(0),
      cancelledCheque: Uint8List(0),
    ),
    VendorsData(
      vendorName: 'Eta Systems',
      address: '7 Eta Place',
      state: 'Gujarat',
      pincode: '380007',
      contactPersonName: 'Elaine',
      contactPersonDesignation: 'Founder',
      contactPersonPhone: '9876543216',
      email: 'eta@systems.com',
      businessType: 'Manufacturer',
      yearOfEstablishment: '2003',
      gstNumber: 'GSTIN0007',
      panNumber: 'PAN0007',
      annualTurnover: '12000000',
      productOrServiceList: 'Solar Panels',
      hsnOrSacCode: '8541',
      productOrServiceDescription: 'Renewable energy products',
      bankName: 'BOB',
      branch: 'Ahmedabad',
      accountNumber: '7890123456',
      ifscCode: 'BARB0AHMEDD',
      registrationCertificate: Uint8List(0),
      panUpload: Uint8List(0),
      cancelledCheque: Uint8List(0),
    ),
    VendorsData(
      vendorName: 'Theta Innovations',
      address: '8 Theta Street',
      state: 'Punjab',
      pincode: '160003',
      contactPersonName: 'Thomas',
      contactPersonDesignation: 'Innovation Lead',
      contactPersonPhone: '9876543217',
      email: 'theta@innovate.com',
      businessType: 'Service Provider',
      yearOfEstablishment: '2019',
      gstNumber: 'GSTIN0008',
      panNumber: 'PAN0008',
      annualTurnover: '2000000',
      productOrServiceList: 'AI & ML Services',
      hsnOrSacCode: '9983',
      productOrServiceDescription: 'AI algorithm development',
      bankName: 'IndusInd Bank',
      branch: 'Chandigarh',
      accountNumber: '8901234567',
      ifscCode: 'INDB0000008',
      registrationCertificate: Uint8List(0),
      panUpload: Uint8List(0),
      cancelledCheque: Uint8List(0),
    ),
    VendorsData(
      vendorName: 'Iota Devs',
      address: '9 Dev Avenue',
      state: 'West Bengal',
      pincode: '700009',
      contactPersonName: 'Irene',
      contactPersonDesignation: 'Dev Manager',
      contactPersonPhone: '9876543218',
      email: 'iota@devs.com',
      businessType: 'Service Provider',
      yearOfEstablishment: '2016',
      gstNumber: 'GSTIN0009',
      panNumber: 'PAN0009',
      annualTurnover: '2500000',
      productOrServiceList: 'App Development',
      hsnOrSacCode: '9983',
      productOrServiceDescription: 'Cross-platform mobile apps',
      bankName: 'PNB',
      branch: 'Salt Lake',
      accountNumber: '9012345678',
      ifscCode: 'PUNB0000009',
      registrationCertificate: Uint8List(0),
      panUpload: Uint8List(0),
      cancelledCheque: Uint8List(0),
    ),
    VendorsData(
      vendorName: 'Kappa Tech',
      address: '10 Tech Valley',
      state: 'Rajasthan',
      pincode: '302001',
      contactPersonName: 'Kevin',
      contactPersonDesignation: 'Co-Founder',
      contactPersonPhone: '9876543219',
      email: 'kappa@tech.com',
      businessType: 'Distributor',
      yearOfEstablishment: '2020',
      gstNumber: 'GSTIN0010',
      panNumber: 'PAN0010',
      annualTurnover: '15000000',
      productOrServiceList: 'Cloud Hardware',
      hsnOrSacCode: '8471',
      productOrServiceDescription: 'Data Center Supplies',
      bankName: 'Yes Bank',
      branch: 'Jaipur',
      accountNumber: '0123456789',
      ifscCode: 'YESB0000010',
      registrationCertificate: Uint8List(0),
      panUpload: Uint8List(0),
      cancelledCheque: Uint8List(0),
    ),
  ].obs;

  var backup_VendorList = <VendorsData>[].obs;
// Basic Info
  var vendor_IdController = TextEditingController().obs;
  var vendor_NameController = TextEditingController().obs;
  var vendor_addressController = TextEditingController().obs;
  var vendor_stateController = TextEditingController().obs;
  var vendor_pincodeController = TextEditingController().obs;

// Contact Person Info
  var vendor_contactPersonNameController = TextEditingController().obs;
  var vendor_contactPersonDesignationController = TextEditingController().obs;
  var vendor_contactPersonPhoneController = TextEditingController().obs;
  var vendor_emailController = TextEditingController().obs;

// Business Info
  var vendor_businessTypeController = TextEditingController().obs;
  var vendor_yearOfEstablishmentController = TextEditingController().obs;
  var vendor_gstNumberController = TextEditingController().obs;
  var vendor_panNumberController = TextEditingController().obs;
  var vendor_annualTurnoverController = TextEditingController().obs;
  var vendor_productOrServiceListController = TextEditingController().obs;
  var vendor_hsnOrSacCodeController = TextEditingController().obs;
  var vendor_productOrServiceDescriptionController = TextEditingController().obs;

// Certification Info
  var vendor_isoCertificationController = TextEditingController().obs;
  var vendor_otherCertificationsController = TextEditingController().obs;
  var vendor_panUpload = Rx<Uint8List?>(null);
  var vendor_registrationCertificate = Rx<Uint8List?>(null);
  var vendor_cancelledCheque = Rx<Uint8List?>(null);
// Bank Info
  var vendor_bankNameController = TextEditingController().obs;
  var vendor_branchController = TextEditingController().obs;
  var vendor_accountNumberController = TextEditingController().obs;
  var vendor_ifscCodeController = TextEditingController().obs;

////////////////////////////////-----------------------------BRANCHES-------------------------------//////////////////////////////////

  void initTabController(TickerProvider tickerProvider, int length) {
    tabController = TabController(length: length, vsync: tickerProvider);
    tabController.addListener(() {
      selectedtab.value = tabController.index;
    });
  }
}
