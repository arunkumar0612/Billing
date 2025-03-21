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
    for (var Livecomp in data.Live) {
      Livecomp.isSelected = false;
    }
    data.Live[selectedIndex].isSelected = true;
    hierarchyModel.CompanyList.refresh();
  }

  dynamic onOrgSelected(CompanyResponse data, int selectedIndex) {
    for (var Livecomp in data.Live) {
      Livecomp.isSelected = false;
    }
    data.Live[selectedIndex].isSelected = true;
    hierarchyModel.OrganizationList.refresh();
  }
}
