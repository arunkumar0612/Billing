import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/constants/voucher_contants.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class VoucherController extends GetxController {
  var voucherModel = VoucherModel();
  void add_Voucher(CMDlResponse value) {
    voucherModel.voucher_list.clear();
    for (int i = 0; i < value.data.length; i++) {
      voucherModel.voucher_list.add(InvoicePaymentVoucher.fromJson(value.data[i]));
    }
    voucherModel.filteredVouchers.assignAll(voucherModel.voucher_list);
  }
}
