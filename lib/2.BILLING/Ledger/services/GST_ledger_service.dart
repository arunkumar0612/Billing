import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/GST_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
// import 'package:ssipl_billing/2.BILLING/GST_Ledgers/controllers/gst_Ledger_action.dart';
import 'package:ssipl_billing/API-/api.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';

mixin GST_LedgerService {
  final GST_LedgerController gst_LedgerController = Get.find<GST_LedgerController>();
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  Future<void> get_GST_LedgerList() async {
    // loader.start(context);
    // await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "gsttype":
            view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value.toLowerCase() == 'consolidate' ? '' : view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value.toLowerCase(),
        "invoicetype":
            view_LedgerController.view_LedgerModel.selectedinvoiceType.value.toLowerCase() == 'show all' ? '' : view_LedgerController.view_LedgerModel.selectedinvoiceType.value.toLowerCase(),
        // "customerid": "SB_1",
        "startdate": view_LedgerController.view_LedgerModel.startDateController.value.text,
        "enddate": view_LedgerController.view_LedgerModel.endDateController.value.text,
      },
      API.getgst_Ledgerlist,
    );
    if (response?['statusCode'] == 200) {
      CMDmResponse value = CMDmResponse.fromJson(response ?? {});
      if (value.code) {
        gst_LedgerController.add_GST_Ledger(value);
        gst_LedgerController.update();
      } else {
        // await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  Future<void> gst_Ledger_refresh() async {
    await get_GST_LedgerList();
    gst_LedgerController.update();
  }

  void resetFilters() {
    gst_LedgerController.gst_LedgerModel.filteredGST_Ledgers.value = gst_LedgerController.gst_LedgerModel.gst_Ledger_list.value;
  }
}
