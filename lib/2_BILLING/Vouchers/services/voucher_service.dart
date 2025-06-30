// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/models/entities/view_ledger_entities.dart';
import 'package:ssipl_billing/2_BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/2_BILLING/Vouchers/models/entities/voucher_entities.dart';
// import 'package:ssipl_billing/2_BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/refresher.dart';

mixin VoucherService {
  final VoucherController voucherController = Get.find<VoucherController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final loader = LoadingOverlay();

  /// Sends a request to extend the due date of a specific voucher by providing the new date and feedback.
  /// Constructs a query from the user inputs, encodes it to JSON, and sends it via the API.
  /// Shows a success dialog if the operation succeeds, or an error dialog if it fails or encounters an exception.
  /// Handles both server-side and client-side errors gracefully.
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

  /// Updates the payment details of a specific transaction within a voucher.
  /// Extracts and formats the entire list of payment transactions for the voucher,
  /// constructs a query payload including the current transaction ID and voucher ID,
  /// and sends the data to the update transaction API endpoint.
  /// Shows a success dialog if the update is successful,
  /// or displays appropriate error dialogs in case of failure or exceptions.
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

  /// Fetches the list of subscription customers from the API and updates the voucher model with the parsed customer data.
  /// If the API response is successful and valid, maps the received data into a list of `CustomerInfo` objects.
  /// Logs errors in debug mode if the response fails or an exception occurs.
  /// Silent on UI feedback — this method is backend-only unless extended with dialogs.
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

  /// Retrieves the list of sales customers from the API and updates the voucher model with the parsed customer data.
  /// If the response is successful and valid, maps each item into a `CustomerInfo` object.
  /// Errors are logged in debug mode for development visibility.
  /// UI dialogs for errors are commented out, making this function backend-focused unless re-enabled.
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

  /// Fetches the list of vouchers from the API based on the selected filter criteria such as voucher type, payment status,
  /// invoice type, customer ID, and date range.
  /// Filters out default values like 'Show All' and 'None' to avoid sending unnecessary parameters.
  /// On successful response, parses the data and updates the voucher list in the model,
  /// triggers the search functionality, and refreshes the UI.
  /// Error handling and loader logic are present but commented out, indicating backend focus or future enhancement.
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

  /// Calculates a grouped summary of all vouchers selected via checkboxes.
  /// Iterates through the checkbox list to find selected indices and maps them to actual vouchers.
  /// Aggregates various financial totals including:
  /// - Total pending amounts (with and without TDS),
  /// - Subtotal, CGST, SGST, IGST, and TDS values.
  /// Returns a `SelectedInvoiceVoucherGroup` object containing both the selected vouchers and computed totals.
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

  /// Refreshes the voucher list and updates the UI by:
  /// 1. Fetching the latest voucher data.
  /// 2. Triggering a UI update using the controller.
  /// 3. After the current frame, resets voucher filters, re-fetches the voucher list,
  ///    and loads both subscription and sales customer lists.
  /// Ensures fresh data and state after any significant action like adding or updating vouchers.
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
  // dynamic clearVoucher(context, int index) async {
  //   try {
  //     final mapData = {
  //       "date": voucherController.voucherModel.closedDate.value,
  //       "voucherid": voucherController.voucherModel.voucher_list[index].voucher_id,
  //       "vouchernumber": voucherController.voucherModel.voucher_list[index].voucherNumber,
  //       "paymentstatus": 'partial',
  //       "IGST": voucherController.voucherModel.voucher_list[index].igst,
  //       "SGST": voucherController.voucherModel.voucher_list[index].sgst,
  //       "CGST": voucherController.voucherModel.voucher_list[index].cgst,
  //       "tds": voucherController.voucherModel.voucher_list[index].tdsCalculationAmount,
  //       "grossamount": voucherController.voucherModel.voucher_list[index].totalAmount,
  //       "subtotal": voucherController.voucherModel.voucher_list[index].subTotal,
  //       "paidamount": double.parse(voucherController.voucherModel.amountCleared_controller.value.text),
  //       "clientaddressname": voucherController.voucherModel.voucher_list[index].clientName,
  //       "clientaddress": voucherController.voucherModel.voucher_list[index].clientAddress,
  //       "invoicenumber": voucherController.voucherModel.voucher_list[index].invoiceNumber,
  //       "emailid": voucherController.voucherModel.voucher_list[index].emailId,
  //       "phoneno": voucherController.voucherModel.voucher_list[index].phoneNumber,
  //       "tdsstatus": true,
  //       "invoicetype": voucherController.voucherModel.voucher_list[index].invoiceType,
  //       "gstnumber": voucherController.voucherModel.voucher_list[index].gstNumber,
  //       "feedback": voucherController.voucherModel.feedback_controller.value.text,
  //       "transactiondetails": voucherController.voucherModel.transactionDetails_controller.value.text,
  //     };
  //     ClearVoucher voucherdata = ClearVoucher.fromJson(mapData);

  //     String encodedData = json.encode(voucherdata.toJson());
  //     Map<String, dynamic>? response = await apiController.Multer(encodedData, API.clearVoucher);
  //     if (response['statusCode'] == 200) {
  //       CMDmResponse value = CMDmResponse.fromJson(response);
  //       if (value.code) {
  //         await Success_dialog(context: context, title: "LOGO", content: value.message!, onOk: () {});
  //       } else {
  //         await Error_dialog(context: context, title: 'Uploading Logo', content: value.message ?? "", onOk: () {});
  //       }
  //     } else {
  //       Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
  //     }
  //   } catch (e) {
  //     Error_dialog(context: context, title: "ERROR", content: "$e");
  //   }
  // }

  /// Updates the checkbox selection state for a specific voucher at the given index.
  /// Checks if any checkbox is selected to determine the visibility of the delete button.
  /// Triggers a UI update through the controller after modifying the selection state.
  void update_checkboxValues(int index, bool value) {
    voucherController.voucherModel.checkboxValues[index] = value;
    if (voucherController.voucherModel.checkboxValues.contains(true)) {
      voucherController.voucherModel.showDeleteButton.value = true;
    } else {
      voucherController.voucherModel.showDeleteButton.value = false;
    }

    voucherController.update();
  }

  /// Clears a group of selected vouchers by preparing and sending their consolidated payment data to the server.
  /// Gathers all relevant details like voucher IDs, amounts, invoice numbers, customer info, and tax breakdowns.
  /// Builds a structured map (`main_map`) that includes transaction details, payment mode, TDS status,
  /// and total amount to be paid. Also supports uploading attachments such as files or receipts.
  /// Sends the data using a multipart request via the API and handles the server response:
  /// - On success: displays a success dialog and closes the popup.
  /// - On failure: shows an error dialog or server down message.
  /// Ensures proper cleanup with loader control and triggers a data refresh after completion.
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
          loader.stop();
          await Error_dialog(context: context, title: 'Processing Invoice', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      loader.stop();
      await Refresher().refreshAll();
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
      loader.stop();
    }
  }

  /// Processes and clears a single voucher by sending its payment and invoice details to the server.
  /// Constructs a data map containing voucher metadata such as tax amounts, paid amount, invoice and client info,
  /// and payment-related details like mode, feedback, and transaction notes.
  /// Wraps the data into a `ClearVoucher` model and sends it using a multipart request,
  /// along with optional file attachments (e.g., receipts).
  /// Handles the response:
  /// - On success: shows a success dialog and closes the popup.
  /// - On failure: displays an error message or server issue alert.
  /// Ensures loader visibility is correctly managed during the request lifecycle and
  /// triggers a full data refresh after completion.
  dynamic clearVoucher(context, int index, File? file, String VoucherType, File receipt) async {
    try {
      loader.start(context);
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
        loader.stop();
      } else {
        loader.stop();
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      loader.stop();
      await Refresher().refreshAll();
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
      loader.stop();
    }
  }

  /// Filters the voucher list based on a search query that matches client name, voucher number, invoice number,
  /// invoice type, or GST number (case-insensitive).
  /// If the query is empty, restores the original unfiltered list from the parent list.
  /// After filtering, it resets all checkbox selections, visibility flags, and input controllers
  /// for due date and feedback fields to match the new list length.
  /// Also disables the "select all" and "delete" button states to avoid unintended actions post-filtering.
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

  /// Determines the visibility of the "Extend" button for a specific voucher row based on input fields.
  /// The button is shown only if both the due date and feedback text fields are filled.
  /// Triggers a refresh to update the UI immediately after evaluating the condition.
  void isExtendButton_visibile(int index) {
    voucherController.voucherModel.isExtendButton_visible[index] =
        voucherController.voucherModel.extendDueDateControllers[index].value.text != '' && voucherController.voucherModel.extendDueFeedbackControllers[index].value.text != '';
    voucherController.voucherModel.isExtendButton_visible.refresh();
  }

  /// Opens a themed date picker dialog to allow the user to select a date within the next 1 year from today.
  /// Once a date is picked, it is formatted as `YYYY-MM-DD` and assigned to the provided [controller].
  /// Applies a custom color scheme and rounded dialog style for visual consistency with the app's theme.
  Future<void> selectfilterDate(BuildContext context, TextEditingController controller) async {
    final DateTime now = DateTime.now();
    final DateTime nextYear = now.add(const Duration(days: 365)); // Limit to next year

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Start from today
      lastDate: nextYear, // Allow dates up to 1 year from today
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Primary_colors.Color3,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Primary_colors.Color3,
              ),
            ),
            dialogTheme: const DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formatted = "${pickedDate.year.toString().padLeft(4, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.day.toString().padLeft(2, '0')}";

      controller.text = formatted;
    }
  }

  /// Opens a file picker dialog allowing the user to select a PDF file only.
  /// If a file is selected, it stores the file reference and its name into the voucher model.
  /// This selected file can then be used for upload, preview, or further processing as required.
  Future<void> pickFile() async {
    // Open file picker and select a file
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], lockParentWindow: true);
    if (result != null) {
      // Get the picked file

      voucherController.voucherModel.selectedFile.value = File(result.files.single.path!);
      voucherController.voucherModel.fileName.value = result.files.single.name;

      // Here you can handle the file upload logic
      // For example, you can send the file to a server or save it locally
    }
  }

  // void updateDeleteButtonVisibility() {
  //   voucherController.voucherModel.showDeleteButton.value = voucherController.voucherModel.selectedItems.contains(true);
  // }

  // void deleteSelectedItems(BuildContext context) {
  //   // Create a list of indices to remove (in reverse order to avoid index shifting)
  //   final indicesToRemove = <int>[];
  //   for (int i = voucherController.voucherModel.selectedItems.length - 1; i >= 0; i--) {
  //     if (voucherController.voucherModel.selectedItems[i]) {
  //       indicesToRemove.add(i);
  //     }
  //   }

  //   // Remove items from voucher_list
  //   for (final index in indicesToRemove) {
  //     voucherController.voucherModel.voucher_list.removeAt(index);
  //   }

  //   // Reset selection state
  //   voucherController.voucherModel.selectedItems.value = List<bool>.filled(voucherController.voucherModel.voucher_list.length, false);
  //   voucherController.voucherModel.selectAll.value = false;
  //   voucherController.voucherModel.showDeleteButton.value = false;

  //   // Show a snackbar to confirm deletion
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Deleted ${indicesToRemove.length} item(s)'),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }

  void showCustomDateRangePicker() {
    voucherController.voucherModel.selectedvouchertype.value = 'Custom range';
  }

//  vouchertype: 'Show All',
//     invoicetype: 'Show All',
//     selectedsalescustomername: 'None',
//     selectedcustomerid: '',
//     selectedsubscriptioncustomername: 'None',
//     paymentstatus: 'Show All',
//     fromdate: '',
//     todate: '',
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
