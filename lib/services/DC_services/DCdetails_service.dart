import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/DC_actions.dart';

mixin DcdetailsService {
  final DCController dcController = Get.find<DCController>();
  void add_details() {
    if (dcController.dcModel.formKey1.value.currentState?.validate() ?? false) {
      dcController.updateClientAddress(dcController.dcModel.clientAddressNameController.value.text, dcController.dcModel.clientAddressController.value.text);
      dcController.updateBillingAddress(dcController.dcModel.billingAddressNameController.value.text, dcController.dcModel.billingAddressController.value.text);
      dcController.updateChallanTitle(dcController.dcModel.TitleController.value.text);
      dcController.nextTab();

      // dcController.dcModel.Delivery_challan_client_addr_name.value = dcController.dcModel.clientAddressNameController.value.text;
      // dcController.dcModel.Delivery_challan_client_addr.value = dcController.dcModel.clientAddressController.value.text;
      // dcController.dcModel.Delivery_challan_bill_addr_name.value = dcController.dcModel.billingAddressNameController.value.text;
      // dcController.dcModel.Delivery_challan_bill_addr.value = dcController.dcModel.billingAddressController.value.text;
      // dcController.dcModel.Delivery_challan_title.value = dcController.dcModel.TitleController.value.text;
    }
  }
}
