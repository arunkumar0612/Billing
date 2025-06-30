import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/models/constants/TDS_ledger_constants.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/models/entities/TDS_ledger_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class TDS_LedgerController extends GetxController {
  var tds_LedgerModel = TDS_LedgerModel();

  /// Populates the TDS ledger model with data from the response,
  /// resets the model initially, and sets the parent ledger as well.
  /// Also initializes the date filters based on the received TDS data.
  void add_TDS_Ledger(CMDmResponse value) {
    tds_LedgerModel.tds_Ledger_list.value = TDSSummaryModel(
      tdsList: [],
      totalTds: 0,
      totalPaid: 0,
      netTdsBalance: 0,
      totalReceivables: 0,
      totalPayables: 0,
      netTds: 0,
      startdate: null,
      enddate: null,
    );
    // for (int i = 0; i < value.data.length; i++) {
    tds_LedgerModel.tds_Ledger_list.value = TDSSummaryModel.fromJson(value.data);
    // }
    tds_LedgerModel.ParentTDS_Ledgers.value = TDSSummaryModel.fromJson(value.data);
    initialize_StartEnd_date(tds_LedgerModel.tds_Ledger_list.value.startdate!, tds_LedgerModel.tds_Ledger_list.value.enddate!);
  }

  /// Sets the start and end date values in the selected TDS ledger filter model.
  void initialize_StartEnd_date(String startDate, String endDate) {
    tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value = startDate;
    tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value = endDate;
  }
  // void reset_tds_LedgerClear_popup() {
  //   tds_LedgerModel.recievableAmount.value = 0.0;
  //   tds_LedgerModel.is_fullClear.value = false;
  //   tds_LedgerModel.is_amountExceeds.value = null;
  //   tds_LedgerModel.is_Deducted.value = true;
  //   tds_LedgerModel.closedDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   tds_LedgerModel.fileName.value = null;
  //   tds_LedgerModel.selectedFile.value = null;

  //   // Reset text controllers
  //   tds_LedgerModel.amountCleared_controller.value.clear();
  //   tds_LedgerModel.transactionDetails_controller.value.clear();
  //   tds_LedgerModel.feedback_controller.value.clear();
  //   tds_LedgerModel.closedDateController.text = tds_LedgerModel.closedDate.value;
  // }

  /// Clears all TDS share-related input fields and resets WhatsApp and Gmail sharing selections.
  void clear_sharedata() {
    tds_LedgerModel.emailController.value.clear();
    tds_LedgerModel.phoneController.value.clear();
    tds_LedgerModel.feedbackController.value.clear();
    tds_LedgerModel.CCemailController.value.clear();
    tds_LedgerModel.whatsapp_selectionStatus.value = false;
    tds_LedgerModel.gmail_selectionStatus.value = false;
  }

  /// Sets the visibility of the CC email field in the TDS ledger model based on the given value.
  void toggleCCemailvisibility(bool value) {
    tds_LedgerModel.CCemailToggle.value = value;
  }
}
