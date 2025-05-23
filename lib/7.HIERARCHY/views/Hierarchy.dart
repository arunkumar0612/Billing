import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/7.HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7.HIERARCHY/services/hierarchy_service.dart';
import 'package:ssipl_billing/7.HIERARCHY/views/BRANCH/BranchGrid.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:ssipl_billing/7.HIERARCHY/views/COMP/CompGrid.dart';
import 'package:ssipl_billing/7.HIERARCHY/views/ORG/OrgGrid.dart';
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
                  const Row(
                    children: [
                      // GestureDetector(
                      //   onTap: _startAnimation,
                      //   child: AnimatedBuilder(
                      //     animation: salesController.salesModel.animationController,
                      //     builder: (context, child) {
                      //       return Transform.rotate(
                      //         angle: -salesController.salesModel.animationController.value * 2 * pi, // Counterclockwise rotation
                      //         child: Transform.scale(
                      //           scale: TweenSequence([
                      //             TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 50),
                      //             TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 50),
                      //           ]).animate(CurvedAnimation(parent: salesController.salesModel.animationController, curve: Curves.easeInOut)).value, // Zoom in and return to normal
                      //           child: Opacity(
                      //             opacity: TweenSequence([
                      //               TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.5), weight: 50),
                      //               TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.0), weight: 50),
                      //             ]).animate(CurvedAnimation(parent: salesController.salesModel.animationController, curve: Curves.easeInOut)).value, // Fade and return to normal
                      //             child: ClipOval(
                      //               child: Image.asset(
                      //                 'assets/images/reload.png',
                      //                 fit: BoxFit.cover,
                      //                 width: 30,
                      //                 height: 30,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // const SizedBox(width: 10),
                      // SizedBox(
                      //   width: 400,
                      //   height: 40,
                      //   child: Stack(
                      //     alignment: Alignment.centerLeft,
                      //     children: [
                      //       TextFormField(
                      //         // controller: TextEditingController(text: salesController.salesModel.searchQuery.value)
                      //         //   ..selection = TextSelection.fromPosition(
                      //         //     TextPosition(offset: salesController.salesModel.searchQuery.value.length),
                      //         //   ),
                      //         // onChanged: (value) => salesController.search(value), // ✅ Updates GetX state
                      //         style: const TextStyle(fontSize: 13, color: Colors.white),
                      //         decoration: const InputDecoration(
                      //           contentPadding: EdgeInsets.all(10),
                      //           filled: true,
                      //           focusedBorder: UnderlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(226, 89, 147, 255),
                      //             ),
                      //           ),
                      //           enabledBorder: UnderlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 104, 93, 255),
                      //             ),
                      //           ),
                      //           hintText: "", // Hide default hintText
                      //           border: UnderlineInputBorder(borderSide: BorderSide.none),
                      //           prefixIcon: Icon(
                      //             Icons.search,
                      //             color: Color.fromARGB(255, 151, 151, 151),
                      //           ),
                      //         ),
                      //       ),
                      //       // if (salesController.salesModel.searchQuery.value.isEmpty)
                      //       Positioned(
                      //         left: 40,
                      //         child: IgnorePointer(
                      //           child: AnimatedTextKit(
                      //             repeatForever: true,
                      //             animatedTexts: [
                      //               TypewriterAnimatedText(
                      //                 "Search from the list...",
                      //                 textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                      //                 speed: const Duration(milliseconds: 100),
                      //               ),
                      //               TypewriterAnimatedText(
                      //                 "Enter customer name...",
                      //                 textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                      //                 speed: const Duration(milliseconds: 100),
                      //               ),
                      //               TypewriterAnimatedText(
                      //                 "Find an invoice...",
                      //                 textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                      //                 speed: const Duration(milliseconds: 100),
                      //               ),
                      //               TypewriterAnimatedText(
                      //                 "Find a Quotation...",
                      //                 textStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 185, 183, 183), letterSpacing: 1),
                      //                 speed: const Duration(milliseconds: 100),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      SizedBox(
                        width: 10,
                      ),
                    ],
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
