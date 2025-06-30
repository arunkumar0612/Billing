import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4_SALES/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/RFQ_entities.dart';
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

  /// Controls the loading animation timing for PDF generation.
  ///
  /// - Initially sets the PDF loading flag to false.
  /// - Waits for a fixed delay (4 seconds) to simulate processing time.
  /// - After the delay, sets the PDF loading flag back to true.
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    rfqController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    rfqController.setpdfLoading(true);
  }

  /// Sends the selected RFQ PDF to the printer using the `printing` package.
  ///
  /// - Reads the PDF file from the `selectedPdf` in the RFQ model.
  /// - Uses `Printing.layoutPdf` to trigger the print layout dialog with the PDF data.
  /// - Logs the selected PDF path and any errors during printing in debug mode.
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

  /// Prepares and posts the RFQ data along with the selected PDF to the server.
  ///
  /// - Validates required fields using `postDatavalidation()`.
  ///   - If validation fails, shows an error dialog and exits.
  /// - Starts a loading indicator.
  /// - Retrieves the cached PDF file from the RFQ model.
  /// - Constructs a `Post_Rfq` object with all necessary RFQ details.
  /// - Serializes the object to JSON and sends it along with the PDF using `send_data`.
  /// - Catches and displays any exceptions in an error dialog.
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

  /// Sends the RFQ JSON data and PDF file to the server using a multipart request.
  ///
  /// - Uses the session token for authentication and calls the `Multer` API endpoint.
  /// - On a successful response (`statusCode == 200` and `code == true`):
  ///   - Stops the loader, shows a success dialog, navigates back with success, and resets the RFQ data.
  /// - If the response fails, stops the loader and shows an appropriate error dialog.
  /// - Handles exceptions by stopping the loader and displaying an error dialog with the exception details.
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
