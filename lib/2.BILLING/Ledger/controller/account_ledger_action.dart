import 'package:get/get.dart';

import 'package:ssipl_billing/2.BILLING/Ledger/models/constants/account_ledger_constants.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class Account_LedgerController extends GetxController {
  var account_LedgerModel = Account_LedgerModel();
  void add_Account_Ledger(CMDlResponse value) {
    account_LedgerModel.account_Ledger_list.clear();
    for (int i = 0; i < value.data.length; i++) {
      account_LedgerModel.account_Ledger_list.add(AccountLedger.fromJson(value.data[i]));
    }
    account_LedgerModel.filteredAccount_Ledgers.assignAll(account_LedgerModel.account_Ledger_list);
  }

  // void reset_account_LedgerClear_popup() {
  //   account_LedgerModel.recievableAmount.value = 0.0;
  //   account_LedgerModel.is_fullClear.value = false;
  //   account_LedgerModel.is_amountExceeds.value = null;
  //   account_LedgerModel.is_Deducted.value = true;
  //   account_LedgerModel.closedDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   account_LedgerModel.fileName.value = null;
  //   account_LedgerModel.selectedFile.value = null;

  //   // Reset text controllers
  //   account_LedgerModel.amountCleared_controller.value.clear();
  //   account_LedgerModel.transactionDetails_controller.value.clear();
  //   account_LedgerModel.feedback_controller.value.clear();
  //   account_LedgerModel.closedDateController.text = account_LedgerModel.closedDate.value;
  // }
}
