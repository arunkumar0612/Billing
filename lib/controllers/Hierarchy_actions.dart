import 'package:get/get.dart';
import 'package:ssipl_billing/models/constants/Hierarchy_constants.dart';
import 'package:ssipl_billing/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';

class HierarchyController extends GetxController {
  var hierarchyModel = HierarchyModel();

  void add_Org(CMDmResponse value) {
    hierarchyModel.OrganizationList.value = OrganizationResponse.fromCMDmResponse(value);
  }

  void add_Comp(CMDmResponse value) {
    hierarchyModel.CompanyList.value = CompanyResponse.fromCMDmResponse(value);
  }

  void add_Branch(CMDmResponse value) {
    hierarchyModel.BranchList.value = BranchResponse.fromCMDmResponse(value);
  }

  dynamic onCompSelected(CompanyResponse data, int selectedIndex) {
    if (data.Live[selectedIndex].isSelected) {
      onCompDeselected(data);
      toggle_cardCount(5);
      toggle_dataPageView(false);

      return;
    }
    for (var Livecomp in data.Live) {
      Livecomp.isSelected = false;
    }
    data.Live[selectedIndex].isSelected = true;
    toggle_dataPageView(true);
    toggle_cardCount(4);
    hierarchyModel.CompanyList.refresh();
  }

  dynamic onCompDeselected(CompanyResponse data) {
    for (var Livecomp in data.Live) {
      Livecomp.isSelected = false;
    }
    hierarchyModel.CompanyList.refresh();
  }

/////////////////////////////////-----------------------------------//////////////////////////////////

  dynamic onOrgSelected(OrganizationResponse data, int selectedIndex) {
    if (data.Live[selectedIndex].isSelected) {
      onOrgDeselected(data);
      toggle_cardCount(5);
      toggle_dataPageView(false);
      return;
    }

    for (var liveOrg in data.Live) {
      liveOrg.isSelected = false;
    }

    data.Live[selectedIndex].isSelected = true;
    toggle_dataPageView(true);
    toggle_cardCount(4);
    hierarchyModel.OrganizationList.refresh();
  }

  dynamic onOrgDeselected(OrganizationResponse data) {
    for (var LiveOrg in data.Live) {
      LiveOrg.isSelected = false;
    }
    hierarchyModel.OrganizationList.refresh();
  }

/////////////////////////////////-----------------------------------//////////////////////////////////

  dynamic onBranchSelected(BranchResponse data, int selectedIndex) {
    if (data.Live[selectedIndex].isSelected) {
      onBranchDeselected(data);
      toggle_cardCount(5);
      toggle_dataPageView(false);
      return;
    }
    for (var LiveBranch in data.Live) {
      LiveBranch.isSelected = false;
    }
    data.Live[selectedIndex].isSelected = true;
    toggle_dataPageView(true);
    toggle_cardCount(4);
    hierarchyModel.BranchList.refresh();
  }

  dynamic onBranchDeselected(BranchResponse data) {
    for (var LiveBranch in data.Live) {
      LiveBranch.isSelected = false;
    }
    hierarchyModel.BranchList.refresh();
  }

  void toggle_dataPageView(bool value) {
    hierarchyModel.DataPageView.value = value;
  }

  void toggle_cardCount(int value) {
    hierarchyModel.cardCount.value = value;
  }
}
