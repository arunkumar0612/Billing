import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4_SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/DC_entities.dart';
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

  /// Controls a timed animation or loading state transition for PDF generation.
  ///
  /// This method performs the following:
  /// 1. Immediately disables the PDF loading indicator by calling `setpdfLoading(false)`.
  /// 2. Waits for 4 seconds using `Future.delayed()` to simulate or allow time for a background task (like PDF generation).
  /// 3. Re-enables the PDF loading indicator by calling `setpdfLoading(true)`.
  ///
  /// **Use Case:**
  /// - Used when triggering an animation or waiting period before displaying a generated PDF.
  /// - Typically useful in UI flows where PDF rendering or preparation needs visual feedback.
  ///
  /// Note: `savePdfToCache()` is commented out but could be included in the wait list if needed.
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    dcController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    dcController.setpdfLoading(true);
  }

  /// Prints the selected PDF file using the `printing` package.
  ///
  /// This method performs the following:
  /// 1. Logs the file path of the selected PDF in debug mode.
  /// 2. Uses `Printing.layoutPdf()` to open the system print dialog and send the PDF for printing.
  /// 3. Reads the PDF file as bytes and returns it for layout.
  /// 4. Catches and logs any errors that occur during the process.
  ///
  /// **Prerequisite:**
  /// - `dcController.dcModel.selectedPdf.value` must point to a valid, non-null `File`.
  ///
  /// **Use Case:**
  /// - Typically triggered from a "Print" button after a PDF is generated or selected by the user.
  ///
  /// Note: Always ensure the file exists before calling this method to avoid null access.
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

  /// Sends the Delivery Challan (DC) data along with the selected PDF file to the server.
  ///
  /// This method performs the following steps:
  /// 1. Validates form data using `dcController.postDatavalidation()`.
  ///    - If validation fails, shows an error dialog and exits early.
  /// 2. Prepares the PDF file from `dcController.dcModel.selectedPdf.value`.
  /// 3. Constructs a `Post_Dc` object using the data filled in the form/UI controllers.
  /// 4. Converts the object to JSON and sends it to the server using `send_data()`, attaching the PDF.
  ///
  /// **Parameters:**
  /// - `context`: The build context, required for dialogs and loader operations.
  /// - `messageType`: An integer indicating how the message should be sent (e.g., 1 = Gmail, 2 = WhatsApp, 3 = both).
  ///
  /// **Preconditions:**
  /// - `selectedPdf` must be a valid, non-null `File`.
  /// - All required fields in `dcController` must be filled correctly.
  ///
  /// **Error Handling:**
  /// - Displays a user-friendly error dialog if validation fails or if any exceptions occur during posting.
  ///
  /// **Typical Use Case:**
  /// - Invoked when the user clicks on "Send" or "Submit" to post DC information along with a PDF.
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

  /// Sends Delivery Challan (DC) data along with a PDF file to the server using multipart upload.
  ///
  /// This method performs the following:
  /// 1. Uses the session token to authenticate the request.
  /// 2. Sends the JSON-encoded DC data (`jsonData`) and the selected PDF file (`file`)
  ///    as multipart form data to the specified API endpoint (`API.add_Dc`) via the `Multer` method.
  /// 3. Parses the response into `CMDmResponse`.
  /// 4. If successful:
  ///    - Shows a success dialog.
  ///    - Pops the current dialog with a success result (`true`).
  ///    - Resets the DC form/controller.
  /// 5. If failed:
  ///    - Displays an error dialog with the response message.
  ///
  /// **Parameters:**
  /// - `context`: Build context used for showing dialogs.
  /// - `jsonData`: A JSON string representing the DC details.
  /// - `file`: A `File` object representing the PDF to upload.
  ///
  /// **Error Handling:**
  /// - Gracefully catches and displays any errors that occur during the network request.
  /// - Uses a loader and appropriate dialogs to inform the user of success or failure.
  ///
  /// **Returns:**
  /// - `void` (asynchronous) — handles UI side-effects, including navigation and controller state reset.
  ///
  /// **Typical Use Case:**
  /// - Called after user submits the DC form and selects a valid PDF file for upload.
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
