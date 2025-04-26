import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/SUBSCRIPTION_Sites_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

mixin SUBSCRIPTION_QuotesiteService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  final Map<String, PackageDetails> packageDetailsMap = {
    'Basic': PackageDetails(
      name: 'Basic',
      cameraCount: 2,
      packageAmount: 999.0,
      additionalCharges: 'No additional charges',
      description: 'Basic security package with essential features',
    ),
    'Standard': PackageDetails(
      name: 'Standard',
      cameraCount: 4,
      packageAmount: 1999.0,
      additionalCharges: 'Installation charges may apply',
      description: 'Standard security package with advanced features',
    ),
    'Premium': PackageDetails(
      name: 'Premium',
      cameraCount: 8,
      packageAmount: 2999.0,
      additionalCharges: 'Includes professional installation',
      description: 'Premium security package with all features',
    ),
    'Enterprise': PackageDetails(
      name: 'Enterprise',
      cameraCount: 16,
      packageAmount: 4999.0,
      additionalCharges: 'Custom installation available',
      description: 'Enterprise-grade security solution',
    ),
    'Custom': PackageDetails(
      name: 'Custom',
      cameraCount: 0,
      packageAmount: 0.0,
      additionalCharges: 'To be determined',
      description: 'Custom security solution tailored to your needs',
    ),
  };
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
        Error_SnackBar(context, 'This Site already exists.');

        return;
      }
      quoteController.addSite(
        context: context,
        siteName: quoteController.quoteModel.siteNameController.value.text,
        cameraquantity: int.parse(quoteController.quoteModel.cameraquantityController.value.text),
        address: quoteController.quoteModel.addressController.value.text,
        packageDetails: quoteController.quoteModel.selectedPackageController.value.text == 'Custom'
            ? quoteController.quoteModel.customPackageDetails.value
            : packageDetailsMap[quoteController.quoteModel.selectedPackageController.value.text],
        selectedPackage: quoteController.quoteModel.selectedPackageController.value.text,
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
        selectedPackage: quoteController.quoteModel.selectedPackageController.value.text,
        address: quoteController.quoteModel.addressController.value.text,
        packageDetails: quoteController.quoteModel.selectedPackageController.value.text == 'Custom'
            ? quoteController.quoteModel.customPackageDetails.value
            : packageDetailsMap[quoteController.quoteModel.selectedPackageController.value.text],
      );

      clearFields();
      quoteController.resetPackageSelection();
      quoteController.addsiteEditindex(null);
    }
  }

  void editsite(int index) {
    Site site = quoteController.quoteModel.QuoteSiteDetails[index];
    quoteController.updateSiteName(site.siteName);
    quoteController.updateQuantity(site.camCount);
    quoteController.updateAddressName(site.address);
    quoteController.updateSelectedPackage(site.selectedPackage);
    quoteController.updateQuantity(site.camCount);
    // If it's a custom package, load the details
    if (site.selectedPackage == 'Custom' && site.packageDetails != null) {
      quoteController.updateCustomPackageDetails(site.packageDetails!);
    }
    quoteController.addSiteEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    quoteController.addSiteEditindex(null);
  }
}
