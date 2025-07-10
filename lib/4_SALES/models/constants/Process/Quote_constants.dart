import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Process/Quote_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Process/product_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Sales_entities.dart';

class QuoteModel extends GetxController with GetSingleTickerProviderStateMixin {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var processID = Rxn<int>();
  var Quote_no = Rxn<String>();
  // var gst_no = Rxn<String>();
  // var Quote_table_heading = "".obs;

  // DETAILS
  final TitleController = TextEditingController().obs;
  final clientAddressNameController = TextEditingController().obs;
  final clientAddressController = TextEditingController().obs;
  final billingAddressNameController = TextEditingController().obs;
  final billingAddressController = TextEditingController().obs;
  final detailsKey = GlobalKey<FormState>().obs;
  final gstNumController = TextEditingController().obs;

  // PRODUCTS
  var Quote_productSuggestion = <ProductSuggestion>[].obs;

  final productKey = GlobalKey<FormState>().obs;
  final product_editIndex = Rxn<int>();
  final productNameController = TextEditingController().obs;
  final hsnController = TextEditingController().obs;
  final priceController = TextEditingController().obs;
  final quantityController = TextEditingController().obs;
  final gstController = TextEditingController().obs;
  var Quote_products = <QuoteProduct>[].obs;
  var Quote_gstTotals = <QuoteGSTtotals>[].obs;

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
  var Quote_recommendationList = <Recommendation>[].obs;
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
  var isGST_local = true.obs;
  final formKey1 = GlobalKey<FormState>().obs;

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
