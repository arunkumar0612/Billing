import 'package:get/get.dart';
import 'package:ssipl_billing/API-/api.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

mixin CompanyService {
  final Invoker apiController = Get.find<Invoker>();

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
          Success_SnackBar(context, "KYC updated successfully");
          // await Basic_dialog(context: context,showCancel: false, title: 'Feedback', content: "Feedback added successfully", onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'Update KYC Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
