import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin RfqdetailsService {
  final RfqController rfqController = Get.find<RfqController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  /// Advances to the next tab if the current form in `detailsKey` is valid.
  ///
  /// Validates the current form state using `detailsKey`. If validation
  /// passes, it calls `nextTab()` on the `rfqController`.
  void nextTab() {
    if (rfqController.rfqModel.detailsKey.value.currentState?.validate() ?? false) {
      rfqController.nextTab();
    }
  }

  /// Fetches required data for a given event and updates the RFQ controller.
  ///
  /// Sends a query using the provided [eventID] and [eventtype] to the sales
  /// preloader API. On successful response:
  /// - Parses the response into a [CMDmResponse].
  /// - If the response is valid (`code == true`), it updates the RFQ controller with the data.
  /// - If not, it shows an error dialog and pops the current context.
  ///
  /// In case of server issues or exceptions, appropriate error dialogs are shown.
  void get_requiredData(context, String eventtype, int eventID) async {
    try {
      Map<String, dynamic> body = {"eventid": eventID, "eventtype": eventtype};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.sales_detailsPreLoader_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          rfqController.update_requiredData(value);
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
      Error_dialog(context: context, title: "ERROR", content: "$e");
      Navigator.of(context).pop();
    }
  }

  /// Retrieves the note suggestion list from the sales API and updates the RFQ controller.
  ///
  /// Sends a GET request with token authentication to fetch note suggestions.
  /// - On success (`statusCode == 200` and `code == true`), updates the RFQ controller with the received data.
  /// - If the API response indicates failure, shows an error dialog and navigates back.
  /// - Handles any exceptions by displaying an error dialog and popping the current context.
  void get_noteSuggestionList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getNote_SUGG_List);

      if (kDebugMode) {
        print(response);
      }
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          rfqController.add_noteSuggestion(value.data);
          // await Basic_dialog(context: context, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          // rfqController.update_requiredData(value);
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

  /// Fetches the vendor list using a query and updates the RFQ controller.
  ///
  /// Sends a query to the vendor list API with a default vendor ID.
  /// - If the response is successful (`statusCode == 200` and `code == true`), it updates the RFQ controller with the vendor list.
  /// - On failure, shows an error dialog and pops the current context.
  /// - Catches and handles any exceptions by showing an error dialog and exiting the current screen.
  void get_VendorList(context, int org_id) async {
    try {
      Map<String, dynamic> body = {"vendorid": 0};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.fetch_vendorList);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          rfqController.update_vendorList(value);
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_CompanyList(value);
        } else {
          await Error_dialog(context: context, title: 'Fetching Vendor List Error', content: value.message ?? "", onOk: () {});
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

  /// Retrieves the product suggestion list from the sales API and updates the RFQ controller.
  ///
  /// Sends a token-authenticated request to fetch product suggestions.
  /// - On success (`statusCode == 200` and `code == true`), updates the RFQ controller with the product suggestions.
  /// - On failure, displays an error dialog and navigates back.
  /// - Catches any exceptions, shows an error dialog, and pops the current context.
  void get_productSuggestionList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getProduct_SUGG_List);

      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          rfqController.add_productSuggestion(value.data);
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
        Error_dialog(
          context: context,
          title: "SERVER DOWN",
          content: "Please contact administration!",
        );
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
