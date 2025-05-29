import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

final Invoker apiController = Get.find<Invoker>();
final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

Future<bool> sharePDF(context, int messageType, File pdf, String email, String phoneNo, String feedback, String CCemail) async {
  try {
    Map<String, dynamic> queryString = {
      "emailid": email,
      "phoneno": phoneNo,
      "feedback": feedback,
      "messagetype": messageType,
      "ccemail": CCemail,
    };
    bool is_success = await sendPDFdata(context, jsonEncode(queryString), pdf);
    return is_success;
  } catch (e) {
    await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    return false;
  }
}

// hariprasath.s@sporadsecure.com
// arunkumar.m@sporadasecure.com
Future<bool> sendPDFdata(context, String jsonData, File file) async {
  try {
    Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.send_anyPDF);
    if (response['statusCode'] == 200) {
      CMDmResponse value = CMDmResponse.fromJson(response);
      if (value.code) {
        await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
        Navigator.of(context).pop(true);
        return true;
        // salesController.reset_shareData();
      } else {
        await Error_dialog(context: context, title: 'Share', content: value.message ?? "", onOk: () {});
      }
    } else {
      Error_dialog(
        context: context,
        title: "SERVER DOWN",
        content: "Please contact administration!",
      );
    }
    return false;
  } catch (e) {
    Error_dialog(context: context, title: "ERROR", content: "$e");
    return false;
  }
}
