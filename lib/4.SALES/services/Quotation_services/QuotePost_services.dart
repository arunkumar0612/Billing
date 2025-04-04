import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4.SALES/controllers/Quote_actions.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Quote_entities.dart';
import 'package:ssipl_billing/API-/api.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS-/helpers/support_functions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin PostServices {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final QuoteController quoteController = Get.find<QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    quoteController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    quoteController.setpdfLoading(true);
  }

  void showReadablePdf(context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
          height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
          child: SfPdfViewer.file(quoteController.quoteModel.selectedPdf.value!),
        ),
      ),
    );
  }

  Future<void> printPdf() async {
    if (kDebugMode) {
      print('Selected PDF Path: ${quoteController.quoteModel.selectedPdf.value}');
    }

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdfBytes = await quoteController.quoteModel.selectedPdf.value!.readAsBytes();
          return pdfBytes;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error printing PDF: $e');
      }
    }
  }

  dynamic postData(context, int messageType, String eventtype) async {
    try {
      if (quoteController.postDatavalidation()) {
        await Basic_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {}, showCancel: false);
        return;
      }
      File cachedPdf = quoteController.quoteModel.selectedPdf.value!;
      // savePdfToCache();
      Post_Quotation salesData = Post_Quotation.fromJson(
          title: quoteController.quoteModel.TitleController.value.text,
          processid: quoteController.quoteModel.processID.value!,
          ClientAddressname: quoteController.quoteModel.clientAddressNameController.value.text,
          ClientAddress: quoteController.quoteModel.clientAddressController.value.text,
          billingAddressName: quoteController.quoteModel.billingAddressNameController.value.text,
          billingAddress: quoteController.quoteModel.billingAddressController.value.text,
          emailId: quoteController.quoteModel.emailController.value.text,
          phoneNo: quoteController.quoteModel.phoneController.value.text,
          gst: quoteController.quoteModel.gstController.value.text,
          product: quoteController.quoteModel.Quote_products,
          notes: quoteController.quoteModel.Quote_noteList,
          date: getCurrentDate(),
          quotationGenID: quoteController.quoteModel.Quote_no.value!,
          messageType: messageType,
          feedback: quoteController.quoteModel.feedbackController.value.text,
          ccEmail: quoteController.quoteModel.CCemailController.value.text);

      await send_data(context, jsonEncode(salesData.toJson()), cachedPdf, eventtype);
    } catch (e) {
      await Basic_dialog(context: context, title: "POST", content: "$e", onOk: () {}, showCancel: false);
    }
  }

  dynamic send_data(context, String jsonData, File file, String eventtype) async {
    try {
      Map<String, dynamic>? response =
          await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, file, eventtype == "quotation" ? API.add_Quotation : API.add_RevisedQuotation);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Basic_dialog(context: context, title: "Quotation", content: value.message!, onOk: () {}, showCancel: false);
          // Navigator.of(context).pop(true);
          // quoteController.resetData();
        } else {
          await Basic_dialog(context: context, title: 'Processing Quotation', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
    }
  }
}
