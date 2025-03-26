import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/services/Hierarchy_services/hierarchy_service.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/COMP/CompGrid.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/BRANCH/BranchGrid.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/ORG/OrgGrid.dart';

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
