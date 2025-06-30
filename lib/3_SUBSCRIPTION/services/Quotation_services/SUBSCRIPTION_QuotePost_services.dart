import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart' show SUBSCRIPTION_QuoteController;
import 'package:ssipl_billing/3_SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart' show PostSubQuote;
import 'package:ssipl_billing/API/api.dart' show API;
import 'package:ssipl_billing/API/invoker.dart' show Invoker;
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart' show Error_dialog, Success_dialog;
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart' show CMDmResponse;
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart' show SessiontokenController;
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart' show getCurrentDate;
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin SUBSCRIPTION_QuotePostServices {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();
// Function to control the animation of the PDF loading
  /// This function controls the animation of the PDF loading.
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    quoteController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    quoteController.setpdfLoading(true);
  }

  /// Sends the selected PDF file to the printer for layout and printing.
  ///
  /// - Logs the selected PDF file path in debug mode.
  /// - Uses the `Printing.layoutPdf` API to send the file bytes to the printing layout.
  /// - Catches and logs any errors that occur during the printing process.

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

  /// Posts the quotation data to the server along with the generated PDF.
  ///
  /// - Validates form fields using `quoteController.postDatavalidation()`.
  /// - If validation fails, displays an error dialog and exits.
  /// - If valid, constructs a `PostSubQuote` object from current quote model values.
  /// - Includes fields such as company ID, process ID, addresses, package list, notes,
  ///   contact details, GST, and feedback.
  /// - Converts the data to JSON and sends it with the cached PDF file using `send_data()`.
  /// - Handles exceptions and displays an error dialog if any issue occurs during posting.
  dynamic postData(context, int messageType, String eventtype) async {
    try {
      if (quoteController.postDatavalidation()) {
        await Error_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
      File cachedPdf = quoteController.quoteModel.selectedPdf.value!;

      PostSubQuote data = PostSubQuote.fromJson({
        "companyid": quoteController.quoteModel.companyid.value,
        "processid": quoteController.quoteModel.processID.value!,
        "clientaddressname": quoteController.quoteModel.clientAddressNameController.value.text,
        "clientaddress": quoteController.quoteModel.clientAddressController.value.text,
        "billingaddress": quoteController.quoteModel.billingAddressNameController.value.text,
        "billingaddressname": quoteController.quoteModel.billingAddressController.value.text,
        "packagedetails": quoteController.quoteModel.selectedPackagesList,
        "notes": quoteController.quoteModel.Quote_noteList,
        "emailid": quoteController.quoteModel.emailController.value.text,
        "phoneno": quoteController.quoteModel.phoneController.value.text,
        "ccemail": quoteController.quoteModel.CCemailController.value.text,
        "date": getCurrentDate(),
        "quotationgenid": quoteController.quoteModel.Quote_no.value!,
        "messagetype": messageType,
        "gstpercent": 18,
        "gst_number": quoteController.quoteModel.gstNumController.value.text,
        "feedback": quoteController.quoteModel.feedbackController.value.text
      });

      await send_data(context, jsonEncode(data.toJson()), cachedPdf, eventtype);
    } catch (e) {
      loader.stop();
      await Error_dialog(
        context: context,
        title: "POST",
        content: "$e",
        onOk: () {},
      );
      loader.stop();
    }
  }

  /// Sends the quotation or revised quotation data to the backend server.
  ///
  /// - Accepts `jsonData` (serialized quotation data), `file` (PDF file), and `eventtype`.
  /// - Based on `eventtype`, it selects the appropriate API endpoint (quotation or revised quotation).
  /// - Uploads data using `apiController.Multer` with session token and attached PDF file.
  /// - If the server returns success (`statusCode == 200` and `value.code == true`):
  ///   - Shows a success dialog.
  ///   - Pops the current screen with success status.
  ///   - Resets the quote controller data.
  /// - If the response indicates failure:
  ///   - Displays an error dialog with the error message.
  /// - Catches and displays any exceptions encountered during the process.
  dynamic send_data(context, String jsonData, File file, String eventtype) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(
          sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], eventtype == "quotation" ? API.subscriptionadd_Quotation : API.subscription_add_RevisedQuotation);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Success_dialog(context: context, title: "Quotation", content: value.message!, onOk: () {});
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
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
