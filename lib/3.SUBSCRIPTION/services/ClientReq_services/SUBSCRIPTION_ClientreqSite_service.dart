import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/SUBSCRIPTION_Sites_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

mixin SUBSCRIPTION_ClientreqSiteService {
  final SUBSCRIPTION_ClientreqController clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();
  void clearFields() {
    clientreqController.clientReqModel.siteNameController.value.clear();
    clientreqController.clientReqModel.cameraquantityController.value.clear();
    clientreqController.clientReqModel.addressController.value.clear();
    // clientreqController.clientReqModel.gstController.value.clear();
  }

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

  void editsite(int index) {
    SUBSCRIPTION_ClientreqSites site = clientreqController.clientReqModel.clientReqSiteDetails[index];
    clientreqController.updateSiteName(site.siteName);
    clientreqController.updateQuantity(site.cameraquantity);
    clientreqController.updateAddressName(site.siteAddress);
    clientreqController.addSiteEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    clientreqController.addSiteEditindex(null);
  }
}
