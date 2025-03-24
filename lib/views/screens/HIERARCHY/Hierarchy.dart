import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/services/Hierarchy_services/hierarchy_service.dart';

import 'package:ssipl_billing/themes/style.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts
import 'package:ssipl_billing/views/screens/HIERARCHY/CompGrid.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/IndGrid.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/CompEditor.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/OrgEditor.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/OrgGid.dart'; // For advanced grid layouts

class Enterprise_Hierarchy extends StatefulWidget with HierarchyService {
  Enterprise_Hierarchy({super.key});

  @override
  State<Enterprise_Hierarchy> createState() => _Enterprise_HierarchyState();
}

class _Enterprise_HierarchyState extends State<Enterprise_Hierarchy> with SingleTickerProviderStateMixin {
  final HierarchyController hierarchyController = Get.find<HierarchyController>();
  // Original lists

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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: Primary_colors.Dark,
        body: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Primary_colors.Light,
                ),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_box, color: Colors.white),
                      tooltip: 'Add Product',
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.design_services, color: Colors.white),
                      tooltip: 'Add Service',
                      onPressed: () {},
                    ),
                  ],
                ),
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
                          Text(
                            '30 Products Available',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.blue[600],
                                fontSize: Primary_font_size.Text10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Search Bar
                          // _buildSearchField(
                          //   controller: _productSearchController,
                          //   hintText: 'Search products',
                          //   onChanged: (value) {
                          //     setState(() {
                          //       productSearchQuery = value;
                          //     });
                          //   },
                          // ),
                          // const SizedBox(height: 15),

                          // TabBar
                          const SizedBox(
                            width: 390,
                            child: TabBar(
                              indicatorColor: Primary_colors.Color5,
                              tabs: [
                                Tab(text: 'Organizations'),
                                Tab(text: 'Companies'),
                                Tab(text: 'Branches'),
                              ],
                            ),
                          ),

                          // TabBarView
                          Expanded(
                            child: TabBarView(
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

                    // Services Section
                    Obx(() {
                      double screenWidth = MediaQuery.of(context).size.width;
                      print("Screen Width: $screenWidth");

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300), // Smooth animation duration
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          final Offset beginOffset = hierarchyController.hierarchyModel.DataPageView.value
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
                        child: hierarchyController.hierarchyModel.DataPageView.value
                            ? OrganizationEditor(
                                screenWidth: screenWidth,
                              )
                            : const SizedBox.shrink(key: ValueKey(0)),
                      );
                    }),
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
