import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/constants/voucher_contants.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class VoucherController extends GetxController {
  var voucherModel = VoucherModel();
  void set_isDeducted(bool value) {
    voucherModel.is_Deducted.value = value;
  }

  void add_Voucher(CMDlResponse value) {
    voucherModel.voucher_list.clear();
    for (int i = 0; i < value.data.length; i++) {
      voucherModel.voucher_list.add(InvoicePaymentVoucher.fromJson(value.data[i]));
    }
    voucherModel.filteredVouchers.assignAll(voucherModel.voucher_list);
  }

  void calculate_recievable(bool TDSdecucted, int index) {
    if (TDSdecucted) {
      voucherModel.recievableAmount.value = voucherModel.voucher_list[index].totalAmount - voucherModel.voucher_list[index].tdsCalculationAmount;
    } else {
      voucherModel.recievableAmount.value = voucherModel.voucher_list[index].totalAmount;
    }
  }

  // bool is_partial(int index) {
  //   if (voucherModel.voucher_list[index].totalAmount != voucherModel.recievableAmount.value) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  void is_amountExceeds() {
    if (voucherModel.amountCleared_controller.value.text.isEmpty) {
      voucherModel.is_amountExceeds.value = true;

      return;
    }
    if (double.parse(voucherModel.amountCleared_controller.value.text) > voucherModel.recievableAmount.value) {
      voucherModel.is_amountExceeds.value = true;
    } else {
      voucherModel.is_amountExceeds.value = false;
    }
  }

  void is_fullclear_Valid(int index) {
    if (voucherModel.amountCleared_controller.value.text.isEmpty) {
      voucherModel.is_fullClear.value = false;
      return;
    }
    if (voucherModel.recievableAmount.value == double.parse(voucherModel.amountCleared_controller.value.text)) {
      voucherModel.is_fullClear.value = true;
    } else {
      voucherModel.is_fullClear.value = false;
    }
  }

  void reset_voucherClear_popup() {
    voucherModel.recievableAmount.value = 0.0;
    voucherModel.is_fullClear.value = false;
    voucherModel.is_amountExceeds.value = false;
    voucherModel.is_Deducted.value = true;
    voucherModel.closedDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    voucherModel.fileName.value = null;
    voucherModel.selectedFile.value = null;

    // Reset text controllers
    voucherModel.amountCleared_controller.value.clear();
    voucherModel.transactionDetails_controller.value.clear();
    voucherModel.feedback_controller.value.clear();
    voucherModel.closedDateController.text = voucherModel.closedDate.value;
  }
}
