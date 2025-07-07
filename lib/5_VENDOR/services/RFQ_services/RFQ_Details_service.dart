import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin RfqdetailsService {
  final vendor_RfqController rfqController = Get.find<vendor_RfqController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  void nextTab() {
    if (rfqController.rfqModel.detailsKey.value.currentState?.validate() ?? false) {
      rfqController.nextTab();
    }
  }

  void get_requiredData(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.RFQ_preloader);
      // Map<String, dynamic>? response = await apiController.GetbyToken(API.RFQ_preloader);
      print(response);
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

  void get_noteSuggestionList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.vendor_getNote_SUGG_List);

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

  void get_VendorList(
    context,
  ) async {
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

  // void get_productSuggestionList(context) async {
  //   try {
  //     Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getProduct_SUGG_List);

  //     if (response?['statusCode'] == 200) {
  //       CMDlResponse value = CMDlResponse.fromJson(response ?? {});
  //       if (value.code) {
  //         rfqController.add_productSuggestion(value.data);
  //       } else {
  //         await Error_dialog(
  //           context: context,
  //           title: 'PRE - LOADER',
  //           content: value.message ?? "",
  //           onOk: () {},
  //         );
  //         Navigator.of(context).pop();
  //       }
  //     } else {
  //       Error_dialog(
  //         context: context,
  //         title: "SERVER DOWN",
  //         content: "Please contact administration!",
  //       );
  //       Navigator.of(context).pop();
  //     }
  //   } catch (e) {
  //     Error_dialog(
  //       context: context,
  //       title: "ERROR",
  //       content: "$e",
  //     );
  //     Navigator.of(context).pop();
  //   }
  // }
}
