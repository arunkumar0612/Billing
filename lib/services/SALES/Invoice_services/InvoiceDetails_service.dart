import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Invoice_actions.dart';
import 'package:ssipl_billing/models/constants/api.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/services/APIservices/invoker.dart';
import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';

mixin InvoicedetailsService {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  void nextTab() {
    if (invoiceController.invoiceModel.detailsKey.value.currentState?.validate() ?? false) {
      invoiceController.nextTab();
    }
  }

  void get_requiredData(context, int eventID, String eventType) async {
    try {
      Map<String, dynamic> body = {"eventid": eventID, "eventtype": eventType};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.sales_detailsPreLoader_API);

      // print(response);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          invoiceController.update_requiredData(value);
          // print(clientreqController.clientReqModel.Enq_ID.value);
          // salesController.addToCustomerList(value);
        } else {
          await Basic_dialog(context: context, title: 'PRE - LOADER', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
    }
  }

  void get_productSuggestionList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getProduct_SUGG_List);

      if (kDebugMode) {
        print(response);
      }
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          invoiceController.add_productSuggestion(value.data);
          // await Basic_dialog(context: context, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          // invoiceController.update_requiredData(value);
          // print(clientreqController.clientReqModel.Enq_ID.value);
          // salesController.addToCustomerList(value);
        } else {
          await Basic_dialog(context: context, title: 'PRE - LOADER', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
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
          invoiceController.add_noteSuggestion(value.data);
          // await Basic_dialog(context: context, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          // invoiceController.update_requiredData(value);
          // print(clientreqController.clientReqModel.Enq_ID.value);
          // salesController.addToCustomerList(value);
        } else {
          await Basic_dialog(context: context, title: 'PRE - LOADER', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
    }
  }
}
