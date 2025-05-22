import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
// import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/view_ledger_entities.dart';
import 'package:ssipl_billing/API-/api.dart';
// import 'package:ssipl_billing/2.BILLING/View_Ledgers/controllers/view_Ledger_action.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES-/style.dart';

mixin View_LedgerService {
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final Account_LedgerController account_LedgerController = Get.find<Account_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  Future<void> Get_SUBcustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_ledgerSubscriptionCustomers);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          view_LedgerController.view_LedgerModel.subCustomerList.value = value.data.map((e) => CustomerInfo.fromJson(e)).toList();
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

  Future<void> Get_SALEScustomerList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.get_ledgerSalesCustomers);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          view_LedgerController.view_LedgerModel.salesCustomerList.value = value.data.map((e) => CustomerInfo.fromJson(e)).toList();
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

  // void applySearchFilter(String query) {
  //   try {
  //     if (query.isEmpty) {
  //       account_LedgerController.account_LedgerModel.filteredaccount_Ledger_list.value = (account_LedgerController.account_LedgerModel.account_Ledger_list.value);
  //     } else {
  //       final filteredList = account_LedgerController.account_LedgerModel.account_Ledger_list.value.ledgerList.where((view_Ledger) {
  //         return view_Ledger.clientName.toLowerCase().contains(query.toLowerCase()) || view_Ledger.voucherNumber.toLowerCase().contains(query.toLowerCase());
  //       }).toList();

  //       final summary = AccountLedgerSummary(
  //         ledgerList: filteredList,
  //         creditAmount: account_LedgerController.account_LedgerModel.account_Ledger_list.value.creditAmount, // or recalculate totals if needed
  //         debitAmount: account_LedgerController.account_LedgerModel.account_Ledger_list.value.debitAmount,
  //         balanceAmount: account_LedgerController.account_LedgerModel.account_Ledger_list.value.balanceAmount,
  //       );

  //       account_LedgerController.account_LedgerModel.filteredaccount_Ledger_list.value = summary;
  //     }

  //     // Update selectedItems to match the new filtered list length
  //   } catch (e) {
  //     debugPrint('Error in applySearchFilter: $e');
  //   }
  // }

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime now = DateTime.now();
    final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: tomorrow,
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
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      if (pickedDate.isAfter(tomorrow)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Date cannot exceed tomorrow.')),
        );
        return;
      }

      final formatted = "${pickedDate.year.toString().padLeft(4, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.day.toString().padLeft(2, '0')}";

      controller.text = formatted;
    }
  }

  // void showCustomDateRangePicker() {
  //   view_LedgerController.view_LedgerModel.showCustomDateRange.value = true;
  // }

  void resetFilters() {
    view_LedgerController.view_LedgerModel.startDateController.value.clear();
    view_LedgerController.view_LedgerModel.endDateController.value.clear();
    view_LedgerController.view_LedgerModel.selectedMonth.value = 'None';
    view_LedgerController.view_LedgerModel.selectedinvoiceType.value = 'Show All';
    view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value = 'Consolidate';
    view_LedgerController.view_LedgerModel.selectedInvoiceType.value = 'Show All';
    view_LedgerController.view_LedgerModel.selectedPaymenttype.value = 'Show All';
    view_LedgerController.view_LedgerModel.selectedsalescustomerID.value = 'None';
    view_LedgerController.view_LedgerModel.selectedsalescustomer.value = 'None';
    view_LedgerController.view_LedgerModel.selectedsubcustomerID.value = 'None';
    view_LedgerController.view_LedgerModel.selectedsubcustomer.value = 'None';
    account_LedgerController.account_LedgerModel.filteredaccount_Ledger_list.value = account_LedgerController.account_LedgerModel.account_Ledger_list.value;
  }
}
