import 'package:get/get.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

mixin SUBSCRIPTION_QuotesiteService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();

  void clearFields() {
    quoteController.quoteModel.siteNameController.value.clear();
    quoteController.quoteModel.cameraquantityController.value.clear();
    quoteController.quoteModel.addressController.value.clear();
  }

  void addsite(context) {
    if (quoteController.quoteModel.siteFormkey.value.currentState?.validate() ?? false) {
      bool exists = quoteController.quoteModel.QuoteSiteDetails.any((site) => site.sitename == quoteController.quoteModel.siteNameController.value.text);

      if (exists) {
        Error_SnackBar(context, 'This Site already exists.');

        return;
      }
      quoteController.addSite(
        context: context,
        siteName: quoteController.quoteModel.siteNameController.value.text,
        cameraquantity: int.parse(quoteController.quoteModel.cameraquantityController.value.text),
        address: quoteController.quoteModel.addressController.value.text,
        billType: quoteController.quoteModel.Billingtype_Controller.value,
        mailType: quoteController.quoteModel.Mailtype_Controller.value,
      );

      clearFields();
    }
  }

  void updatesite(context) {
    if (quoteController.quoteModel.siteFormkey.value.currentState?.validate() ?? false) {
      quoteController.updateSite(
        context: context,
        cameraquantity: int.parse(quoteController.quoteModel.cameraquantityController.value.text),
        editIndex: quoteController.quoteModel.site_editIndex.value!,
        siteName: quoteController.quoteModel.siteNameController.value.text,
        billType: quoteController.quoteModel.Billingtype_Controller.value,
        mailType: quoteController.quoteModel.Mailtype_Controller.value,
        address: quoteController.quoteModel.addressController.value.text,
      );

      clearFields();
      quoteController.addSiteEditindex(null);
    }
  }

  void editsite(int index) {
    Site site = quoteController.quoteModel.QuoteSiteDetails[index];
    quoteController.updateSiteName(site.sitename);
    quoteController.updateQuantity(site.cameraquantity);
    quoteController.updateAddressName(site.address);
    quoteController.addSiteEditindex(index);
    quoteController.updateBillingtype(site.billType);
    quoteController.updateMailtype(site.mailType);
  }

  void resetEditingState() {
    clearFields();
    quoteController.addSiteEditindex(null);
  }
}
