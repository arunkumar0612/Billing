import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/TDS_ledger_action.dart';
// import 'package:ssipl_billing/2.BILLING/TDS_Ledgers/controllers/tds_Ledger_action.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin TDS_LedgerService {
  final TDS_LedgerController tds_LedgerController = Get.find<TDS_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  /// Fetches the TDS Ledger data based on the applied filter values.
  ///
  /// This asynchronous method constructs a query using the selected TDS type, invoice type,
  /// customer ID, and date range from `tds_LedgerSelectedFilter`, then calls the API to retrieve
  /// the corresponding TDS ledger records.
  ///
  /// If the response is successful (`statusCode == 200`) and the `code` flag in the response is true,
  /// the retrieved data is parsed into a `CMDmResponse`, added to the controller, and triggers a UI update.
  ///
  /// It handles special cases like "Show All" filters and "None" customer ID by passing empty strings
  /// to the API query to ensure broad or unrestricted searches.
  Future<void> get_TDS_LedgerList() async {
    // loader.start(context);
    // await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "tdstype": tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value.toLowerCase() == 'show all'
            ? ''
            : tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value.toLowerCase(),

        "invoicetype": tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value.toLowerCase() == 'show all'
            ? ''
            : tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value.toLowerCase(),
        // "customerid": "SB_1",
        "customerid": tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value == 'None'
            ? ''
            : tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value,
        "startdate": tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value.toString(),
        "enddate": tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value.toString(),
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

  /// Refreshes the TDS Ledger data and updates the UI.
  ///
  /// This method triggers a fresh fetch of TDS ledger records by calling `get_TDS_LedgerList()`,
  /// and then updates the `tds_LedgerController` to reflect the latest data in the UI.
  ///
  /// Typically used for pull-to-refresh actions or when filters are applied to reload data accordingly.
  Future<void> tds_Ledger_refresh() async {
    await get_TDS_LedgerList();
    tds_LedgerController.update();
  }

  /// Resets the TDS ledger list to its original unfiltered state.
  ///
  /// This method assigns the original `ParentTDS_Ledgers` list (which holds the full unfiltered data)
  /// back to the currently displayed `tds_Ledger_list`, effectively removing any active filters.
  void resetFilters() {
    tds_LedgerController.tds_LedgerModel.tds_Ledger_list.value = tds_LedgerController.tds_LedgerModel.ParentTDS_Ledgers.value;
  }

  /// Resets all TDS ledger filter fields to their default values.
  ///
  /// This method clears the selected TDS type, invoice type, customer names, customer ID,
  /// and date range filters to their initial states, effectively removing any filter conditions
  /// applied to the TDS ledger view.
  void resettds_LedgerFilters() {
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value = 'Show All';
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value = 'Show All';
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value = '';
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';

    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value = '';
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value = '';

    // tds_LedgerController.tds_LedgerModel.filteredtds_Ledgers.value = tds_LedgerController.tds_LedgerModel.tds_Ledger_list;
  }

  /// Saves the current TDS ledger filter selections into the filter snapshot.
  ///
  /// This method captures the currently selected TDS type, invoice type, customer names, customer ID,
  /// and date range, storing them into the `tds_LedgerSelectedFilter` object for future restoration or comparison.
  void assigntds_LedgerFilters() {
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value = tds_LedgerController.tds_LedgerModel.selectedTDStype.value;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value = tds_LedgerController.tds_LedgerModel.selectedInvoiceType.value;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsalescustomername.value = tds_LedgerController.tds_LedgerModel.selectedsalescustomer.value;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = tds_LedgerController.tds_LedgerModel.selectedsubcustomer.value;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value = tds_LedgerController.tds_LedgerModel.selectedcustomerID.value;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value = tds_LedgerController.tds_LedgerModel.startDateController.value.text;
    tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value = tds_LedgerController.tds_LedgerModel.endDateController.value.text;
  }

  /// Reassigns the saved TDS ledger filters back to the active filter fields.
  ///
  /// This method restores previously saved filter values (such as TDS type, invoice type, customer details,
  /// and date range) from `tds_LedgerSelectedFilter` into the currently active fields in `tds_LedgerModel`,
  /// effectively reapplying a prior filter state.
  void reassigntds_LedgerFilters() {
    tds_LedgerController.tds_LedgerModel.selectedTDStype.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value;
    tds_LedgerController.tds_LedgerModel.selectedInvoiceType.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value;
    tds_LedgerController.tds_LedgerModel.selectedsalescustomer.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsalescustomername.value;
    tds_LedgerController.tds_LedgerModel.selectedsubcustomer.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value;
    tds_LedgerController.tds_LedgerModel.selectedcustomerID.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value;

    tds_LedgerController.tds_LedgerModel.startDateController.value.text = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.toString();
    tds_LedgerController.tds_LedgerModel.endDateController.value.text = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.toString();
    tds_LedgerController.tds_LedgerModel.selectedMonth.value = tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedmonth.value.toString();
  }
}
