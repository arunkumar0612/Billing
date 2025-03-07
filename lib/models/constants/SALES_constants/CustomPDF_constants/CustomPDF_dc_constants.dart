import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/SALES/CustomPDF_entities/CustomPDF_Product_entities.dart';

class CustomPDF_DcModel {
  final date = TextEditingController().obs;
  final manualdcNo = TextEditingController().obs;
  final clientName = TextEditingController().obs;
  final clientAddress = TextEditingController().obs;
  final billingName = TextEditingController().obs;
  final billingAddres = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final Email = TextEditingController().obs;
  final GSTnumber = TextEditingController().obs;
  final feedback = TextEditingController().obs;
  final filePathController = TextEditingController().obs;

  final CCemailController = TextEditingController().obs;
  var noteControllers = <TextEditingController>[].obs;

  var textControllers = <List<TextEditingController>>[].obs;

  var manualDcproducts = <CustomPDF_DcProduct>[
    CustomPDF_DcProduct(
      sNo: "1",
      description: "Laptop",
      hsn: "8471",
      quantity: "2",
    ),
    CustomPDF_DcProduct(
      sNo: "2",
      description: "Mouse",
      hsn: "8472",
      quantity: "5",
    ),
  ].obs;

  final notecontent = <String>[].obs;
  var progress = 0.0.obs;
  var checkboxValues = <bool>[].obs;
  var ispdfLoading = false.obs;
  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  var isLoading = false.obs;
  var CCemailToggle = false.obs;

  var genearatedPDF = Rxn<File>();
  late AnimationController animationController;
  late Animation<double> animation;
  final allData_key = GlobalKey<FormState>().obs;
}
