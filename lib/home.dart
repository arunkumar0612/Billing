import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/1.DASHBOARD/views/dashboard.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/views/Billing.dart' show Billing;
import 'package:ssipl_billing/3.SUBSCRIPTION/views/Subscription.dart';
import 'package:ssipl_billing/4.SALES/views/Sales.dart';
import 'package:ssipl_billing/5.VENDOR/views/vendors.dart';
import 'package:ssipl_billing/6.INVENTORY/views/inventory.dart';
import 'package:ssipl_billing/7.HIERARCHY/views/Hierarchy.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  bool showfull = true;
  @override
  void initState() {
    sideMenu.addListener(
      (index) {
        pageController.jumpToPage(index);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary_colors.Dark,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              // footer: const Padding(
              //   padding: EdgeInsets.all(25),
              //   child: Row(
              //     children: [
              //       Icon(Icons.exit_to_app),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Text(
              //         'LOGOUT',
              //         style: TextStyle(letterSpacing: 1, color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
              //       )
              //     ],
              //   ),
              // ),
              controller: sideMenu,
              style: SideMenuStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                showTooltip: true,
                openSideMenuWidth: 200,
                // compactSideMenuWidth: 50,
                displayMode: showfull ? SideMenuDisplayMode.compact : SideMenuDisplayMode.open,
                backgroundColor: Primary_colors.Light,
                showHamburger: false,
                selectedColor: Colors.transparent,
                selectedTitleTextStyle: const TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  color: Primary_colors.Color3,
                  fontSize: Primary_font_size.Text7, // Decrease font size for selected items
                ),
                selectedIconColor: Primary_colors.Color3,
                unselectedTitleTextStyle: const TextStyle(
                  letterSpacing: 1,
                  color: Primary_colors.Color1,
                  fontSize: Primary_font_size.Text7, // Decrease font size for unselected items
                ),
                unselectedIconColor: Primary_colors.Color1,
              ),

              title: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  color: Primary_colors.Color3,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Primary_colors.Color3,
                      constraints: const BoxConstraints(
                        maxHeight: 250,
                        maxWidth: 150,
                      ),
                      child: Image.asset(width: 20, 'assets/images/white.jpg'),
                    ),
                    const Divider(
                      color: Colors.transparent,
                      indent: 8.0,
                      endIndent: 8.0,
                    ),
                  ],
                ),
              ),
              items: [
                SideMenuItem(
                  title: 'DASHBOARD',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.dashboard), // Dashboard Icon
                ),
                SideMenuItem(
                  title: 'BILLING',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.receipt_long), // Billing Icon
                ),
                SideMenuItem(
                  title: 'SUBSCRIPTION',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.subscriptions), // Subscription Icon
                ),
                SideMenuItem(
                  title: 'SALES',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.bar_chart), // Sales Icon
                ),
                SideMenuItem(
                  title: 'VENDOR',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.storefront), // Vendor Icon
                ),
                SideMenuItem(
                  title: 'INVENTORY',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.inventory), // Inventory Icon
                ),
                SideMenuItem(
                  title: 'ENTERPRISE HIERARCHY',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.groups_3), // Inventory Icon
                ),
                SideMenuItem(
                  title: 'LOGOUT',
                  onTap: (index, _) {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('Are you sure you want to Logout?'),
                          actions: [
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Get.back();
                                // windowManager.destroy();
                              },
                            ),
                          ],
                        );
                      },
                    );

                    // Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.exit_to_app), // Inventory Icon
                ),
              ],
            ),
            const VerticalDivider(
              width: 5,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: showfull
                    ? const Text('>', style: TextStyle(color: Color.fromARGB(255, 141, 140, 140), fontSize: 22))
                    : const Text('||', style: TextStyle(color: Color.fromARGB(255, 141, 140, 140), fontSize: 15)),
                onTap: () {
                  setState(() {
                    showfull = showfull ? false : true;
                  });
                },
              ),
            ),
            const VerticalDivider(
              width: 5,
            ),
            Expanded(
              child: MaterialApp(
                title: 'ERP',
                // home: const IAM(),
                initialRoute: '/IAM', // Set the initial route
                // getPages: AppRoutes.routes,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  iconTheme: const IconThemeData(color: Colors.white),
                  primaryColor: Primary_colors.Color3,
                  useMaterial3: false,
                  textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: Primary_colors.Color3,
                    selectionColor: Color.fromARGB(255, 130, 223, 230),
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    trackColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 229, 204, 10),
                    ),
                    trackBorderColor: WidgetStateProperty.all(
                      Primary_colors.Color3,
                    ),
                    thumbColor: const WidgetStatePropertyAll(
                      Color.fromARGB(255, 90, 90, 90),
                    ),
                  ),
                  fontFamily: 'Poppins',
                ),
                home: PageView(
                  controller: pageController,
                  children: [
                    const Dashboard(),
                    Billing(),
                    Subscription_Client(),
                    Sales_Client(),
                    const Vendor(),
                    const Inventory(),
                    Enterprise_Hierarchy(),
                    Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
