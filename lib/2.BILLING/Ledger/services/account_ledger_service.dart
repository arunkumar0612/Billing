import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/account_ledger_action.dart';
// import 'package:ssipl_billing/2.BILLING/Account_Ledgers/controllers/account_Ledger_action.dart';
import 'package:ssipl_billing/API-/api.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';

mixin Account_LedgerService {
  final Account_LedgerController account_LedgerController = Get.find<Account_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  Future<void> get_Account_LedgerList() async {
    // loader.start(context);
    await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "ledgertype": "receivable",
        "account_Ledgertype": "payment",
        "invoicetype": "subscription",
        "customerid": "",
        "startdate": "",
        "enddate": ""

        // "customerid": "SB_1",
      },
      API.getaccount_Ledgerlist,
    );
    if (response?['statusCode'] == 200) {
      CMDlResponse value = CMDlResponse.fromJson(response ?? {});
      if (value.code) {
        account_LedgerController.add_Account_Ledger(value);
        print(account_LedgerController.account_LedgerModel.account_Ledger_list[0].billDetails);
        account_LedgerController.update();
      } else {
        // await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  Future<void> account_Ledger_refresh() async {
    await get_Account_LedgerList();
    account_LedgerController.update();
  }

  void resetFilters() {
    account_LedgerController.account_LedgerModel.filteredAccount_Ledgers.value = account_LedgerController.account_LedgerModel.account_Ledger_list;
  }
}
