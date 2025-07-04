import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/7_HIERARCHY/models/constants/Hierarchy_constants.dart';
import 'package:ssipl_billing/7_HIERARCHY/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class HierarchyController extends GetxController {
  var hierarchyModel = HierarchyModel();

  void add_Org(CMDmResponse value) {
    hierarchyModel.OrganizationList.value = OrganizationResponse.fromCMDmResponse(value);
    hierarchyModel.backup_OrganizationList.value = OrganizationResponse.fromCMDmResponse(value);
  }

  void add_Comp(CMDmResponse value) {
    hierarchyModel.CompanyList.value = CompanyResponse.fromCMDmResponse(value);
    hierarchyModel.backup_CompanyList.value = CompanyResponse.fromCMDmResponse(value);
  }

  void add_Branch(CMDmResponse value) {
    hierarchyModel.BranchList.value = BranchResponse.fromCMDmResponse(value);
    hierarchyModel.backup_BranchList.value = BranchResponse.fromCMDmResponse(value);
  }

  void search(String query) {
    hierarchyModel.searchQuery.value = query;
    // hierarchyModel.searchQuery.value = query;
//////////////////////////////////////////////////////////ORGANIZATION/////////////////////////////////////////////////////////
    if (query.isEmpty) {
      hierarchyModel.OrganizationList.value.Demo.assignAll(hierarchyModel.backup_OrganizationList.value.Demo);
      hierarchyModel.OrganizationList.value.Live.assignAll(hierarchyModel.backup_OrganizationList.value.Live);
    } else {
      var filtered_OrgLive = hierarchyModel.backup_OrganizationList.value.Live.where((liv) => liv.organizationName!.toLowerCase().contains(query.toLowerCase()));
      var filtered_OrgDemo = hierarchyModel.backup_OrganizationList.value.Demo.where((dem) => dem.organizationName!.toLowerCase().contains(query.toLowerCase()));

      hierarchyModel.OrganizationList.value.Demo.assignAll(filtered_OrgDemo);
      hierarchyModel.OrganizationList.value.Live.assignAll(filtered_OrgLive);
    }
    hierarchyModel.OrganizationList.refresh();
/////////////////////////////////////////////////////////////COMPANY/////////////////////////////////////////////////////////
    if (query.isEmpty) {
      hierarchyModel.CompanyList.value.Demo.assignAll(hierarchyModel.backup_CompanyList.value.Demo);
      hierarchyModel.CompanyList.value.Live.assignAll(hierarchyModel.backup_CompanyList.value.Live);
    } else {
      var filtered_CompLive = hierarchyModel.backup_CompanyList.value.Live.where((liv) => liv.customerName!.toLowerCase().contains(query.toLowerCase()));
      var filtered_CompDemo = hierarchyModel.backup_CompanyList.value.Demo.where((dem) => dem.customerName!.toLowerCase().contains(query.toLowerCase()));

      hierarchyModel.CompanyList.value.Demo.assignAll(filtered_CompDemo);
      hierarchyModel.CompanyList.value.Live.assignAll(filtered_CompLive);
    }
    hierarchyModel.CompanyList.refresh();
/////////////////////////////////////////////////////////////BRANCH/////////////////////////////////////////////////////////

    if (query.isEmpty) {
      hierarchyModel.BranchList.value.Demo.assignAll(hierarchyModel.backup_BranchList.value.Demo);
      hierarchyModel.BranchList.value.Live.assignAll(hierarchyModel.backup_BranchList.value.Live);
    } else {
      var filtered_BranchLive = hierarchyModel.backup_BranchList.value.Live.where((liv) => liv.branchName!.toLowerCase().contains(query.toLowerCase()));
      var filtered_BranchDemo = hierarchyModel.backup_BranchList.value.Demo.where((dem) => dem.branchName!.toLowerCase().contains(query.toLowerCase()));

      hierarchyModel.BranchList.value.Demo.assignAll(filtered_BranchDemo);
      hierarchyModel.BranchList.value.Live.assignAll(filtered_BranchLive);
    }
    hierarchyModel.BranchList.refresh();
  }

  void updateOrgName(String org) {
    hierarchyModel.Org_Controller.value = org;
  }

  void updateOrdID(int? id) {
    hierarchyModel.OrgID.value = id;
  }

  void updateCompID(int? id) {
    hierarchyModel.CompID.value = id;
  }

  void on_Orgselected() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hierarchyModel.Comp_Controller.value = null;
    });
    hierarchyModel.refresh();
  }

  void updateCompName(String comp) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hierarchyModel.Comp_Controller.value = comp;
    });
  }

  void reset_OrgComp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hierarchyModel.Org_Controller.value = 'All';
      hierarchyModel.Comp_Controller.value = 'All';
      hierarchyModel.CompID.value = null;
      hierarchyModel.OrgID.value = null;
    });
    hierarchyModel.refresh();
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hierarchyModel.selectedBranchDetails.value = data[index];
    });
  }

  void resetBranchDetails() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hierarchyModel.selectedBranchDetails.value = BranchsData();
    });
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
