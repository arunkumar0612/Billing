import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4_SALES/controllers/CustomPDF_Controllers/CustomPDF_DC_actions.dart';
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

mixin PostServices {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final CustomPDF_DcController pdfpopup_controller = Get.find<CustomPDF_DcController>();
  final loader = LoadingOverlay();
  final Invoker apiController = Get.find<Invoker>();
  final SalesController salesController = Get.find<SalesController>();

  /// Controls the PDF loading animation by toggling the loading state
  /// in the `pdfpopup_controller` with a simulated delay.
  ///
  /// Steps:
  /// 1. Immediately sets the loading state to `false`, indicating the
  ///    start of the animation or loading transition.
  /// 2. Waits for a duration (currently 4 seconds) using `Future.delayed`,
  ///    simulating a processing or loading period.
  /// 3. After the delay, sets the loading state back to `true`, which can
  ///    be used to trigger UI updates like showing the generated PDF or
  ///    stopping the animation.
  ///
  /// Returns:
  /// - A [Future] that completes after the delay and state update.
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    pdfpopup_controller.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    pdfpopup_controller.setpdfLoading(true);
  }

  /// Sends the generated PDF file to the printer using the `printing` package.
  ///
  /// This function performs the following steps:
  /// 1. Logs the selected PDF file path in debug mode for verification.
  /// 2. Attempts to read the bytes from the previously generated PDF file
  ///    stored in the `pdfModel`.
  /// 3. Uses `Printing.layoutPdf` to open the native print dialog and send
  ///    the PDF data for printing.
  ///
  /// Any exceptions during printing are caught and logged in debug mode
  /// to assist with troubleshooting issues such as missing files or printer errors.
  ///
  /// Returns:
  /// - A [Future] that completes after the printing operation is initiated or fails.
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

  /// Validates form input, constructs a delivery challan data model,
  /// and sends the PDF and data to the backend for posting.
  ///
  /// Workflow:
  /// 1. Checks if all required form fields are filled using the controller's validation method.
  ///    - If validation fails, an error dialog is shown and the function returns early.
  /// 2. Starts a loading indicator using `loader.start`.
  /// 3. Retrieves the previously generated PDF file from the controller.
  /// 4. Constructs a `Post_CustomDc` model from the current user input,
  ///    including client details, billing address, contact info, date, DC number,
  ///    feedback, CC email, and message type.
  /// 5. Serializes the model to JSON and sends it along with the PDF
  ///    using the `send_data` method.
  /// 6. Catches and displays any exceptions that occur during the process
  ///    using an error dialog.
  ///
  /// Parameters:
  /// - [context]: The current build context for showing dialogs and loaders.
  /// - [messageType]: An integer indicating the type of message or dispatch behavior.
  ///
  /// Returns:
  /// - A [Future] that completes once the data is posted or an error occurs.
  dynamic postData(context, int messageType) async {
    try {
      if (pdfpopup_controller.postDatavalidation()) {
        await Error_dialog(
          context: context,
          title: "POST",
          content: "All fields must be filled",
          onOk: () {},
        );
        return;
      }
      loader.start(context);
      File cachedPdf = pdfpopup_controller.pdfModel.value.genearatedPDF.value!;
      // savePdfToCache();
      Post_CustomDc salesData = Post_CustomDc.fromJson(
        ClientAddressname: pdfpopup_controller.pdfModel.value.clientName.value.text,
        ClientAddress: pdfpopup_controller.pdfModel.value.clientAddress.value.text,
        billingAddressName: pdfpopup_controller.pdfModel.value.billingName.value.text,
        billingAddress: pdfpopup_controller.pdfModel.value.billingAddres.value.text,
        emailId: pdfpopup_controller.pdfModel.value.Email.value.text,
        phoneNo: pdfpopup_controller.pdfModel.value.phoneNumber.value.text,
        gst: pdfpopup_controller.pdfModel.value.GSTnumber.value.text,
        // product: pdfpopup_controller.pdfModel.value.Dc_products,
        // notes: pdfpopup_controller.pdfModel.value.Dc_noteList,
        date: getCurrentDate(),
        DcGenID: pdfpopup_controller.pdfModel.value.manualdcNo.value.text,
        messageType: messageType,
        feedback: pdfpopup_controller.pdfModel.value.feedback.value.text,
        ccEmail: pdfpopup_controller.pdfModel.value.CCemailController.value.text,
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

  /// Fetches the list of custom sales PDFs from the backend API using an authenticated request.
  ///
  /// Steps:
  /// 1. Sends a GET request to the `get_salesCustompdf` endpoint using `GetbyToken`.
  /// 2. If the response has a 200 status code:
  ///    - Parses the response into a `CMDlResponse` model.
  ///    - If the response `code` is true, it adds the result to the sales controller's custom PDF list.
  ///    - Otherwise, logs the error message in debug mode.
  /// 3. If the response status code is not 200, logs a generic administration error in debug mode.
  /// 4. If an exception occurs during the request, catches and logs it in debug mode.
  ///
  /// This function is designed to silently handle failures during fetch,
  /// but debug logs are used for development visibility.
  ///
  /// Returns:
  /// - A [Future] that completes once the API call and processing are done.
  Future<void> Get_salesCustomPDFLsit() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_salesCustompdf);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          salesController.addToCustompdfList(value);
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

  /// Sends the delivery challan data and associated PDF file to the backend server using a multipart request.
  ///
  /// Workflow:
  /// 1. Uses the `apiController.Multer` method to send the session token, JSON data,
  ///    and PDF file to the `add_salesCustomDc` API endpoint.
  /// 2. If the response has a status code of 200:
  ///    - Parses the response into a `CMDmResponse` object.
  ///    - If the `code` field is true:
  ///       - Stops the loader.
  ///       - Shows a success dialog with the response message.
  ///       - Refreshes the sales custom PDF list by calling `Get_salesCustomPDFLsit()`.
  ///    - If the `code` is false:
  ///       - Stops the loader.
  ///       - Displays an error dialog with the response message.
  /// 3. If the response status code is not 200:
  ///    - Stops the loader.
  ///    - Displays a "SERVER DOWN" error dialog.
  /// 4. If an exception occurs:
  ///    - Stops the loader.
  ///    - Shows a generic error dialog with the exception message.
  ///
  /// Parameters:
  /// - [context]: The current build context for showing dialogs and controlling UI state.
  /// - [jsonData]: The JSON string representing the delivery challan data.
  /// - [file]: The PDF file to be uploaded with the request.
  ///
  /// Returns:
  /// - A [Future] that completes once the request is handled and dialogs are shown.
  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.add_salesCustomDc);
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
          Get_salesCustomPDFLsit();
          // Navigator.of(context).pop(true);
          // pdfpopup_controller.pdfModel.value.resetData();
        } else {
          loader.stop();
          await Error_dialog(
            context: context,
            title: 'Processing Dc',
            content: value.message ?? "",
            onOk: () {},
          );
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
      Error_dialog(
        context: context,
        title: "ERROR",
        content: "$e",
      );
    }
  }
}
