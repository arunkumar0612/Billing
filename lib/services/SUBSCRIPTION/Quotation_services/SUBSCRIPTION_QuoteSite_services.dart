import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Sites_entities.dart';

mixin SUBSCRIPTION_QuotesiteService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  void clearFields() {
    quoteController.quoteModel.siteNameController.value.clear();
    quoteController.quoteModel.cameraquantityController.value.clear();
    quoteController.quoteModel.addressController.value.clear();
    //quoteController.quoteModel.gstController.value.clear();
  }

  void addsite(context) {
    if (quoteController.quoteModel.siteFormkey.value.currentState?.validate() ?? false) {
      bool exists = quoteController.quoteModel.QuoteSiteDetails.any((site) => site.siteName == quoteController.quoteModel.siteNameController.value.text);

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This Site already exists.'),
          ),
        );
        return;
      }
      quoteController.addSite(
          context: context,
          siteName: quoteController.quoteModel.siteNameController.value.text,
          cameraquantity: int.parse(quoteController.quoteModel.cameraquantityController.value.text),
          address: quoteController.quoteModel.addressController.value.text);

      clearFields();
    }
  }

  void updateSite(context) {
    if (quoteController.quoteModel.siteFormkey.value.currentState?.validate() ?? false) {
      quoteController.updateSite(
        context: context,
        editIndex: quoteController.quoteModel.site_editIndex.value!, // The index of the Site to be updated
        siteName: quoteController.quoteModel.siteNameController.value.text,

        cameraquantity: int.parse(quoteController.quoteModel.cameraquantityController.value.text),
        address: quoteController.quoteModel.addressController.value.text,
      );

      clearFields();
      quoteController.addSiteEditindex(null);
    }
  }

  void editsite(int index) {
    Site site = quoteController.quoteModel.QuoteSiteDetails[index];
    quoteController.updateSiteName(site.siteName);
    quoteController.updateQuantity(site.camCount);
    quoteController.updateAddressName(site.address);
    quoteController.addSiteEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    quoteController.addSiteEditindex(null);
  }
}
