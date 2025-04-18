import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4.SALES/controllers/CustomPDF_Controllers/CustomPDF_DC_actions.dart';
import 'package:ssipl_billing/4.SALES/models/entities/CustomPDF_entities/CustomPDF_Product_entities.dart';
import 'package:ssipl_billing/API-/api.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS-/helpers/support_functions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin PostServices {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final CustomPDF_DcController pdfpopup_controller = Get.find<CustomPDF_DcController>();
  final loader = LoadingOverlay();
  final Invoker apiController = Get.find<Invoker>();
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    pdfpopup_controller.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    pdfpopup_controller.setpdfLoading(true);
  }

  void showReadablePdf(context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
          height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
          child: SfPdfViewer.file(pdfpopup_controller.pdfModel.value.genearatedPDF.value!),
        ),
      ),
    );
  }

  Future<void> printPdf() async {
    if (kDebugMode) {
      print('Selected PDF Path: ${pdfpopup_controller.pdfModel.value.genearatedPDF.value}');
    }

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdfBytes = await pdfpopup_controller.pdfModel.value.genearatedPDF.value!.readAsBytes();
          return pdfBytes;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error printing PDF: $e');
      }
    }
  }

  Future<void> downloadPdf(String filename) async {
    try {
      final pdfFile = pdfpopup_controller.pdfModel.value.genearatedPDF.value;
      if (pdfFile == null) {
        if (kDebugMode) {
          print("No PDF file found to download.");
        }
        return;
      }

      // Let the user pick a folder to save the file
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      // Define the destination path
      String savePath = "$selectedDirectory/$filename";

      // Copy the PDF file to the selected directory
      await pdfFile.copy(savePath);

      if (kDebugMode) {
        print("PDF downloaded successfully to: $savePath");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error downloading PDF: $e");
      }
    }
  }

  dynamic postData(context, int messageType) async {
    try {
      if (pdfpopup_controller.postDatavalidation()) {
        await Basic_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {}, showCancel: false);
        return;
      }
      loader.start(context);
      File cachedPdf = pdfpopup_controller.pdfModel.value.genearatedPDF.value!;
      // savePdfToCache();
      Post_CustomDc salesData = Post_CustomDc.fromJson(
        ClientAddressname: pdfpopup_controller.pdfModel.value.clientName.value.text,
        ClientAddress: pdfpopup_controller.pdfModel.value.clientAddress.value.text,
        billingAddressName: pdfpopup_controller.pdfModel.value.billingName.value.text,
        billingAddress: pdfpopup_controller.pdfModel.value.billingAddres.value.text,
        emailId: pdfpopup_controller.pdfModel.value.Email.value.text,
        phoneNo: pdfpopup_controller.pdfModel.value.phoneNumber.value.text,
        gst: pdfpopup_controller.pdfModel.value.GSTnumber.value.text,
        // product: pdfpopup_controller.pdfModel.value.Dc_products,
        // notes: pdfpopup_controller.pdfModel.value.Dc_noteList,
        date: getCurrentDate(),
        DcGenID: pdfpopup_controller.pdfModel.value.manualdcNo.value.text,
        messageType: messageType,
        feedback: pdfpopup_controller.pdfModel.value.feedback.value.text,
        ccEmail: pdfpopup_controller.pdfModel.value.CCemailController.value.text,
      );

      await send_data(context, jsonEncode(salesData.toJson()), cachedPdf);
    } catch (e) {
      await Basic_dialog(context: context, title: "POST", content: "$e", onOk: () {}, showCancel: false);
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, file, API.add_salesCustomDc);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Basic_dialog(context: context, title: "Dc", content: value.message!, onOk: () {}, showCancel: false);
          // Navigator.of(context).pop(true);
          // DcController.resetData();
        } else {
          loader.stop();
          await Basic_dialog(context: context, title: 'Processing Dc', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        loader.stop();
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      //await Refresher().refreshAll(context);
    } catch (e) {
      loader.stop();
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
    }
  }
}
