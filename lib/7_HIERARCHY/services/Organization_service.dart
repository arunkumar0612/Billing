import 'package:get/get.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

mixin OrganizationService {
  final Invoker apiController = Get.find<Invoker>();

  Future<void> UpdateKYC(context, String organizationid, String organizationname, String emailid, String contactno, String address, String contactperson, String? orgcode, String sitetype) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({
        "organizationid": int.parse(organizationid),
        "organizationname": organizationname,
        "emailid": emailid,
        "contactno": contactno,
        "address": address,
        "contactperson": contactperson,
        "orgcode": orgcode,
        "sitetype": sitetype,
      }, API.updateOrganization_KYC);
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
