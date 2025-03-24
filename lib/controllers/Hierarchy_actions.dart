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
    if (type == "LIVE") {
      if (data.Live[selectedIndex].isSelected) {
        onCompDeselected(data, type);
        toggle_cardCount(5);
        toggle_dataPageView(false);
        return;
      }

      for (var liveComp in data.Live) {
        liveComp.isSelected = false;
      }

      data.Live[selectedIndex].isSelected = true;
    } else if (type == "DEMO") {
      if (data.Demo[selectedIndex].isSelected) {
        onCompDeselected(data, type);
        toggle_cardCount(5);
        toggle_dataPageView(false);
        return;
      }

      for (var DemoOrg in data.Live) {
        DemoOrg.isSelected = false;
      }

      data.Demo[selectedIndex].isSelected = true;
    }

    // if (data.Live[selectedIndex].isSelected) {
    //   onCompDeselected(data);
    //   toggle_cardCount(5);
    //   toggle_dataPageView(false);

    //   return;
    // }
    // for (var Livecomp in data.Live) {
    //   Livecomp.isSelected = false;
    // }
    // data.Live[selectedIndex].isSelected = true;
    toggle_dataPageView(true);
    toggle_cardCount(4);
    hierarchyModel.CompanyList.refresh();
  }

  dynamic onCompDeselected(CompanyResponse data, String type) {
    if (type == "LIVE") {
      for (var LiveComp in data.Live) {
        LiveComp.isSelected = false;
      }
    } else if (type == "DEMO") {
      for (var DemoComp in data.Demo) {
        DemoComp.isSelected = false;
      }
    }

    hierarchyModel.CompanyList.refresh();
  }

/////////////////////////////////-----------------------------------//////////////////////////////////

  dynamic onOrgSelected(OrganizationResponse data, int selectedIndex, String type) {
    if (type == "LIVE") {
      if (data.Live[selectedIndex].isSelected) {
        print(data.Live[selectedIndex].address);
        onOrgDeselected(data, type);
        toggle_cardCount(5);
        toggle_dataPageView(false);
        return;
      }

      for (var liveOrg in data.Live) {
        liveOrg.isSelected = false;
      }

      data.Live[selectedIndex].isSelected = true;
    } else if (type == "DEMO") {
      if (data.Demo[selectedIndex].isSelected) {
        onOrgDeselected(data, type);
        toggle_cardCount(5);
        toggle_dataPageView(false);
        return;
      }

      for (var DemoOrg in data.Demo) {
        DemoOrg.isSelected = false;
      }

      data.Demo[selectedIndex].isSelected = true;
    }

    toggle_dataPageView(true);
    toggle_cardCount(4);
    hierarchyModel.OrganizationList.refresh();
  }

  dynamic onOrgDeselected(OrganizationResponse data, String type) {
    if (type == "LIVE") {
      for (var LiveOrg in data.Live) {
        LiveOrg.isSelected = false;
      }
    } else if (type == "DEMO") {
      for (var DemoOrg in data.Demo) {
        DemoOrg.isSelected = false;
      }
    }

    hierarchyModel.OrganizationList.refresh();
  }

/////////////////////////////////-----------------------------------//////////////////////////////////

  dynamic onBranchSelected(BranchResponse data, int selectedIndex, String type) {
    if (type == "LIVE") {
      if (data.Live[selectedIndex].isSelected) {
        onBranchDeselected(data, type);
        toggle_cardCount(5);
        toggle_dataPageView(false);
        return;
      }

      for (var liveBranch in data.Live) {
        liveBranch.isSelected = false;
      }

      data.Live[selectedIndex].isSelected = true;
    } else if (type == "DEMO") {
      if (data.Demo[selectedIndex].isSelected) {
        onBranchDeselected(data, type);
        toggle_cardCount(5);
        toggle_dataPageView(false);
        return;
      }

      for (var DemoBranch in data.Live) {
        DemoBranch.isSelected = false;
      }

      data.Demo[selectedIndex].isSelected = true;
    }

    // if (data.Live[selectedIndex].isSelected) {
    //   onBranchDeselected(data);
    //   toggle_cardCount(5);
    //   toggle_dataPageView(false);
    //   return;
    // }
    // for (var LiveBranch in data.Live) {
    //   LiveBranch.isSelected = false;
    // }
    // data.Live[selectedIndex].isSelected = true;
    toggle_dataPageView(true);
    toggle_cardCount(4);
    hierarchyModel.BranchList.refresh();
  }

  dynamic onBranchDeselected(BranchResponse data, String type) {
    if (type == "LIVE") {
      for (var LiveBranch in data.Live) {
        LiveBranch.isSelected = false;
      }
    } else if (type == "DEMO") {
      for (var DemoBranch in data.Demo) {
        DemoBranch.isSelected = false;
      }
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
