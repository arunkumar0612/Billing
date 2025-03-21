import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/views/screens/BILLING/Billing.dart';
import 'package:ssipl_billing/views/screens/SALES/Sales.dart';
import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Subscription.dart';
import 'package:ssipl_billing/views/screens/DASHBOARD/dashboard.dart';
import 'package:ssipl_billing/views/screens/INVENTORY/inventory.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/screens/VENDOR/vendors.dart';

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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
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
                // decoration: const BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(30)),
                //   image: DecorationImage(
                //     image: AssetImage('assets/images/bottom.jpg'), // ✅ Your image here
                //     fit: BoxFit.fill, // Covers the entire background
                //   ),
                // ),
              ),
              // title: Container(
              //   height: 70,
              //   // color: Primary_colors.Color3,
              //   child: IconButton(
              //       onPressed: () {
              //         setState(() {
              //           showfull = showfull ? false : true;
              //         });
              //       },
              //       icon: Icon(Icons.abc)),
              // ),
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
                      // child: TextButton.icon(
                      //   onPressed: () {
                      //     setState(() {
                      //       showfull = showfull ? false : true;
                      //     });
                      //   },
                      //   label: Text(
                      //     showfull ? '' : 'Collapse',
                      //     style: const TextStyle(color: Primary_colors.Color1),
                      //   ),
                      //   icon: showfull
                      //       ? Image.asset(
                      //           width: 20,
                      //           'assets/images/unhide.png',
                      //           color: Primary_colors.Color1,
                      //         )
                      //       : Image.asset(width: 20, 'assets/images/hide.png'),
                      // ),

                      //  Row(
                      //   children: [
                      //     IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             showfull = showfull ? false : true;
                      //           });
                      //         },
                      //         icon: showfull
                      //             ? Image.asset(
                      //                 'assets/images/hide.png',
                      //                 color: Primary_colors.Color5,
                      //               )
                      //             : Image.asset('assets/images/unhide.png'))
                      //   ],
                      // ),
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
                  title: 'LOGOUT',
                  onTap: (index, _) {},
                  icon: const Icon(Icons.exit_to_app), // Inventory Icon
                ),
              ],
            ),
            const VerticalDivider(
              width: 5,
            ),
            GestureDetector(
              child: showfull
                  ? const Text('>', style: TextStyle(color: Color.fromARGB(255, 141, 140, 140), fontSize: 22))
                  : const Text('||', style: TextStyle(color: Color.fromARGB(255, 141, 140, 140), fontSize: 15)),
              onTap: () {
                setState(() {
                  showfull = showfull ? false : true;
                });
              },
            ),
            const VerticalDivider(
              width: 5,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  const Dashboard(),
                  const Billing(),
                  Subscription_Client(),
                  Sales_Client(),
                  const Vendor(),
                  const Inventory(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
