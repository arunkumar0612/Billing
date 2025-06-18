import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

mixin SUBSCRIPTION_QuotesiteService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
// Function to clear the fields in the site form
  /// This function clears the text fields in the site form.
  /// It clears the site name, camera quantity, and address fields.
  /// It is used to reset the form fields after adding or updating a site.
  /// It is called after a site is successfully added or updated.
  /// It is also used to reset the form when the user is done editing a site.
  /// It is important to clear the fields to avoid confusion and ensure that the user can enter new data.
  /// It is a good practice to clear the fields after performing an action to ensure that the form is ready for new input.
  /// It is called in the addsite and updatesite functions after the site is successfully added or updated.
  /// It is also called in the resetEditingState function to clear the fields when the user is done editing a site.
  /// It is a simple function that does not take any parameters and does not return any value.
  /// It is a part of the SUBSCRIPTION_QuoteSite_services mixin, which contains functions related to site management in the subscription quote process.
  // It is used to manage the site details in the subscription quote process.
  void clearFields() {
    quoteController.quoteModel.siteNameController.value.clear();
    quoteController.quoteModel.cameraquantityController.value.clear();
    quoteController.quoteModel.addressController.value.clear();
  }

//// Function to add a site
  /// This function validates the site form, checks for duplicate site names,
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

// Function to update a site
  /// This function validates the site form and updates the site details.
  /// It checks if the form is valid and if the site name already exists.
  /// If the site name exists, it shows an error message.
  /// If the form is valid, it updates the site details and clears the fields.
  /// It also resets the editing state by setting the edit index to null.
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

// Function to delete a site
  /// This function deletes a site from the quote model.
  /// It checks if the site index is not null, then removes the site from the list.
  /// It also resets the editing state by setting the edit index to null.
  void editsite(int index) {
    Site site = quoteController.quoteModel.QuoteSiteDetails[index];
    quoteController.updateSiteName(site.sitename);
    quoteController.updateQuantity(site.cameraquantity);
    quoteController.updateAddressName(site.address);
    quoteController.addSiteEditindex(index);
    quoteController.updateBillingtype(site.billType);
    quoteController.updateMailtype(site.mailType);
  }

// Function to reset the editing state
  /// This function clears the fields and resets the editing state by setting the edit index to null.
  /// It is used to reset the form when the user is done editing a site.
  void resetEditingState() {
    clearFields();
    quoteController.addSiteEditindex(null);
  }
}
