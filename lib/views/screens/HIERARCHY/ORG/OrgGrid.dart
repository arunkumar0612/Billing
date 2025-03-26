import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/services/Hierarchy_services/hierarchy_service.dart';
import 'package:ssipl_billing/views/components/Loading.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/ORG/Org_card.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:ssipl_billing/views/screens/HIERARCHY/ORG/OrgEditor.dart';

class OrganizationGrid extends StatefulWidget with HierarchyService {
  OrganizationGrid({super.key});

  @override
  _OrganizationGridState createState() => _OrganizationGridState();
}

class _OrganizationGridState extends State<OrganizationGrid> with SingleTickerProviderStateMixin {
  final HierarchyController hierarchyController = Get.find<HierarchyController>();
  final loader = LoadingOverlay();
  @override
  void initState() {
    super.initState();
    hierarchyController.hierarchyModel.Org_controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    hierarchyController.hierarchyModel.slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: hierarchyController.hierarchyModel.Org_controller,
      curve: Curves.easeInCubic,
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) hierarchyController.hierarchyModel.Org_controller.forward();
    });
  }

  @override
  void dispose() {
    hierarchyController.hierarchyModel.Org_controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                return Expanded(
                  child: SlideTransition(
                    position: hierarchyController.hierarchyModel.slideAnimation,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: hierarchyController.hierarchyModel.Org_cardCount.value,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                      ),
                      itemCount: hierarchyController.hierarchyModel.OrganizationList.value.Live.length,
                      itemBuilder: (context, index) {
                        var org = hierarchyController.hierarchyModel.OrganizationList.value.Live[index];
                        return OrganizationCard(
                          name: org.organizationName ?? "",
                          id: org.organizationId ?? 0,
                          email: org.email ?? "",
                          imageBytes: org.organizationLogo!,
                          index: index,
                          data: hierarchyController.hierarchyModel.OrganizationList.value,
                          controller: hierarchyController,
                          isSelected: hierarchyController.hierarchyModel.OrganizationList.value.Live[index].isSelected,
                          type: "LIVE",
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
                        crossAxisCount: hierarchyController.hierarchyModel.Org_cardCount.value,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                      ),
                      itemCount: hierarchyController.hierarchyModel.OrganizationList.value.Demo.length,
                      itemBuilder: (context, index) {
                        var org = hierarchyController.hierarchyModel.OrganizationList.value.Demo[index];
                        return OrganizationCard(
                          name: org.organizationName ?? "",
                          id: org.organizationId ?? 0,
                          email: org.email ?? "",
                          imageBytes: org.organizationLogo!,
                          index: index,
                          data: hierarchyController.hierarchyModel.OrganizationList.value,
                          controller: hierarchyController,
                          isSelected: hierarchyController.hierarchyModel.OrganizationList.value.Demo[index].isSelected,
                          type: "DEMO",
                        );
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        Obx(() {
          double screenWidth = MediaQuery.of(context).size.width;
          return hierarchyController.hierarchyModel.Org_DataPageView.value
              ? Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300), // Smooth animation duration
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        final Offset beginOffset = hierarchyController.hierarchyModel.Org_DataPageView.value
                            ? const Offset(1.0, 0.0) // Slide in from right
                            : const Offset(1.0, 0.0); // Slide in from left

                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: beginOffset,
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                      child: hierarchyController.hierarchyModel.Org_DataPageView.value
                          ? OrganizationEditor(
                              screenWidth: screenWidth,
                              data: hierarchyController.hierarchyModel.selectedOrgDetails,
                              controller: hierarchyController,
                            )
                          : const SizedBox.shrink(key: ValueKey(0)),
                    ),
                  ),
                )
              : const SizedBox.shrink();
        }),
      ],
    );
  }
}
