import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/ClientReq_actions.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin ClientreqDetailsService {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  void nextTab(context) async {
    clientreqController.nextTab();
  }

  void on_Orgselected(context, Orgname) {
    // clientreqController.clear_CompanyName();
    // clientreqController.clientReqModel.organizationList.clear();
    int? id = clientreqController.clientReqModel.organizationList
        .firstWhere(
          (x) => x.organizationName == Orgname,
        )
        .organizationId;
    get_CompanyList(context, id!);
  }

  void on_Compselected(context, Compname) {
    int? id = clientreqController.clientReqModel.CompanyList
        .firstWhere(
          (x) => x.companyName == Compname,
        )
        .companyId;
    get_BranchList(context, id!);
    // get_CompanyList(context, id!);
  }

  Future<void> MORaction(context) async {
    bool pickedStatus = await clientreqController.pickFile(context);
    if (pickedStatus) {
      uploadMor(context, clientreqController.clientReqModel.morFile.value!);
    } else {
      null;
    }
  }

  void uploadMor(
    context,
    File file,
  ) async {
    try {
      List<int> fileBytes = await file.readAsBytes();
      if (kDebugMode) {
        print("Binary Data: ${fileBytes.length}");
      } // Prints file in binary format
      Map<String, dynamic>? response = await apiController.multiPart(file, API.Upload_MOR_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Upload MOR', content: "MOR uploaded Successfully", onOk: () {});
          clientreqController.updateMOR_uploadedPath(value);
        } else {
          await Error_dialog(context: context, title: 'Upload MOR', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  void get_OrganizationList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_fetchOrg_list);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          clientreqController.update_OrganizationList(value);
        } else {
          await Error_dialog(context: context, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
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

  void get_CompanyList(context, int org_id) async {
    try {
      Map<String, dynamic> body = {"organizationid": org_id};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.sales_fetchCompany_list);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          clientreqController.update_CompanyList(value);
        } else {
          await Error_dialog(context: context, title: 'Fetching Company List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  void get_BranchList(context, int comp_id) async {
    try {
      Map<String, dynamic> body = {"companyid": comp_id};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.sales_fetchBranch_list);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          clientreqController.update_BranchList(value);
        } else {
          await Error_dialog(context: context, title: 'Fetching Branch List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  void get_productSuggestionList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_getProduct_SUGG_List);

      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          clientreqController.add_productSuggestion(value.data);
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
