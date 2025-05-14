import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';
// import 'package:ssipl_billing/2.BILLING/Vouchers/controllers/voucher_action.dart';
import 'package:ssipl_billing/API-/api.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES-/style.dart';

mixin VoucherService {
  final VoucherController voucherController = Get.find<VoucherController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  Future<void> get_VoucherList(context) async {
    // loader.start(context);
    await Future.delayed(const Duration(milliseconds: 1000));
    // response;
    Map<String, dynamic>? response = await apiController.GetbyQueryString(
      {
        "vouchertype": "payment",
        "invoicetype": "subscription",
        // "customerid": "SB_1",
      },
      API.getvoucherlist,
    );
    if (response?['statusCode'] == 200) {
      CMDlResponse value = CMDlResponse.fromJson(response ?? {});
      if (value.code) {
        voucherController.add_Voucher(value);
        voucherController.update();
      } else {
        await Error_dialog(context: context, title: 'ERROR', content: value.message ?? "", onOk: () {});
      }
    } else {
      Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
    }
    // loader.stop();
  }

  dynamic clearVoucher(context, int index) async {
    try {
      final mapData = {
        "date": voucherController.voucherModel.closedDate.value,
        "voucherid": voucherController.voucherModel.voucher_list[index].voucher_id,
        "vouchernumber": voucherController.voucherModel.voucher_list[index].voucherNumber,
        "paymentstatus": 'partial',
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
        "tdsstatus": true,
        "invoicetype": voucherController.voucherModel.voucher_list[index].invoiceType,
        "gstnumber": voucherController.voucherModel.voucher_list[index].gstNumber,
        "feedback": voucherController.voucherModel.feedback_controller.value.text,
        "transactiondetails": voucherController.voucherModel.transactionDetails_controller.value.text,
      };
      ClearVoucher voucherdata = ClearVoucher.fromJson(mapData);

      String encodedData = json.encode(voucherdata.toJson());
      Map<String, dynamic>? response = await apiController.SendByQuerystring(encodedData, API.clearVoucher);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Success_dialog(context: context, title: "LOGO", content: value.message!, onOk: () {});
        } else {
          await Error_dialog(context: context, title: 'Uploading Logo', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  void applySearchFilter(String query) {
    try {
      if (query.isEmpty) {
        voucherController.voucherModel.filteredVouchers.assignAll(voucherController.voucherModel.voucher_list);
      } else {
        final filtered = voucherController.voucherModel.voucher_list.where((voucher) {
          return voucher.clientName.toLowerCase().contains(query.toLowerCase()) || voucher.voucherNumber.toLowerCase().contains(query.toLowerCase());
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

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    // Step 1: Show Date Picker
    final DateTime? pickedDate = await showDatePicker(
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
        // Combine date and time
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Format it to a readable string (e.g., yyyy-MM-dd HH:mm)
        final formatted = "${fullDateTime.year.toString().padLeft(4, '0')}-"
            "${fullDateTime.month.toString().padLeft(2, '0')}-"
            "${fullDateTime.day.toString().padLeft(2, '0')} "
            "${pickedTime.hour.toString().padLeft(2, '0')}:"
            "${pickedTime.minute.toString().padLeft(2, '0')}";

        controller.text = formatted;
      }
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

  void showCustomDateRangePicker() {
    voucherController.voucherModel.showCustomDateRange.value = true;
    voucherController.voucherModel.selectedQuickFilter.value = 'Custom range';
  }

  void resetFilters() {
    voucherController.voucherModel.startDateController.clear();
    voucherController.voucherModel.endDateController.clear();
    voucherController.voucherModel.selectedpaymentStatus.value = 'Show All';
    voucherController.voucherModel.selectedInvoiceType.value = 'Show All';
    voucherController.voucherModel.selectedQuickFilter.value = 'Show All';
    voucherController.voucherModel.showCustomDateRange.value = false;
    voucherController.voucherModel.filteredVouchers.value = voucherController.voucherModel.voucher_list;
    voucherController.voucherModel.selectedItems.value = List.filled(voucherController.voucherModel.voucher_list.length, false);
    voucherController.voucherModel.selectAll.value = false;
    voucherController.voucherModel.showDeleteButton.value = false;
  }
}
