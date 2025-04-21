import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart' as site;

import '../entities/SUBSCRIPTION_Quote_entities.dart';
import '../entities/SUBSCRIPTION_Sites_entities.dart';

class SUBSCRIPTION_QuoteModel extends GetxController with GetSingleTickerProviderStateMixin {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var processID = Rxn<int>();
  var Quote_no = Rxn<String>();
  // var gst_no = Rxn<String>();
  var Quote_table_heading = "".obs;
  final gstNumController = TextEditingController().obs;

  // DETAILS
  final TitleController = TextEditingController().obs;
  final clientAddressNameController = TextEditingController().obs;
  final clientAddressController = TextEditingController().obs;
  final billingAddressNameController = TextEditingController().obs;
  final billingAddressController = TextEditingController().obs;
  final detailsKey = GlobalKey<FormState>().obs;

//SITES
  final siteFormkey = GlobalKey<FormState>().obs;
  final siteNameController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  var Billingtype_Controller = Rxn<String>();
  var BillingtypeList = <String>[
    'Individual',
    'Consolidate',
  ].obs;
  var Mailtype_Controller = Rxn<String>();
  var MailtypeList = <String>[
    'Individual',
    'Consolidate',
  ].obs;
  final cameraquantityController = TextEditingController().obs;
  final site_editIndex = Rxn<int>();
  var QuoteSiteDetails = <site.Site>[].obs;
  //  var Quote_sites = <SUBSCRIPTION_QuoteSite>[].obs;
  var selectedPackageController = TextEditingController().obs;
  Rx<PackageDetails?> customPackageDetails = Rx<PackageDetails?>(null);

  // PACKAGE

  final List<String> packageList = ['Basic Plan', 'Standard Plan', 'Premium Plan', 'Custom Package'].obs;
  Rx<String?> selectedPackage = Rx<String?>(null);

  RxBool customPackageCreated = false.obs;
  late AnimationController animationControllers;
  late Animation<double> fadeAnimations;
  final RxList<Map<String, String>> selectedPackages = <Map<String, String>>[].obs;

  final Map<String, Map<String, String>> packageDetails = {
    'Basic Plan': {
      'name': 'Basic Plan',
      'description': 'Includes 5 cameras, ideal for small homes or small businesses.',
      'camera_count': '5',
      'amount': '\$50/month',
      'additional_cameras': '\$10 per extra camera',
      'show': 'Global',
      'icon': '🏠',
    },
    'Standard Plan': {
      'name': 'Standard Plan',
      'description': 'Includes 10 cameras, perfect for medium offices and retail spaces.',
      'camera_count': '10',
      'amount': '\$100/month',
      'additional_cameras': '\$8 per extra camera',
      'show': 'Global',
      'icon': '🏢',
    },
    'Premium Plan': {
      'name': 'Premium Plan',
      'description': 'Includes 20 cameras, designed for large buildings and enterprises.',
      'camera_count': '20',
      'amount': '\$200/month',
      'additional_cameras': '\$5 per extra camera',
      'show': 'Global',
      'icon': '🏭',
    },
  }.obs;

  final customNameControllers = TextEditingController().obs;
  final customDescControllers = TextEditingController().obs;
  final customCameraCountControllers = TextEditingController().obs;
  final customAmountControllers = TextEditingController().obs;
  final customChargesControllers = TextEditingController().obs;
  final showto = 'Global'.obs;

  Rx<Map<String, String>?> customPackage = Rx<Map<String, String>?>(null);

  RxBool showSiteList = false.obs;
  var selectedIndices = <int>[].obs;

  // NOTES
  final noteformKey = GlobalKey<FormState>().obs;
  var progress = 0.0.obs;
  var isLoading = false.obs;
  var note_editIndex = Rxn<int>();
  final notecontentController = TextEditingController().obs;
  var recommendation_editIndex = Rxn<int>();
  final recommendationHeadingController = TextEditingController().obs;
  final recommendationKeyController = TextEditingController().obs;
  final recommendationValueController = TextEditingController().obs;
  var Quote_noteList = [].obs;
  var Quote_recommendationList = <SUBSCRIPTION_QuoteRecommendation>[].obs;
  final notecontent = <String>[
    'Delivery within 30 working days from the date of issuing the PO.',
    'Payment terms : 100% along with PO.',
    'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
  ].obs;

  // POST
  late AnimationController animationController;
  late Animation<double> animation;

  var pickedFile = Rxn<FilePickerResult>();
  var selectedPdf = Rxn<File>();
  var ispdfLoading = false.obs;
  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final CCemailController = TextEditingController().obs;
  var feedbackController = TextEditingController().obs;
  var filePathController = TextEditingController().obs;
  var CCemailToggle = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize AnimationController
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this, // Now 'this' is a valid TickerProvider
    )..repeat(reverse: true);

    // Initialize Animation
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
