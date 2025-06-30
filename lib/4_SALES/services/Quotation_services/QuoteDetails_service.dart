import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/Quote_actions.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin QuotedetailsService {
  final QuoteController quoteController = Get.find<QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  /// Validates the details form and navigates to the next tab if validation succeeds.
  ///
  /// - Uses the `detailsKey` form key to trigger validation.
  /// - If the form is valid, it calls `nextTab()` on the controller to proceed to the next tab.
  ///
  /// This is usually triggered by a "Next" button in a multi-step form.
  void nextTab() {
    if (quoteController.quoteModel.detailsKey.value.currentState?.validate() ?? false) {
      quoteController.nextTab();
    }
  }

  /// Fetches and updates the required data for a sales-related event.
  ///
  /// - Sends a query with `eventid` and `eventtype` to the `sales_detailsPreLoader_API`.
  /// - On a successful response with a valid `code`, it updates the quote data via `quoteController`.
  /// - If the API fails or returns an error, it shows a corresponding error dialog and closes the current dialog.
  ///
  /// This is commonly used to preload data when editing or viewing a sales enquiry, quote, or invoice.
  void get_requiredData(context, String eventtype, int eventID) async {
    try {
      Map<String, dynamic> body = {"eventid": eventID, "eventtype": eventtype};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.sales_detailsPreLoader_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          quoteController.update_requiredData(value, eventtype);
          // print(clientreqController.clientReqModel.Enq_ID.value);
          // salesController.addToCustomerList(value);
        } else {
          await Error_dialog(
            context: context,
            title: 'PRE - LOADER',
            content: value.message ?? "",
            onOk: () {},
          );
          Navigator.of(context).pop();
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
        Navigator.of(context).pop();
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
      Navigator.of(context).pop();
    }
  }

  /// Fetches the product suggestion list for the quote module.
  ///
  /// - Calls the `sales_getProduct_SUGG_List` API using a token-based GET request.
  /// - If the response is successful and contains valid data, it updates the product suggestion list in `quoteController`.
  /// - On API error or failure, displays an error dialog and closes the current context.
  ///
  /// This is typically used to populate dropdowns or autocomplete suggestions when adding products to a quote.
  void get_productSuggestionList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getProduct_SUGG_List);

      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          quoteController.add_productSuggestion(value.data);
        } else {
          await Error_dialog(context: context, title: 'PRE - LOADER', content: value.message ?? "", onOk: () {});
          Navigator.of(context).pop();
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
        Navigator.of(context).pop();
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
      Navigator.of(context).pop();
    }
  }
}
