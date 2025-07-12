import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Process/PO_entities.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Process/product_entities.dart';

// import 'package:ssipl_billing/5_VENDOR/models/entities/Process/PO_entities.dart';
// import 'package:ssipl_billing/5_VENDOR/models/entities/Process/product_entities.dart';

import '../../entities/Vendor_entities.dart';

class POModel extends GetxController with GetSingleTickerProviderStateMixin {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var vendorID = Rxn<int>();
  var vendorName = Rxn<String>();
  // var processID = Rxn<int>();
  var PO_no = Rxn<String>();
  // var gst_no = Rxn<String>();
  // var PO_table_heading = "".obs;

  var po_amount = Rxn<double>();
  var po_subTotal = Rxn<double>();
  var po_CGSTamount = Rxn<double>();
  var po_SGSTamount = Rxn<double>();
  var po_IGSTamount = Rxn<double>();

  // DETAILS
  final AddressController = TextEditingController().obs;
  final gstNumController = TextEditingController().obs;
  final PAN_Controller = TextEditingController().obs;
  final contactPerson_Controller = TextEditingController().obs;
  final detailsKey = GlobalKey<FormState>().obs;

  // PRODUCTS
  var VendorProduct_sugestions = <ProductSuggestion>[].obs;
  final productKey = GlobalKey<FormState>().obs;
  final product_editIndex = Rxn<int>();
  final productNameController = TextEditingController().obs;
  final hsnController = TextEditingController().obs;
  final priceController = TextEditingController().obs;
  final lastknown_price = Rxn<double>();
  final quantityController = TextEditingController().obs;
  final gstController = TextEditingController().obs;
  var PO_products = <POProduct>[].obs;
  var PO_productSuggestion = <VendorProductSuggestion>[].obs;
  var PO_gstTotals = <POGSTtotals>[].obs;

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
  var PO_noteList = [].obs;
  var PO_recommendationList = <Recommendation>[].obs;
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
  var isGST_local = true.obs;

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
