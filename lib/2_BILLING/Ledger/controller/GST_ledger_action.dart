import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/models/constants/GST_ledger_constants.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/models/entities/GST_ledger_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class GST_LedgerController extends GetxController {
  var gst_LedgerModel = GST_LedgerModel();

  /// Adds GST ledger data by parsing the response and assigning it to both primary and parent models.
  /// Initializes the start and end date filters based on the GST ledger data.
  void add_GST_Ledger(CMDmResponse value) {
    gst_LedgerModel.gst_Ledger_list.value = GSTSummaryModel(
      gstList: [],
      inputGst: 0.0,
      outputGst: 0.0,
      totalGst: 0.0,
      startdate: null,
      enddate: null,
    );
    // for (int i = 0; i < value.data.length; i++) {
    gst_LedgerModel.gst_Ledger_list.value = GSTSummaryModel.fromJson(value.data);
    // }
    gst_LedgerModel.ParentGST_Ledgers.value = GSTSummaryModel.fromJson(value.data);
    initialize_StartEnd_date(gst_LedgerModel.gst_Ledger_list.value.startdate!, gst_LedgerModel.gst_Ledger_list.value.enddate!);
  }

  /// Sets the start and end date values in the selected GST ledger filter model.
  void initialize_StartEnd_date(String startDate, String endDate) {
    gst_LedgerModel.gst_LedgerSelectedFilter.value.fromdate.value = startDate;
    gst_LedgerModel.gst_LedgerSelectedFilter.value.todate.value = endDate;
  }
  // void reset_gst_LedgerClear_popup() {
  //   gst_LedgerModel.recievableAmount.value = 0.0;
  //   gst_LedgerModel.is_fullClear.value = false;
  //   gst_LedgerModel.is_amountExceeds.value = null;
  //   gst_LedgerModel.is_Deducted.value = true;
  //   gst_LedgerModel.closedDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   gst_LedgerModel.fileName.value = null;
  //   gst_LedgerModel.selectedFile.value = null;

  //   // Reset text controllers
  //   gst_LedgerModel.amountCleared_controller.value.clear();
  //   gst_LedgerModel.transactionDetails_controller.value.clear();
  //   gst_LedgerModel.feedback_controller.value.clear();
  //   gst_LedgerModel.closedDateController.text = gst_LedgerModel.closedDate.value;
  // }

  /// Clears all GST share-related input fields and resets WhatsApp and Gmail sharing selections.
  void clear_sharedata() {
    gst_LedgerModel.emailController.value.clear();
    gst_LedgerModel.phoneController.value.clear();
    gst_LedgerModel.feedbackController.value.clear();
    gst_LedgerModel.CCemailController.value.clear();
    gst_LedgerModel.whatsapp_selectionStatus.value = false;
    gst_LedgerModel.gmail_selectionStatus.value = false;
  }

  /// Updates the visibility status of the CC email field in the GST ledger model.
  void toggleCCemailvisibility(bool value) {
    gst_LedgerModel.CCemailToggle.value = value;
  }
}
