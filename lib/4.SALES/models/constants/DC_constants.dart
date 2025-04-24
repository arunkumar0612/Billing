import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4.SALES/models/entities/DC_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/product_entities.dart';

class DcModel extends GetxController with GetSingleTickerProviderStateMixin {
  final Rxn<TabController> tabController = Rxn<TabController>();
  var processID = Rxn<int>();
  var Dc_no = Rxn<String>();
  var invRef_no = Rxn<String>();
  var Dc_table_heading = "".obs;
  final gstNumController = TextEditingController().obs;
  var dc_amount = Rxn<double>();

  // DETAILS
  final TitleController = TextEditingController().obs;
  final clientAddressNameController = TextEditingController().obs;
  final clientAddressController = TextEditingController().obs;
  final billingAddressNameController = TextEditingController().obs;
  final billingAddressController = TextEditingController().obs;
  final detailsKey = GlobalKey<FormState>().obs;

  // PRODUCTS
  var Dc_products = <DcProduct>[].obs;
  var selected_dcProducts = <DcProduct>[].obs;
  var pending_dcProducts = <DcProduct>[].obs;
  var Dc_gstTotals = <DcGSTtotals>[].obs;
  var checkboxValues = <bool>[].obs;
  var selectall_status = false.obs;
  var product_feedback = "".obs;
  final productNameController = TextEditingController().obs;
  var textControllers = <TextEditingController>[].obs;
  var quantities = <RxInt>[].obs;
  var focusNodes = <Rx<FocusNode>>[].obs;
  var isFocused = <bool>[].obs;
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
  var Dc_noteList = [].obs;
  var Dc_recommendationList = <Recommendation>[].obs;
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
