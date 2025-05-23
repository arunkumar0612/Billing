import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/constants/account_ledger_constants.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class Account_LedgerController extends GetxController {
  var account_LedgerModel = Account_LedgerModel();

  void add_Account_Ledger(CMDmResponse value) {
    account_LedgerModel.account_Ledger_list.value = AccountLedgerSummary(
      balanceAmount: 0.0,
      creditAmount: 0.0,
      debitAmount: 0.0,
      ledgerList: [],
    );
    account_LedgerModel.account_Ledger_list.value = AccountLedgerSummary.fromJson(value.data);

    account_LedgerModel.filteredaccount_Ledger_list.value = AccountLedgerSummary.fromJson(value.data);
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

  void clear_sharedata() {
    account_LedgerModel.emailController.value.clear();
    account_LedgerModel.phoneController.value.clear();
    account_LedgerModel.feedbackController.value.clear();
    account_LedgerModel.CCemailController.value.clear();
    account_LedgerModel.whatsapp_selectionStatus.value = false;
    account_LedgerModel.gmail_selectionStatus.value = false;
  }

  void toggleCCemailvisibility(bool value) {
    account_LedgerModel.CCemailToggle.value = value;
  }

  void applySearchFilter(String query) {
    try {
      if (query.isEmpty) {
        account_LedgerModel.filteredaccount_Ledger_list.value.ledgerList.assignAll(account_LedgerModel.account_Ledger_list.value.ledgerList);
      } else {
        final filtered = account_LedgerModel.account_Ledger_list.value.ledgerList.where((accountledger) {
          return accountledger.gstNumber.toLowerCase().contains(query.toLowerCase()) ||
              accountledger.clientName.toLowerCase().contains(query.toLowerCase()) ||
              accountledger.voucherNumber.toLowerCase().contains(query.toLowerCase()) ||
              accountledger.invoiceNumber.toLowerCase().contains(query.toLowerCase()) ||
              accountledger.ledgerType.toLowerCase().contains(query.toLowerCase());
        }).toList();

        account_LedgerModel.filteredaccount_Ledger_list.value.ledgerList.assignAll(filtered);
      }
    } catch (e) {
      debugPrint('Error in applySearchFilter: $e');
    }
  }
}
