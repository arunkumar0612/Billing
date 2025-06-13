// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/view_ledger_entities.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';
// import 'package:ssipl_billing/2.BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin VoucherService {
  final VoucherController voucherController = Get.find<VoucherController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final loader = LoadingOverlay();

  /// Sends a request to add an overdue entry for a specific voucher.
  ///
  /// - [context]: The build context used for showing dialogs.
  /// - [voucherID]: The ID of the voucher to which the overdue is being added.
  /// - [index]: The index of the overdue entry in the controller's list.
  ///
  /// Steps:
  /// 1. Constructs a query with `voucherid`, `date`, and `feedback` using the given index.
  /// 2. Encodes the data to JSON and sends it to the `add_overdue` API via the controller.
  /// 3. Parses the response into a [CMDlResponse] object.
  /// 4. On success, shows a success dialog with the server's message.
  /// 5. On failure, shows an error dialog with the message or a generic server error.
  /// 6. Handles unexpected errors by showing a generic exception dialog.
  dynamic add_Overdue(context, int voucherID, int index) async {
    try {
      Map<String, dynamic> query = {
        "voucherid": voucherID,
        "date": voucherController.voucherModel.extendDueDateControllers[index].value.text,
        "feedback": voucherController.voucherModel.extendDueFeedbackControllers[index].value.text,
      };
      String encodedData = json.encode(query);
      Map<String, dynamic>? response = await apiController.SendByQuerystring(encodedData, API.add_overdue);
      if (response['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response);
        if (value.code) {
          await Success_dialog(context: context, title: "Success", content: value.message!, onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Updates a specific transaction's payment details in a voucher.
  ///
  /// - [context]: Build context for displaying dialogs.
  /// - [voucherIndex]: Index of the voucher in the voucher list.
  /// - [transactionIndex]: Index of the transaction to update.
  ///
  /// Function Workflow:
  /// 1. Retrieves the targeted voucher and its payment list.
  /// 2. Maps the `paymentDetails` list into a list of formatted maps:
  ///    - Converts date to `YYYY-MM-DD`
  ///    - Ensures transaction ID is encoded as `double`
  /// 3. Constructs a query containing:
  ///    - The full list of payment details
  ///    - The current transaction ID and voucher ID
  /// 4. Sends the data to the backend via `SendByQuerystring`.
  /// 5. Displays a success dialog on update success, else shows error or server failure dialog.
  /// 6. Catches and handles unexpected exceptions.
  dynamic update_paymentDetails(context, int voucherIndex, int transactionIndex) async {
    try {
      final voucher = voucherController.voucherModel.voucher_list[voucherIndex];
      final paymentList = voucher.paymentDetails ?? [];

      final List<Map<String, dynamic>> formattedTransactions = paymentList
          .map((txn) => {
                "date": txn.date.toIso8601String().split('T').first, // Formats to "YYYY-MM-DD"
                "amount": txn.amount,
                "feedback": txn.feedback,
                "transactionid": txn.transactionId.toDouble(), // Convert int to double
                "transanctiondetails": txn.transanctionDetails,
                "paymentmode": txn.paymentmode,
              })
          .toList();

      Map<String, dynamic> query = {
        "paymentdetails": formattedTransactions,
        "transactionid": voucherController.voucherModel.voucher_list[voucherIndex].paymentDetails![transactionIndex].transactionId,
        "voucherid": voucherController.voucherModel.voucher_list[voucherIndex].voucher_id,
        // "paymentmode": "cash",
      };
      String encodedData = json.encode(query);
      Map<String, dynamic>? response = await apiController.SendByQuerystring(encodedData, API.update_transactionDetails);
      if (response['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response);
        if (value.code) {
          await Success_dialog(context: context, title: "Success", content: value.message!, onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Fetches the list of subscription customers from the server and updates the `subCustomerList` in the voucher model.
  ///
  /// Steps:
  /// 1. Sends a GET request with token to the API endpoint `get_ledgerSubscriptionCustomers`.
  /// 2. If response status is 200:
  ///    - Parses the response into [CMDlResponse].
  ///    - If `code` is true, maps the returned data to a list of [CustomerInfo] and updates `subCustomerList`.
  ///    - If `code` is false, logs the error message in debug mode.
  /// 3. If response status is not 200, logs a server error in debug mode.
  /// 4. Catches and logs any unexpected exceptions in debug mode.
  Future<void> Get_SUBcustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_ledgerSubscriptionCustomers);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          voucherController.voucherModel.subCustomerList.value = value.data.map((e) => CustomerInfo.fromJson(e)).toList();

          // print('ijhietjwe${view_LedgerController.view_LedgerModel.subCustomerList}');
          // salesController.addToCustompdfList(value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Processcustomer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  /// Fetches the list of subscription customers from the server and updates the `subCustomerList` in the voucher model.
  ///
  /// Steps:
  /// 1. Sends a GET request with token to the API endpoint `get_ledgerSubscriptionCustomers`.
  /// 2. If response status is 200:
  ///    - Parses the response into [CMDlResponse].
  ///    - If `code` is true, maps the returned data to a list of [CustomerInfo] and updates `subCustomerList`.
  ///    - If `code` is false, logs the error message in debug mode.
  /// 3. If response status is not 200, logs a server error in debug mode.
  /// 4. Catches and logs any unexpected exceptions in debug mode.
  Future<void> Get_SALEScustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_ledgerSalesCustomers);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          voucherController.voucherModel.salesCustomerList.value = value.data.map((e) => CustomerInfo.fromJson(e)).toList();
          // print(view_LedgerController.view_LedgerModel.salesCustomerList);
          // salesController.addToCustompdfList(value);
        } else {
          if (kDebugMode) {
            print("error : ${value.message}");
          }
          // await Basic_dialog(context: context, showCancel: false, title: 'Processcustomer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        if (kDebugMode) {
          print("error : ${"please contact administration"}");
        }
        // Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      // Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }

  /// Fetches the filtered list of vouchers from the server and updates the local voucher list.
  ///
  /// Functionality:
  /// 1. Constructs query parameters based on the selected filter values:
  ///    - Converts filter values like `vouchertype`, `paymentstatus`, and `invoicetype` to lowercase.
  ///    - If any filter is set to "Show All" or "None", it sends an empty string instead.
  /// 2. Sends a GET request to the `getvoucherlist` endpoint with the query parameters.
  /// 3. On successful response (`statusCode == 200`):
  ///    - Parses the response into `CMDlResponse`.
  ///    - If `code` is true:
  ///       - Calls `add_Voucher()` to update the voucher list.
  ///       - Triggers a search based on the current search field text.
  ///       - Calls `update()` to notify listeners.
  ///    - If `code` is false, the error message is currently ignored but may be displayed in future.
  /// 4. If the server fails to respond properly, an error dialog is prepared but commented out for now.
  Future<void> get_VoucherList() async {
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "vouchertype": voucherController.voucherModel.voucherSelectedFilter.value.vouchertype.value.toLowerCase() == 'show all'
            ? ''
            : voucherController.voucherModel.voucherSelectedFilter.value.vouchertype.value.toLowerCase(),
        "paymentstatus": voucherController.voucherModel.voucherSelectedFilter.value.paymentstatus.value.toLowerCase() == 'show all'
            ? ''
            : voucherController.voucherModel.voucherSelectedFilter.value.paymentstatus.value.toLowerCase(),
        "invoicetype": voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value.toLowerCase() == 'show all'
            ? ''
            : voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value.toLowerCase(),
        // "customerid": "SB_1",
        "customerid":
            voucherController.voucherModel.voucherSelectedFilter.value.selectedcustomerid.value == 'None' ? '' : voucherController.voucherModel.voucherSelectedFilter.value.selectedcustomerid.value,
        "startdate": voucherController.voucherModel.voucherSelectedFilter.value.fromdate.value.toString(),
        "enddate": voucherController.voucherModel.voucherSelectedFilter.value.todate.value.toString(),
      },
      API.getvoucherlist,
    );
    // print('asfasfasa${voucherController.voucherModel.voucherSelectedFilter.value.fromdate.toString()}');
    if (response?['statusCode'] == 200) {
      CMDlResponse value = CMDlResponse.fromJson(
        response ?? {},
      );
      if (value.code) {
        // print(value.data);
        voucherController.add_Voucher(value);
        search(voucherController.voucherModel.searchController.value.text);

        voucherController.update();
      } else {
        // await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  /// Calculates aggregated values for the vouchers selected via checkboxes.
  ///
  /// Steps:
  /// 1. Iterates over `checkboxValues` to find indices of selected vouchers.
  /// 2. Uses the selected indices to extract corresponding `InvoicePaymentVoucher` objects from `voucher_list`.
  /// 3. Aggregates financial data from selected vouchers into a `SelectedInvoiceVoucherGroup` object:
  ///    - `totalPendingAmount_withoutTDS`: Sum of all `pendingAmount` values.
  ///    - `totalPendingAmount_withTDS`: Same as above but subtracting `tdsCalculationAmount`.
  ///    - `netAmount`: Sum of all `subTotal` values.
  ///    - `totalCGST`, `totalSGST`, `totalIGST`: Tax-wise aggregation.
  ///    - `totalTDS`: Total TDS amount.
  /// 4. Returns the constructed group object.
  ///
  /// Purpose:
  /// Used to dynamically compute totals (amounts and taxes) for all selected vouchers, aiding bulk operations like grouped payments.
  Future<SelectedInvoiceVoucherGroup> calculate_SelectedVouchers() async {
    List<int> selectedIndices = [];
    for (int i = 0; i < voucherController.voucherModel.checkboxValues.length; i++) {
      if (voucherController.voucherModel.checkboxValues[i] == true) {
        selectedIndices.add(i);
      }
    }

    List<InvoicePaymentVoucher> fullList = voucherController.voucherModel.voucher_list; // assume this is populated

    List<InvoicePaymentVoucher> selected = selectedIndices.map((index) => fullList[index]).toList();

    SelectedInvoiceVoucherGroup group = SelectedInvoiceVoucherGroup(
      selectedVoucherList: selected,
      totalPendingAmount_withoutTDS: selected.fold(0, (sum, v) => sum + v.pendingAmount),
      totalPendingAmount_withTDS: selected.fold<double>(0.0, (sum, v) => sum + v.pendingAmount) - selected.fold<double>(0.0, (sum, v) => sum + v.tdsCalculationAmount),
      netAmount: selected.fold(0, (sum, v) => sum + v.subTotal),
      totalCGST: selected.fold(0, (sum, v) => sum + v.cgst),
      totalSGST: selected.fold(0, (sum, v) => sum + v.sgst),
      totalIGST: selected.fold(0, (sum, v) => sum + v.igst),
      totalTDS: selected.fold(0, (sum, v) => sum + v.tdsCalculationAmount),
    );

    return group;
  }

  /// Refreshes the voucher screen by reloading data and resetting filters.
  ///
  /// Sequence of operations:
  /// 1. Awaits `get_VoucherList()` to fetch the initial set of vouchers.
  /// 2. Calls `voucherController.update()` to notify listeners of any data change.
  /// 3. Schedules a post-frame callback (after the widget tree is built):
  ///    - Resets all filter values to default using `resetvoucherFilters()`.
  ///    - Fetches updated data again using `get_VoucherList()`, `Get_SUBcustomerList()`, and `Get_SALEScustomerList()`.
  ///    - (Commented) Optionally reinitializes the checkbox list for voucher selection.
  ///
  /// Use Case:
  /// Triggered when the user wants to refresh or reset the voucher screen, ensuring all filters and data are up to date.
  Future<void> voucher_refresh() async {
    await get_VoucherList();
    voucherController.update();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      resetvoucherFilters();
      get_VoucherList();
      Get_SUBcustomerList();
      Get_SALEScustomerList();

      // Initialize checkboxValues after data is loaded
      // voucherController.voucherModel.checkboxValues = List<bool>.filled(voucherController.voucherModel.voucher_list.length, false).obs;
    });
  }

  /// Updates the checkbox value at the specified index and toggles the delete button visibility.
  ///
  /// Parameters:
  /// - [index]: The index of the checkbox to be updated.
  /// - [value]: The new value (true/false) to be set at the given index.
  ///
  /// Logic:
  /// - Sets the checkbox value at the given index.
  /// - Checks if any checkbox is selected (`true`) in the list:
  ///   - If yes, enables the delete button by setting `showDeleteButton` to true.
  ///   - If none selected, disables the delete button.
  /// - Calls `voucherController.update()` to refresh the UI with the new state.
  ///
  /// Use Case:
  /// This method is typically triggered when a checkbox in a list of vouchers is toggled.
  void update_checkboxValues(int index, bool value) {
    voucherController.voucherModel.checkboxValues[index] = value;
    if (voucherController.voucherModel.checkboxValues.contains(true)) {
      voucherController.voucherModel.showDeleteButton.value = true;
    } else {
      voucherController.voucherModel.showDeleteButton.value = false;
    }

    voucherController.update();
  }

  /// Processes and clears a group of selected vouchers by sending their combined data to the server.
  ///
  /// Parameters:
  /// - [context]: BuildContext for showing dialogs.
  /// - [selectedVouchers]: A `SelectedInvoiceVoucherGroup` object containing the list of vouchers to be processed.
  /// - [file]: Optional supporting file (e.g., attachment).
  /// - [receipt]: Mandatory file representing the receipt document.
  ///
  /// Steps:
  /// 1. Iterates through each selected voucher to extract required fields like voucher ID, number, taxes, amounts, client info, etc.
  /// 2. Creates multiple lists to track voucher IDs, numbers, invoice numbers, customer IDs, and detailed invoice metadata.
  /// 3. Constructs a `main_map` with all consolidated data needed for processing the voucher group.
  /// 4. Encodes this data into JSON and sends it via a `Multer` request to the backend (`clearClubVoucher` API), along with the provided files.
  /// 5. Handles the server response:
  ///    - On success: Shows a success dialog and closes the current screen.
  ///    - On failure: Shows an appropriate error dialog based on the response.
  /// 6. If the server is down or unresponsive, shows a generic server error dialog.
  ///
  /// Use Case:
  /// Triggered when finalizing payments for multiple vouchers as a single consolidated entry.
  dynamic clear_ClubVoucher(context, SelectedInvoiceVoucherGroup selectedVouchers, File? file, File receipt) async {
    try {
      List<Map<String, dynamic>> consolidateJSON = [];
      List<int> voucherIds = [];
      List<String> voucherNumbers = [];
      List<String> invoiceNumbers = [];
      List<String> cusIDs = [];
      List<Map<String, dynamic>> invoiceDetails = [];
      for (int i = 0; i < selectedVouchers.selectedVoucherList.length; i++) {
        voucherIds.add(selectedVouchers.selectedVoucherList[i].voucher_id);
        voucherNumbers.add(selectedVouchers.selectedVoucherList[i].voucherNumber);
        invoiceNumbers.add(selectedVouchers.selectedVoucherList[i].invoiceNumber);
        cusIDs.add(selectedVouchers.selectedVoucherList[i].customerId);
        invoiceDetails.add({
          'invoicenumber': selectedVouchers.selectedVoucherList[i].invoiceNumber,
          'invoicedate': selectedVouchers.selectedVoucherList[i].date,
        });
        final mapData = {
          "voucherid": selectedVouchers.selectedVoucherList[i].voucher_id,
          "vouchernumber": selectedVouchers.selectedVoucherList[i].voucherNumber,
          "IGST": selectedVouchers.selectedVoucherList[i].igst,
          "SGST": selectedVouchers.selectedVoucherList[i].sgst,
          "CGST": selectedVouchers.selectedVoucherList[i].cgst,
          "tds": selectedVouchers.selectedVoucherList[i].tdsCalculationAmount,
          "tdsstatus": voucherController.voucherModel.is_Deducted.value,
          "grossamount": selectedVouchers.selectedVoucherList[i].totalAmount,
          "subtotal": selectedVouchers.selectedVoucherList[i].subTotal,
          "paidamount": voucherController.voucherModel.is_Deducted.value
              ? (selectedVouchers.selectedVoucherList[i].pendingAmount - selectedVouchers.selectedVoucherList[i].tdsCalculationAmount)
              : selectedVouchers.selectedVoucherList[i].totalAmount,
          "clientaddressname": selectedVouchers.selectedVoucherList[i].clientName,
          "clientaddress": selectedVouchers.selectedVoucherList[i].clientAddress,
          "invoicenumber": selectedVouchers.selectedVoucherList[i].invoiceNumber,
          "emailid": selectedVouchers.selectedVoucherList[i].emailId,
          "phoneno": selectedVouchers.selectedVoucherList[i].phoneNumber,
          "invoicetype": selectedVouchers.selectedVoucherList[i].invoiceType,
          "gstnumber": selectedVouchers.selectedVoucherList[i].gstNumber,
          'invoicedate': voucherController.voucherModel.voucher_list[i].date?.toIso8601String(),
        };
        consolidateJSON.add(mapData);
      }
      final main_map = {
        "totalpaidamount": voucherController.voucherModel.is_Deducted.value ? selectedVouchers.totalPendingAmount_withTDS : selectedVouchers.totalPendingAmount_withoutTDS,
        "voucherlist": consolidateJSON,
        "date": voucherController.voucherModel.closedDate.value,
        "feedback": voucherController.voucherModel.feedback_controller.value.text,
        "transactiondetails": voucherController.voucherModel.transactionDetails_controller.value.text,
        "tdsstatus": voucherController.voucherModel.is_Deducted.value,
        "paymentstatus": "complete",
        "voucherids": voucherIds,
        "vouchernumbers": voucherNumbers,
        'invoicenumbers': invoiceNumbers,
        'selectedpaymentmode': voucherController.voucherModel.Selectedpaymentmode.value,
        'selectedinvoicegroup': selectedVouchers,
        "invoicedetails": invoiceDetails,
        "paymentmode": voucherController.voucherModel.Selectedpaymentmode.value,
        "customerids": cusIDs,
      };

      ClubVoucher_data voucherdata = ClubVoucher_data.fromJson(main_map);
      // String encodedData = json.encode(voucherdata.toJson());
      // print((voucherdata.toJson()));
      String encodedData = json.encode(voucherdata.toJson());
      Map<String, dynamic>? response = await apiController.Multer(
        sessiontokenController.sessiontokenModel.sessiontoken.value,
        encodedData,
        [file, receipt].whereType<File>().toList(), // ✅ Corrected line
        API.clearClubVoucher,
      );

      // Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, encodedData, [file!], API.clearClubVoucher);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
        } else {
          await Error_dialog(context: context, title: 'Processing Invoice', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      //await Refresher().refreshAll(context);
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Clears a single voucher entry by sending relevant data and attached files to the server.
  ///
  /// Parameters:
  /// - [context]: Required for showing dialogs and navigation.
  /// - [index]: The index of the voucher in the list to be processed.
  /// - [file]: Optional additional document to be uploaded.
  /// - [VoucherType]: A string representing the payment status (e.g., "Paid", "Partial").
  /// - [receipt]: Mandatory receipt file to be attached.
  ///
  /// Logic:
  /// 1. Gathers data from the selected voucher and UI fields, forming a structured `mapData`.
  /// 2. Converts this data into a `ClearVoucher` object and encodes it as JSON.
  /// 3. Sends a multipart request (via `Multer`) including the data and attached files.
  /// 4. Handles the server response:
  ///    - On success (code true): Shows a success dialog and pops the current screen.
  ///    - On failure (code false): Displays an error dialog with the server message.
  ///    - On server error (status not 200): Shows a "SERVER DOWN" dialog.
  /// 5. Any exceptions are caught and displayed using a generic error dialog.
  ///
  /// Use Case:
  /// Used when a user finalizes and clears payment for a specific voucher in the system.
  dynamic clearVoucher(context, int index, File? file, String VoucherType, File receipt) async {
    try {
      final mapData = {
        "date": DateTime.parse(voucherController.voucherModel.closedDate.value),
        "voucherid": voucherController.voucherModel.voucher_list[index].voucher_id,
        "vouchernumber": voucherController.voucherModel.voucher_list[index].voucherNumber,
        "paymentstatus": VoucherType,
        "IGST": voucherController.voucherModel.voucher_list[index].igst,
        "SGST": voucherController.voucherModel.voucher_list[index].sgst,
        "CGST": voucherController.voucherModel.voucher_list[index].cgst,
        "tds": voucherController.voucherModel.voucher_list[index].tdsCalculationAmount,
        "grossamount": voucherController.voucherModel.voucher_list[index].totalAmount,
        "subtotal": voucherController.voucherModel.voucher_list[index].subTotal,
        "paidamount": double.parse(voucherController.voucherModel.amountCleared_controller.value.text),
        "clientaddressname": voucherController.voucherModel.voucher_list[index].clientName,
        "clientaddress": voucherController.voucherModel.voucher_list[index].clientAddress,
        "invoicenumber": voucherController.voucherModel.voucher_list[index].invoiceNumber,
        "emailid": voucherController.voucherModel.voucher_list[index].emailId,
        "phoneno": voucherController.voucherModel.voucher_list[index].phoneNumber,
        "tdsstatus": voucherController.voucherModel.is_Deducted.value,
        "invoicetype": voucherController.voucherModel.voucher_list[index].invoiceType,
        "gstnumber": voucherController.voucherModel.voucher_list[index].gstNumber,
        "feedback": voucherController.voucherModel.feedback_controller.value.text,
        "transactiondetails": voucherController.voucherModel.transactionDetails_controller.value.text,
        "invoicedate": voucherController.voucherModel.voucher_list[index].date,
        "paymentmode": voucherController.voucherModel.Selectedpaymentmode.value
      };
      ClearVoucher voucherdata = ClearVoucher.fromJson(mapData);

      String encodedData = json.encode(voucherdata.toJson());
      Map<String, dynamic>? response = await apiController.Multer(
        sessiontokenController.sessiontokenModel.sessiontoken.value,
        encodedData,
        [file, receipt].whereType<File>().toList(), // ✅ Corrected line
        API.clearVoucher,
      );
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
        } else {
          await Error_dialog(context: context, title: 'Processing Invoice', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      //await Refresher().refreshAll(context);
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  /// Filters the voucher list based on the user's search query and resets relevant UI states.
  ///
  /// Parameters:
  /// - [query]: The text entered by the user to search vouchers.
  ///
  /// Logic:
  /// 1. If the search query is empty, the full parent voucher list is restored to the display list.
  /// 2. If the query is not empty:
  ///    - Filters vouchers by checking if any of the following fields contain the query string (case-insensitive):
  ///      - `clientName`
  ///      - `voucherNumber`
  ///      - `invoiceNumber`
  ///      - `invoiceType`
  ///      - `gstNumber`
  ///    - Assigns the filtered result to the visible `voucher_list`.
  /// 3. Resets and synchronizes other reactive properties related to voucher interaction:
  ///    - `checkboxValues`: For selection tracking
  ///    - `isExtendButton_visible`: Controls the extend due date button visibility
  ///    - `extendDueDateControllers` & `extendDueFeedbackControllers`: Re-initialized to match filtered length
  ///    - `selectAll` and `showDeleteButton`: Reset to default states
  ///
  /// Use Case:
  /// Called when a user performs a search on the voucher screen to dynamically filter results based on various voucher attributes.
  Future<void> search(String query) async {
    try {
      if (query.isEmpty) {
        voucherController.voucherModel.voucher_list.assignAll(voucherController.voucherModel.ParentVoucher_list);
      } else {
        final filtered = voucherController.voucherModel.ParentVoucher_list.where((voucher) {
          return voucher.clientName.toLowerCase().contains(query.toLowerCase()) ||
              voucher.voucherNumber.toLowerCase().contains(query.toLowerCase()) ||
              voucher.invoiceNumber.toLowerCase().contains(query.toLowerCase()) ||
              voucher.invoiceType.toLowerCase().contains(query.toLowerCase()) ||
              voucher.gstNumber.toLowerCase().contains(query.toLowerCase());
        }).toList();
        voucherController.voucherModel.voucher_list.assignAll(filtered);
      }

      // Update selectedItems to match the new filtered list length
      voucherController.voucherModel.checkboxValues.value = List<bool>.filled(voucherController.voucherModel.voucher_list.length, false);
      voucherController.voucherModel.isExtendButton_visible = List<bool>.filled(voucherController.voucherModel.voucher_list.length, false).obs;

      voucherController.voucherModel.extendDueDateControllers.assignAll(
        List.generate(voucherController.voucherModel.voucher_list.length, (_) => TextEditingController()),
      );
      voucherController.voucherModel.extendDueFeedbackControllers.assignAll(
        List.generate(voucherController.voucherModel.voucher_list.length, (_) => TextEditingController()),
      );
      voucherController.voucherModel.selectAll.value = false;
      voucherController.voucherModel.showDeleteButton.value = false;
    } catch (e) {
      debugPrint('Error in applySearchFilter: $e');
    }
  }

  /// Determines the visibility of the "Extend Due Date" button for a specific voucher.
  ///
  /// Parameters:
  /// - [index]: The index of the voucher in the list for which visibility should be updated.
  ///
  /// Logic:
  /// 1. Checks whether both the "Extend Due Date" and "Feedback" input fields at the given index are non-empty.
  /// 2. If both fields are filled:
  ///    - Sets the corresponding `isExtendButton_visible[index]` value to `true`.
  /// 3. If either field is empty:
  ///    - Sets it to `false`.
  /// 4. Refreshes the observable `isExtendButton_visible` list to update the UI reactively.
  ///
  /// Use Case:
  /// Ensures that the "Extend Due Date" button is only shown when both required fields are filled for a given voucher entry.
  void isExtendButton_visibile(int index) {
    voucherController.voucherModel.isExtendButton_visible[index] =
        voucherController.voucherModel.extendDueDateControllers[index].value.text != '' && voucherController.voucherModel.extendDueFeedbackControllers[index].value.text != '';
    voucherController.voucherModel.isExtendButton_visible.refresh();
  }

  /// Opens a file picker dialog and updates the voucher model with the selected file.
  ///
  /// Functionality:
  /// - Launches the file picker using `FilePicker.platform.pickFiles()`.
  /// - If the user selects a file:
  ///   - Stores the file path in `voucherModel.selectedFile` as a `File` object.
  ///   - Stores the file name in `voucherModel.fileName`.
  ///
  /// Use Case:
  /// Typically used when the user wants to upload or attach a file (e.g., invoice, document)
  /// to a voucher record.
  ///
  /// Note:
  /// - You can extend this function by adding logic to upload the file to a server,
  ///   or handle validation, if necessary.
  Future<void> pickFile() async {
    // Open file picker and select a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Get the picked file

      voucherController.voucherModel.selectedFile.value = File(result.files.single.path!);
      voucherController.voucherModel.fileName.value = result.files.single.name;

      // Here you can handle the file upload logic
      // For example, you can send the file to a server or save it locally
    }
  }

  /// Sets the voucher type filter to "Custom range" mode.
  ///
  /// Logic:
  /// - Updates the `selectedvouchertype` reactive variable in the `voucherModel` to the string `'Custom range'`.
  ///
  /// Use Case:
  /// Triggered when a user selects the "Custom range" option from a date filter UI,
  /// allowing the app to present a custom date range picker or apply custom filtering logic accordingly.
  void showCustomDateRangePicker() {
    voucherController.voucherModel.selectedvouchertype.value = 'Custom range';
  }

  /// Resets all filters and related UI state in the voucher module to their default values.
  ///
  /// Main Actions:
  /// - Resets filter dropdown values like voucher type, invoice type, payment status, and customer selections.
  /// - Clears date range filters (`fromdate` and `todate`).
  /// - Resets checkbox selection states and visibility of "extend" buttons.
  /// - Reinitializes `TextEditingController`s used for extending due dates and feedbacks.
  /// - Ensures that "Select All" and "Delete" button states are cleared.
  ///
  /// Use Case:
  /// Called when the user clicks a "Reset Filters" button, ensuring the view returns to its initial, unfiltered state.
  /// This improves UX by clearing both UI selections and dependent states tied to voucher rows.
  void resetvoucherFilters() {
    voucherController.voucherModel.voucherSelectedFilter.value.vouchertype.value = 'Show All';
    voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value = 'Show All';
    voucherController.voucherModel.voucherSelectedFilter.value.selectedsalescustomername.value = 'None';
    voucherController.voucherModel.voucherSelectedFilter.value.selectedcustomerid.value = '';
    voucherController.voucherModel.voucherSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
    voucherController.voucherModel.voucherSelectedFilter.value.paymentstatus.value = 'Show All';
    voucherController.voucherModel.voucherSelectedFilter.value.fromdate.value = '';
    voucherController.voucherModel.voucherSelectedFilter.value.todate.value = '';

    // voucherController.voucherModel.filteredVouchers.value = voucherController.voucherModel.voucher_list;
    voucherController.voucherModel.checkboxValues.value = List.filled(voucherController.voucherModel.voucher_list.length, false);
    voucherController.voucherModel.isExtendButton_visible = List<bool>.filled(voucherController.voucherModel.voucher_list.length, false).obs;

    voucherController.voucherModel.extendDueDateControllers.assignAll(
      List.generate(voucherController.voucherModel.voucher_list.length, (_) => TextEditingController()),
    );
    voucherController.voucherModel.extendDueFeedbackControllers.assignAll(
      List.generate(voucherController.voucherModel.voucher_list.length, (_) => TextEditingController()),
    );
    voucherController.voucherModel.selectAll.value = false;
    voucherController.voucherModel.showDeleteButton.value = false;
  }

  /// Assigns the current filter selections from the voucher model to the saved filter state.
  ///
  /// Functionality:
  /// - Copies the current values of filter fields such as:
  ///   - Voucher type
  ///   - Invoice type
  ///   - Sales/subscription customer name
  ///   - Customer ID
  ///   - Payment status
  ///   - From and to dates
  /// - Stores them into `voucherSelectedFilter`, which acts as a snapshot of the applied filters.
  ///
  /// Use Case:
  /// Called before performing actions like filtering voucher data or persisting filter selections,
  /// ensuring the current state is preserved for later use (e.g., reloads or reassigning).
  void assignvoucherFilters() {
    voucherController.voucherModel.voucherSelectedFilter.value.vouchertype.value = voucherController.voucherModel.selectedvouchertype.value;
    voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value = voucherController.voucherModel.selectedInvoiceType.value;
    voucherController.voucherModel.voucherSelectedFilter.value.selectedsalescustomername.value = voucherController.voucherModel.selectedsalescustomer.value;
    voucherController.voucherModel.voucherSelectedFilter.value.selectedsubscriptioncustomername.value = voucherController.voucherModel.selectedsubcustomer.value;
    voucherController.voucherModel.voucherSelectedFilter.value.selectedcustomerid.value = voucherController.voucherModel.selectedcustomerID.value;
    voucherController.voucherModel.voucherSelectedFilter.value.paymentstatus.value = voucherController.voucherModel.selectedpaymentStatus.value;
    voucherController.voucherModel.voucherSelectedFilter.value.fromdate.value = voucherController.voucherModel.startDateController.value.text;
    voucherController.voucherModel.voucherSelectedFilter.value.todate.value = voucherController.voucherModel.endDateController.value.text;
  }

  /// Reassigns saved filter values from `voucherSelectedFilter` back to the current voucher model.
  ///
  /// Functionality:
  /// - Restores previously saved filter selections such as:
  ///   - Voucher type, invoice type, sales/subscription customer name
  ///   - Customer ID, payment status
  ///   - From and to date values
  ///   - Selected month
  /// - Updates the UI fields like date controllers and dropdowns to reflect the restored state.
  ///
  /// Use Case:
  /// Typically used after a refresh or screen re-entry to restore the user's last-used filter settings.
  /// Helps maintain continuity in the user's filter context across different views or sessions.
  void reassignvoucherFilters() {
    voucherController.voucherModel.selectedvouchertype.value = voucherController.voucherModel.voucherSelectedFilter.value.vouchertype.value;
    voucherController.voucherModel.selectedInvoiceType.value = voucherController.voucherModel.voucherSelectedFilter.value.invoicetype.value;
    voucherController.voucherModel.selectedsalescustomer.value = voucherController.voucherModel.voucherSelectedFilter.value.selectedsalescustomername.value;
    voucherController.voucherModel.selectedsubcustomer.value = voucherController.voucherModel.voucherSelectedFilter.value.selectedsubscriptioncustomername.value;
    voucherController.voucherModel.selectedcustomerID.value = voucherController.voucherModel.voucherSelectedFilter.value.selectedcustomerid.value;
    voucherController.voucherModel.selectedpaymentStatus.value = voucherController.voucherModel.voucherSelectedFilter.value.paymentstatus.value;
    voucherController.voucherModel.startDateController.value.text = voucherController.voucherModel.voucherSelectedFilter.value.fromdate.toString();
    voucherController.voucherModel.endDateController.value.text = voucherController.voucherModel.voucherSelectedFilter.value.todate.toString();
    voucherController.voucherModel.selectedMonth.value = voucherController.voucherModel.voucherSelectedFilter.value.selectedmonth.value.toString();
  }
}
