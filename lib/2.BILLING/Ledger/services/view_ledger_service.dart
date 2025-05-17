import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
// import 'package:ssipl_billing/2.BILLING/View_Ledgers/controllers/view_Ledger_action.dart';
import 'package:ssipl_billing/API-/invoker.dart';

import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES-/style.dart';

mixin View_LedgerService {
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final Account_LedgerController account_LedgerController = Get.find<Account_LedgerController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  void applySearchFilter(String query) {
    try {
      if (query.isEmpty) {
        account_LedgerController.account_LedgerModel.filteredAccount_Ledgers.assignAll(account_LedgerController.account_LedgerModel.account_Ledger_list);
      } else {
        final filtered = account_LedgerController.account_LedgerModel.account_Ledger_list.where((view_Ledger) {
          return view_Ledger.clientName.toLowerCase().contains(query.toLowerCase()) || view_Ledger.voucherNo.toLowerCase().contains(query.toLowerCase());
        }).toList();
        account_LedgerController.account_LedgerModel.filteredAccount_Ledgers.assignAll(filtered);
      }

      // Update selectedItems to match the new filtered list length
    } catch (e) {
      debugPrint('Error in applySearchFilter: $e');
    }
  }

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime now = DateTime.now();
    final DateTime tomorrow = DateTime(now.year, now.month, now.day, 23, 59);

    // Step 1: Show Date Picker
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
      // Step 2: Show Time Picker
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: const TimePickerThemeData(
                dialHandColor: Primary_colors.Color3,
                entryModeIconColor: Primary_colors.Color3,
              ),
              colorScheme: const ColorScheme.light(
                primary: Primary_colors.Color3,
                onPrimary: Colors.white,
                onSurface: Colors.black87,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Check if the selected datetime exceeds tomorrow
        if (fullDateTime.isAfter(tomorrow)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Date/time cannot exceed tomorrow.')),
          );
          return;
        }

        final formatted = "${fullDateTime.year.toString().padLeft(4, '0')}-"
            "${fullDateTime.month.toString().padLeft(2, '0')}-"
            "${fullDateTime.day.toString().padLeft(2, '0')} "
            "${pickedTime.hour.toString().padLeft(2, '0')}:"
            "${pickedTime.minute.toString().padLeft(2, '0')}";

        controller.text = formatted;
      }
    }
  }

  void showCustomDateRangePicker() {
    view_LedgerController.view_LedgerModel.showCustomDateRange.value = true;
    view_LedgerController.view_LedgerModel.selectedQuickFilter.value = 'Custom range';
  }

  void resetFilters() {
    view_LedgerController.view_LedgerModel.startDateController.value.clear();
    view_LedgerController.view_LedgerModel.endDateController.value.clear();
    view_LedgerController.view_LedgerModel.selectedAccountLedgerType.value = 'Show All';
    view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value = 'Show All';
    view_LedgerController.view_LedgerModel.selectedInvoiceType.value = 'Show All';
    view_LedgerController.view_LedgerModel.selectedQuickFilter.value = 'Show All';
    view_LedgerController.view_LedgerModel.showCustomDateRange.value = false;
    account_LedgerController.account_LedgerModel.filteredAccount_Ledgers.value = account_LedgerController.account_LedgerModel.account_Ledger_list;
  }
}
