import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/services/Hierarchy_services/hierarchy_service.dart';
import 'package:ssipl_billing/views/components/Loading.dart';
import 'package:ssipl_billing/views/components/Org_card.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

class OrganizationGrid extends StatefulWidget with HierarchyService {
  // static var organizations = <OrganizationData>[].obs;

  OrganizationGrid({super.key});

  @override
  _OrganizationGridState createState() => _OrganizationGridState();
}

class _OrganizationGridState extends State<OrganizationGrid> with SingleTickerProviderStateMixin {
  final HierarchyController hierarchyController = Get.find<HierarchyController>();
  // late AnimationController _controller;
  // late Animation<Offset> _slideAnimation;
  final loader = LoadingOverlay();
  @override
  void initState() {
    super.initState();
    hierarchyController.hierarchyModel.controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    hierarchyController.hierarchyModel.slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: hierarchyController.hierarchyModel.controller,
      curve: Curves.easeInCubic,
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) hierarchyController.hierarchyModel.controller.forward();
    });
    // // Ensures fetchCompanyList() runs only after the first frame is built
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   widget.get_OrganizationList(context);
    // });
  }

  // @override
  // void dispose() {
  //   hierarchyController.hierarchyModel.controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(() {
          return Expanded(
            child: SlideTransition(
              position: hierarchyController.hierarchyModel.slideAnimation,
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: hierarchyController.hierarchyModel.cardCount.value,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                ),
                itemCount: hierarchyController.hierarchyModel.OrganizationList.value.Live.length,
                itemBuilder: (context, index) {
                  var org = hierarchyController.hierarchyModel.OrganizationList.value.Live[index];
                  return GestureDetector(
                    child: OrganizationCard(
                      name: org.organizationName,
                      id: org.organizationId,
                      email: org.email,
                      imageBytes: org.organizationLogo!,
                      index: index,
                      data: hierarchyController.hierarchyModel.OrganizationList.value,
                      controller: hierarchyController,
                      isSelected: hierarchyController.hierarchyModel.OrganizationList.value.Live[index].isSelected,
                      type: "LIVE",
                    ),
                  );
                },
              ),
            ),
          );
        }),
        const SizedBox(
          height: 60,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "DEMO",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 60,
        ),
        Obx(() {
          return Expanded(
            child: SlideTransition(
              position: hierarchyController.hierarchyModel.slideAnimation,
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: hierarchyController.hierarchyModel.cardCount.value,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                ),
                itemCount: hierarchyController.hierarchyModel.OrganizationList.value.Demo.length,
                itemBuilder: (context, index) {
                  var org = hierarchyController.hierarchyModel.OrganizationList.value.Demo[index];
                  return GestureDetector(
                    child: OrganizationCard(
                      name: org.organizationName,
                      id: org.organizationId,
                      email: org.email,
                      imageBytes: org.organizationLogo!,
                      index: index,
                      data: hierarchyController.hierarchyModel.OrganizationList.value,
                      controller: hierarchyController,
                      isSelected: hierarchyController.hierarchyModel.OrganizationList.value.Demo[index].isSelected,
                      type: "DEMO",
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
