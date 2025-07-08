import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Quote_actions.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin Quoteservice {
  final Vendor_QuoteController quoteController = Get.find<Vendor_QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  Future<void> Quote_action(context) async {
    bool pickedStatus = await quoteController.pickFile(context);
    if (pickedStatus) {
      uploadQuote(context, quoteController.quoteModel.selectedPdf.value!);
    } else {
      null;
    }
  }

  void uploadQuote(context, File file) async {
    try {
      List<int> fileBytes = await file.readAsBytes();
      if (kDebugMode) {
        print("Binary Data: ${fileBytes.length}");
      } // Prints file in binary format
      Map<String, dynamic>? response = await apiController.multiPart(file, API.Upload_MOR_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Upload MOR', content: "MOR uploaded Successfully", onOk: () {});
          // quoteModel.updateMOR_uploadedPath(value);
        } else {
          await Error_dialog(context: context, title: 'Upload MOR', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
