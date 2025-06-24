import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/GST_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin GST_LedgerService {
  final GST_LedgerController gst_LedgerController = Get.find<GST_LedgerController>();
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  /// Fetches GST Ledger data based on current filter values.
  ///
  /// This async function prepares query parameters from the `gst_LedgerSelectedFilter`,
  /// then sends a GET request to the API to retrieve the GST ledger list.
  ///
  /// Key filter parameters:
  /// - `gsttype`: Sent as an empty string if "Consolidate" is selected.
  /// - `invoicetype`: Empty if "Show All" is selected.
  /// - `customerid`: Empty if no specific customer is selected.
  /// - `startdate` and `enddate`: Passed as selected date range.
  ///
  /// Upon successful response (`statusCode == 200` and `code == true`):
  /// - The ledger list is updated in the controller using `add_GST_Ledger()`
  /// - UI is refreshed via `update()`
  ///
  /// Error conditions are currently commented out but are intended for future user alerts.
  Future<void> get_GST_LedgerList() async {
    // loader.start(context);
    // await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "gsttype": gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value.toLowerCase() == 'consolidate'
            ? ''
            : gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value.toLowerCase(),

        "invoicetype": gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value.toLowerCase() == 'show all'
            ? ''
            : gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value.toLowerCase(),
        // "customerid": "SB_1",
        "customerid": gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value == 'None'
            ? ''
            : gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value,
        "startdate": gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.fromdate.value.toString(),
        "enddate": gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.todate.value.toString(),
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

  /// Refreshes the GST Ledger data.
  ///
  /// This function performs two tasks sequentially:
  /// 1. Calls `get_GST_LedgerList()` to fetch the latest GST ledger entries from the API.
  /// 2. Triggers a UI update via `gst_LedgerController.update()` to reflect the newly fetched data.
  ///
  /// Typically used in pull-to-refresh gestures or on screen re-entry.
  Future<void> gst_Ledger_refresh() async {
    await get_GST_LedgerList();
    gst_LedgerController.update();
  }

  /// Resets the GST Ledger filters by restoring the full original data.
  ///
  /// This function assigns the `ParentGST_Ledgers` (which holds the unfiltered original list)
  /// back to the currently displayed `gst_Ledger_list`, effectively removing any active filters.
  void resetFilters() {
    gst_LedgerController.gst_LedgerModel.gst_Ledger_list.value = gst_LedgerController.gst_LedgerModel.ParentGST_Ledgers.value;
  }

  /// Resets all GST Ledger filter fields to their default values.
  ///
  /// This includes:
  /// - Setting `GSTtype` to `'Consolidate'`
  /// - Setting `invoicetype` to `'Show All'`
  /// - Resetting customer-related selections (`sales`, `subscription`, `ID`)
  /// - Clearing the date range (`fromdate`, `todate`)
  ///
  /// Use this method to fully clear any active filters and restore filter UI to its initial state.
  void resetgst_LedgerFilters() {
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value = 'Consolidate';
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value = 'Show All';
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value = '';
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';

    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.fromdate.value = '';
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.todate.value = '';

    // gst_LedgerController.gst_LedgerModel.filteredgst_Ledgers.value = gst_LedgerController.gst_LedgerModel.gst_Ledger_list;
  }

  /// Assigns the currently selected GST Ledger filter values to the filter state model.
  ///
  /// This method takes the values from the active selection controls (`selectedGSTtype`, `selectedInvoiceType`,
  /// `selectedsalescustomer`, etc.) and saves them into `gst_LedgerSelectedFilter`.
  ///
  /// This is typically used before performing operations that require remembering user-selected filters,
  /// like saving preferences or reapplying filters after navigation.
  void assigngst_LedgerFilters() {
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value = gst_LedgerController.gst_LedgerModel.selectedGSTtype.value;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value = gst_LedgerController.gst_LedgerModel.selectedInvoiceType.value;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsalescustomername.value = gst_LedgerController.gst_LedgerModel.selectedsalescustomer.value;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = gst_LedgerController.gst_LedgerModel.selectedsubcustomer.value;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value = gst_LedgerController.gst_LedgerModel.selectedcustomerID.value;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.fromdate.value = gst_LedgerController.gst_LedgerModel.startDateController.value.text;
    gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.todate.value = gst_LedgerController.gst_LedgerModel.endDateController.value.text;
  }

  /// Reassigns the saved GST Ledger filter values back to the UI filter fields.
  ///
  /// This method restores previously selected filter values from `gst_LedgerSelectedFilter`
  /// into the current model's reactive fields. It ensures that user-selected
  /// filters (like GST type, invoice type, customers, and date range)
  /// are re-populated into the filter form for consistent experience,
  /// such as after navigation or reopening the filter view.
  void reassigngst_LedgerFilters() {
    gst_LedgerController.gst_LedgerModel.selectedGSTtype.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value;
    gst_LedgerController.gst_LedgerModel.selectedInvoiceType.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value;
    gst_LedgerController.gst_LedgerModel.selectedsalescustomer.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsalescustomername.value;
    gst_LedgerController.gst_LedgerModel.selectedsubcustomer.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value;
    gst_LedgerController.gst_LedgerModel.selectedcustomerID.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value;

    gst_LedgerController.gst_LedgerModel.startDateController.value.text = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.fromdate.toString();
    gst_LedgerController.gst_LedgerModel.endDateController.value.text = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.todate.toString();
    gst_LedgerController.gst_LedgerModel.selectedMonth.value = gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedmonth.value.toString();
  }
}
