import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4_SALES/controllers/Quote_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Quote_entities.dart';
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
  final QuoteController quoteController = Get.find<QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();

  /// Controls the loading animation for PDF generation.
  ///
  /// - Initially disables the loading state using `setpdfLoading(false)`.
  /// - Waits asynchronously for 4 seconds (acts as a placeholder delay).
  /// - Then re-enables the loading state using `setpdfLoading(true)`.
  ///
  /// This function is typically used to simulate or manage a loading indicator
  /// during a PDF-related operation or UI transition.
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    quoteController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    quoteController.setpdfLoading(true);
  }

  /// Sends the selected PDF file to the print layout for printing.
  ///
  /// - Logs the selected PDF file path in debug mode.
  /// - Uses the `Printing.layoutPdf` method to handle the print layout.
  /// - Reads the PDF file as bytes and returns it for printing.
  /// - Catches and logs any errors during the printing process.
  ///
  /// This function assumes that `selectedPdf` holds a valid `File` object.
  /// Useful for allowing users to print generated quote or invoice PDFs.
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

  /// Prepares and sends the quotation data along with the selected PDF file.
  ///
  /// - Validates the input fields using `postDatavalidation()`.
  ///   If validation fails, shows an error dialog and stops execution.
  /// - Starts a loading indicator using `loader.start(context)`.
  /// - Retrieves the cached PDF file from the `selectedPdf` field.
  /// - Constructs a `Post_Quotation` object using the values from `quoteController`.
  /// - Converts the quotation object to JSON.
  /// - Calls `send_data()` to post the JSON data and PDF to the backend.
  /// - Catches and displays any exceptions in an error dialog.
  ///
  /// This function is used to submit a completed quotation to the server.
  dynamic postData(context, int messageType, String eventtype) async {
    try {
      if (quoteController.postDatavalidation()) {
        await Error_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
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
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  /// Sends the quotation or revised quotation data to the backend using a multipart request.
  ///
  /// - Uses the `Multer` function from `apiController` to upload both the JSON data and the attached PDF file.
  /// - Determines the correct API endpoint based on the `eventtype` value (`"quotation"` or `"revised"`).
  /// - On success (status code 200 and response `code == true`), it:
  ///   - Stops the loader
  ///   - Displays a success dialog
  ///   - Pops the current screen and resets the form data
  /// - If the backend returns an error code or status, it:
  ///   - Stops the loader
  ///   - Shows an error dialog with the backend message
  /// - If the server is unreachable or the request fails, it:
  ///   - Stops the loader
  ///   - Displays a generic server down or error dialog
  dynamic send_data(context, String jsonData, File file, String eventtype) async {
    try {
      Map<String, dynamic>? response =
          await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], eventtype == "quotation" ? API.add_Quotation : API.add_RevisedQuotation);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
          quoteController.resetData();
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Processing Quotation', content: value.message ?? "", onOk: () {});
        }
      } else {
        loader.stop();
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      //await Refresher().refreshAll(context);
    } catch (e) {
      loader.stop();
      Error_dialog(
        context: context,
        title: "ERROR",
        content: "$e",
      );
    }
  }
}
