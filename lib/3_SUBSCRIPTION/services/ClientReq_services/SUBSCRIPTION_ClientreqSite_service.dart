import 'package:get/get.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/models/entities/SUBSCRIPTION_ClientReq_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

mixin SUBSCRIPTION_ClientreqSiteService {
  final SUBSCRIPTION_ClientreqController clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();

  /// Clears all the input fields related to the client request form.
  /// This includes site name, camera quantity, and address fields.
  /// (GST field is currently commented out and not being cleared.)
  void clearFields() {
    clientreqController.clientReqModel.siteNameController.value.clear();
    clientreqController.clientReqModel.cameraquantityController.value.clear();
    clientreqController.clientReqModel.addressController.value.clear();
    // clientreqController.clientReqModel.gstController.value.clear();
  }

  /// Validates the site form and adds a new site to the client request model.
  /// Checks if the site already exists; if yes, shows an error snackbar.
  /// If the site is new, adds it with provided details (site name, camera quantity, address),
  /// then clears the form fields after successful addition.
  void addsite(context) {
    if (clientreqController.clientReqModel.siteFormkey.value.currentState?.validate() ?? false) {
      bool exists = clientreqController.clientReqModel.clientReqSiteDetails.any((site) => site.siteName == clientreqController.clientReqModel.siteNameController.value.text);

      if (exists) {
        Error_SnackBar(context, 'This Site already exists.');

        return;
      }
      clientreqController.addSite(
          context: context,
          siteName: clientreqController.clientReqModel.siteNameController.value.text,
          cameraquantity: int.parse(clientreqController.clientReqModel.cameraquantityController.value.text),
          address: clientreqController.clientReqModel.addressController.value.text);

      clearFields();
    }
  }

  /// Updates an existing site entry in the client request model.
  /// First validates the site form, then uses the edit index to update the site data
  /// including site name, camera quantity, and address.
  /// Clears the input fields and resets the edit index after successful update.
  void updateSite(context) {
    if (clientreqController.clientReqModel.siteFormkey.value.currentState?.validate() ?? false) {
      clientreqController.updateSite(
        context: context,
        editIndex: clientreqController.clientReqModel.site_editIndex.value!, // The index of the Site to be updated
        siteName: clientreqController.clientReqModel.siteNameController.value.text,

        cameraquantity: int.parse(clientreqController.clientReqModel.cameraquantityController.value.text),
        address: clientreqController.clientReqModel.addressController.value.text,
      );

      clearFields();
      clientreqController.addSiteEditindex(null);
    }
  }

  /// Populates the form fields with data from the selected site at the given index
  /// to allow editing. Updates the site name, camera quantity, and address fields,
  /// and sets the current edit index in the controller.
  void editsite(int index) {
    SUBSCRIPTION_ClientreqSites site = clientreqController.clientReqModel.clientReqSiteDetails[index];
    clientreqController.updateSiteName(site.siteName);
    clientreqController.updateQuantity(site.cameraquantity);
    clientreqController.updateAddressName(site.siteAddress);
    clientreqController.addSiteEditindex(index);
  }

  /// Resets the editing state by clearing all input fields
  /// and nullifying the site edit index to indicate no active editing.
  void resetEditingState() {
    clearFields();
    clientreqController.addSiteEditindex(null);
  }
}
