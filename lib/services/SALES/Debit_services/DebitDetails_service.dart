import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Debit_actions.dart';

mixin DebitdetailsService {
  final DebitController debitController = Get.find<DebitController>();
  void add_details() {
    if (debitController.debitModel.detailsKey.value.currentState?.validate() ?? false) {
      debitController.updateClientAddress(debitController.debitModel.clientAddressNameController.value.text, debitController.debitModel.clientAddressController.value.text);
      debitController.updateBillingAddress(debitController.debitModel.billingAddressNameController.value.text, debitController.debitModel.billingAddressController.value.text);
      debitController.updateChallanTitle(debitController.debitModel.TitleController.value.text);
      debitController.nextTab();
    }
  }
}
