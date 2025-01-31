import 'package:get/get.dart';

import '../../../controllers/credit_actions.dart';

mixin CreditdetailsService {
  final CreditController creditController = Get.find<CreditController>();
  void add_details() {
    if (creditController.creditModel.detailsKey.value.currentState?.validate() ?? false) {
      creditController.updateClientAddress(creditController.creditModel.clientAddressNameController.value.text, creditController.creditModel.clientAddressController.value.text);
      creditController.updateBillingAddress(creditController.creditModel.billingAddressNameController.value.text, creditController.creditModel.billingAddressController.value.text);
      creditController.updateChallanTitle(creditController.creditModel.TitleController.value.text);
      creditController.nextTab();
    }
  }
}
