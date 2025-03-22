import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/Hierarchy_entities.dart';

class HierarchyModel extends GetxController with GetSingleTickerProviderStateMixin {
  var organizations = <Map<String, dynamic>>[].obs;
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  var DataPageView = false.obs;
  var cardCount = 5.obs;

  var OrganizationList = OrganizationResponse(Live: [], Demo: []).obs;
  var CompanyList = CompanyResponse(Live: [], Demo: []).obs;
  var BranchList = BranchResponse(Live: [], Demo: []).obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize controller
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Initialize animation
    slideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    // Start animation with a delay
    Future.delayed(const Duration(milliseconds: 300), () {
      controller.forward();
    });
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
