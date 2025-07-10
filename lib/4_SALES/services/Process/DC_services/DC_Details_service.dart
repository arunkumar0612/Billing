import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/Process/DC_actions.dart';
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
