import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/models/constants/voucher_contants.dart';
import 'package:ssipl_billing/2.BILLING/models/entities/voucher_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class VoucherController extends GetxController {
  var voucherModel = VoucherModel();
  void add_Voucher(CMDlResponse value) {
    voucherModel.voucherlist.value = Voucher_List.fromCMDlResponse(value);
  }
}
