import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/models/constants/account_ledger_constants.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/models/entities/account_ledger_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class Account_LedgerController extends GetxController {
  var account_LedgerModel = Account_LedgerModel();
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  // final Account_LedgerController account_ledgerController = Get.find<Account_LedgerController>();

  /// Adds account ledger data to both primary and secondary lists.
  /// Also initializes the start and end date filters based on the ledger data.
  void add_Account_Ledger(CMDmResponse value) {
    account_LedgerModel.Secondaryaccount_Ledger_list.value = AccountLedgerSummary.fromJson(value.data);
    account_LedgerModel.account_Ledger_list.value = AccountLedgerSummary.fromJson(value.data);

    initialize_StartEnd_date(account_LedgerModel.account_Ledger_list.value.startdate!, account_LedgerModel.account_Ledger_list.value.enddate!);
  }

  /// Sets the start and end date values in the selected filter model.
  void initialize_StartEnd_date(String startDate, String endDate) {
    account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value = startDate;
    account_LedgerModel.account_LedgerSelectedFilter.value.todate.value = endDate;
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

  /// Clears all share-related input fields and resets sharing option selections.
  void clear_sharedata() {
    account_LedgerModel.emailController.value.clear();
    account_LedgerModel.phoneController.value.clear();
    account_LedgerModel.feedbackController.value.clear();
    account_LedgerModel.CCemailController.value.clear();
    account_LedgerModel.whatsapp_selectionStatus.value = false;
    account_LedgerModel.gmail_selectionStatus.value = false;
  }

  /// Toggles the visibility of the CC email input based on the given boolean value.
  void toggleCCemailvisibility(bool value) {
    account_LedgerModel.CCemailToggle.value = value;
  }

  // void applySearchFilter(String query) {
  //   try {
  //     if (query.isEmpty) {
  //       account_LedgerModel.account_Ledger_list.value.ledgerList.assignAll(account_LedgerModel.Secondaryaccount_Ledger_list.value.ledgerList);

  //       account_LedgerModel.account_Ledger_list.refresh();
  //     } else {
  //       final filtered = account_LedgerModel.Secondaryaccount_Ledger_list.value.ledgerList.where((accountledger) {
  //         return accountledger.gstNumber.toLowerCase().contains(query.toLowerCase()) ||
  //             accountledger.clientName.toLowerCase().contains(query.toLowerCase()) ||
  //             accountledger.voucherNumber.toLowerCase().contains(query.toLowerCase()) ||
  //             accountledger.invoiceNumber.toLowerCase().contains(query.toLowerCase()) ||
  //             accountledger.ledgerType.toLowerCase().contains(query.toLowerCase());
  //       }).toList();

  //       account_LedgerModel.account_Ledger_list.value.ledgerList.assignAll(filtered);

  //       account_LedgerModel.account_Ledger_list.refresh();
  //     }
  //   } catch (e) {
  //     debugPrint('Error in applySearchFilter: $e');
  //   }
  // }
}
