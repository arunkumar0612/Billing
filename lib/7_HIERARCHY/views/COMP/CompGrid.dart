import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ssipl_billing/7_HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7_HIERARCHY/models/entities/Hierarchy_entities.dart';
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
    hierarchyController.reset_OrgComp();
    // hierarchyController.toggle_dataPageView(false);

    hierarchyController.hierarchyModel.Comp_Animecontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    hierarchyController.hierarchyModel.slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: hierarchyController.hierarchyModel.Comp_Animecontroller,
      curve: Curves.easeInCubic,
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) hierarchyController.hierarchyModel.Comp_Animecontroller.forward();
    });
  }

  @override
  void dispose() {
    hierarchyController.reset_OrgComp();
    hierarchyController.hierarchyModel.Comp_Animecontroller.dispose();
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
                Row(
                  children: [
                    // Obx(() {
                    //   return
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200, maxHeight: 75),
                      child: DropdownButtonFormField<String>(
                        menuMaxHeight: 350,
                        isExpanded: true,
                        dropdownColor: Primary_colors.Color1,
                        decoration: const InputDecoration(
                            label: Text(
                              'Select Organization',
                              style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            // hintText: 'Customer Type',hintStyle: TextStyle(),
                            contentPadding: EdgeInsets.all(13),
                            labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                            filled: true,
                            fillColor: Color.fromARGB(255, 164, 110, 250),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            prefixIcon: Icon(
                              Icons.business,
                              color: Colors.black,
                            )),
                        value: hierarchyController.hierarchyModel.Org_Controller.value == "" ? null : hierarchyController.hierarchyModel.Org_Controller.value,
                        items: [
                          OrganizationsData(organizationName: 'All', organizationId: null),
                          ...hierarchyController.hierarchyModel.OrganizationList.value.Live,
                          ...hierarchyController.hierarchyModel.OrganizationList.value.Demo,
                        ].map((organization) {
                          return DropdownMenuItem<String>(
                            value: organization.organizationName,
                            child: Text(
                              organization.organizationName ?? "Unknown",
                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 0, 0, 0), overflow: TextOverflow.ellipsis),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            // Merge Live and Demo lists
                            final allOrganizations = [
                              OrganizationsData(organizationName: 'All', organizationId: null),
                              ...hierarchyController.hierarchyModel.OrganizationList.value.Live,
                              ...hierarchyController.hierarchyModel.OrganizationList.value.Demo,
                            ];

                            // Find the selected organization by its name
                            final selectedOrg = allOrganizations.firstWhere(
                              (org) => org.organizationName == newValue,
                            );

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              hierarchyController.updateOrgName(newValue);
                              hierarchyController.updateOrdID(selectedOrg.organizationId); // ✅ Pass the ID
                              hierarchyController.on_Orgselected();
                              widget.get_CompanyList(context);
                            });
                          }
                        },
                        validator: (value) {
                          return null;

                          // if ( hierarchyController.hierarchyModel.Company_Controller.value == "" ||  hierarchyController.hierarchyModel.Company_Controller.value == null) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please Select customer type';
                          //   }
                          //   return null;
                          // }
                          // return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                      initiallyExpanded: false,
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
