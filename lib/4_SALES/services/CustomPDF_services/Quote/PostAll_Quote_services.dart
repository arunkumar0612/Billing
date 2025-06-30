import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4_SALES/controllers/CustomPDF_Controllers/CustomPDF_Quote_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/Sales_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/CustomPDF_entities/CustomPDF_Product_entities.dart';
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

  /// Controls the animation timing for showing the PDF loading state.
  ///
  /// This method:
  /// - Immediately sets the `pdfLoading` state to `false` using `pdfpopup_controller.setpdfLoading(false)`,
  ///   which typically stops or hides any loading indicator.
  /// - Waits for 4 seconds asynchronously (simulating a delay or animation duration).
  /// - Then sets the `pdfLoading` state to `true`, indicating that the loading or transition is complete.
  ///
  /// Note:
  /// - Any previously planned `savePdfToCache()` call is commented out but may be reinstated later.
  /// - Useful for triggering animations or transitions that depend on timing and PDF generation status.
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    pdfpopup_controller.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    pdfpopup_controller.setpdfLoading(true);
  }

  /// Sends the currently generated PDF to the printer using the `printing` package.
  ///
  /// This method:
  /// - Logs the selected PDF file path in debug mode.
  /// - Uses `Printing.layoutPdf` to initiate the print dialog and provide the PDF bytes.
  /// - Reads the bytes from the file stored in `pdfpopup_controller.pdfModel.value.genearatedPDF`.
  /// - Catches and logs any errors that occur during the printing process.
  ///
  /// Note:
  /// - This function assumes that the generated PDF file is not null and is already stored on disk.
  /// - The `PdfPageFormat` passed to `onLayout` is ignored since the layout is already finalized.
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

  /// Validates form fields and sends the custom quote PDF and associated metadata to the server.
  ///
  /// This method performs the following:
  /// - Validates if all required fields are filled using `pdfpopup_controller.postDatavalidation()`.
  ///   - If validation fails, it shows an error dialog and exits early.
  /// - Retrieves the cached/generated PDF file from `pdfpopup_controller`.
  /// - Constructs a `Post_CustomQuote` object with:
  ///   - Client and billing addresses
  ///   - Contact details (email, phone, GST)
  ///   - Quote metadata (date, quote number, feedback, etc.)
  /// - Serializes the quote object to JSON and sends it to the server using the `send_data()` function along with the PDF.
  ///
  /// Parameters:
  /// - `context`: Build context used for dialog and loading overlay.
  /// - `messageType`: Integer representing how the PDF should be sent (e.g., email, WhatsApp, or both).
  ///
  /// Catches and shows any errors via a dialog box.
  ///
  /// **Note:** The `product` and `notes` fields are commented out and can be included if needed.
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

  /// Uploads a custom sales quote and its associated PDF file to the server using a multipart/form-data request.
  ///
  /// This method:
  /// - Sends the provided `jsonData` along with the `file` using the `apiController.Multer` function.
  /// - Uses the current session token for authentication.
  /// - On success:
  ///   - Parses the response into a `CMDmResponse` object.
  ///   - Shows a success dialog with the message from the server.
  ///   - Triggers a refresh of the custom sales quote list using `salesController.Get_salesCustomPDFLsit()`.
  /// - On failure:
  ///   - Displays an error dialog with the server's error message or a generic error if the server is unreachable.
  ///
  /// Parameters:
  /// - `context`: Build context for showing dialogs.
  /// - `jsonData`: JSON string containing all the quote metadata.
  /// - `file`: The PDF file to be uploaded with the request.
  ///
  /// **Note:** The loader is stopped in all branches to ensure the UI is updated correctly even in case of exceptions.
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
