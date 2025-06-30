import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/4_SALES/controllers/CustomPDF_Controllers/CustomPDF_Invoice_actions.dart';
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
  final CustomPDF_InvoiceController pdfpopup_controller = Get.find<CustomPDF_InvoiceController>();
  final loader = LoadingOverlay();
  final Invoker apiController = Get.find<Invoker>();
  final SalesController salesController = Get.find<SalesController>();

  /// Controls a PDF loading animation sequence with a delay.
  ///
  /// This asynchronous function manages the state of a PDF loading indicator,
  /// typically used to provide visual feedback to the user during PDF generation
  /// or processing.
  ///
  /// **Process:**
  /// 1.  **Initial Loading State:**
  ///     - `pdfpopup_controller.setpdfLoading(false)` is called immediately.
  ///       This suggests that the loading indicator is initially turned OFF,
  ///       perhaps because a previous process just finished or the loading
  ///       animation is about to start.
  /// 2.  **Simulated Delay/Waiting:**
  ///     - `await Future.wait([...])` is used to pause the execution.
  ///       - `Future.delayed(const Duration(seconds: 4))`: This specifically
  ///         introduces a **4-second delay**. This delay acts as a placeholder
  ///         for a long-running operation (like `widget.savePdfToCache()` which
  ///         is commented out but likely intended to be part of this wait).
  ///         The `Future.wait` ensures that all provided futures complete before
  ///         proceeding.
  /// 3.  **Final Loading State:**
  ///     - After the 4-second delay, `pdfpopup_controller.setpdfLoading(true)`
  ///       is called. This action turns the loading indicator ON, implying that
  ///       the (simulated or real) PDF generation/saving process has completed,
  ///       and the UI is now ready to display the PDF or transition to a new state.
  ///
  /// **Note:** The commented-out `widget.savePdfToCache()` suggests that this
  /// function was designed to include an actual PDF saving operation, which is
  /// currently replaced by a fixed 4-second delay for demonstration or testing purposes.
  void animation_control() async {
    // await Future.delayed(const Duration(milliseconds: 200));
    pdfpopup_controller.setpdfLoading(false);

    await Future.wait([
      // widget.savePdfToCache(),
      Future.delayed(const Duration(seconds: 4))
    ]);

    pdfpopup_controller.setpdfLoading(true);
  }

  /// Initiates the printing process for a generated PDF file.
  ///
  /// This asynchronous function leverages the `printing` package to provide
  /// print functionality for a PDF document that has been previously generated
  /// and stored in the `pdfpopup_controller.pdfModel`.
  ///
  /// **Process:**
  /// 1.  **Debug Logging:**
  ///     - In debug mode (`kDebugMode`), the path of the selected PDF file
  ///       (`pdfpopup_controller.pdfModel.value.genearatedPDF.value`) is printed
  ///       to the console for debugging purposes.
  /// 2.  **Printing Execution:**
  ///     - A `try-catch` block is used to handle potential errors during the
  ///       printing process.
  ///     - `await Printing.layoutPdf`: This is the core method from the `printing`
  ///       package that triggers the print dialog and manages the PDF layout for printing.
  ///       - `onLayout`: This callback function is executed when the printing
  ///         plugin requests the PDF data.
  ///         - It receives a `PdfPageFormat` object, although it's not directly
  ///           used in this specific implementation to modify the PDF content,
  ///           it provides information about the printer's page format.
  ///         - `final pdfBytes = await pdfpopup_controller.pdfModel.value.genearatedPDF.value!.readAsBytes();`
  ///           reads the entire content of the generated PDF file (stored as a `File` object)
  ///           into a `Uint8List` (byte array). The `!` asserts that `genearatedPDF.value`
  ///           is not null.
  ///         - `return pdfBytes;`: The byte data of the PDF is returned to the
  ///           printing plugin, which then renders it for printing.
  /// 3.  **Error Handling:**
  ///     - If any exception occurs during the `Printing.layoutPdf` call (e.g.,
  ///       printer not found, file access issues), the `catch` block will
  ///       execute.
  ///     - In debug mode, an error message detailing the exception is printed
  ///       to the console.
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

  /// Attempts to post invoice data, including a generated PDF, to a backend.
  ///
  /// This asynchronous function handles the process of validating invoice data,
  /// preparing it for submission, and then sending it along with the cached PDF
  /// to a backend service. It includes error handling and visual feedback for the user.
  ///
  /// **Process:**
  /// 1.  **Data Validation:**
  ///     - `pdfpopup_controller.postDatavalidation()` is called to check if all
  ///       necessary fields for posting the data are filled.
  ///     - If validation fails (returns `true`, indicating an issue), an `Error_dialog`
  ///       is shown to the user with the message "All fields must be filled", and
  ///       the function returns, preventing further execution.
  /// 2.  **Initiate Loading Indicator:**
  ///     - `loader.start(context)` is called to display a loading indicator
  ///       (e.g., a spinner) to the user, signaling that a background operation
  ///       is in progress.
  /// 3.  **Retrieve Cached PDF:**
  ///     - The previously generated and cached PDF file is retrieved from
  ///       `pdfpopup_controller.pdfModel.value.genearatedPDF.value!`. The `!`
  ///       asserts that the value will not be null at this point, implying
  ///       `savePdfToCache()` must have been called successfully prior to this.
  /// 4.  **Prepare Data for Posting:**
  ///     - A `Post_CustomInvoice` object is created using `Post_CustomInvoice.fromJson`.
  ///       This object is populated with various data points extracted from the
  ///       `pdfpopup_controller.pdfModel`, including:
  ///         - Client and billing addresses/names
  ///         - Email, phone number, GST details
  ///         - Current date (`getCurrentDate()`)
  ///         - Invoice generated ID (`manualinvoiceNo`)
  ///         - `messageType` (indicating the type of message/post)
  ///         - Feedback and CC email
  ///         - Total amount
  ///     - Note: `product` and `notes` fields are commented out, indicating they
  ///       are not currently being sent with this particular `Post_CustomInvoice`.
  /// 5.  **Send Data to Backend:**
  ///     - `await send_data(context, jsonEncode(salesData.toJson()), cachedPdf)` is called.
  ///       - `salesData.toJson()` converts the `Post_CustomInvoice` object into a
  ///         JSON-compatible map.
  ///       - `jsonEncode(...)` converts that map into a JSON string.
  ///       - This JSON string and the `cachedPdf` file are then sent to the `send_data`
  ///         function, which is presumed to handle the actual API call to the backend.
  /// 6.  **Error Handling:**
  ///     - A `try-catch` block surrounds the entire operation.
  ///     - If any exception `e` occurs during the process (e.g., network error during `send_data`,
  ///       parsing errors), an `Error_dialog` is shown to the user with the title "POST"
  ///       and the content detailing the error message (`"$e"`). The `onOk` callback is empty,
  ///       simply closing the dialog.
  ///
  /// @param context The `BuildContext` used for showing dialogs and the loader.
  /// @param messageType An integer indicating the type of message or post being made.
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
      Post_CustomInvoice salesData = Post_CustomInvoice.fromJson(
          ClientAddressname: pdfpopup_controller.pdfModel.value.clientName.value.text,
          ClientAddress: pdfpopup_controller.pdfModel.value.clientAddress.value.text,
          billingAddressName: pdfpopup_controller.pdfModel.value.billingName.value.text,
          billingAddress: pdfpopup_controller.pdfModel.value.billingAddres.value.text,
          emailId: pdfpopup_controller.pdfModel.value.Email.value.text,
          phoneNo: pdfpopup_controller.pdfModel.value.phoneNumber.value.text,
          gst: pdfpopup_controller.pdfModel.value.GSTnumber.value.text,
          // product: pdfpopup_controller.pdfModel.value.Invoice_products,
          // notes: pdfpopup_controller.pdfModel.value.Invoice_noteList,
          date: getCurrentDate(),
          invoiceGenID: pdfpopup_controller.pdfModel.value.manualinvoiceNo.value.text,
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

  /// Uploads a custom sales invoice PDF file with associated JSON metadata.
  ///
  /// This function sends a multipart request using the provided JSON data and PDF file
  /// to the `add_salesCustomInvoice` API endpoint. It handles the response to show
  /// success or error dialogs and triggers an update of the sales custom PDF list.
  ///
  /// Parameters:
  /// - [context]: BuildContext used for dialog display and UI operations.
  /// - [jsonData]: A JSON-encoded string containing metadata for the invoice.
  /// - [file]: The PDF file to be uploaded.
  ///
  /// Behavior:
  /// - Displays a success dialog and refreshes the PDF list on success.
  /// - Displays an error dialog with appropriate message on failure.
  /// - Stops the loader in all cases.

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.add_salesCustomInvoice);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
          salesController.Get_salesCustomPDFLsit();

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
