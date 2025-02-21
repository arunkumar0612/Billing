import 'dart:io';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/ClientReq_actions.dart';
import 'package:ssipl_billing/models/constants/api.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';

import 'package:ssipl_billing/services/APIservices/invoker.dart';

import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';

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

  void uploadMor(context, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.multiPart(file, API.Upload_MOR_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Upload MOR', content: "MOR uploaded Successfully", onOk: () {});
          clientreqController.updateMOR_uploadedPath(value);
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Upload MOR', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
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
          await Basic_dialog(context: context, showCancel: false, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
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
          await Basic_dialog(context: context, showCancel: false, title: 'Fetching Company List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
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
          await Basic_dialog(context: context, showCancel: false, title: 'Fetching Branch List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }
}
