import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/RFQ_actions.dart';

mixin RFQdetailsService {
  final RFQController rfqController = Get.find<RFQController>();
  void add_details() {
    if (rfqController.rfqModel.detailsKey.value.currentState?.validate() ?? false) {
      rfqController.updateVendorCredentials(rfqController.rfqModel.vendor_address_controller.value.text, rfqController.rfqModel.vendor_phone_controller.value.text, rfqController.rfqModel.vendor_email_controller.value.text);

      rfqController.nextTab();
    }
  }
}
