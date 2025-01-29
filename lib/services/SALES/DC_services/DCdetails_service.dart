import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/DC_actions.dart';

mixin DcdetailsService {
  final DCController dcController = Get.find<DCController>();
  void add_details() {
    if (dcController.dcModel.detailsKey.value.currentState?.validate() ?? false) {
      dcController.updateClientAddress(dcController.dcModel.clientAddressNameController.value.text, dcController.dcModel.clientAddressController.value.text);
      dcController.updateBillingAddress(dcController.dcModel.billingAddressNameController.value.text, dcController.dcModel.billingAddressController.value.text);
      dcController.updateChallanTitle(dcController.dcModel.TitleController.value.text);
      dcController.nextTab();
    }
  }
}
