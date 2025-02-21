import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Quote_actions.dart';
import 'package:ssipl_billing/models/constants/api.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/services/APIservices/invoker.dart';
import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';

mixin QuotedetailsService {
  final QuoteController quoteController = Get.find<QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  void add_details() {
    if (quoteController.quoteModel.detailsKey.value.currentState?.validate() ?? false) {
      quoteController.nextTab();
    }
  }

  void get_requiredData(context) async {
    try {
      Map<String, dynamic> body = {"eventid": 1, "eventtype": "quotation"};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.sales_fetchEventNumber_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          // await Basic_dialog(context: context,showCancel: false, title: 'Enquiry - ID', content: value.message!, onOk: () {});
          quoteController.update_requiredData(value);
          // print(clientreqController.clientReqModel.Enq_ID.value);
          // salesController.addToCustomerList(value);
        } else {
          await Basic_dialog(context: context, showCancel: false, title: 'Customer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }
}
