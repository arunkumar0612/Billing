import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/controllers/voucher_action.dart';
import 'package:ssipl_billing/2.BILLING/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES-/style.dart';

mixin VoucherService {
  final VoucherController voucherController = Get.find<VoucherController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  void applySearchFilter(String query) {
    try {
      if (query.isEmpty) {
        voucherController.voucherModel.filteredVouchers.assignAll(voucherController.voucherModel.voucher_list);
      } else {
        final filtered = voucherController.voucherModel.voucher_list.where((voucher) {
          return voucher.clientName!.toLowerCase().contains(query.toLowerCase()) || voucher.voucherId!.toLowerCase().contains(query.toLowerCase());
        }).toList();
        voucherController.voucherModel.filteredVouchers.assignAll(filtered);
      }

      // Update selectedItems to match the new filtered list length
      voucherController.voucherModel.selectedItems.value = List<bool>.filled(voucherController.voucherModel.filteredVouchers.length, false);
      voucherController.voucherModel.selectAll.value = false;
      voucherController.voucherModel.showDeleteButton.value = false;
    } catch (e) {
      debugPrint('Error in applySearchFilter: $e');
    }
  }

  void applyFilters() {
    try {
      List<Voucherdata> filtered = voucherController.voucherModel.voucher_list.where((voucher) {
        // Date filter
        if (voucherController.voucherModel.startDateController.text.isNotEmpty && voucherController.voucherModel.endDateController.text.isNotEmpty) {
          final voucherDate = DateTime.parse(voucher.date!);
          final startDate = DateTime.parse(voucherController.voucherModel.startDateController.text);
          final endDate = DateTime.parse(voucherController.voucherModel.endDateController.text);

          if (voucherDate.isBefore(startDate) || voucherDate.isAfter(endDate)) {
            return false;
          }
        }

        // Product type filter
        if (voucherController.voucherModel.selectedProductType.value != 'All' && voucher.productType != voucherController.voucherModel.selectedProductType.value) {
          return false;
        }

        // Status filter
        if (voucherController.voucherModel.selectedStatus.value != 'All') {
          // Assuming 'note' field contains status information in your data
          // Adjust this according to your actual data structure
          final status = voucher.note!.contains('Closed') ? 'Closed' : 'Open';
          if (status != voucherController.voucherModel.selectedStatus.value) {
            return false;
          }
        }

        return true;
      }).toList();

      voucherController.voucherModel.filteredVouchers.assignAll(filtered);

      // Update selectedItems to match the new filtered list length
      voucherController.voucherModel.selectedItems.value = List<bool>.filled(voucherController.voucherModel.filteredVouchers.length, false);
      voucherController.voucherModel.selectAll.value = false;
      voucherController.voucherModel.showDeleteButton.value = false;
    } catch (e) {
      debugPrint('Error in applyFilters: $e');
    }
  }

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
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

    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

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

  void updateDeleteButtonVisibility() {
    voucherController.voucherModel.showDeleteButton.value = voucherController.voucherModel.selectedItems.contains(true);
  }

  void deleteSelectedItems(BuildContext context) {
    // Create a list of indices to remove (in reverse order to avoid index shifting)
    final indicesToRemove = <int>[];
    for (int i = voucherController.voucherModel.selectedItems.length - 1; i >= 0; i--) {
      if (voucherController.voucherModel.selectedItems[i]) {
        indicesToRemove.add(i);
      }
    }

    // Remove items from voucher_list
    for (final index in indicesToRemove) {
      voucherController.voucherModel.voucher_list.removeAt(index);
    }

    // Reset selection state
    voucherController.voucherModel.selectedItems.value = List<bool>.filled(voucherController.voucherModel.voucher_list.length, false);
    voucherController.voucherModel.selectAll.value = false;
    voucherController.voucherModel.showDeleteButton.value = false;

    // Show a snackbar to confirm deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted ${indicesToRemove.length} item(s)'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void setQuickDateFilter(int value, String unit) {
    final now = DateTime.now();
    DateTime startDate;

    if (unit == 'hour') {
      startDate = now.subtract(Duration(hours: value));
    } else {
      startDate = now.subtract(Duration(days: value));
    }

    voucherController.voucherModel.startDateController.text = "${startDate.toLocal()}".split(' ')[0];
    voucherController.voucherModel.endDateController.text = "${now.toLocal()}".split(' ')[0];

    voucherController.voucherModel.showCustomDateRange.value = false;
    applyFilters();
  }

  void showCustomDateRangePicker() {
    voucherController.voucherModel.showCustomDateRange.value = true;
    voucherController.voucherModel.selectedQuickFilter.value = 'Custom range';
  }

  void resetFilters() {
    voucherController.voucherModel.endDateController.clear();
    voucherController.voucherModel.selectedClients.clear();
    voucherController.voucherModel.selectedProductTypes.clear();
    voucherController.voucherModel.selectedStatus.value = 'All';
    voucherController.voucherModel.filteredVouchers.value = voucherController.voucherModel.voucher_list;
    voucherController.voucherModel.startDateController.clear();
    voucherController.voucherModel.selectedItems.value = List.filled(voucherController.voucherModel.voucher_list.length, false);
    voucherController.voucherModel.selectAll.value = false;
    voucherController.voucherModel.showDeleteButton.value = false;
  }
}
