import 'package:get/get.dart';
import 'package:ssipl_billing/API-/api.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

mixin BranchService {
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();

  void UpdateKYC(
    context,
    String branchid,
    String branchname,
    String emailid,
    String contactno,
    String address,
    String gstno,
    String billingaddressname,
    String billingaddress,
    String contactperson,
    String branchcode,
    String sitetype,
    String billingplan,
    String billmode,
    String startdate,
    String enddate,
    String amount,
    String billingperiod,
    String subscriptionid,
  ) async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyQueryString({
        "branchid": branchid,
        "branchname": branchname,
        "emailid": emailid,
        "contactno": contactno,
        "address": address,
        "gstno": gstno,
        "billingaddressname": billingaddressname,
        "billingaddress": billingaddress,
        "contactperson": contactperson,
        "branchcode": branchcode,
        "sitetype": sitetype,
        "billingplan": billingplan,
        "billmode": billmode,
        "startdate": startdate,
        "enddate": enddate,
        "amount": amount,
        "billingperiod": billingperiod,
        "subscriptionid": subscriptionid,
      }, API.updateBranch_KYC);
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
