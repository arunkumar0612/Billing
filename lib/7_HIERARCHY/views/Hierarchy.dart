import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/7_HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7_HIERARCHY/services/hierarchy_service.dart';
import 'package:ssipl_billing/7_HIERARCHY/views/BRANCH/BranchGrid.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:ssipl_billing/7_HIERARCHY/views/COMP/CompGrid.dart';
import 'package:ssipl_billing/7_HIERARCHY/views/ORG/OrgGrid.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class Enterprise_Hierarchy extends StatefulWidget with HierarchyService {
  Enterprise_Hierarchy({super.key});

  @override
  State<Enterprise_Hierarchy> createState() => _Enterprise_HierarchyState();
}

class _Enterprise_HierarchyState extends State<Enterprise_Hierarchy> with SingleTickerProviderStateMixin {
  final HierarchyController hierarchyController = Get.find<HierarchyController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.get_OrganizationList(context);
      widget.get_CompanyList(context);
      widget.get_BranchList(context);
    });
  }

  @override
  void initState() {
    super.initState();
    hierarchyController.reset_OrgComp();
    hierarchyController.hierarchyModel.initTabController(this, 3);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Primary_colors.Dark,
        body: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Primary_colors.Color3, Primary_colors.Color4], // Example gradient
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: const Icon(
                          Icons.groups_3,
                          size: 25.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Enterprise Hierarchy',
                        style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text13),
                      ),
                    ],
                  ),
                  Obx(
                    () => SizedBox(
                      width: 400,
                      height: 40,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          TextFormField(
                            controller: TextEditingController(text: hierarchyController.hierarchyModel.searchQuery.value)
                              ..selection = TextSelection.fromPosition(
                                TextPosition(offset: hierarchyController.hierarchyModel.searchQuery.value.length),
                              ),
                            onChanged: (value) => hierarchyController.search(value), // ✅ Updates GetX state
                            style: const TextStyle(fontSize: 13, color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(226, 89, 147, 255)),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 104, 93, 255)),
                              ),
                              hintText: "", // Hide default hintText
                              border: UnderlineInputBorder(borderSide: BorderSide.none),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color.fromARGB(255, 151, 151, 151),
                              ),
                            ),
                          ),
                          if (hierarchyController.hierarchyModel.searchQuery.value.isEmpty)
                            Positioned(
                              left: 40,
                              child: IgnorePointer(
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      "Search from the Live...",
                                      textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                    TypewriterAnimatedText(
                                      "Search from the Demo...",
                                      textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                    // TypewriterAnimatedText(
                                    //   "Find an invoice...",
                                    //   textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                    //   speed: const Duration(milliseconds: 100),
                                    // ),
                                    // TypewriterAnimatedText(
                                    //   "Find a Quotation...",
                                    //   textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                                    //   speed: const Duration(milliseconds: 100),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  children: [
                    // Products Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section Title

                          Row(
                            children: [
                              SizedBox(
                                width: 390,
                                child: TabBar(
                                  controller: hierarchyController.hierarchyModel.tabController,
                                  indicatorColor: Primary_colors.Color5,
                                  tabs: const [
                                    Tab(text: 'Organizations'),
                                    Tab(text: 'Companies'),
                                    Tab(text: 'Branches'),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 100),
                              // Obx(() {
                              //   return hierarchyController.hierarchyModel.selectedtab.value != 0
                              //       ? ConstrainedBox(
                              //           constraints: const BoxConstraints(maxWidth: 200, maxHeight: 75),
                              //           child: DropdownButtonFormField<String>(
                              //             menuMaxHeight: 350,
                              //             isExpanded: true,
                              //             dropdownColor: Primary_colors.Color1,
                              //             decoration: const InputDecoration(
                              //                 label: Text(
                              //                   'Select Organization Name',
                              //                   style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 0, 0, 0)),
                              //                 ),
                              //                 // hintText: 'Customer Type',hintStyle: TextStyle(),
                              //                 contentPadding: EdgeInsets.all(13),
                              //                 labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                              //                 filled: true,
                              //                 fillColor: Color.fromARGB(255, 164, 110, 250),
                              //                 border: OutlineInputBorder(
                              //                   borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                              //                 ),
                              //                 enabledBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                              //                 ),
                              //                 focusedBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(),
                              //                 ),
                              //                 prefixIcon: Icon(
                              //                   Icons.business,
                              //                   color: Colors.black,
                              //                 )),
                              //             value: hierarchyController.hierarchyModel.Org_Controller.value == "" ? null : hierarchyController.hierarchyModel.Org_Controller.value,
                              //             items: [
                              //               ...hierarchyController.hierarchyModel.OrganizationList.value.Live,
                              //               ...hierarchyController.hierarchyModel.OrganizationList.value.Demo,
                              //             ].map((organization) {
                              //               return DropdownMenuItem<String>(
                              //                 value: organization.organizationName,
                              //                 child: Text(
                              //                   organization.organizationName ?? "Unknown",
                              //                   style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 0, 0, 0), overflow: TextOverflow.ellipsis),
                              //                 ),
                              //               );
                              //             }).toList(),
                              //             onChanged: (String? newValue) {
                              //               WidgetsBinding.instance.addPostFrameCallback((_) {
                              //                 hierarchyController.updateOrgName(newValue!);
                              //                 hierarchyController.on_Orgselected();
                              //               });
                              //             },
                              //             validator: (value) {
                              //               return null;

                              //               // if ( hierarchyController.hierarchyModel.Company_Controller.value == "" ||  hierarchyController.hierarchyModel.Company_Controller.value == null) {
                              //               //   if (value == null || value.isEmpty) {
                              //               //     return 'Please Select customer type';
                              //               //   }
                              //               //   return null;
                              //               // }
                              //               // return null;
                              //             },
                              //           ),
                              //         )
                              //       : SizedBox.shrink();
                              // }),
                              // const SizedBox(width: 50),
                              // Obx(() {
                              //   return hierarchyController.hierarchyModel.selectedtab.value != 0 && hierarchyController.hierarchyModel.selectedtab.value != 1
                              //       ? ConstrainedBox(
                              //           constraints: const BoxConstraints(maxWidth: 200, maxHeight: 75),
                              //           child: DropdownButtonFormField<String>(
                              //             menuMaxHeight: 350,
                              //             isExpanded: true,
                              //             dropdownColor: Primary_colors.Color1,
                              //             decoration: InputDecoration(
                              //                 label: const Text(
                              //                   'Select Company Name',
                              //                   style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 0, 0, 0)),
                              //                 ),
                              //                 // hintText: 'Customer Type',hintStyle: TextStyle(),
                              //                 contentPadding: const EdgeInsets.all(13),
                              //                 labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                              //                 filled: true,
                              //                 fillColor: const Color.fromARGB(255, 250, 110, 180),
                              //                 border: OutlineInputBorder(
                              //                   borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                              //                 ),
                              //                 enabledBorder: const OutlineInputBorder(
                              //                   borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                              //                 ),
                              //                 focusedBorder: const OutlineInputBorder(
                              //                   borderSide: BorderSide(),
                              //                 ),
                              //                 prefixIcon: const Icon(
                              //                   Icons.business,
                              //                   color: Colors.black,
                              //                 )),
                              //             value: hierarchyController.hierarchyModel.Comp_Controller.value == "" ? null : hierarchyController.hierarchyModel.Comp_Controller.value,
                              //             items: [
                              //               ...hierarchyController.hierarchyModel.CompanyList.value.Live,
                              //               ...hierarchyController.hierarchyModel.CompanyList.value.Demo,
                              //             ].map((organization) {
                              //               return DropdownMenuItem<String>(
                              //                 value: organization.customerName,
                              //                 child: Text(
                              //                   organization.customerName ?? "Unknown",
                              //                   style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 0, 0, 0), overflow: TextOverflow.ellipsis),
                              //                 ),
                              //               );
                              //             }).toList(),
                              //             onChanged: (String? newValue) {
                              //               WidgetsBinding.instance.addPostFrameCallback((_) {
                              //                 hierarchyController.updateCompName(newValue!);
                              //                 // widget.on_Orgselected(context, newValue);
                              //               });
                              //             },
                              //             validator: (value) {
                              //               return null;

                              //               // if ( hierarchyController.hierarchyModel.Company_Controller.value == "" ||  hierarchyController.hierarchyModel.Company_Controller.value == null) {
                              //               //   if (value == null || value.isEmpty) {
                              //               //     return 'Please Select customer type';
                              //               //   }
                              //               //   return null;
                              //               // }
                              //               // return null;
                              //             },
                              //           ),
                              //         )
                              //       : SizedBox.shrink();
                              // }),
                            ],
                          ),

                          const SizedBox(height: 10),
                          // TabBarView
                          Expanded(
                            child: TabBarView(
                              controller: hierarchyController.hierarchyModel.tabController,
                              children: [
                                OrganizationGrid(),
                                CompanyGrid(),
                                BranchGrid(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
