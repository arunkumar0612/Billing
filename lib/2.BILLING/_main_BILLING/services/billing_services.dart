import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';
import 'package:ssipl_billing/API-/api.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';

mixin main_Billing {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();

  void get_SubscriptionInvoiceList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.billing_subscriptionInvoice);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          for (int i = 0; i < value.data.length; i++) {
            mainBilling_Controller.addto_SubscriptionInvoiceList(SubscriptionInvoice.fromJson(value.data[i]));
          }

          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_OrganizationList(value);
        } else {
          // await Error_dialog(context: context, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      // Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  void get_SalesInvoiceList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.billing_salesInvoice);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          print(value.data);

          for (int i = 0; i < value.data.length; i++) {
            mainBilling_Controller.addto_SalesInvoiceList(SalesInvoice.fromJson(value.data[i]));
          }

          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_OrganizationList(value);
        } else {
          // await Error_dialog(context: context, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      // Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
