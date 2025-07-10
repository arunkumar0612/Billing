import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Process/RRFQ_entities.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Process/product_entities.dart';

class RrfqModel extends GetxController with GetSingleTickerProviderStateMixin {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var vendorID = Rxn<int>();
  var vendorName = Rxn<String>();
  var Rrfq_no = Rxn<String>();
  final type = 0.obs;
  // var gst_no = Rxn<String>();
  // var Rrfq_table_heading = "".obs;
  // var rrfq_amount = Rxn<double>();

  // DETAILS

  final AddressController = TextEditingController().obs;
  final GSTIN_Controller = TextEditingController().obs;
  final PAN_Controller = TextEditingController().obs;
  final contactPerson_Controller = TextEditingController().obs;
  // final contactNo_Controller = TextEditingController().obs;
  // final email_Controller = TextEditingController().obs;

  // final gstNumController = TextEditingController().obs;

  // final billingAddressNameController = TextEditingController().obs;
  // final billingAddressController = TextEditingController().obs;
  final detailsKey = GlobalKey<FormState>().obs;

  // PRODUCTS
  final productKey = GlobalKey<FormState>().obs;
  final product_editIndex = Rxn<int>();
  final productNameController = TextEditingController().obs;
  // final hsnController = TextEditingController().obs;
  // final priceController = TextEditingController().obs;
  final quantityController = TextEditingController().obs;
  final hsnController = TextEditingController().obs;

  // final gstController = TextEditingController().obs;
  var Rrfq_products = <RRFQProduct>[].obs;
  var VendorProduct_sugestions = <VendorProduct_suggestions>[].obs;
  // var Rrfq_productSuggestion = <ProductSuggestion>[].obs;
  // var Rrfq_gstTotals = <RrfqGSTtotals>[].obs;

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
  var Rrfq_noteList = [].obs;
  var Rrfq_recommendationList = <Recommendation>[].obs;
  final noteSuggestion = <String>[].obs;

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
