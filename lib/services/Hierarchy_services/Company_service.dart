import 'package:get/get.dart';

import 'package:ssipl_billing/models/constants/api.dart';

import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/services/APIservices/invoker.dart';
import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';
import 'package:ssipl_billing/views/components/Loading.dart';

mixin CompanyService {
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();

  void UpdateKYC(context, String companyid, String companyname, String sitetype, String organizationid, String contactperson, String contactpersonno, String contactemail, String address,
      String billingaddress, String pannumber, String cinno, String customercode) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({
        "companyid": companyid,
        "companyname": companyname,
        "sitetype": sitetype,
        "organizationid": organizationid,
        "contactperson": contactperson,
        "contactpersonno": contactpersonno,
        "contactemail": contactemail,
        "address": address,
        "billingaddress": billingaddress,
        "pannumber": pannumber,
        "cinno": cinno,
        "customercode": customercode,
      }, API.updateCompany_KYC);
      if (response?['statusCode'] == 200) {
        CMResponse value = CMResponse.fromJson(response ?? {});
        if (value.code) {
          Basic_SnackBar(context, "KYC updated successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Update KYC Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }
}
