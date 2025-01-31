import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/RFQ_actions.dart';

mixin RFQdetailsService {
  final RFQController rfqController = Get.find<RFQController>();
  void add_details() {
    if (rfqController.rfqModel.detailsKey.value.currentState?.validate() ?? false) {
      rfqController.updateClientAddress(rfqController.rfqModel.clientAddressNameController.value.text, rfqController.rfqModel.clientAddressController.value.text);
      rfqController.updateBillingAddress(rfqController.rfqModel.billingAddressNameController.value.text, rfqController.rfqModel.billingAddressController.value.text);
      rfqController.updateChallanTitle(rfqController.rfqModel.TitleController.value.text);
      rfqController.nextTab();
    }
  }
}
