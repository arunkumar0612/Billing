import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4.SALES/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Invoice_entities.dart';
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
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    invoiceController.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    invoiceController.setpdfLoading(true);
  }

  void showReadablePdf(context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
          height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
          child: SfPdfViewer.file(invoiceController.invoiceModel.selectedPdf.value!),
        ),
      ),
    );
  }

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

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, file, API.add_invoice);
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
