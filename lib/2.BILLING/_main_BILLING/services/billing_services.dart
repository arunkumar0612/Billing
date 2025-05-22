import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';

mixin main_BillingService {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();

  void get_SubscriptionInvoiceList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.billing_subscriptionInvoice);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          for (int i = 0; i < value.data.length; i++) {
            mainBilling_Controller.addto_SubscriptionInvoiceList(SubscriptionInvoice.fromJson(value.data[i]));
          }

          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_OrganizationList(value);
        } else {
          // await Error_dialog(context: context, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      // Error_dialog(context: context, title: "ERROR", content: "$e");
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

  void get_SalesInvoiceList() async {
    try {
      Map<String, dynamic>? response = await apiController.GetbyToken(API.billing_salesInvoice);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          print(value.data);

          for (int i = 0; i < value.data.length; i++) {
            mainBilling_Controller.addto_SalesInvoiceList(SalesInvoice.fromJson(value.data[i]));
          }

          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_OrganizationList(value);
        } else {
          // await Error_dialog(context: context, title: 'Fetching Organization List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        // Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      // Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  void resetFilters() {
    mainBilling_Controller.billingModel.startDateController.value.clear();
    mainBilling_Controller.billingModel.endDateController.value.clear();
    mainBilling_Controller.billingModel.selectedPaymentStatus.value = 'Show All';
    mainBilling_Controller.billingModel.selectedInvoiceType.value = 'Show All';
    mainBilling_Controller.billingModel.selectedQuickFilter.value = 'Show All';
    mainBilling_Controller.billingModel.selectedPackageName.value = 'Show All';
    mainBilling_Controller.billingModel.showCustomDateRange.value = false;
    // voucherController.voucherModel.filteredVouchers.value = voucherController.voucherModel.voucher_list;
    // voucherController.voucherModel.selectedItems.value = List.filled(voucherController.voucherModel.voucher_list.length, false);
    // voucherController.voucherModel.selectAll.value = false;
    // voucherController.voucherModel.showDeleteButton.value = false;
  }
}
