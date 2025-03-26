import 'package:get/get.dart';

import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Sites_entities.dart';

mixin SUBSCRIPTION_QuotesiteService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  void clearFields() {
    quoteController.quoteModel.siteNameController.value.clear();
    quoteController.quoteModel.hsnController.value.clear();
    quoteController.quoteModel.priceController.value.clear();
    quoteController.quoteModel.quantityController.value.clear();
    quoteController.quoteModel.gstController.value.clear();
  }

  void addsite(context) {
    if (quoteController.quoteModel.siteKey.value.currentState?.validate() ?? false) {
      // ignore: unrelated_type_equality_checks
      bool exists = quoteController.quoteModel.Quote_sites.any((site) =>
          site.siteName == quoteController.quoteModel.siteNameController.value.text &&
          // ignore: unrelated_type_equality_checks
          site.hsn == quoteController.quoteModel.hsnController.value.text &&
          site.quantity == int.parse(quoteController.quoteModel.quantityController.value.text));

      if (exists) {
        Get.snackbar("Site", "This site already exists.");
        return;
      }
      quoteController.addsite(
          context: context,
          siteName: quoteController.quoteModel.siteNameController.value.text,
          hsn: quoteController.quoteModel.hsnController.value.text,
          price: double.parse(quoteController.quoteModel.priceController.value.text),
          quantity: int.parse(quoteController.quoteModel.quantityController.value.text),
          gst: double.parse(quoteController.quoteModel.gstController.value.text));

      clearFields();
    }
  }

  void onSubmit() {
    quoteController.quoteModel.Quote_gstTotals.assignAll(
      quoteController.quoteModel.Quote_sites
          .fold<Map<double, double>>({}, (Map<double, double> accumulator, SUBSCRIPTION_QuoteSite site) {
            accumulator[site.gst] = (accumulator[site.gst] ?? 0) + site.total;
            return accumulator;
          })
          .entries
          .map((entry) => SUBSCRIPTION_QuoteGSTtotals(
                gst: entry.key, // Convert key to String
                total: entry.value, // Convert value to String
              ))
          .toList(),
    );
  }

  void updatesite(context) {
    if (quoteController.quoteModel.siteKey.value.currentState?.validate() ?? false) {
      quoteController.updatesite(
        context: context,
        editIndex: quoteController.quoteModel.site_editIndex.value!, // The index of the site to be updated
        siteName: quoteController.quoteModel.siteNameController.value.text,
        hsn: quoteController.quoteModel.hsnController.value.text,
        price: double.parse(quoteController.quoteModel.priceController.value.text),
        quantity: int.parse(quoteController.quoteModel.quantityController.value.text),
        gst: double.parse(quoteController.quoteModel.gstController.value.text),
      );

      clearFields();
      quoteController.addsiteEditindex(null);
    }
  }

  void editsite(int index) {
    SUBSCRIPTION_QuoteSite site = quoteController.quoteModel.Quote_sites[index];

    quoteController.updatesiteName(site.siteName);
    quoteController.updateHSN(site.hsn);
    quoteController.updatePrice(site.price);
    quoteController.updateQuantity(site.quantity);
    quoteController.updateGST(site.gst);
    quoteController.addsiteEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    quoteController.addsiteEditindex(null);
  }
}
