import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/view_ledger_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

mixin Account_LedgerService {
  final Account_LedgerController account_LedgerController = Get.find<Account_LedgerController>();
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  Future<void> get_Account_LedgerList() async {
    // final ledgerData = {
    //   "ledgertype":
    //       view_LedgerController.view_LedgerModel.selectedtransactiontype.value.toLowerCase() == 'show all' ? '' : view_LedgerController.view_LedgerModel.selectedtransactiontype.value.toLowerCase(),
    //   "paymenttype": view_LedgerController.view_LedgerModel.selectedPaymenttype.value.toLowerCase() == 'show all' ? '' : view_LedgerController.view_LedgerModel.selectedPaymenttype.value.toLowerCase(),
    //   "invoicetype": view_LedgerController.view_LedgerModel.selectedinvoiceType.value.toLowerCase() == 'show all' ? '' : view_LedgerController.view_LedgerModel.selectedinvoiceType.value.toLowerCase(),
    //   "customerid": view_LedgerController.view_LedgerModel.selectedsalescustomer.value,
    //   "startdate": view_LedgerController.view_LedgerModel.startDateController.value.text,
    //   "enddate": view_LedgerController.view_LedgerModel.endDateController.value.text,
    // };

    // print('--- Ledger Data ---');
    // ledgerData.forEach((key, value) {
    //   print('$key: $value');
    // });

    // loader.start(context);
    // await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "ledgertype":
            view_LedgerController.view_LedgerModel.selectedtransactiontype.value.toLowerCase() == 'show all' ? '' : view_LedgerController.view_LedgerModel.selectedtransactiontype.value.toLowerCase(),
        "paymenttype": view_LedgerController.view_LedgerModel.selectedPaymenttype.value.toLowerCase() == 'show all'
            ? ''
            : view_LedgerController.view_LedgerModel.selectedPaymenttype.value.toLowerCase(), //"credit"       (or) debit,
        "invoicetype": view_LedgerController.view_LedgerModel.selectedinvoiceType.value.toLowerCase() == 'show all'
            ? ''
            : view_LedgerController.view_LedgerModel.selectedinvoiceType.value.toLowerCase(), //sales   (or) subscription (or) vendor,
        "customerid": view_LedgerController.view_LedgerModel.selectedsubcustomerID.value == 'None' ? '' : view_LedgerController.view_LedgerModel.selectedsubcustomerID.value,
        // "startdate": view_LedgerController.view_LedgerModel.startDateController.value.text,
        // "enddate": view_LedgerController.view_LedgerModel.endDateController.value.text,
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

  Future<PDF_AccountLedgerSummary> parsePDF_AccountLedger(bool Sub_clientOrNot, bool Sales_clientOrNot) async {
    final ClientDetails? clientDetails;

    if (Sub_clientOrNot) {
      String? clientID = view_LedgerController.view_LedgerModel.selectedsubcustomerID.value;

      CustomerInfo clientData = view_LedgerController.view_LedgerModel.subCustomerList.firstWhere((element) => element.customerId == clientID);
      clientDetails = ClientDetails(
        clientName: clientData.customerName,
        clientAddress: clientData.customerName,
        GSTIN: clientData.customerGstNo == '' ? '-' : clientData.customerGstNo,
        PAN: extractPanFromGst(clientData.customerGstNo),
        // fromDate: DateTime.parse(account_LedgerController
        //     .account_LedgerModel.account_Ledger_list.value.startdate!),
        // toDate: DateTime.parse(account_LedgerController
        //     .account_LedgerModel.account_Ledger_list.value.enddate!),
      );
    } else if (Sales_clientOrNot) {
      String? clientID = view_LedgerController.view_LedgerModel.selectedsalescustomerID.value;

      CustomerInfo clientData = view_LedgerController.view_LedgerModel.salesCustomerList.firstWhere((element) => element.customerId == clientID);
      clientDetails = ClientDetails(
        clientName: clientData.customerName,
        clientAddress: clientData.customerName,
        GSTIN: clientData.customerGstNo == '' ? '-' : clientData.customerGstNo,
        PAN: extractPanFromGst(clientData.customerGstNo),
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

  Future<void> account_Ledger_refresh() async {
    await get_Account_LedgerList();
    account_LedgerController.update();
  }

  void resetFilters() {
    account_LedgerController.account_LedgerModel.account_Ledger_list.value = account_LedgerController.account_LedgerModel.Secondaryaccount_Ledger_list.value;
  }

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

  void resetaccount_LedgerFilters() {
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.transactiontype.value = 'Show All';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value = 'Show All';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedcustomerid.value = '';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.paymentstatus.value = 'Show All';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value = '';
    account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value = '';

    // account_LedgerController.account_LedgerModel.filteredVouchers.value = account_LedgerController.account_LedgerModel.account_Ledger_list;
  }
}
// void applySearchFilter(String query) {
//     try {
//       if (query.isEmpty) {
//         account_LedgerController.account_LedgerModel.filteredVouchers.assignAll(account_LedgerController.account_LedgerModel.account_Ledger_list);
//       } else {
//         final filtered = account_LedgerController.account_LedgerModel.account_Ledger_list.where((account_Ledger) {
//           return account_Ledger.clientName.toLowerCase().contains(query.toLowerCase()) || account_Ledger.account_LedgerNumber.toLowerCase().contains(query.toLowerCase());
//         }).toList();
//         account_LedgerController.account_LedgerModel.filteredVouchers.assignAll(filtered);
//       }

//       // Update selectedItems to match the new filtered list length
//       account_LedgerController.account_LedgerModel.selectedItems.value = List<bool>.filled(account_LedgerController.account_LedgerModel.filteredVouchers.length, false);
//       account_LedgerController.account_LedgerModel.selectAll.value = false;
//       account_LedgerController.account_LedgerModel.showDeleteButton.value = false;
//     } catch (e) {
//       debugPrint('Error in applySearchFilter: $e');
//     }
//   }
