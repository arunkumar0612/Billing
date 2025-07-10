import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/PO_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/PO_entities.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin PostServices {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final vendor_PoController poController = Get.find<vendor_PoController>();
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    poController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    poController.setpdfLoading(true);
  }

  Future<void> printPdf() async {
    if (kDebugMode) {
      print('Selected PDF Path: ${poController.poModel.selectedPdf.value}');
    }

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdfBytes = await poController.poModel.selectedPdf.value!.readAsBytes();
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
      if (poController.postDatavalidation()) {
        await Error_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
      File cachedPdf = poController.poModel.selectedPdf.value!;
      // savePdfToCache();
      Post_Po poData = Post_Po.fromJson(
        GSTIN: poController.poModel.GSTIN_Controller.value.text,
        PAN: poController.poModel.PAN_Controller.value.text,
        Contact_person: poController.poModel.contactPerson_Controller.value.text,
        vendorID: poController.poModel.vendorID.value!,
        vendorName: poController.poModel.vendorName.value!,
        vendorAddress: poController.poModel.AddressController.value.text,
        emailId: poController.poModel.emailController.value.text,
        phoneNo: poController.poModel.phoneController.value.text,
        // gst: poController.poModel.gstController.value.text,
        product: poController.poModel.Po_products,
        notes: poController.poModel.Po_noteList,
        date: getCurrentDate(),
        poGenID: poController.poModel.Po_no.value!,
        messageType: messageType,
        feedback: poController.poModel.feedbackController.value.text,
        ccEmail: poController.poModel.CCemailController.value.text,
      );

      await send_data(context, jsonEncode(poData.toJson()), cachedPdf);
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], 'API.vendor_createpo');
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
          poController.resetData();
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Processing Po', content: value.message ?? "", onOk: () {});
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
