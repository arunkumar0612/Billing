import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin DcdetailsService {
  final DcController dcController = Get.find<DcController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  void nextTab() {
    if (dcController.dcModel.detailsKey.value.currentState?.validate() ?? false) {
      dcController.nextTab();
    }
  }

  /// Fetches all the necessary data for a given event and updates the state accordingly.
  ///
  /// This makes an API call using the provided `eventID` and `eventType`.
  /// If the response is successful and valid, it updates the required data in `dcController`.
  /// If not, it shows an error dialog and closes the current screen.
  /// Also catches and handles any exceptions with a general error message.
  ///
  /// [context] – Used to show dialogs and manage navigation.
  /// [eventID] – The ID of the event to fetch data for.
  /// [eventType] – A string representing the type of event (like 'enquiry', 'client request', etc).
  void get_requiredData(context, int eventID, String eventType) async {
    try {
      Map<String, dynamic> body = {"eventid": eventID, "eventtype": eventType};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.sales_detailsPreLoader_API);

      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          dcController.update_requiredData(value);
          // print(clientreqController.clientReqModel.Enq_ID.value);
          // salesController.addToCustomerList(value);
        } else {
          await Error_dialog(context: context, title: 'PRE - LOADER', content: value.message ?? "", onOk: () {});
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

  /// Fetches note suggestions from the backend and updates the controller state.
  ///
  /// This function:
  /// - Sends a GET request to the API to fetch note suggestions.
  /// - If the response is successful and valid, it updates the note suggestion list in `dcController`.
  /// - If the API returns a failure response, it shows an error dialog and pops the screen.
  /// - If there's a server issue or exception, it shows a fallback error dialog and exits the current screen.
  ///
  /// [context] – Used for showing dialogs and navigating back in case of an error.
  void get_noteSuggestionList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getNote_SUGG_List);

      if (kDebugMode) {
        print(response);
      }
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          dcController.add_noteSuggestion(value.data);
          // await Basic_dialog(context: context, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          // dcController.update_requiredData(value);
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
        Error_dialog(
          context: context,
          title: "SERVER DOWN",
          content: "Please contact administration!",
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
      Navigator.of(context).pop();
    }
  }
}
