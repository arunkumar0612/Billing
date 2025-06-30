import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4_SALES/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Invoice_entities.dart';
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
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();

  /// Controls the PDF loading animation sequence for the invoice UI.
  ///
  /// - Initially sets the PDF loading state to `false`.
  /// - Waits for 4 seconds (can simulate background operations like PDF generation).
  /// - After the delay, sets the PDF loading state back to `true` to indicate completion.
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    invoiceController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    invoiceController.setpdfLoading(true);
  }

  /// Sends the selected invoice PDF to the printer using the `printing` package.
  ///
  /// - Logs the selected PDF file path in debug mode.
  /// - Reads the PDF bytes from the file stored in `invoiceModel.selectedPdf`.
  /// - Uses `Printing.layoutPdf` to open the print dialog and render the document.
  /// - Catches and logs any errors during the printing process.
  Future<void> printPdf() async {
    if (kDebugMode) {
      print('Selected PDF Path: ${invoiceController.invoiceModel.selectedPdf.value}');
    }

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdfBytes = await invoiceController.invoiceModel.selectedPdf.value!.readAsBytes();
          return pdfBytes;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error printing PDF: $e');
      }
    }
  }

  /// Handles the complete process of validating, preparing, and posting invoice data with an attached PDF.
  ///
  /// - Validates form data using `postDatavalidation()`. If invalid, shows an error dialog.
  /// - Initializes the PDF file to be uploaded from the cached selection.
  /// - Constructs a `BillDetails` object with tax components and subtotal/total.
  /// - Converts all necessary invoice fields into a `Post_Invoice` model.
  /// - Sends the data and attached PDF file to the backend via `send_data()` for processing.
  ///
  /// Parameters:
  /// - `context`: Build context used for dialogs.
  /// - `messageType`: Integer indicating the communication method (e.g., email, WhatsApp, or both).
  dynamic postData(context, int messageType) async {
    try {
      if (invoiceController.postDatavalidation()) {
        await Error_dialog(
          context: context,
          title: "ERROR",
          content: "All fields must be filled",
          onOk: () {},
        );
        return;
      }
      loader.start(context);
      File cachedPdf = invoiceController.invoiceModel.selectedPdf.value!;
      var bill = BillDetails(
        total: invoiceController.invoiceModel.invoice_amount.value!,
        subtotal: invoiceController.invoiceModel.invoice_subTotal.value!,
        tdsamount: 0.0, //while genrating a invoice we  cannot know, that client will deduct tds or not
        gst: GST(
          IGST: double.parse((invoiceController.invoiceModel.invoice_IGSTamount.value ?? 0).toStringAsFixed(2)),
          CGST: double.parse((invoiceController.invoiceModel.invoice_CGSTamount.value ?? 0).toStringAsFixed(2)),
          SGST: double.parse((invoiceController.invoiceModel.invoice_SGSTamount.value ?? 0).toStringAsFixed(2)),
        ),
      );
      // savePdfToCache();
      Post_Invoice salesData = Post_Invoice.fromJson(
        title: invoiceController.invoiceModel.TitleController.value.text,
        processid: invoiceController.invoiceModel.processID.value!,
        ClientAddressname: invoiceController.invoiceModel.clientAddressNameController.value.text,
        ClientAddress: invoiceController.invoiceModel.clientAddressController.value.text,
        billingAddressName: invoiceController.invoiceModel.billingAddressNameController.value.text,
        billingAddress: invoiceController.invoiceModel.billingAddressController.value.text,
        emailId: invoiceController.invoiceModel.emailController.value.text,
        phoneNo: invoiceController.invoiceModel.phoneController.value.text,
        gst: invoiceController.invoiceModel.gstController.value.text,
        product: invoiceController.invoiceModel.Invoice_products,
        notes: invoiceController.invoiceModel.Invoice_noteList,
        date: getCurrentDate(),
        invoiceGenID: invoiceController.invoiceModel.Invoice_no.value!,
        messageType: messageType,
        feedback: invoiceController.invoiceModel.feedbackController.value.text,
        ccEmail: invoiceController.invoiceModel.CCemailController.value.text,
        total_amount: invoiceController.invoiceModel.invoice_amount.value!,
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

  /// Sends invoice data along with a PDF file to the server using a multipart request.
  ///
  /// - Uses the `Multer` API to post `jsonData` and the attached file using the current session token.
  /// - On a successful response with status code 200 and a valid server response (`value.code == true`):
  ///   - Stops the loader.
  ///   - Displays a success dialog with the server message.
  ///   - Pops the dialog returning `true`.
  ///   - Resets the invoice form data.
  /// - If the response is invalid or an error message is returned:
  ///   - Stops the loader and shows an error dialog with the returned message.
  /// - Handles server or exception errors gracefully by stopping the loader and showing a fallback error dialog.
  ///
  /// Parameters:
  /// - `context`: Build context used for dialogs.
  /// - `jsonData`: Invoice information serialized as JSON string.
  /// - `file`: The PDF file to be uploaded along with the invoice.
  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.add_invoice);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
          invoiceController.resetData();
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Processing Invoice', content: value.message ?? "", onOk: () {});
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
