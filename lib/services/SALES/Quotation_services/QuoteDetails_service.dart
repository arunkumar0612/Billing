import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Quote_actions.dart';

mixin QuotedetailsService {
  final QuoteController quoteController = Get.find<QuoteController>();
  void add_details() {
    if (quoteController.quoteModel.detailsKey.value.currentState?.validate() ?? false) {
      quoteController.nextTab();
    }
  }
}
