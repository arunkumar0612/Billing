import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin InvoicedetailsService {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  void nextTab() {
    if (invoiceController.invoiceModel.detailsKey.value.currentState?.validate() ?? false) {
      invoiceController.nextTab();
    }
  }

  /// Fetches and preloads required sales data based on the given event ID and event type.
  ///
  /// This method is typically used to initialize or preload form fields or dependent data
  /// before navigating to or displaying a new screen, such as a quotation or invoice editor.
  ///
  /// **Functionality:**
  /// 1. Constructs a query string using the provided `eventID` and `eventType`.
  /// 2. Calls the API endpoint `sales_detailsPreLoader_API` using `apiController.GetbyQueryString`.
  /// 3. Parses the response into a `CMDmResponse` object.
  /// 4. If the response is successful (`value.code == true`), updates `invoiceController` with the loaded data.
  /// 5. If the response fails or server returns an error, shows an appropriate error dialog and closes the dialog/screen.
  ///
  /// **Parameters:**
  /// - `context`: Build context for showing dialogs and handling UI-related operations.
  /// - `eventID`: The unique identifier of the event to fetch data for.
  /// - `eventType`: A string describing the type of event (e.g., 'enquiry', 'quote').
  ///
  /// **Error Handling:**
  /// - On server error or failure in the API call, an error dialog is displayed.
  /// - Automatically pops the current screen (`Navigator.of(context).pop()`) on failure.
  ///
  /// **Use Case:**
  /// - Used to preload data when opening a quotation/invoice dialog based on an existing event.
  void get_requiredData(context, int eventID, String eventType) async {
    try {
      Map<String, dynamic> body = {"eventid": eventID, "eventtype": eventType};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.sales_detailsPreLoader_API);

      // print(response);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          // Navigator.of(context).pop();
          invoiceController.update_requiredData(value);
          // print(clientreqController.clientReqModel.Enq_ID.value);
          // salesController.addToCustomerList(value);
        } else {
          await Error_dialog(context: context, title: 'PRE - LOADER', content: value.message ?? "", onOk: () {});
          Navigator.of(context).pop();
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
        Navigator.of(context).pop();
      }
    } catch (e) {
      Error_dialog(
        context: context,
        title: "ERROR",
        content: "$e",
      );
      Navigator.of(context).pop();
    }
  }

  /// Fetches the list of product suggestions used in the sales invoice module.
  ///
  /// This method retrieves pre-configured or recommended products from the backend
  /// to assist users during quotation or invoice creation by providing a quick-select list.
  ///
  /// **Functionality:**
  /// 1. Sends a GET request to the API endpoint `sales_getProduct_SUGG_List` using the session token.
  /// 2. If the response status is 200 and the response `code` is true, updates the
  ///    product suggestion list in `invoiceController` using the retrieved data.
  /// 3. If the response `code` is false or an error occurs, displays an error dialog
  ///    and pops the current screen (usually a dialog or page).
  ///
  /// **Parameters:**
  /// - `context`: Build context for displaying dialogs and handling navigation.
  ///
  /// **Error Handling:**
  /// - Shows an error dialog with a custom message if the server responds with a failure.
  /// - Automatically closes the dialog or screen on failure via `Navigator.of(context).pop()`.
  ///
  /// **Use Case:**
  /// - To provide a ready list of frequently used or recommended products in sales workflows like invoices or quotes.
  void get_productSuggestionList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getProduct_SUGG_List);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          invoiceController.add_productSuggestion(value.data);
        } else {
          await Error_dialog(context: context, title: 'PRE - LOADER', content: value.message ?? "", onOk: () {});
          Navigator.of(context).pop();
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
        Navigator.of(context).pop();
      }
    } catch (e) {
      Error_dialog(
        context: context,
        title: "ERROR",
        content: "$e",
      );
      Navigator.of(context).pop();
    }
  }

  /// Fetches the list of predefined note suggestions for invoices or quotations.
  ///
  /// This method is used to retrieve commonly used note templates (such as terms & conditions,
  /// footer notes, or general remarks) from the backend to assist users during invoice/quote creation.
  ///
  /// **Functionality:**
  /// - Sends a GET request to the API endpoint `sales_getNote_SUGG_List` using token-based authentication.
  /// - On a successful response (`statusCode == 200` and `code == true`), it adds the note suggestions
  ///   to the `invoiceController` using `add_noteSuggestion()`.
  /// - If the response fails or contains an error, it displays an appropriate error dialog
  ///   and exits the current screen using `Navigator.of(context).pop()`.
  ///
  /// **Parameters:**
  /// - `context`: The current build context, used to show dialogs or pop navigation.
  ///
  /// **Debug Logging:**
  /// - Prints the raw API response if `kDebugMode` is enabled (for development troubleshooting).
  ///
  /// **Use Case:**
  /// - Used when generating sales documents to auto-fill optional or mandatory notes for quicker workflow.
  ///
  /// **Error Handling:**
  /// - Handles and reports server errors, network issues, or invalid responses gracefully with user feedback.
  void get_noteSuggestionList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getNote_SUGG_List);

      if (kDebugMode) {
        print(response);
      }
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          invoiceController.add_noteSuggestion(value.data);
          // await Basic_dialog(context: context, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          // invoiceController.update_requiredData(value);
          // print(clientreqController.clientReqModel.Enq_ID.value);
          // salesController.addToCustomerList(value);
        } else {
          await Error_dialog(context: context, title: 'PRE - LOADER', content: value.message ?? "", onOk: () {});
          Navigator.of(context).pop();
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
        Navigator.of(context).pop();
      }
    } catch (e) {
      Error_dialog(
        context: context,
        title: "ERROR",
        content: "$e",
      );
      Navigator.of(context).pop();
    }
  }
}
