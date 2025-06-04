import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4.SALES/controllers/CustomPDF_Controllers/CustomPDF_Quote_actions.dart';
import 'package:ssipl_billing/4.SALES/controllers/Sales_actions.dart';
import 'package:ssipl_billing/4.SALES/models/entities/CustomPDF_entities/CustomPDF_Product_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin salesCustom_PostServices {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final CustomPDF_QuoteController pdfpopup_controller = Get.find<CustomPDF_QuoteController>();
  final loader = LoadingOverlay();
  final Invoker apiController = Get.find<Invoker>();
  final SalesController salesController = Get.find<SalesController>();

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
        await Error_dialog(context: context, title: "Error", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
      File cachedPdf = pdfpopup_controller.pdfModel.value.genearatedPDF.value!;
      // savePdfToCache();
      Post_CustomQuote salesData = Post_CustomQuote.fromJson(
          ClientAddressname: pdfpopup_controller.pdfModel.value.clientName.value.text,
          ClientAddress: pdfpopup_controller.pdfModel.value.clientAddress.value.text,
          billingAddressName: pdfpopup_controller.pdfModel.value.billingName.value.text,
          billingAddress: pdfpopup_controller.pdfModel.value.billingAddres.value.text,
          emailId: pdfpopup_controller.pdfModel.value.Email.value.text,
          phoneNo: pdfpopup_controller.pdfModel.value.phoneNumber.value.text,
          gst: pdfpopup_controller.pdfModel.value.GSTnumber.value.text,
          // product: pdfpopup_controller.pdfModel.value.Quote_products,
          // notes: pdfpopup_controller.pdfModel.value.Quote_noteList,
          date: getCurrentDate(),
          QuoteGenID: pdfpopup_controller.pdfModel.value.manualquoteNo.value.text,
          messageType: messageType,
          feedback: pdfpopup_controller.pdfModel.value.feedback.value.text,
          ccEmail: pdfpopup_controller.pdfModel.value.CCemailController.value.text,
          total_amount: pdfpopup_controller.pdfModel.value.Total_amount.value);

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
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.add_salesCustomQuote);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Success_dialog(
            context: context,
            title: "Quote",
            content: value.message!,
            onOk: () {},
          );
          salesController.Get_salesCustomPDFLsit();

          // Navigator.of(context).pop(true);
          // QuoteController.resetData();
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Processing Quote', content: value.message ?? "", onOk: () {});
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
