import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/models/constants/api.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/services/APIservices/invoker.dart';
import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';

mixin HierarchyService {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final HierarchyController hierarchyController = Get.find<HierarchyController>();
  final Invoker apiController = Get.find<Invoker>();

  void get_OrganizationList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.hierarchy_OrganizationData);

      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          hierarchyController.add_Org(value);
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

  void get_CompanyList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.hierarchy_CompanyData);

      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          hierarchyController.add_Comp(value);
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

  void get_BranchList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.hierarchy_BranchData);

      if (kDebugMode) {
        print(response);
      }
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          hierarchyController.add_Branch(value);
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
