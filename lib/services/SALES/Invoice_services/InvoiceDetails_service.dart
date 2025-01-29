import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Invoice_actions.dart';

mixin InvoicedetailsService {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  void add_details() {
    if (invoiceController.invoiceModel.detailsKey.value.currentState?.validate() ?? false) {
      invoiceController.updateClientAddress(invoiceController.invoiceModel.clientAddressNameController.value.text, invoiceController.invoiceModel.clientAddressController.value.text);
      invoiceController.updateBillingAddress(invoiceController.invoiceModel.billingAddressNameController.value.text, invoiceController.invoiceModel.billingAddressController.value.text);
      invoiceController.updateChallanTitle(invoiceController.invoiceModel.TitleController.value.text);
      invoiceController.nextTab();
    }
  }
}
