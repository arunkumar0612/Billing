import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HierarchyModel extends GetxController with GetSingleTickerProviderStateMixin {
  var organizations = <Map<String, dynamic>>[].obs;
  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0), // Slide from left
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
