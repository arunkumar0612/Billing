import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/constants/voucher_constants.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class VoucherController extends GetxController {
  var voucherModel = VoucherModel();
  void set_isDeducted(bool value) {
    voucherModel.is_Deducted.value = value;
  }

  Future<void> PDFfileApiData(CMDmResponse value) async {
    var pdfFileData = await PDFfileData.fromJson(value); // Await async function
    var binaryData = pdfFileData.data; // Extract File object
    await updatePDFfile(binaryData);
  }

  Future<void> updatePDFfile(File value) async {
    voucherModel.pdfFile.value = value;
  }

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

  void calculate_recievable(bool TDSdeducted, int index) {
    final voucher = voucherModel.voucher_list[index];
    final tdsAmount = (voucher.tdsCalculation == 1) ? voucher.tdsCalculationAmount : 0.0;

    voucherModel.recievableAmount.value = TDSdeducted ? (voucher.pendingAmount - tdsAmount).roundToDouble() : voucher.pendingAmount.roundToDouble();

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

  void is_amountExceeds(int index) {
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

    final exceeds = voucherModel.selectedValue.value == "Full" ? clearedAmount > voucherModel.recievableAmount.value : clearedAmount > (voucher.pendingAmount.roundToDouble() - tdsAmount);

    voucherModel.is_amountExceeds.value = exceeds;
  }

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
