import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ssipl_billing/2_BILLING/Vouchers/models/constants/voucher_constants.dart';
import 'package:ssipl_billing/2_BILLING/Vouchers/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class VoucherController extends GetxController {
  var voucherModel = VoucherModel();

  /// Sets the deduction status flag in the voucher model.
  void set_isDeducted(bool value) {
    voucherModel.is_Deducted.value = value;
  }

  /// Updates the selected mode of payment in the voucher model.
  void set_modeOfPayment(String value) {
    voucherModel.Selectedpaymentmode.value = value;
  }

  // Future<void> PDFfileApiData(CMDmResponse value) async {
  //   var pdfFileData = await PDFfileData.fromJson(value); // Await async function
  //   var binaryData = pdfFileData.data; // Extract File object
  //   await updatePDFfile(binaryData);
  // }

  // Future<void> updatePDFfile(File value) async {
  //   voucherModel.pdfFile.value = value;
  // }

  /// Parses and adds voucher data from the response into both the working and parent voucher lists.
  /// Clears any existing data before adding new entries.
  /// For each voucher item, it initializes:
  /// - A checkbox selection list (used for UI interactions like bulk actions)
  /// - A visibility flag list for toggling due date extension buttons
  /// - Text editing controllers for due date and feedback fields
  /// These controllers are dynamically assigned based on the number of vouchers,
  /// ensuring the UI elements are properly bound to their respective data.
  void add_Voucher(CMDlResponse value) {
    voucherModel.voucher_list.clear();
    voucherModel.ParentVoucher_list.clear();
    for (int i = 0; i < value.data.length; i++) {
      voucherModel.voucher_list.add(InvoicePaymentVoucher.fromJson(value.data[i]));
      voucherModel.ParentVoucher_list.add(InvoicePaymentVoucher.fromJson(value.data[i]));
      voucherModel.checkboxValues = List<bool>.filled(voucherModel.voucher_list.length, false).obs;
      voucherModel.isExtendButton_visible = List<bool>.filled(voucherModel.voucher_list.length, false).obs;
      voucherModel.extendDueDateControllers.assignAll(
        List.generate(voucherModel.voucher_list.length, (_) => TextEditingController()),
      );
      voucherModel.extendDueFeedbackControllers.assignAll(
        List.generate(voucherModel.voucher_list.length, (_) => TextEditingController()),
      );
    }
  }

  /// Resets the amount cleared field by clearing its associated text controller in the voucher model.
  void resetAmountCleared() {
    voucherModel.amountCleared_controller.value.text = '';
  }

  /// Calculates the receivable amount for a given voucher based on TDS deduction and payment type.
  /// If TDS is deducted, it subtracts the TDS amount (and a small adjustment if payment is partial).
  /// Updates the receivable amount in the model and resets the amount cleared field to '0.0' if the result is zero.
  void calculate_recievable(bool TDSdeducted, int index, String paymentType) {
    final voucher = voucherModel.voucher_list[index];
    final tdsAmount = (voucher.tdsCalculation == 1) ? voucher.tdsCalculationAmount : 0.0;

    voucherModel.recievableAmount.value = TDSdeducted ? ((voucher.pendingAmount - (paymentType == 'Partial' ? 1 : 0)) - tdsAmount).roundToDouble() : voucher.pendingAmount.roundToDouble();

    if (voucherModel.recievableAmount.value == 0.0) {
      voucherModel.amountCleared_controller.value.text = '0.0';
    }
  }

  // bool is_partial(int index) {
  //   if (voucherModel.voucher_list[index].totalAmount != voucherModel.recievableAmount.value) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  /// Checks whether the entered cleared amount exceeds the valid receivable amount for a specific voucher.
  /// Considers TDS deductions and payment type (Full or Partial) in the calculation.
  /// Sets the `is_amountExceeds` flag in the model to true or false based on the comparison result.
  /// If the cleared amount is empty, it defaults to marking the input as exceeding.
  void is_amountExceeds(int index, String? paymentType) {
    final clearedText = voucherModel.amountCleared_controller.value.text;
    final voucher = voucherModel.voucher_list[index];
    final tdsAmount = (voucher.tdsCalculation == 1) ? voucher.tdsCalculationAmount : 0.0;

    if (clearedText.isEmpty) {
      voucherModel.is_amountExceeds.value = true;
      return;
    }

    final clearedAmount = double.parse(clearedText);

    if (voucherModel.recievableAmount.value == 0.0) {
      voucherModel.is_amountExceeds.value = false;
      return;
    }

    final exceeds = voucherModel.selectedValue.value == "Full"
        ? clearedAmount > voucherModel.recievableAmount.value
        : clearedAmount > ((voucher.pendingAmount.roundToDouble() - (paymentType == 'Partial' ? 1 : 0)) - tdsAmount);

    voucherModel.is_amountExceeds.value = exceeds;
  }

  /// Validates whether the entered cleared amount fully matches the receivable amount for a specific voucher.
  /// Updates the `is_fullClear` flag accordingly.
  /// If the cleared amount is empty, it marks full clearance as invalid.
  /// Triggers a UI update via the model.
  void is_fullclear_Valid(int index) {
    final clearedText = voucherModel.amountCleared_controller.value.text;

    if (clearedText.isEmpty) {
      voucherModel.is_fullClear.value = false;
    } else {
      final clearedAmount = double.parse(clearedText);
      voucherModel.is_fullClear.value = voucherModel.recievableAmount.value == clearedAmount;
    }

    voucherModel.update();
  }

  /// Checks if the entered cleared amount fully matches the given pending amount (used for clubbed voucher cases).
  /// Sets the `is_fullClear` flag to true if amounts match exactly; otherwise, sets it to false.
  /// If the input is empty, full clearance is considered invalid.
  /// Calls `update()` to refresh any UI elements bound to the model.
  void is_Club_fullclear_Valid(pending_amount) {
    final clearedText = voucherModel.amountCleared_controller.value.text;

    if (clearedText.isEmpty) {
      voucherModel.is_fullClear.value = false;
    } else {
      final clearedAmount = double.parse(clearedText);
      voucherModel.is_fullClear.value = pending_amount == clearedAmount;
    }

    voucherModel.update();
  }

  /// Resets all fields and controllers related to the voucher clearance popup to their default values.
  /// This includes flags (like full clear, amount exceeds, deduction), date, file selections, payment type,
  /// and input fields such as amount cleared, transaction details, and feedback.
  /// Also updates the closed date controller with the current date.
  void reset_voucherClear_popup() {
    voucherModel.recievableAmount.value = 0.0;
    voucherModel.is_fullClear.value = false;
    voucherModel.is_amountExceeds.value = null;
    voucherModel.is_Deducted.value = true;
    voucherModel.closedDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    voucherModel.fileName.value = null;
    voucherModel.selectedFile.value = null;
    voucherModel.selectedValue.value = 'Full';

    // Reset text controllers
    voucherModel.amountCleared_controller.value.clear();
    voucherModel.transactionDetails_controller.value.clear();
    voucherModel.feedback_controller.value.clear();
    voucherModel.closedDateController.text = voucherModel.closedDate.value;
  }
}
