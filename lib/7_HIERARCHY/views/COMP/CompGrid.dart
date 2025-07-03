import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ssipl_billing/7_HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7_HIERARCHY/services/hierarchy_service.dart';
import 'package:ssipl_billing/7_HIERARCHY/views/COMP/CompEditor.dart';
import 'package:ssipl_billing/7_HIERARCHY/views/COMP/Comp_card.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class CompanyGrid extends StatefulWidget with HierarchyService {
  CompanyGrid({super.key});

  @override
  _CompanyGridState createState() => _CompanyGridState();
}

class _CompanyGridState extends State<CompanyGrid> with SingleTickerProviderStateMixin {
  final HierarchyController hierarchyController = Get.find<HierarchyController>();

  @override
  void initState() {
    super.initState();
    // hierarchyController.toggle_dataPageView(false);

    hierarchyController.hierarchyModel.Comp_controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    hierarchyController.hierarchyModel.slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: hierarchyController.hierarchyModel.Comp_controller,
      curve: Curves.easeInCubic,
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) hierarchyController.hierarchyModel.Comp_controller.forward();
    });
  }

  @override
  void dispose() {
    hierarchyController.hierarchyModel.Comp_controller.dispose();
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
                      title: const Text("LIVE", style: TextStyle(fontSize: 15, color: Primary_colors.Color1)),
                      initiallyExpanded: true,
                      children: [
                        hierarchyController.hierarchyModel.CompanyList.value.Live.isNotEmpty
                            ? SizedBox(
                                height: screenheight - 270,
                                child: SingleChildScrollView(
                                  child: SlideTransition(
                                    position: hierarchyController.hierarchyModel.slideAnimation,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(8.0),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: hierarchyController.hierarchyModel.Comp_cardCount.value,
                                        crossAxisSpacing: 30,
                                        mainAxisSpacing: 30,
                                      ),
                                      itemCount: hierarchyController.hierarchyModel.CompanyList.value.Live.length,
                                      itemBuilder: (context, index) {
                                        var Comp = hierarchyController.hierarchyModel.CompanyList.value.Live[index];
                                        return CompanyCard(
                                          name: Comp.customerName ?? "",
                                          id: Comp.customerId ?? 0,
                                          email: Comp.email ?? "",
                                          imageBytes: Comp.customerLogo ?? Uint8List(0),
                                          index: index,
                                          data: hierarchyController.hierarchyModel.CompanyList.value,
                                          controller: hierarchyController,
                                          isSelected: hierarchyController.hierarchyModel.CompanyList.value.Live[index].isSelected,
                                          type: "LIVE",
                                        );
                                      },
                                    ),
                                  ),
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
                                        'No Live Company Found',
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
                                        'When you add live company, they will appear here',
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
                const SizedBox(
                  height: 20,
                ),
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
                        hierarchyController.hierarchyModel.CompanyList.value.Demo.isNotEmpty
                            ? SlideTransition(
                                position: hierarchyController.hierarchyModel.slideAnimation,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8.0),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: hierarchyController.hierarchyModel.Comp_cardCount.value,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30,
                                  ),
                                  itemCount: hierarchyController.hierarchyModel.CompanyList.value.Demo.length,
                                  itemBuilder: (context, index) {
                                    var Comp = hierarchyController.hierarchyModel.CompanyList.value.Demo[index];
                                    return CompanyCard(
                                      name: Comp.customerName ?? "",
                                      id: Comp.customerId ?? 0,
                                      email: Comp.email ?? "",
                                      imageBytes: Comp.customerLogo ?? Uint8List(0),
                                      index: index,
                                      data: hierarchyController.hierarchyModel.CompanyList.value,
                                      controller: hierarchyController,
                                      isSelected: hierarchyController.hierarchyModel.CompanyList.value.Demo[index].isSelected,
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
                                        'No Demo Company Found',
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
                                        'When you add demo company, they will appear here',
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
              ],
            ),
          ),
        ),
        Obx(() {
          double screenWidth = MediaQuery.of(context).size.width;
          return hierarchyController.hierarchyModel.Comp_DataPageView.value
              ? Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300), // Smooth animation duration
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        final Offset beginOffset = hierarchyController.hierarchyModel.Comp_DataPageView.value
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
                      child: hierarchyController.hierarchyModel.Comp_DataPageView.value
                          ? CompanyEditor(
                              screenWidth: screenWidth,
                              data: hierarchyController.hierarchyModel.selectedCompDetails, controller: hierarchyController,
                              // data: hierarchyController.hierarchyModel.CompanizationList.value,
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
