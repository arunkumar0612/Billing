import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/API/api.dart' show API;
import 'package:ssipl_billing/API/invoker.dart' show Invoker;
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin SUBSCRIPTION_QuotedetailsService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  void nextTab() {
    if (quoteController.quoteModel.detailsKey.value.currentState?.validate() ?? false) {
      quoteController.nextTab();
    }
  }

// Fetch required data for the quote
  /// This function fetches the required data for the quote based on the event type and event ID.
  /// It sends a request to the API with the event type and event ID, and updates the quote controller with the response.
  void get_requiredData(context, String eventtype, int eventID) async {
    try {
      Map<String, dynamic> body = {"eventid": eventID, "eventtype": eventtype};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.subscription_detailsPreLoader_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await quoteController.update_requiredData(value, eventtype);
          get_CompanyBasedPackages(context, quoteController.quoteModel.companyid.value);
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

// Fetch company based packages
  /// This function fetches company-based packages for the given company ID.
  /// It sends a request to the API with the company ID and updates the quote controller with the response.
  void get_CompanyBasedPackages(context, int companyid) async {
    try {
      Map<String, dynamic> body = {"companyid": companyid};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.get_CompanyBasedPackageList);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          quoteController.update_companyBasedPackages(value);
        } else {
          await Error_dialog(context: context, title: 'Company customized packages', content: value.message ?? "", onOk: () {});
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
