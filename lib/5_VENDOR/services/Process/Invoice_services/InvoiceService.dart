import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Process/Invoice_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Vendor_actions.dart';
// import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin Invoiceservice {
  final Vendor_InvoiceController invoiceController = Get.find<Vendor_InvoiceController>();
  final VendorController vendorController = Get.find<VendorController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  Future<void> Invoice_action(context) async {
    // bool pickedStatus = await invoiceController.pickFile(context);
    // if (pickedStatus) {
    //   uploadInvoice(context, invoiceController.invoiceModel.selectedPdf.value!);
    // } else {
    //   null;
    // }
  }

  void uploadInvoice(context, File file) async {
    try {
      Map<String, dynamic> feedback = {
        'processid': vendorController.vendorModel.processID.value,
        'feedback': invoiceController.invoiceModel.feedbackController.value.text,
      };
      final jsonData = jsonEncode(feedback);
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], 'API.vendor_uploadInvoice');

      // Map<String, dynamic>? response = await apiController.multiPart(file, API.vendor_uploadInvoice);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await Success_dialog(context: context, title: 'Upload Invoice', content: "Invoice uploaded Successfully", onOk: () {});
          Navigator.of(context).pop(true);
          // invoiceModel.updateMOR_uploadedPath(value);
        } else {
          await Error_dialog(context: context, title: 'Upload Invoice', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
