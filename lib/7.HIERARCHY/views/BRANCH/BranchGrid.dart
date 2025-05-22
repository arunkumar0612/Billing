// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/7.HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7.HIERARCHY/services/hierarchy_service.dart';
import 'package:ssipl_billing/7.HIERARCHY/views/BRANCH/BranchEditor.dart';
import 'package:ssipl_billing/7.HIERARCHY/views/BRANCH/Branchcard.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class BranchGrid extends StatefulWidget with HierarchyService {
  BranchGrid({super.key});

  @override
  _BranchGridState createState() => _BranchGridState();
}

class _BranchGridState extends State<BranchGrid> with SingleTickerProviderStateMixin {
  final HierarchyController hierarchyController = Get.find<HierarchyController>();

  @override
  void initState() {
    super.initState();
    hierarchyController.hierarchyModel.Branch_controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    hierarchyController.hierarchyModel.slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: hierarchyController.hierarchyModel.Branch_controller,
      curve: Curves.easeInCubic,
    ));
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) hierarchyController.hierarchyModel.Branch_controller.forward();
    });
  }

  @override
  void dispose() {
    hierarchyController.hierarchyModel.Branch_controller.dispose();
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
                Obx(
                  () {
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
                          SizedBox(
                            height: screenheight - 270,
                            child: SingleChildScrollView(
                              child: SlideTransition(
                                position: hierarchyController.hierarchyModel.slideAnimation,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8.0),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: hierarchyController.hierarchyModel.Branch_cardCount.value,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30,
                                  ),
                                  itemCount: hierarchyController.hierarchyModel.BranchList.value.Live.length,
                                  itemBuilder: (context, index) {
                                    var Branch = hierarchyController.hierarchyModel.BranchList.value.Live[index];
                                    return BranchCard(
                                      name: Branch.branchName ?? '',
                                      id: Branch.branchId ?? 0,
                                      email: Branch.emailId ?? '',
                                      imageBytes: Branch.branchLogo!,
                                      index: index,
                                      data: hierarchyController.hierarchyModel.BranchList.value,
                                      controller: hierarchyController,
                                      isSelected: hierarchyController.hierarchyModel.BranchList.value.Live[index].isSelected,
                                      type: "LIVE",
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
                        SingleChildScrollView(
                          child: SlideTransition(
                            position: hierarchyController.hierarchyModel.slideAnimation,
                            child: GridView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8.0),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: hierarchyController.hierarchyModel.Branch_cardCount.value,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 30,
                              ),
                              itemCount: hierarchyController.hierarchyModel.BranchList.value.Demo.length,
                              itemBuilder: (context, index) {
                                var Branch = hierarchyController.hierarchyModel.BranchList.value.Demo[index];
                                return BranchCard(
                                  name: Branch.branchName ?? '',
                                  id: Branch.branchId ?? 0,
                                  email: Branch.emailId ?? '',
                                  imageBytes: Branch.branchLogo!,
                                  index: index,
                                  data: hierarchyController.hierarchyModel.BranchList.value,
                                  controller: hierarchyController,
                                  isSelected: hierarchyController.hierarchyModel.BranchList.value.Demo[index].isSelected,
                                  type: "DEMO",
                                );
                              },
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
          return hierarchyController.hierarchyModel.Branch_DataPageView.value
              ? Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300), // Smooth animation duration
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        final Offset beginOffset = hierarchyController.hierarchyModel.Branch_DataPageView.value
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
                      child: hierarchyController.hierarchyModel.Branch_DataPageView.value
                          ? BranchEditor(
                              screenWidth: screenWidth,
                              data: hierarchyController.hierarchyModel.selectedBranchDetails,
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
