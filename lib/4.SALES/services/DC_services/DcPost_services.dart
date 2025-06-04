import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4.SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4.SALES/models/entities/DC_entities.dart';
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
  final DcController dcController = Get.find<DcController>();
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    dcController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    dcController.setpdfLoading(true);
  }

  Future<void> printPdf() async {
    if (kDebugMode) {
      print('Selected PDF Path: ${dcController.dcModel.selectedPdf.value}');
    }

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdfBytes = await dcController.dcModel.selectedPdf.value!.readAsBytes();
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
      if (dcController.postDatavalidation()) {
        await Error_dialog(
          context: context,
          title: "POST",
          content: "All fields must be filled",
          onOk: () {},
        );
        return;
      }
      loader.start(context);
      File cachedPdf = dcController.dcModel.selectedPdf.value!;
      // savePdfToCache();
      Post_Dc salesData = Post_Dc.fromJson(
          title: dcController.dcModel.TitleController.value.text,
          processid: dcController.dcModel.processID.value!,
          ClientAddressname: dcController.dcModel.clientAddressNameController.value.text,
          ClientAddress: dcController.dcModel.clientAddressController.value.text,
          billingAddressName: dcController.dcModel.billingAddressNameController.value.text,
          billingAddress: dcController.dcModel.billingAddressController.value.text,
          emailId: dcController.dcModel.emailController.value.text,
          phoneNo: dcController.dcModel.phoneController.value.text,
          gst: dcController.dcModel.gstNumController.value.text,
          product: dcController.dcModel.selected_dcProducts,
          notes: dcController.dcModel.Dc_noteList,
          date: getCurrentDate(),
          dcGenID: dcController.dcModel.Dc_no.value!,
          messageType: messageType,
          feedback: dcController.dcModel.feedbackController.value.text,
          ccEmail: dcController.dcModel.CCemailController.value.text,
          productFeedback: dcController.dcModel.product_feedback.value);

      await send_data(context, jsonEncode(salesData.toJson()), cachedPdf);
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.add_Dc);
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
          dcController.resetData();
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Processing Dc', content: value.message ?? "", onOk: () {});
        }
      } else {
        loader.stop();
        Error_dialog(
          context: context,
          title: "SERVER DOWN",
          content: "Please contact administration!",
        );
      }
      //await Refresher().refreshAll(context);
    } catch (e) {
      loader.stop();
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
