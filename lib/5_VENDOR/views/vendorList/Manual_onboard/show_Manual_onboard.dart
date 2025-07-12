import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/vendorList_actions.dart';
import 'package:ssipl_billing/5_VENDOR/views/vendorList/Manual_onboard/vendorBankDetails_tab.dart';
import 'package:ssipl_billing/5_VENDOR/views/vendorList/Manual_onboard/vendorBusinessInfo_tab.dart';
import 'package:ssipl_billing/5_VENDOR/views/vendorList/Manual_onboard/vendorKYC_tab.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class ShowManualOnboard extends StatefulWidget {
  const ShowManualOnboard({super.key});
  @override
  _ShowManualOnboardState createState() => _ShowManualOnboardState();
}

class _ShowManualOnboardState extends State<ShowManualOnboard> with SingleTickerProviderStateMixin {
  final VendorListController vendorListController = Get.find<VendorListController>();
  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or controllers here
    vendorListController.initializeTabController(TabController(length: 3, vsync: this));
  }

  @override
  void dispose() {
    vendorListController.vendorListModel.tabController.value?.dispose();
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
                          controller: vendorListController.vendorListModel.tabController.value,
                          indicator: const BoxDecoration(),
                          tabs: const [
                            Tab(text: "KYC"),
                            Tab(text: "BUSINESS INFO"),
                            Tab(text: "BANK DETAILS & UPLOADS"),
                            // Tab(text: "POST"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: vendorListController.vendorListModel.tabController.value,
                      children: [
                        VendorKYC(),
                        VendorBusinessInfo(),
                        Vendorbankdetails(),
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
