import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/constants/VendorList_constants.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/VendorList_entities.dart';

class VendorListController extends GetxController {
  var vendorListModel = VendorListModel();

  void search(String query) {
    vendorListModel.searchQuery.value = query;
    // vendorListModel.searchQuery.value = query;

    if (query.isEmpty) {
      vendorListModel.VendorList.assignAll(vendorListModel.backup_VendorList);
    } else {
      var filtered_VendorLive = vendorListModel.backup_VendorList.where((liv) => liv.vendorName!.toLowerCase().contains(query.toLowerCase()));

      vendorListModel.VendorList.assignAll(filtered_VendorLive);
    }
    vendorListModel.VendorList.refresh();
  }

/////////////////////////////////-----------------------------------//////////////////////////////////

/////////////////////////////////-----------------------------------//////////////////////////////////

  dynamic onVendorSelected(List<VendorsData> data, int selectedIndex) async {
    List<VendorsData> selectedList = data;

    if (selectedList[selectedIndex].isSelected) {
      onVendorDeselected(data);
      toggle_cardCount(5, "vendor");
      toggle_VendordataPageView(false);
      // await Future.delayed(const Duration(milliseconds: 2000));

      return;
    }

    // Deselect all vendores
    for (var vendor in data) {
      vendor.isSelected = false;
    }

    // Select the chosen vendor
    selectedList[selectedIndex].isSelected = true;
    injectVendorDetails(selectedIndex, selectedList);
    toggle_VendordataPageView(true);
    toggle_cardCount(4, "vendor");
    vendorListModel.VendorList.refresh();
  }

  dynamic onVendorDeselected(List<VendorsData> data) {
    resetVendorDetails();

    for (var vendor in data) {
      vendor.isSelected = false;
    }

    vendorListModel.VendorList.refresh();
  }

  void injectVendorDetails(int index, List<VendorsData> data) {
    vendorListModel.selectedVendorDetails.value = data[index];
  }

  void resetVendorDetails() {
    vendorListModel.selectedVendorDetails.value = VendorsData();
  }

///////////////////////////////////////-------------------------------////////////////////////////////////////////

  void toggle_VendordataPageView(bool value) {
    vendorListModel.Vendor_DataPageView.value = value;
  }

  void toggle_cardCount(int value, String nature) {
    if (nature == "org") {
      // vendorListModel.Org_cardCount.value = value;
    } else if (nature == "comp") {
      // vendorListModel.Comp_cardCount.value = value;
    } else if (nature == "vendor") {
      vendorListModel.Vendor_cardCount.value = value;
    }
  }
}
