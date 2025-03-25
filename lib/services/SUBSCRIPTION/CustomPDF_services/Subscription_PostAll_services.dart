import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';

import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/CustomPDF_Controllers/SUBSCRIPTION_CustomPDF_Invoice_actions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:ssipl_billing/models/constants/api.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/services/APIservices/invoker.dart';
import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';

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
  // dynamic postData(context, int messageType) async {
  //   try {
  //     if (invoiceController.postDatavalidation()) {
  //       await Basic_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {}, showCancel: false);
  //       return;
  //     }
  //     File cachedPdf = invoiceController.invoiceModel.selectedPdf.value!;
  //     // savePdfToCache();
  //     Post_Invoice salesData = Post_Invoice.fromJson(
  //         title: invoiceController.invoiceModel.TitleController.value.text,
  //         processid: invoiceController.invoiceModel.processID.value!,
  //         ClientAddressname: invoiceController.invoiceModel.clientAddressNameController.value.text,
  //         ClientAddress: invoiceController.invoiceModel.clientAddressController.value.text,
  //         billingAddressName: invoiceController.invoiceModel.billingAddressNameController.value.text,
  //         billingAddress: invoiceController.invoiceModel.billingAddressController.value.text,
  //         emailId: invoiceController.invoiceModel.emailController.value.text,
  //         phoneNo: invoiceController.invoiceModel.phoneController.value.text,
  //         gst: invoiceController.invoiceModel.gstController.value.text,
  //         product: invoiceController.invoiceModel.Invoice_products,
  //         notes: invoiceController.invoiceModel.Invoice_noteList,
  //         date: getCurrentDate(),
  //         invoiceGenID: invoiceController.invoiceModel.Invoice_no.value!,
  //         messageType: messageType,
  //         feedback: invoiceController.invoiceModel.feedbackController.value.text,
  //         ccEmail: invoiceController.invoiceModel.CCemailController.value.text,
  //         total_amount: invoiceController.invoiceModel.invoice_amount.value!);

  //     await send_data(context, jsonEncode(salesData.toJson()), cachedPdf);
  //   } catch (e) {
  //     await Basic_dialog(context: context, title: "POST", content: "$e", onOk: () {}, showCancel: false);
  //   }
  // }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, file, API.add_invoice);
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
