import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/DC_actions.dart';

mixin DcdetailsService {
  final DCController dcController = Get.find<DCController>();
  void add_details() {
    if (dcController.dcModel.detailsKey.value.currentState?.validate() ?? false) {
      dcController.nextTab();
    }
  }
}
