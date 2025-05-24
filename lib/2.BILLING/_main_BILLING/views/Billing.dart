import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ViewLedger.dart';
import 'package:ssipl_billing/2.BILLING/Vouchers/views/voucher.dart';
// import 'package:ssipl_billing/2.BILLING/views/VOUCHERS/voucher.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/models/entities/Billing_entities.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/services/billing_services.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/views/filter.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/views/piechart.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

import '../../../THEMES/style.dart';

PageRouteBuilder _createCustomPageRoute(Widget Function() navigation) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => navigation(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class Billing extends StatefulWidget with main_BillingService {
  Billing({super.key});

  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> with TickerProviderStateMixin {
  final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mainBilling_Controller.billingModel.animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    mainBilling_Controller.billingModel.animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    widget.get_SubscriptionInvoiceList();
    widget.get_SalesInvoiceList();
  }

  void _startAnimation() {
    if (!mainBilling_Controller.billingModel.animationController.isAnimating) {
      mainBilling_Controller.billingModel.animationController.forward(from: 0).then((_) {
        widget.billing_refresh();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              endDrawer: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      width: 350,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(width: 350, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Dark), child: FilterScreen()),
                  ),
                ],
              ),
              backgroundColor: Primary_colors.Dark,
              body: Center(
                child: Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 235,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              // gradient: const LinearGradient(
                                              //   colors: [Primary_colors.Light, Color.fromARGB(255, 40, 39, 59), Primary_colors.Light],
                                              //   begin: Alignment.topLeft,
                                              //   end: Alignment.bottomRight,
                                              // ),
                                              // boxShadow: const [
                                              //   BoxShadow(
                                              //     color: Colors.black12,
                                              //     offset: Offset(0, 10),
                                              //     blurRadius: 20,
                                              //   ),
                                              // ],
                                              color: Primary_colors.Light),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // const Text(
                                                //   'Overview',
                                                //   style: TextStyle(color: Primary_colors.Color1, fontSize: 20),
                                                // ),
                                                // const SizedBox(
                                                //   height: 10,
                                                // ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(16),
                                                      // gradient: const LinearGradient(
                                                      //   colors: [Primary_colors.Light, Color.fromARGB(255, 40, 39, 59), Primary_colors.Light],
                                                      //   begin: Alignment.topLeft,
                                                      //   end: Alignment.bottomRight,
                                                      // ),
                                                      // boxShadow: const [
                                                      //   BoxShadow(
                                                      //     color: Colors.black12,
                                                      //     offset: Offset(0, 10),
                                                      //     blurRadius: 20,
                                                      //   ),
                                                      // ],
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(16),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text(
                                                                'TOTAL',
                                                                style: TextStyle(
                                                                  color: Color.fromARGB(255, 186, 185, 185),
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                              const Text(
                                                                "\$17,6232",
                                                                style: TextStyle(
                                                                  color: Primary_colors.Color1,
                                                                  fontSize: 28,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: const Color.fromARGB(255, 202, 227, 253),
                                                                ),
                                                                child: const Padding(
                                                                  padding: EdgeInsets.all(4),
                                                                  child: Text(
                                                                    '210 invoices',
                                                                    style: TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 15, 139, 234)),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text(
                                                                'PAID',
                                                                style: TextStyle(
                                                                  color: Color.fromARGB(255, 186, 185, 185),
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                              const Text(
                                                                "\$18,6232",
                                                                style: TextStyle(
                                                                  color: Primary_colors.Color1,
                                                                  fontSize: 28,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: const Color.fromARGB(255, 202, 253, 223),
                                                                ),
                                                                child: const Padding(
                                                                  padding: EdgeInsets.all(4),
                                                                  child: Text(
                                                                    '210 invoices',
                                                                    style: TextStyle(fontSize: Primary_font_size.Text5, color: Colors.green),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text(
                                                                'UNPAID',
                                                                style: TextStyle(
                                                                  color: Color.fromARGB(255, 186, 185, 185),
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                              const Text(
                                                                "\$6,232",
                                                                style: TextStyle(
                                                                  color: Primary_colors.Color1,
                                                                  fontSize: 28,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: const Color.fromARGB(255, 253, 206, 202),
                                                                ),
                                                                child: const Padding(
                                                                  padding: EdgeInsets.all(4),
                                                                  child: Text(
                                                                    '110 invoices',
                                                                    style: TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 234, 29, 15)),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      // Column(
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   children: [
                                      //     Container(
                                      //       height: 180,
                                      //       width: 2,
                                      //       color: const Color.fromARGB(255, 111, 110, 110),
                                      //     ),
                                      //   ],
                                      // ),
                                      // const SizedBox(
                                      //   width: 10,
                                      // ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              // gradient: const LinearGradient(
                                              //   colors: [
                                              //     Primary_colors.Light,
                                              //     Color.fromARGB(255, 40, 39, 59),
                                              //     Primary_colors.Light,
                                              //   ],
                                              //   begin: Alignment.topLeft,
                                              //   end: Alignment.bottomRight,
                                              // ),
                                              // boxShadow: const [
                                              //   BoxShadow(
                                              //     color: Colors.black26,
                                              //     offset: Offset(0, 6),
                                              //     blurRadius: 12,
                                              //   ),
                                              // ],
                                              color: Primary_colors.Light),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                // First row of icons and labels
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: _buildIconWithLabel(
                                                        image: 'assets/images/ledger.png',
                                                        label: 'View Ledger',
                                                        color: Primary_colors.Color4,
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                            _createCustomPageRoute(
                                                              () => ViewLedger(),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: _buildIconWithLabel(image: 'assets/images/transaction.png', label: 'View Transaction', color: Primary_colors.Color5, onPressed: () {}),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 20),
                                                // Second row of icons and labels
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: _buildIconWithLabel(
                                                        image: 'assets/images/voucher.png',
                                                        label: 'Voucher',
                                                        color: Primary_colors.Color6,
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                            _createCustomPageRoute(() => Voucher()),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: _buildIconWithLabel(image: 'assets/images/balancesheet.png', label: 'Balance Sheet', color: Primary_colors.Color8, onPressed: () {}),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // Reusable function to build icon with label for consistency
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      children: [
                                        // const Text(
                                        //   'Invoice status',
                                        //   style: TextStyle(color: Primary_colors.Color1, fontSize: 20),
                                        // ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Primary_colors.Light
                                                // gradient: const LinearGradient(
                                                //   colors: [Primary_colors.Light, Color.fromARGB(255, 40, 39, 59), Primary_colors.Light],
                                                //   begin: Alignment.topLeft,
                                                //   end: Alignment.bottomRight,
                                                // ),
                                                // boxShadow: const [
                                                //   BoxShadow(
                                                //     color: Colors.black12,
                                                //     offset: Offset(0, 10),
                                                //     blurRadius: 20,
                                                //   ),
                                                // ],
                                                ),
                                            child: const Padding(padding: EdgeInsets.all(16), child: Pie_chart()),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              SizedBox(
                                width: 380,
                                height: 40,
                                child: TabBar(
                                  indicatorColor: Primary_colors.Color5,
                                  onTap: (index) {
                                    if (index == 0) mainBilling_Controller.setActiveTab('Subscription');
                                    if (index == 1) mainBilling_Controller.setActiveTab('Sales');
                                    if (index == 2) mainBilling_Controller.setActiveTab('Vendor');
                                  },
                                  tabs: const [
                                    Text('Subscription'),
                                    Text('Sales'),
                                    Text('Vendor'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: _startAnimation,
                                        child: AnimatedBuilder(
                                          animation: mainBilling_Controller.billingModel.animationController,
                                          builder: (context, child) {
                                            return Transform.rotate(
                                              angle: -mainBilling_Controller.billingModel.animationController.value * 2 * pi, // Counterclockwise rotation
                                              child: Transform.scale(
                                                scale: TweenSequence([
                                                  TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 50),
                                                  TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 50),
                                                ])
                                                    .animate(CurvedAnimation(parent: mainBilling_Controller.billingModel.animationController, curve: Curves.easeInOut))
                                                    .value, // Zoom in and return to normal
                                                child: Opacity(
                                                  opacity: TweenSequence([
                                                    TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.5), weight: 50),
                                                    TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.0), weight: 50),
                                                  ])
                                                      .animate(CurvedAnimation(parent: mainBilling_Controller.billingModel.animationController, curve: Curves.easeInOut))
                                                      .value, // Fade and return to normal
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      'assets/images/reload.png',
                                                      fit: BoxFit.cover,
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Obx(
                                      () => SizedBox(
                                        width: max(screenWidth - 1480, 200),
                                        height: 40,
                                        child: TextFormField(
                                          controller: TextEditingController(text: mainBilling_Controller.billingModel.searchQuery.value)
                                            ..selection = TextSelection.fromPosition(
                                              TextPosition(offset: mainBilling_Controller.billingModel.searchQuery.value.length),
                                            ),
                                          onChanged: mainBilling_Controller.search,
                                          style: const TextStyle(fontSize: 13, color: Colors.white),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.all(1),
                                            filled: true,
                                            fillColor: Primary_colors.Light,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            hintStyle: const TextStyle(
                                              fontSize: Primary_font_size.Text7,
                                              color: Color.fromARGB(255, 167, 165, 165),
                                            ),
                                            hintText: 'Search customer',
                                            prefixIcon: const Icon(
                                              Icons.search,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // SizedBox(
                                    //   width: 300,
                                    //   height: 40,
                                    //   child: DropdownButtonFormField<String>(
                                    //     style: const TextStyle(fontSize: 13, color: Colors.white),
                                    //     decoration: InputDecoration(
                                    //         contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Adjust padding to center the hint
                                    //         filled: true,
                                    //         fillColor: Primary_colors.Light,
                                    //         focusedBorder: OutlineInputBorder(
                                    //           borderRadius: BorderRadius.circular(30),
                                    //           borderSide: const BorderSide(color: Colors.transparent),
                                    //         ),
                                    //         enabledBorder: OutlineInputBorder(
                                    //           borderRadius: BorderRadius.circular(30),
                                    //           borderSide: const BorderSide(color: Colors.transparent),
                                    //         ),
                                    //         // hintStyle: const TextStyle(
                                    //         //   fontSize: Primary_font_size.Text7,
                                    //         //   color: Color.fromARGB(255, 167, 165, 165),
                                    //         // ),
                                    //         // hintText: 'Select customer',
                                    //         // alignLabelWithHint: true, // Helps to align hint text
                                    //         label: const Text(
                                    //           'Select type',
                                    //           style: TextStyle(color: Color.fromARGB(255, 162, 162, 162), fontSize: Primary_font_size.Text7),
                                    //         )),
                                    //     dropdownColor: Primary_colors.Dark,
                                    //     value: Selected_billingtype, // Bind your selected value here
                                    //     onChanged: (String? newValue) {
                                    //       setState(() {
                                    //         Selected_billingtype = newValue; // Update the selected value
                                    //       });
                                    //     },
                                    //     items: billing_type.map<DropdownMenuItem<String>>((String customer) {
                                    //       return DropdownMenuItem<String>(
                                    //         value: customer,
                                    //         child: Text(customer),
                                    //       );
                                    //     }).toList(),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   width: 10,
                                    // ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          Scaffold.of(context).openEndDrawer();
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.filter_alt_outlined,
                                        color: Primary_colors.Color1,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Primary_colors.Color3, Primary_colors.Color3], // Example gradient colors
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10), // Ensure border radius for smooth corners
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: mainBilling_Controller.billingModel.activeTab.value == 'Subscription'
                                            ? SubscriptionHeaders()
                                            : mainBilling_Controller.billingModel.activeTab.value == 'Sales'
                                                ? SalesHeaders()
                                                : SubscriptionHeaders()),
                                  ),
                                  const SizedBox(height: 5),
                                  Expanded(
                                    child: TabBarView(
                                      children: [Subscription(), Sales(), Vendor()],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            )));
  }

  Widget SubscriptionHeaders() {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Date',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Invoice No',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Voucher No',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            textAlign: TextAlign.center,
            'Client Name',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Text(
            'Type',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Package',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Amount',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Duedate',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Overdue',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Status',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        )
      ],
    );
  }

  Widget SalesHeaders() {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Date',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Invoice No',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Voucher No',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            textAlign: TextAlign.center,
            'Client Name',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            'Amount',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Status',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '',
            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
          ),
        )
      ],
    );
  }

  Widget _buildIconWithLabel({
    required String image,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300), // Animation duration
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Container(
              key: ValueKey(image), // ✅ Key ensures animation on image change
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(0),
              child: ClipOval(
                child: Image.asset(
                  image,
                  key: ValueKey(image), // ✅ Key applied to image
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              letterSpacing: 1,
              fontSize: Primary_font_size.Text5,
              color: Primary_colors.Color1,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget Subscription() {
    return Obx(
      () {
        return mainBilling_Controller.billingModel.subscriptionInvoiceList.isEmpty
            ? Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Lottie.asset(
                        'assets/animations/JSON/emptyprocesslist.json',
                        height: 150,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 164),
                      child: Text(
                        'No invoices found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 204),
                      child: Text(
                        'When an invoice is created, it will appear here.',
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
              )
            : ListView.separated(
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: const Color.fromARGB(94, 125, 125, 125),
                ),
                itemCount: mainBilling_Controller.billingModel.subscriptionInvoiceList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Primary_colors.Light,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  formatDate(mainBilling_Controller.billingModel.subscriptionInvoiceList[index].date),
                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      bool success = await widget.GetSubscriptionPDFfile(context: context, invoiceNo: mainBilling_Controller.billingModel.subscriptionInvoiceList[index].invoiceNo);
                                      if (success) {
                                        widget.showPDF(context, mainBilling_Controller.billingModel.subscriptionInvoiceList[index].invoiceNo);
                                      }
                                    },
                                    child: Text(
                                      mainBilling_Controller.billingModel.subscriptionInvoiceList[index].invoiceNo,
                                      style: const TextStyle(color: Colors.blue, fontSize: Primary_font_size.Text7),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  mainBilling_Controller.billingModel.subscriptionInvoiceList[index].voucher_number,
                                  style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          // ignore: deprecated_member_use
                                          color: Primary_colors.Color5.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/black.jpg',
                                            fit: BoxFit.cover, // Ensures the image covers the container
                                            width: double.infinity, // Makes the image fill the container's width
                                            height: double.infinity, // Makes the image fill the container's height
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          softWrap: true,
                                          maxLines: 4,
                                          // overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Primary_colors.Color1,
                                            fontSize: Primary_font_size.Text7,
                                          ),
                                          textAlign: TextAlign.start,
                                          mainBilling_Controller.billingModel.subscriptionInvoiceList[index].clientAddressName,
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(width: 10),

                              // Expanded(
                              //   flex: 2,
                              //   child: Text(
                              //     mainBilling_Controller.billingModel.subscriptionInvoiceList[index].subs,
                              //     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  mainBilling_Controller.billingModel.subscriptionInvoiceList[index].planType,
                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  mainBilling_Controller.billingModel.subscriptionInvoiceList[index].planName,
                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  // textAlign: TextAlign.left,
                                  mainBilling_Controller.billingModel.subscriptionInvoiceList[index].totalAmount.toString(),
                                  style: const TextStyle(
                                    color: Primary_colors.Color1,
                                    fontSize: Primary_font_size.Text7,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Builder(
                                  builder: (context) {
                                    OverlayEntry? overlayEntry;

                                    void showPopup() {
                                      if (overlayEntry != null) return;

                                      final RenderBox renderBox = context.findRenderObject() as RenderBox;
                                      final Offset offset = renderBox.localToGlobal(Offset.zero);
                                      final Size size = renderBox.size;

                                      double top;
                                      double left = offset.dx - 80;

                                      if (offset.dy > 320) {
                                        top = offset.dy - 320;
                                      } else {
                                        top = offset.dy + size.height + 5;
                                      }

                                      final overdueList = mainBilling_Controller.billingModel.subscriptionInvoiceList[index].overdueHistory;

                                      overlayEntry = OverlayEntry(
                                        builder: (_) => Positioned(
                                          left: left,
                                          top: top,
                                          child: TweenAnimationBuilder(
                                            duration: const Duration(milliseconds: 200),
                                            tween: Tween<double>(begin: 0.9, end: 1.0),
                                            builder: (_, double scale, __) => Transform.scale(
                                              scale: scale,
                                              child: MouseRegion(
                                                onExit: (_) {
                                                  overlayEntry?.remove();
                                                  overlayEntry = null;
                                                },
                                                child: Material(
                                                  elevation: 8,
                                                  borderRadius: BorderRadius.circular(16),
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    width: 340,
                                                    padding: const EdgeInsets.all(16),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(16),
                                                      gradient: LinearGradient(
                                                        colors: [Colors.white, Colors.grey[50]!],
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.1),
                                                          blurRadius: 20,
                                                          spreadRadius: 2,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const CircleAvatar(
                                                              radius: 16,
                                                              backgroundColor: Colors.blue,
                                                              child: Icon(Icons.timeline, color: Colors.white, size: 20),
                                                            ),
                                                            const SizedBox(width: 8),
                                                            const Text(
                                                              "Overdue History",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 16),
                                                        ..._buildTimelineFromList(overdueList),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );

                                      Overlay.of(context).insert(overlayEntry!);
                                    }

                                    void removePopup() {
                                      overlayEntry?.remove();
                                      overlayEntry = null;
                                    }

                                    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          onEnter: (_) => showPopup(),
                                          onExit: (_) => removePopup(),
                                          child: const Icon(Icons.info_outline, size: 20, color: Colors.blue),
                                        ),
                                        const SizedBox(width: 3),
                                        Expanded(
                                          child: Text(
                                            // textAlign: TextAlign.left,
                                            mainBilling_Controller.billingModel.subscriptionInvoiceList[index].dueDate != null
                                                ? formatDate(DateTime.parse(mainBilling_Controller.billingModel.subscriptionInvoiceList[index].dueDate!))
                                                : '-',
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: Primary_font_size.Text7,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),

                              // Expanded(
                              //     flex: 2,
                              //     child: MouseRegion(
                              //       cursor: SystemMouseCursors.click,
                              //       child: GestureDetector(
                              //         onTap: () {widh},
                              //         child: Text(
                              //           // textAlign: TextAlign.left,
                              //           mainBilling_Controller.billingModel.subscriptionInvoiceList[index].dueDate != null
                              //               ? formatDate(DateTime.parse(mainBilling_Controller.billingModel.subscriptionInvoiceList[index].dueDate!))
                              //               : '-',
                              //           style: const TextStyle(
                              //             color: Colors.blue,
                              //             fontSize: Primary_font_size.Text7,
                              //           ),
                              //         ),
                              //       ),
                              //     )),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  // textAlign: TextAlign.center,
                                  (mainBilling_Controller.billingModel.subscriptionInvoiceList[index].overdueDays ?? 0).toString(),
                                  style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 22,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: mainBilling_Controller.billingModel.subscriptionInvoiceList[index].paymentStatus == 1
                                              ? const Color.fromARGB(193, 103, 223, 109)
                                              : const Color.fromARGB(208, 245, 85, 74),
                                        ),
                                        child: Center(
                                          child: Text(
                                            mainBilling_Controller.billingModel.subscriptionInvoiceList[index].paymentStatus == 1 ? 'Paid' : 'Pending',
                                            style: TextStyle(
                                                color: mainBilling_Controller.billingModel.subscriptionInvoiceList[index].paymentStatus == 1
                                                    ? const Color.fromARGB(255, 0, 0, 0)
                                                    : const Color.fromARGB(255, 0, 0, 0),
                                                fontSize: Primary_font_size.Text5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              const Expanded(flex: 2, child: Icon(Icons.keyboard_control))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  Widget Sales() {
    return Obx(() {
      return mainBilling_Controller.billingModel.salesInvoiceList.isEmpty
          ? Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Lottie.asset(
                      'assets/animations/JSON/emptyprocesslist.json',
                      height: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 164),
                    child: Text(
                      'No invoices found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 204),
                    child: Text(
                      'When an invoice is created, it will appear here.',
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
            )
          : ListView.separated(
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: const Color.fromARGB(94, 125, 125, 125),
              ),
              itemCount: mainBilling_Controller.billingModel.salesInvoiceList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Primary_colors.Light,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                formatDate(mainBilling_Controller.billingModel.salesInvoiceList[index].date),
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                mainBilling_Controller.billingModel.salesInvoiceList[index].invoiceNumber,
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            const Expanded(
                              flex: 2,
                              child: Text(
                                "VCH905857",
                                style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      // ignore: deprecated_member_use
                                      color: Primary_colors.Color5.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/black.jpg',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      maxLines: 4,
                                      mainBilling_Controller.billingModel.salesInvoiceList[index].clientAddressName,
                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Expanded(
                              flex: 1,
                              child: Text(
                                // mainBilling_Controller.billingModel.salesInvoiceList[index].clientAddress,
                                'plan type',
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'Plan Name',
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                mainBilling_Controller.billingModel.salesInvoiceList[index].invoiceAmount.toString(),
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            const Expanded(
                              flex: 2,
                              child: Text(
                                "9 days",
                                style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            // Expanded(
                            //   flex: 2,
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         height: 22,
                            //         width: 60,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(20),
                            //           color: mainBilling_Controller.billingModel.salesInvoiceList[index].paymentStatus == 1
                            //               ? const Color.fromARGB(193, 222, 244, 223)
                            //               : const Color.fromARGB(208, 244, 214, 212),
                            //         ),
                            //         child: Center(
                            //           child: Text(
                            //             mainBilling_Controller.billingModel.salesInvoiceList[index].paymentStatus == 1 ? 'Paid' : 'Pending',
                            //             style: TextStyle(
                            //                 color: mainBilling_Controller.billingModel.salesInvoiceList[index].paymentStatus == 1 ? const Color.fromARGB(255, 0, 122, 4) : Colors.red,
                            //                 fontSize: Primary_font_size.Text5,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            const Expanded(flex: 2, child: Icon(Icons.keyboard_control))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
    });
  }

  Widget Vendor() {
    return Obx(
      () {
        return mainBilling_Controller.billingModel.subscriptionInvoiceList.isEmpty
            ? Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Lottie.asset(
                        'assets/animations/JSON/emptyprocesslist.json',
                        height: 150,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 164),
                      child: Text(
                        'No invoices found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 204),
                      child: Text(
                        'When an invoice is created, it will appear here.',
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
              )
            : ListView.separated(
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: const Color.fromARGB(94, 125, 125, 125),
                ),
                itemCount: mainBilling_Controller.billingModel.subscriptionInvoiceList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Primary_colors.Light,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  formatDate(mainBilling_Controller.billingModel.subscriptionInvoiceList[index].date),
                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  mainBilling_Controller.billingModel.subscriptionInvoiceList[index].invoiceNo,
                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  "VCH905857",
                                  style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          // ignore: deprecated_member_use
                                          color: Primary_colors.Color5.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/black.jpg',
                                            fit: BoxFit.cover, // Ensures the image covers the container
                                            width: double.infinity, // Makes the image fill the container's width
                                            height: double.infinity, // Makes the image fill the container's height
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          softWrap: true,
                                          maxLines: 4,
                                          // overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Primary_colors.Color1,
                                            fontSize: Primary_font_size.Text7,
                                          ),
                                          textAlign: TextAlign.start,
                                          mainBilling_Controller.billingModel.subscriptionInvoiceList[index].clientAddressName,
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(width: 10),

                              // Expanded(
                              //   flex: 2,
                              //   child: Text(
                              //     mainBilling_Controller.billingModel.subscriptionInvoiceList[index].subs,
                              //     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  mainBilling_Controller.billingModel.subscriptionInvoiceList[index].planType,
                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  mainBilling_Controller.billingModel.subscriptionInvoiceList[index].planName,
                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  mainBilling_Controller.billingModel.subscriptionInvoiceList[index].totalAmount.toString(),
                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  "9 days",
                                  style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 22,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: mainBilling_Controller.billingModel.subscriptionInvoiceList[index].paymentStatus == 1
                                              ? const Color.fromARGB(193, 103, 223, 109)
                                              : const Color.fromARGB(208, 255, 80, 68),
                                        ),
                                        child: Center(
                                          child: Text(
                                            mainBilling_Controller.billingModel.subscriptionInvoiceList[index].paymentStatus == 1 ? 'Paid' : 'Pending',
                                            style: TextStyle(
                                                color: mainBilling_Controller.billingModel.subscriptionInvoiceList[index].paymentStatus == 1
                                                    ? const Color.fromARGB(255, 0, 0, 0)
                                                    : const Color.fromARGB(255, 0, 0, 0),
                                                fontSize: Primary_font_size.Text5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              const Expanded(flex: 2, child: Icon(Icons.keyboard_control))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  List<Widget> _buildTimelineFromList(List<OverdueHistory>? overdueList) {
    if (overdueList == null || overdueList.isEmpty) {
      return [
        const Text(
          "No overdue history available.",
          style: TextStyle(color: Colors.grey),
        ),
      ];
    }

    return List.generate(overdueList.length, (index) {
      final isLast = index == overdueList.length - 1;
      final item = overdueList[index];
      final date = item.date ?? "Unknown Date";
      final feedback = item.feedback ?? "No feedback provided";

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const Icon(Icons.circle, size: 10, color: Colors.blue),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 30,
                    color: Colors.blue.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                  children: [
                    TextSpan(
                      text: "$date: ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: feedback),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
