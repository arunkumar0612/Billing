import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart' show SUBSCRIPTION_QuoteController;
import 'package:ssipl_billing/API-/api.dart' show API;
import 'package:ssipl_billing/API-/invoker.dart' show Invoker;
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart' show CMDmResponse;
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart' show SessiontokenController;

mixin SUBSCRIPTION_QuotedetailsService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  void nextTab() {
    if (quoteController.quoteModel.detailsKey.value.currentState?.validate() ?? false) {
      quoteController.nextTab();
    }
  }

  void get_requiredData(context, String eventtype, int eventID) async {
    try {
      Map<String, dynamic> body = {"eventid": eventID, "eventtype": eventtype};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.subscription_detailsPreLoader_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          quoteController.update_requiredData(value);
          // print(clientreqController.clientReqModel.Enq_ID.value);
          // salesController.addToCustomerList(value);
        } else {
          await Error_dialog(context: context, title: 'PRE - LOADER', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
