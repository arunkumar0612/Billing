import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Quote_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Vendor_actions.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin Quoteservice {
  final Vendor_QuoteController quoteController = Get.find<Vendor_QuoteController>();
  final VendorController vendorController = Get.find<VendorController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  Future<void> Quote_action(context) async {
    await quoteController.pickFile(context);
  }

  void uploadQuote(context, File file) async {
    try {
      Map<String, dynamic> feedback = {
        'processid': vendorController.vendorModel.processID.value,
        'feedback': quoteController.quoteModel.feedbackController.value.text,
      };
      final jsonData = jsonEncode(feedback);
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.vendor_uploadQuote);

      // Map<String, dynamic>? response = await apiController.multiPart(file, API.vendor_uploadQuote);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Success_dialog(context: context, title: 'Upload Quote', content: "Quote uploaded Successfully", onOk: () {});
          Navigator.of(context).pop(true);
          // quoteModel.updateMOR_uploadedPath(value);
        } else {
          await Error_dialog(context: context, title: 'Upload Quote', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
