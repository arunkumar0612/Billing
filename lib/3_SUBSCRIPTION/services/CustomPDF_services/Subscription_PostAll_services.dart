import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/CustomPDF_Controllers/SUBSCRIPTION_CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/Subscription_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/models/entities/CustomPDF_entities/CustomPDF_invoice_entities.dart';
import 'package:ssipl_billing/API/api.dart' show API;
import 'package:ssipl_billing/API/invoker.dart' show Invoker;
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart' show CMDlResponse, CMDmResponse;
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart' show SessiontokenController;
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin SUBSCRIPTION_PostServices {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final SUBSCRIPTION_CustomPDF_InvoiceController pdfpopup_controller = Get.find<SUBSCRIPTION_CustomPDF_InvoiceController>();
  final loader = LoadingOverlay();
  final Invoker apiController = Get.find<Invoker>();
  final SubscriptionController subscriptionController = Get.find<SubscriptionController>();
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    pdfpopup_controller.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    pdfpopup_controller.setpdfLoading(true);
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

  dynamic postData(context, int messageType) async {
    try {
      if (pdfpopup_controller.postDatavalidation()) {
        await Error_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
      File cachedPdf = pdfpopup_controller.pdfModel.value.genearatedPDF.value!;
      // savePdfToCache();
      PostInvoice subscriptionData = PostInvoice(
          siteIds: [], // Provide a valid list of integers
          subscriptionBillId: "0", // Provide a valid subscription bill ID
          billingAddressName: pdfpopup_controller.pdfModel.value.billingName.value.text, // Provide billing address name
          billingAddress: pdfpopup_controller.pdfModel.value.billingAddress.value.text, // Provide billing address
          installation_serviceAddressName: pdfpopup_controller.pdfModel.value.installation_serviceName.value.text, // Provide billing address name
          installation_serviceAddress: pdfpopup_controller.pdfModel.value.installation_serviceAddres.value.text, // Provide billing address
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
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  Future<void> Get_subscriptionCustomPDFLsit() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_subscriptionCustompdf);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          subscriptionController.addToCustompdfList(value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Processcustomer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.subscription_addCustomInvoice_API);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Success_dialog(context: context, title: "Invoice", content: value.message!, onOk: () {});
          Get_subscriptionCustomPDFLsit();
          // Navigator.of(context).pop(true);
          // invoiceController.resetData();
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
