import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/manual_onboard_actions.dart';
import 'package:ssipl_billing/5_VENDOR/views/Manual_onboard/vendorBusinessInfo_tab.dart';
import 'package:ssipl_billing/5_VENDOR/views/Manual_onboard/vendorKYC_tab.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class ShowManualOnboard extends StatefulWidget {
  const ShowManualOnboard({super.key});
  @override
  _ShowManualOnboardState createState() => _ShowManualOnboardState();
}

class _ShowManualOnboardState extends State<ShowManualOnboard> with SingleTickerProviderStateMixin {
  final ManualOnboardController manualOnboardController = Get.find<ManualOnboardController>();
  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or controllers here
    manualOnboardController.initializeTabController(TabController(length: 3, vsync: this));
  }

  @override
  void dispose() {
    manualOnboardController.manualOnboardModel.tabController.value?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Primary_colors.Dark,
        body: Row(children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 4, 6, 10),
                    Primary_colors.Light,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    color: Primary_colors.Dark,
                    child: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: IgnorePointer(
                        child: TabBar(
                          unselectedLabelStyle: const TextStyle(
                            color: Primary_colors.Color1,
                            fontSize: Primary_font_size.Text7,
                          ),
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 227, 77, 60),
                            fontSize: Primary_font_size.Text10,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: manualOnboardController.manualOnboardModel.tabController.value,
                          indicator: const BoxDecoration(),
                          tabs: const [
                            Tab(text: "KYC"),
                            Tab(text: "BUSINESS INFO"),
                            // Tab(text: "NOTE"),
                            // Tab(text: "POST"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: manualOnboardController.manualOnboardModel.tabController.value,
                      children: [
                        VendorKYC(),
                        VendorBusinessInfo(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
