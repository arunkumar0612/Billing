import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/view_ledger_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin Account_LedgerService {
  final Account_LedgerController account_LedgerController = Get.find<Account_LedgerController>();
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  /// Fetches the account ledger list based on the current selected filter values.
  ///
  /// Query parameters include:
  /// - `ledgertype`: Filters by transaction type unless set to "show all"
  /// - `paymenttype`: Filters by payment type unless set to "show all"
  /// - `invoicetype`: Filters by invoice type unless set to "show all"
  /// - `customerid`: Filters by specific customer unless "None" is selected
  /// - `startdate` and `enddate`: Define the date range for filtering
  ///
  /// If the API response is successful (`statusCode == 200` and `value.code == true`):
  /// - Updates the `account_LedgerModel` with the retrieved ledger data
  /// - Triggers a UI update via `account_LedgerController.update()`
  ///
  /// In case of an error, appropriate error handling is present but commented out.

  Future<void> get_Account_LedgerList() async {
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "ledgertype": account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.transactiontype.value.toLowerCase() == 'show all'
            ? ''
            : account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.transactiontype.value.toLowerCase(),
        "paymenttype": account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.paymenttype.value.toLowerCase() == 'show all'
            ? ''
            : account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.paymenttype.value.toLowerCase(),
        "invoicetype": account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value.toLowerCase() == 'show all'
            ? ''
            : account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value.toLowerCase(),
        // "customerid": "SB_1",
        "customerid": account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedcustomerid.value == 'None'
            ? ''
            : account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedcustomerid.value,
        "startdate": account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value.toString(),
        "enddate": account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value.toString(),
      },
      API.getaccount_Ledgerlist,
    );
    if (response?['statusCode'] == 200) {
      CMDmResponse value = CMDmResponse.fromJson(response ?? {});
      if (value.code) {
        account_LedgerController.add_Account_Ledger(value);

        // print(account_LedgerController.account_LedgerModel.account_Ledger_list[0].billDetails);
        account_LedgerController.update();
      } else {
        // await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  /// Constructs and returns a `PDF_AccountLedgerSummary` object for generating a PDF ledger.
  ///
  /// This function does the following:
  /// - Determines the client type (subscription or sales) based on the input booleans:
  ///   - If `Sub_clientOrNot` is true, it fetches client details from the `subCustomerList`.
  ///   - If `Sales_clientOrNot` is true, it fetches from the `salesCustomerList`.
  /// - Extracts client information such as name, address, GSTIN, and PAN.
  ///   - If GSTIN or PAN are missing (empty string), they are replaced with a dash (`-`).
  /// - Always pulls the ledger data and the date range (`fromDate`, `toDate`) from `account_LedgerController`.
  /// - Finally, it returns a `PDF_AccountLedgerSummary` created using the gathered data.
  ///
  /// Returns:
  /// - A fully initialized `PDF_AccountLedgerSummary` instance ready for PDF export.
  Future<PDF_AccountLedgerSummary> parsePDF_AccountLedger(bool Sub_clientOrNot, bool Sales_clientOrNot) async {
    final ClientDetails? clientDetails;

    if (Sub_clientOrNot) {
      String? clientID = account_LedgerController.account_LedgerModel.selectedcustomerID.value;

      CustomerInfo clientData = view_LedgerController.view_LedgerModel.subCustomerList.firstWhere((element) => element.customerId == clientID);
      clientDetails = ClientDetails(
        clientName: clientData.customerName,
        clientAddress: clientData.customerAddress,
        GSTIN: clientData.customerGstNo == '' ? '-' : clientData.customerGstNo,
        PAN: clientData.customerPAN == '' ? '-' : clientData.customerPAN,
        // fromDate: DateTime.parse(account_LedgerController
        //     .account_LedgerModel.account_Ledger_list.value.startdate!),
        // toDate: DateTime.parse(account_LedgerController
        //     .account_LedgerModel.account_Ledger_list.value.enddate!),
      );
    } else if (Sales_clientOrNot) {
      String? clientID = account_LedgerController.account_LedgerModel.selectedcustomerID.value;

      CustomerInfo clientData = view_LedgerController.view_LedgerModel.salesCustomerList.firstWhere((element) => element.customerId == clientID);
      clientDetails = ClientDetails(
        clientName: clientData.customerName,
        clientAddress: clientData.customerAddress,
        GSTIN: clientData.customerGstNo == '' ? '-' : clientData.customerGstNo,
        PAN: clientData.customerPAN == '' ? '-' : clientData.customerPAN,
      );
    } else {
      clientDetails = null;
    }

    PDF_AccountLedgerSummary value = PDF_AccountLedgerSummary.fromJson(
        clientDetails: clientDetails,
        ledgerDetails: account_LedgerController.account_LedgerModel.account_Ledger_list.value,
        fromDate: DateTime.parse(account_LedgerController.account_LedgerModel.account_Ledger_list.value.startdate!),
        toDate: DateTime.parse(account_LedgerController.account_LedgerModel.account_Ledger_list.value.enddate!));

    return value;
  }

  bool isSubscription_Client() {
    return account_LedgerController.account_LedgerModel.selectedsubcustomer.value != 'None' && account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Subscription' ? true : false;
  }

  /// Checks whether the selected client qualifies as a sales client.
  ///
  /// A client is considered a sales client if:
  /// - The selected sales customer is not 'None'
  /// - The selected invoice type is 'Sales'
  ///
  /// Returns:
  /// - `true` if both conditions are met, indicating a valid sales client
  /// - `false` otherwise
  bool isSales_Client() {
    return account_LedgerController.account_LedgerModel.selectedsalescustomer.value != 'None' && account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Sales' ? true : false;
  }

  /// Refreshes the account ledger data.
  ///
  /// This function performs the following:
  /// - Calls `get_Account_LedgerList()` to fetch the latest account ledger entries.
  /// - Triggers an update on `account_LedgerController` to refresh any UI or listeners
  ///   depending on the controller.
  Future<void> account_Ledger_refresh() async {
    await get_Account_LedgerList();
    account_LedgerController.update();
  }

  /// Resets the applied filters on the account ledger list.
  ///
  /// This function sets the primary `account_Ledger_list` to the value of the
  /// `Secondaryaccount_Ledger_list`, effectively restoring the original unfiltered data.
  void resetFilters() {
    account_LedgerController.account_LedgerModel.account_Ledger_list.value = account_LedgerController.account_LedgerModel.Secondaryaccount_Ledger_list.value;
  }

  /// Resets all applied filters in the account ledger filter model to their default values.
  ///
  /// This includes:
  /// - Setting transaction type, invoice type, and payment type to 'Show All'
  /// - Resetting selected customer and subscription names to 'None'
  /// - Clearing customer ID, from-date, and to-date fields
  ///
  /// Use this to clear any filters applied on the ledger list and restore default filter state.
  void resetaccount_LedgerFilters() {
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.transactiontype.value = 'Show All';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value = 'Show All';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedcustomerid.value = '';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.paymenttype.value = 'Show All';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value = '';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value = '';

    // account_LedgerController.account_LedgerModel.filteredaccount_Ledgers.value = account_LedgerController.account_LedgerModel.account_Ledger_list;
  }

  /// Assigns the currently selected filter values to the active filter state in the account ledger.
  ///
  /// This function copies the following fields from the main selection model into the `account_LedgerSelectedFilter`:
  /// - Transaction type
  /// - Invoice type
  /// - Sales customer name
  /// - Subscription customer name
  /// - Customer ID
  /// - Payment type
  /// - From date
  /// - To date
  ///
  /// This helps persist and apply the chosen filter values when processing or displaying filtered results.
  void assignaccount_LedgerFilters() {
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.transactiontype.value = account_LedgerController.account_LedgerModel.selectedtransactiontype.value;
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value = account_LedgerController.account_LedgerModel.selectedInvoiceType.value;
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsalescustomername.value = account_LedgerController.account_LedgerModel.selectedsalescustomer.value;
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = account_LedgerController.account_LedgerModel.selectedsubcustomer.value;
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedcustomerid.value = account_LedgerController.account_LedgerModel.selectedcustomerID.value;
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.paymenttype.value = account_LedgerController.account_LedgerModel.selectedpaymenttype.value;
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value = account_LedgerController.account_LedgerModel.startDateController.value.text;
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value = account_LedgerController.account_LedgerModel.endDateController.value.text;
  }

  /// Reapplies previously saved filter selections back to the main filter fields in the account ledger.
  ///
  /// This function transfers values from the `account_LedgerSelectedFilter` object back into the primary filter fields:
  /// - Transaction type, invoice type, sales customer, and subscription customer
  /// - Customer ID and payment type
  /// - From date and to date (into their respective controllers)
  /// - Selected month value
  ///
  /// Use this to restore a user's saved filter settings after navigation or screen refresh.
  void reassignaccount_LedgerFilters() {
    account_LedgerController.account_LedgerModel.selectedtransactiontype.value = account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.transactiontype.value;
    account_LedgerController.account_LedgerModel.selectedInvoiceType.value = account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value;
    account_LedgerController.account_LedgerModel.selectedsalescustomer.value = account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsalescustomername.value;
    account_LedgerController.account_LedgerModel.selectedsubcustomer.value = account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value;
    account_LedgerController.account_LedgerModel.selectedcustomerID.value = account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedcustomerid.value;
    account_LedgerController.account_LedgerModel.selectedpaymenttype.value = account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.paymenttype.value;
    account_LedgerController.account_LedgerModel.startDateController.value.text = account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value;
    account_LedgerController.account_LedgerModel.endDateController.value.text = account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.toString();
    account_LedgerController.account_LedgerModel.selectedMonth.value = account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedmonth.value.toString();
  }
}
