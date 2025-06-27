import 'dart:io';

import 'package:get/get.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart' show SUBSCRIPTION_ClientreqController;
import 'package:ssipl_billing/API/api.dart' show API;
import 'package:ssipl_billing/API/invoker.dart' show Invoker;
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart' show CMDlResponse, CMDmResponse;
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart' show SessiontokenController;

mixin SUBSCRIPTION_ClientreqDetailsService {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final SUBSCRIPTION_ClientreqController clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();
  void nextTab(context) async {
    clientreqController.nextTab();
  }

  void get_OrganizationList(context) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.sales_fetchOrg_list);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          clientreqController.update_OrganizationList(value);
          // get_CompanyList(context, 0);
        } else {
          await Error_dialog(context: context, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
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
    // int? id = clientreqController.clientReqModel.CompanyList
    //     .firstWhere(
    //       (x) => x.companyName == Compname,
    //     )
    //     .companyId;

    var model = clientreqController.clientReqModel.CompanyList.firstWhere(
      (x) => x.companyName == Compname,
    );
    // update_KYC(model.client_address, model.billing_addressname, model.billing_address, model.emailid, model.contact_number, model.gst_number);
    clientreqController.updateCompanyID(model.companyId ?? 0);
    clientreqController.updateCompanyName(Compname);
    clientreqController.update_KYC(model.client_addressname, model.client_address, model.billing_addressname, model.billing_address, model.emailid, model.contact_number, model.gst_number);
    // get_BranchList(context, id!);
    // get_CompanyList(context, id!);
  }

  // void on_Orgselected(context, Orgname) {
  //   // clientreqController.clear_CompanyName();
  //   // clientreqController.clientReqModel.organizationList.clear();
  //   int? id = clientreqController.clientReqModel.organizationList
  //       .firstWhere(
  //         (x) => x.organizationName == Orgname,
  //       )
  //       .organizationId;
  //   get_CompanyList(context, id!);
  // }

  // void on_Compselected(context, Compname) {
  //   int? id = clientreqController.clientReqModel.CompanyList
  //       .firstWhere(
  //         (x) => x.companyName == Compname,
  //       )
  //       .companyId;
  //   get_BranchList(context, id!);
  //   // get_CompanyList(context, id!);
  // }

  Future<void> MORaction(context) async {
    bool pickedStatus = await clientreqController.pickFile(context);
    if (pickedStatus) {
      uploadMor(context, clientreqController.clientReqModel.morFile.value!);
    } else {
      null;
    }
  }

// 9500753815
  void uploadMor(context, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.multiPart(file, API.subscription_Upload_MOR_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context, showCancel: false, title: 'Upload MOR', content: "MOR uploaded Successfully", onOk: () {});
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

  // void get_OrganizationList(context) async {
  //   try {
  //     Map<String, dynamic>? response = await apiController.GetbyToken(API.subscription_fetchOrg_list);
  //     if (response?['statusCode'] == 200) {
  //       CMDlResponse value = CMDlResponse.fromJson(response ?? {});
  //       if (value.code) {
  //         // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
  //         clientreqController.update_OrganizationList(value);
  //       } else {
  //         await Basic_dialog(context: context, showCancel: false, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
  //       }
  //     } else {
  //       Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
  //     }
  //   } catch (e) {
  //     Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
  //   }
  // }

  // void get_CompanyList(context, int org_id) async {
  //   try {
  //     Map<String, dynamic> body = {"organizationid": org_id};
  //     Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.subscription_fetchCompany_list);
  //     if (response?['statusCode'] == 200) {
  //       CMDlResponse value = CMDlResponse.fromJson(response ?? {});
  //       if (value.code) {
  //         // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
  //         clientreqController.update_CompanyList(value);
  //       } else {
  //         await Basic_dialog(context: context, showCancel: false, title: 'Fetching Company List Error', content: value.message ?? "", onOk: () {});
  //       }
  //     } else {
  //       Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
  //     }
  //   } catch (e) {
  //     Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
  //   }
  // }

  // void get_BranchList(context, int comp_id) async {
  //   try {
  //     Map<String, dynamic> body = {"companyid": comp_id};
  //     Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.subscription_fetchBranch_list);
  //     if (response?['statusCode'] == 200) {
  //       CMDlResponse value = CMDlResponse.fromJson(response ?? {});
  //       if (value.code) {
  //         // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
  //         clientreqController.update_BranchList(value);
  //       } else {
  //         await Basic_dialog(context: context, showCancel: false, title: 'Fetching Branch List Error', content: value.message ?? "", onOk: () {});
  //       }
  //     } else {
  //       Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
  //     }
  //   } catch (e) {
  //     Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
  //   }
  // }
}
