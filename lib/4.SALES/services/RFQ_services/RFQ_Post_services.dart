import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4.SALES/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/4.SALES/models/entities/RFQ_entities.dart';
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
  final RfqController rfqController = Get.find<RfqController>();
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    rfqController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    rfqController.setpdfLoading(true);
  }

  // void showReadablePdf(context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
  //       child: SizedBox(
  //         width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
  //         height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
  //         child: SfPdfViewer.file(rfqController.rfqModel.selectedPdf.value!),
  //       ),
  //     ),
  //   );
  // }

  Future<void> printPdf() async {
    if (kDebugMode) {
      print('Selected PDF Path: ${rfqController.rfqModel.selectedPdf.value}');
    }

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdfBytes = await rfqController.rfqModel.selectedPdf.value!.readAsBytes();
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
      if (rfqController.postDatavalidation()) {
        await Error_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
      File cachedPdf = rfqController.rfqModel.selectedPdf.value!;
      // savePdfToCache();
      Post_Rfq salesData = Post_Rfq.fromJson(
        title: rfqController.rfqModel.TitleController.value.text,
        processid: rfqController.rfqModel.processID.value!,
        vendorID: rfqController.rfqModel.vendorID.value!,
        vendorName: rfqController.rfqModel.vendorName.value!,
        vendorAddress: rfqController.rfqModel.AddressController.value.text,
        emailId: rfqController.rfqModel.emailController.value.text,
        phoneNo: rfqController.rfqModel.phoneController.value.text,
        // gst: rfqController.rfqModel.gstController.value.text,
        product: rfqController.rfqModel.Rfq_products,
        notes: rfqController.rfqModel.Rfq_noteList,
        date: getCurrentDate(),
        rfqGenID: rfqController.rfqModel.Rfq_no.value!,
        messageType: messageType,
        feedback: rfqController.rfqModel.feedbackController.value.text,
        ccEmail: rfqController.rfqModel.CCemailController.value.text,
      );

      await send_data(context, jsonEncode(salesData.toJson()), cachedPdf);
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.add_rfq);
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
          rfqController.resetData();
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Processing Rfq', content: value.message ?? "", onOk: () {});
        }
      } else {
        loader.stop();
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      //await Refresher().refreshAll(context);
    } catch (e) {
      loader.stop();
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
