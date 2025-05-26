import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/TDS_ledger_action.dart';
// import 'package:ssipl_billing/2.BILLING/TDS_Ledgers/controllers/gst_Ledger_action.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin TDS_LedgerService {
  final TDS_LedgerController tds_LedgerController = Get.find<TDS_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  Future<void> get_TDS_LedgerList() async {
    // loader.start(context);
    // await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "tdstype": "receivable",
        "invoicetype": "subscription",
        "customerid": "",
        "startdate": "",
        "enddate": "",
      },
      API.gettds_Ledgerlist,
    );
    if (response?['statusCode'] == 200) {
      CMDmResponse value = CMDmResponse.fromJson(response ?? {});
      if (value.code) {
        tds_LedgerController.add_TDS_Ledger(value);
        tds_LedgerController.update();
      } else {
        // await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  Future<void> gst_Ledger_refresh() async {
    await get_TDS_LedgerList();
    tds_LedgerController.update();
  }

  void resetFilters() {
    tds_LedgerController.tds_LedgerModel.tds_Ledger_list.value = tds_LedgerController.tds_LedgerModel.ParentTDS_Ledgers.value;
  }
}
