import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Debit_actions.dart';

mixin DebitdetailsService {
  final DebitController debitController = Get.find<DebitController>();
  void add_details() {
    if (debitController.debitModel.detailsKey.value.currentState?.validate() ?? false) {
      debitController.nextTab();
    }
  }
}
