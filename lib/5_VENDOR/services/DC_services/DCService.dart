import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/DC_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Vendor_actions.dart';
// import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin DCservice {
  final Vendor_DCController dcController = Get.find<Vendor_DCController>();
  final VendorController vendorController = Get.find<VendorController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  Future<void> DC_action(context) async {
    // bool pickedStatus = await dcController.pickFile(context);
    // if (pickedStatus) {
    //   uploadDC(context, dcController.dcModel.selectedPdf.value!);
    // } else {
    //   null;
    // }
  }

  void uploadDC(context, File file) async {
    try {
      Map<String, dynamic> feedback = {
        'processid': vendorController.vendorModel.processID.value,
        'feedback': dcController.dcModel.feedbackController.value.text,
      };
      final jsonData = jsonEncode(feedback);
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], 'API.vendor_uploadDC');

      // Map<String, dynamic>? response = await apiController.multiPart(file, API.vendor_uploadDC);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await Success_dialog(context: context, title: 'Upload DC', content: "DC uploaded Successfully", onOk: () {});
          Navigator.of(context).pop(true);
          // dcModel.updateMOR_uploadedPath(value);
        } else {
          await Error_dialog(context: context, title: 'Upload DC', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
