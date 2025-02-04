import 'package:get/get.dart';

import '../../../controllers/Credit_actions.dart';

mixin CreditdetailsService {
  final CreditController creditController = Get.find<CreditController>();
  void add_details() {
    if (creditController.creditModel.detailsKey.value.currentState?.validate() ?? false) {
      creditController.nextTab();
    }
  }
}
