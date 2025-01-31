import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Quote_actions.dart';

mixin QuotedetailsService {
  final QuoteController quoteController = Get.find<QuoteController>();
  void add_details() {
    if (quoteController.quoteModel.detailsKey.value.currentState?.validate() ?? false) {
      quoteController.updateClientAddress(quoteController.quoteModel.clientAddressNameController.value.text, quoteController.quoteModel.clientAddressController.value.text);
      quoteController.updateBillingAddress(quoteController.quoteModel.billingAddressNameController.value.text, quoteController.quoteModel.billingAddressController.value.text);
      quoteController.updateChallanTitle(quoteController.quoteModel.TitleController.value.text);
      quoteController.nextTab();
    }
  }
}
