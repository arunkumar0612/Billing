import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/Hierarchy_entities.dart';

class HierarchyModel extends GetxController with GetSingleTickerProviderStateMixin {
  late Animation<Offset> slideAnimation;
  late TabController tabController;
  var selectedtab = 0.obs;
///////////////////////////////-----------------------------COMMON--------------------------------///////////////////////////////
  late AnimationController Org_controller;
  var Org_DataPageView = false.obs;
  var Org_cardCount = 5.obs;
  var OrganizationList = OrganizationResponse(Live: [], Demo: []).obs;
  var selectedOrgDetails = OrganizationsData().obs;

  var org_IdController = TextEditingController().obs;
  var org_emailIdController = TextEditingController().obs;
  var org_NameController = TextEditingController().obs;
  var org_CodeController = TextEditingController().obs;
  var org_addressController = TextEditingController().obs;
  var org_siteTypeController = TextEditingController().obs;
  var org_contactnoController = TextEditingController().obs;
  var org_contactpersonController = TextEditingController().obs;

///////////////////////////////-----------------------------ORGANOZATION--------------------------------///////////////////////////////
  late AnimationController Comp_controller;
  var Comp_DataPageView = false.obs;
  var Comp_cardCount = 5.obs;
  var selectedCompDetails = CompanysData().obs;
  var CompanyList = CompanyResponse(Live: [], Demo: []).obs;

  var comp_IdController = TextEditingController().obs;
  var comp_NameController = TextEditingController().obs;
  var comp_siteTypeController = TextEditingController().obs;
  var comp_organizationidController = TextEditingController().obs;
  var comp_contactpersonController = TextEditingController().obs;
  var comp_contactpersonnoController = TextEditingController().obs;
  var comp_emailIdController = TextEditingController().obs;
  var comp_addressController = TextEditingController().obs;
  var comp_billingaddressController = TextEditingController().obs;
  var comp_pannumberController = TextEditingController().obs;
  var comp_cinnoController = TextEditingController().obs;
  var comp_ccodeController = TextEditingController().obs;
  ///////////////////////////////-----------------------------COMPANY--------------------------------///////////////////////////////

  late AnimationController Branch_controller;
  var Branch_DataPageView = false.obs;
  var Branch_cardCount = 5.obs;
  var selectedBranchDetails = BranchsData().obs;
  var BranchList = BranchResponse(Live: [], Demo: []).obs;

  var branch_IdController = TextEditingController().obs;
  var branch_NameController = TextEditingController().obs;
  var branch_CodeController = TextEditingController().obs;
  var branch_clientAddressNameController = TextEditingController().obs;
  var branch_clientAddressController = TextEditingController().obs;
  var branch_gstNumberController = TextEditingController().obs;
  var branch_emailIdController = TextEditingController().obs;
  var branch_contactNumberController = TextEditingController().obs;
  var branch_contact_personController = TextEditingController().obs;
  var branch_billingAddressController = TextEditingController().obs;
  var branch_billingAddressNameController = TextEditingController().obs;
  var branch_siteTypeController = TextEditingController().obs;
  var branch_subscriptionIdController = TextEditingController().obs;
  var branch_billingPlanController = TextEditingController().obs;
  var branch_billModeController = TextEditingController().obs;
  var branch_fromDateController = TextEditingController().obs;
  var branch_toDateController = TextEditingController().obs;
  var branch_amountController = TextEditingController().obs;
  var branch_billingPeriodController = TextEditingController().obs;

////////////////////////////////-----------------------------BRANCHES-------------------------------//////////////////////////////////

  void initTabController(TickerProvider tickerProvider, int length) {
    tabController = TabController(length: length, vsync: tickerProvider);
    tabController.addListener(() {
      selectedtab.value = tabController.index;
    });
  }
}
