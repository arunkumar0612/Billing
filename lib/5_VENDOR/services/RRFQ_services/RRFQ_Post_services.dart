import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/RRFQ_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/RRFQ_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin PostServices {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final vendor_RrfqController rrfqController = Get.find<vendor_RrfqController>();
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    rrfqController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    rrfqController.setpdfLoading(true);
  }

  Future<void> printPdf() async {
    if (kDebugMode) {
      print('Selected PDF Path: ${rrfqController.rrfqModel.selectedPdf.value}');
    }

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdfBytes = await rrfqController.rrfqModel.selectedPdf.value!.readAsBytes();
          return pdfBytes;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error printing PDF: $e');
      }
    }
  }

  dynamic postData(context, int messageType) async {
    try {
      if (rrfqController.postDatavalidation()) {
        await Error_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
      File cachedPdf = rrfqController.rrfqModel.selectedPdf.value!;
      // savePdfToCache();
      Post_Rrfq rrfqData = Post_Rrfq.fromJson(
        GSTIN: rrfqController.rrfqModel.GSTIN_Controller.value.text,
        PAN: rrfqController.rrfqModel.PAN_Controller.value.text,
        Contact_person: rrfqController.rrfqModel.contactPerson_Controller.value.text,
        vendorID: rrfqController.rrfqModel.vendorID.value!,
        vendorName: rrfqController.rrfqModel.vendorName.value!,
        vendorAddress: rrfqController.rrfqModel.AddressController.value.text,
        emailId: rrfqController.rrfqModel.emailController.value.text,
        phoneNo: rrfqController.rrfqModel.phoneController.value.text,
        // gst: rrfqController.rrfqModel.gstController.value.text,
        product: rrfqController.rrfqModel.Rrfq_products,
        notes: rrfqController.rrfqModel.Rrfq_noteList,
        date: getCurrentDate(),
        rrfqGenID: rrfqController.rrfqModel.Rrfq_no.value!,
        messageType: messageType,
        feedback: rrfqController.rrfqModel.feedbackController.value.text,
        ccEmail: rrfqController.rrfqModel.CCemailController.value.text,
      );

      await send_data(context, jsonEncode(rrfqData.toJson()), cachedPdf);
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], 'API.vendor_createrrfq');
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Success_dialog(
            context: context,
            title: "SUCCESS",
            content: value.message!,
            onOk: () {},
          );
          Navigator.of(context).pop(true);
          rrfqController.resetData();
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Processing Rrfq', content: value.message ?? "", onOk: () {});
        }
      } else {
        loader.stop();
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      // await Refresher().refreshAll();
    } catch (e) {
      loader.stop();
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
