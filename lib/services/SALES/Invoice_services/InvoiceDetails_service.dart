import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Invoice_actions.dart';

mixin InvoicedetailsService {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  void add_details() {
    if (invoiceController.invoiceModel.detailsKey.value.currentState?.validate() ?? false) {
      invoiceController.nextTab();
    }
  }
}
