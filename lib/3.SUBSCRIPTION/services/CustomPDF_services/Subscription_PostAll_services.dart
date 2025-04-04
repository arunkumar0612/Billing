import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/CustomPDF_Controllers/SUBSCRIPTION_CustomPDF_Invoice_actions.dart' show SUBSCRIPTION_CustomPDF_InvoiceController;
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/CustomPDF_entities/CustomPDF_invoice_entities.dart';
import 'package:ssipl_billing/API-/api.dart' show API;
import 'package:ssipl_billing/API-/invoker.dart' show Invoker;
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart' show Basic_dialog;
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart' show CMDmResponse;
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart' show SessiontokenController;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin SUBSCRIPTION_PostServices {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final SUBSCRIPTION_CustomPDF_InvoiceController pdfpopup_controller = Get.find<SUBSCRIPTION_CustomPDF_InvoiceController>();

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
      File cachedPdf = pdfpopup_controller.pdfModel.value.genearatedPDF.value!;
      // savePdfToCache();
      PostInvoice subscriptionData = PostInvoice(
          siteIds: [], // Provide a valid list of integers
          subscriptionBillId: "0", // Provide a valid subscription bill ID
          clientAddressName: pdfpopup_controller.pdfModel.value.clientName.value.text, // Provide client address name
          clientAddress: pdfpopup_controller.pdfModel.value.clientAddress.value.text, // Provide client address
          billingAddressName: pdfpopup_controller.pdfModel.value.billingName.value.text, // Provide billing address name
          billingAddress: pdfpopup_controller.pdfModel.value.billingAddres.value.text, // Provide billing address
          gst: pdfpopup_controller.pdfModel.value.customerGSTIN.value.text,
          planName: pdfpopup_controller.pdfModel.value.planname.value.text, // Provide the plan name
          emailId: pdfpopup_controller.pdfModel.value.Email.value.text, // Provide email ID
          ccEmail: pdfpopup_controller.pdfModel.value.CCemailController.value.text, // Provide CC email
          phoneNo: pdfpopup_controller.pdfModel.value.phoneNumber.value.text, // Provide phone number
          totalAmount: pdfpopup_controller.pdfModel.value.Total.value.text, // Provide total amount
          invoiceGenId: pdfpopup_controller.pdfModel.value.manualinvoiceNo.value.text, // Provide invoice generation ID
          date: pdfpopup_controller.pdfModel.value.date.value.text, // Provide a date
          messageType: messageType, // Provide a valid message type (integer)
          feedback: pdfpopup_controller.pdfModel.value.feedback.value.text // Provide feedback
          );

      await send_data(context, jsonEncode(subscriptionData.toJson()), cachedPdf);
    } catch (e) {
      await Basic_dialog(context: context, title: "POST", content: "$e", onOk: () {}, showCancel: false);
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, file, API.subscription_addCustomInvoice_API);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Basic_dialog(context: context, title: "Invoice", content: value.message!, onOk: () {}, showCancel: false);
          // Navigator.of(context).pop(true);
          // invoiceController.resetData();
        } else {
          await Basic_dialog(context: context, title: 'Processing Invoice', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
    }
  }
}
