import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:ssipl_billing/7.HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7.HIERARCHY/services/hierarchy_service.dart';
import 'package:ssipl_billing/7.HIERARCHY/views/ORG/OrgEditor.dart';
import 'package:ssipl_billing/7.HIERARCHY/views/ORG/Org_card.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class OrganizationGrid extends StatefulWidget with HierarchyService {
  OrganizationGrid({super.key});

  @override
  _OrganizationGridState createState() => _OrganizationGridState();
}

class _OrganizationGridState extends State<OrganizationGrid> with SingleTickerProviderStateMixin {
  final HierarchyController hierarchyController = Get.find<HierarchyController>();
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
    double screenheight = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  return Container(
                    decoration: BoxDecoration(
                      color: Primary_colors.Light,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      collapsedIconColor: const Color.fromARGB(255, 135, 132, 132),
                      iconColor: Colors.red,
                      collapsedBackgroundColor: Primary_colors.Light,
                      backgroundColor: Primary_colors.Light,
                      title: const Text(
                        "LIVE",
                        style: TextStyle(fontSize: 15, color: Primary_colors.Color1),
                      ),
                      initiallyExpanded: true,
                      expansionAnimationStyle: AnimationStyle(duration: const Duration(milliseconds: 500)),
                      children: [
                        hierarchyController.hierarchyModel.OrganizationList.value.Live.isNotEmpty
                            ? SizedBox(
                                height: screenheight - 270,
                                child: SingleChildScrollView(
                                  child: SlideTransition(
                                    position: hierarchyController.hierarchyModel.slideAnimation,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
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
                                          isSelected: org.isSelected,
                                          type: "LIVE",
                                        );
                                      },
                                    ),
                                  ),
                                ))
                            : Center(
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Lottie.asset(
                                        'assets/animations/JSON/emptycustomerlist.json',
                                        // width: 264,
                                        height: 150,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 204),
                                      child: Text(
                                        'No Live Organization Found',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blueGrey[800],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 244, bottom: 40),
                                      child: Text(
                                        'When you add live organization, they will appear here',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueGrey[400],
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Obx(() {
                  return Container(
                    // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Primary_colors.Light,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      collapsedIconColor: const Color.fromARGB(255, 135, 132, 132),
                      iconColor: Colors.red,
                      collapsedBackgroundColor: Primary_colors.Light,
                      backgroundColor: Primary_colors.Light,
                      title: const Text("DEMO", style: TextStyle(fontSize: 15, color: Primary_colors.Color1)),
                      initiallyExpanded: false,
                      children: [
                        SingleChildScrollView(
                          child: hierarchyController.hierarchyModel.OrganizationList.value.Demo.isNotEmpty
                              ? SlideTransition(
                                  position: hierarchyController.hierarchyModel.slideAnimation,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
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
                                        isSelected: org.isSelected,
                                        type: "DEMO",
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 40),
                                        child: Lottie.asset(
                                          'assets/animations/JSON/emptycustomerlist.json',
                                          // width: 264,
                                          height: 150,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 204),
                                        child: Text(
                                          'No Demo Organization Found',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blueGrey[800],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 244, bottom: 40),
                                        child: Text(
                                          'When you add demo organization, they will appear here',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blueGrey[400],
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
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
