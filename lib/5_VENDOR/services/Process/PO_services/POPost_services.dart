import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/5_Vendor/models/entities/Process/PO_entities.dart';
import 'package:ssipl_billing/5_Vendor/controllers/Process/PO_actions.dart';
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
  final POController poController = Get.find<POController>();
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
        await Error_dialog(
          context: context,
          title: "ERROR",
          content: "All fields must be filled",
          onOk: () {},
        );
        return;
      }
      loader.start(context);
      File cachedPdf = poController.poModel.selectedPdf.value!;
      var bill = BillDetails(
        total: poController.poModel.po_amount.value!,
        subtotal: poController.poModel.po_subTotal.value!,
        tdsamount: 0.0, //while genrating a po we  cannot know, that client will deduct tds or not
        gst: GST(
          IGST: double.parse((poController.poModel.po_IGSTamount.value ?? 0).toStringAsFixed(2)),
          CGST: double.parse((poController.poModel.po_CGSTamount.value ?? 0).toStringAsFixed(2)),
          SGST: double.parse((poController.poModel.po_SGSTamount.value ?? 0).toStringAsFixed(2)),
        ),
      );
      // savePdfToCache();
      Post_PO salesData = Post_PO.fromJson(
        title: poController.poModel.TitleController.value.text,
        processid: poController.poModel.processID.value!,
        ClientAddressname: poController.poModel.clientAddressNameController.value.text,
        ClientAddress: poController.poModel.clientAddressController.value.text,
        billingAddressName: poController.poModel.billingAddressNameController.value.text,
        billingAddress: poController.poModel.billingAddressController.value.text,
        emailId: poController.poModel.emailController.value.text,
        phoneNo: poController.poModel.phoneController.value.text,
        gst: poController.poModel.gstController.value.text,
        product: poController.poModel.PO_products,
        notes: poController.poModel.PO_noteList,
        date: getCurrentDate(),
        poGenID: poController.poModel.PO_no.value!,
        messageType: messageType,
        feedback: poController.poModel.feedbackController.value.text,
        ccEmail: poController.poModel.CCemailController.value.text,
        total_amount: poController.poModel.po_amount.value!,
        billdetails: bill.toJson(),
      );

      await send_data(context, jsonEncode(salesData.toJson()), cachedPdf);
    } catch (e) {
      await Error_dialog(
        context: context,
        title: "POST",
        content: "$e",
        onOk: () {},
      );
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], 'API.add_po');
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
          poController.resetData();
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Processing PO', content: value.message ?? "", onOk: () {});
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
