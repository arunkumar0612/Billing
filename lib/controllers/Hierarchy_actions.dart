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

  dynamic onCompSelected(CompanyResponse data, int selectedIndex, String type) {
    List<CompanysData> selectedList = (type == "LIVE") ? data.Live : data.Demo;

    if (selectedList[selectedIndex].isSelected) {
      onCompDeselected(data);
      toggle_cardCount(5, "comp");
      toggle_CompdataPageView(false);
      return;
    }

    // Deselect all companies
    for (var comp in data.Live) {
      comp.isSelected = false;
    }
    for (var comp in data.Demo) {
      comp.isSelected = false;
    }

    // Select the chosen company
    selectedList[selectedIndex].isSelected = true;
    injectCompDetails(selectedIndex, selectedList);
    toggle_CompdataPageView(true);
    toggle_cardCount(4, "comp");
    hierarchyModel.CompanyList.refresh();
  }

  dynamic onCompDeselected(CompanyResponse data) {
    resetCompDetails();
    for (var comp in data.Live) {
      comp.isSelected = false;
    }
    for (var comp in data.Demo) {
      comp.isSelected = false;
    }
    hierarchyModel.CompanyList.refresh();
  }

  void injectCompDetails(int index, List<CompanysData> data) {
    hierarchyModel.selectedCompDetails.value = data[index];
  }

  void resetCompDetails() {
    hierarchyModel.selectedCompDetails.value = CompanysData();
  }
/////////////////////////////////-----------------------------------//////////////////////////////////

  dynamic onOrgSelected(OrganizationResponse data, int selectedIndex, String type) {
    List<OrganizationsData> selectedList = (type == "LIVE") ? data.Live : data.Demo;
    if (selectedList[selectedIndex].isSelected) {
      onOrgDeselected(data);
      toggle_OrgdataPageView(false);
      toggle_cardCount(5, "org");
      return;
    }

    // Deselect all organizations
    for (var org in data.Live) {
      org.isSelected = false;
    }
    for (var org in data.Demo) {
      org.isSelected = false;
    }

    // Select the chosen organization
    selectedList[selectedIndex].isSelected = true;
    injectOrgDetails(selectedIndex, selectedList);
    toggle_OrgdataPageView(true);
    toggle_cardCount(4, "org");
    hierarchyModel.OrganizationList.refresh();
    hierarchyModel.selectedOrgDetails.refresh();
  }

  dynamic onOrgDeselected(OrganizationResponse data) {
    resetOrgDetails();
    for (var org in data.Live) {
      org.isSelected = false;
    }
    for (var org in data.Demo) {
      org.isSelected = false;
    }
    // hierarchyModel.OrganizationList.refresh();
  }

  void injectOrgDetails(int index, List<OrganizationsData> data) {
    hierarchyModel.selectedOrgDetails.value = data[index];
  }

  void resetOrgDetails() {
    hierarchyModel.selectedOrgDetails.value = OrganizationsData();
  }
/////////////////////////////////-----------------------------------//////////////////////////////////

  dynamic onBranchSelected(BranchResponse data, int selectedIndex, String type) async {
    List<BranchsData> selectedList = (type == "LIVE") ? data.Live : data.Demo;

    if (selectedList[selectedIndex].isSelected) {
      onBranchDeselected(data);
      toggle_cardCount(5, "branch");
      toggle_BranchdataPageView(false);
      // await Future.delayed(const Duration(milliseconds: 2000));

      return;
    }

    // Deselect all branches
    for (var branch in data.Live) {
      branch.isSelected = false;
    }
    for (var branch in data.Demo) {
      branch.isSelected = false;
    }

    // Select the chosen branch
    selectedList[selectedIndex].isSelected = true;
    injectBranchDetails(selectedIndex, selectedList);
    toggle_BranchdataPageView(true);
    toggle_cardCount(4, "branch");
    hierarchyModel.BranchList.refresh();
  }

  dynamic onBranchDeselected(BranchResponse data) {
    resetBranchDetails();
    for (var branch in data.Live) {
      branch.isSelected = false;
    }
    for (var branch in data.Demo) {
      branch.isSelected = false;
    }
    hierarchyModel.BranchList.refresh();
  }

  void injectBranchDetails(int index, List<BranchsData> data) {
    hierarchyModel.selectedBranchDetails.value = data[index];
  }

  void resetBranchDetails() {
    hierarchyModel.selectedBranchDetails.value = BranchsData();
  }

///////////////////////////////////////-------------------------------////////////////////////////////////////////
  void toggle_OrgdataPageView(bool value) {
    hierarchyModel.Org_DataPageView.value = value;
  }

  void toggle_CompdataPageView(bool value) {
    hierarchyModel.Comp_DataPageView.value = value;
  }

  void toggle_BranchdataPageView(bool value) {
    hierarchyModel.Branch_DataPageView.value = value;
  }

  void toggle_cardCount(int value, String nature) {
    if (nature == "org") {
      hierarchyModel.Org_cardCount.value = value;
    } else if (nature == "comp") {
      hierarchyModel.Comp_cardCount.value = value;
    } else if (nature == "branch") {
      hierarchyModel.Branch_cardCount.value = value;
    }
  }

  // void on_OrgDispose() async {
  //   // toggle_dataPageView(false);
  //   // await Future.delayed(const Duration(milliseconds: 4000));
  //   for (var liveBranch in hierarchyModel.OrganizationList.value.Live) {
  //     liveBranch.isSelected = false;
  //   }
  //   for (var DemoBranch in hierarchyModel.OrganizationList.value.Demo) {
  //     DemoBranch.isSelected = false;
  //   }
  // }

  // void on_CompDispose() async {
  //   // toggle_dataPageView(false);
  //   // await Future.delayed(const Duration(milliseconds: 4000));
  //   for (var liveBranch in hierarchyModel.CompanyList.value.Live) {
  //     liveBranch.isSelected = false;
  //   }
  //   for (var DemoBranch in hierarchyModel.CompanyList.value.Demo) {
  //     DemoBranch.isSelected = false;
  //   }
  // }

  // void on_BranchDispose() async {
  //   // toggle_dataPageView(false);
  //   // await Future.delayed(const Duration(milliseconds: 4000));

  //   for (var liveBranch in hierarchyModel.BranchList.value.Live) {
  //     liveBranch.isSelected = false;
  //   }
  //   for (var DemoBranch in hierarchyModel.BranchList.value.Demo) {
  //     DemoBranch.isSelected = false;
  //   }
  // }
}
