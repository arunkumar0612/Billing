// ignore_for_file: deprecated_member_use

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
import 'package:ssipl_billing/COMPONENTS-/showPDF.dart';
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
    widget.GetDashboardData();
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

  bool isHovered = false;
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
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(
                                  colors: [Primary_colors.Color3, Primary_colors.Color4], // Example gradient
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                                child: const Icon(
                                  Icons.currency_rupee_sharp,
                                  size: 25.0,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Bills & Payments',
                                style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text13),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 240,
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
                                                Obx(() {
                                                  return Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 8, left: 8),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  const Text(
                                                                    'Select date',
                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                                                                  ),
                                                                  // const SizedBox(width: 8),
                                                                  Obx(
                                                                    () => SizedBox(
                                                                      child: mainBilling_Controller.billingModel.dashboard_startDateController.value.text.isNotEmpty ||
                                                                              mainBilling_Controller.billingModel.dashboard_endDateController.value.text.isNotEmpty
                                                                          ? TextButton(
                                                                              onPressed: () {
                                                                                mainBilling_Controller.billingModel.dashboard_selectedMonth.value = 'None';
                                                                                mainBilling_Controller.billingModel.dashboard_startDateController.value.clear();
                                                                                mainBilling_Controller.billingModel.dashboard_endDateController.value.clear();
                                                                                // widget.get_VoucherList();
                                                                              },
                                                                              child: const Text('Clear', style: TextStyle(fontSize: Primary_font_size.Text7)),
                                                                            )
                                                                          : const SizedBox(),
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                  Obx(() {
                                                                    return Container(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                      width: 100, // Adjust width as needed
                                                                      height: 30, // Adjust height as needed
                                                                      child: DropdownButtonFormField<String>(
                                                                        menuMaxHeight: 300,
                                                                        value: mainBilling_Controller.billingModel.dashboard_selectedMonth.value,
                                                                        items: [
                                                                          'None',
                                                                          'January',
                                                                          'February',
                                                                          'March',
                                                                          'April',
                                                                          'May',
                                                                          'June',
                                                                          'July',
                                                                          'August',
                                                                          'September',
                                                                          'October',
                                                                          'November',
                                                                          'December'
                                                                        ].map((String value) {
                                                                          return DropdownMenuItem<String>(value: value, child: Text(value));
                                                                        }).toList(),
                                                                        onChanged: (value) {
                                                                          mainBilling_Controller.billingModel.dashboard_selectedMonth.value = value!;
                                                                          if (value != 'None') {
                                                                            final monthIndex = [
                                                                                  'January',
                                                                                  'February',
                                                                                  'March',
                                                                                  'April',
                                                                                  'May',
                                                                                  'June',
                                                                                  'July',
                                                                                  'August',
                                                                                  'September',
                                                                                  'October',
                                                                                  'November',
                                                                                  'December'
                                                                                ].indexOf(value) +
                                                                                1;

                                                                            final now = DateTime.now();
                                                                            final year = now.year;
                                                                            final firstDay = DateTime(year, monthIndex, 1);
                                                                            final lastDay = monthIndex < 12 ? DateTime(year, monthIndex + 1, 0) : DateTime(year + 1, 1, 0);

                                                                            String formatDate(DateTime date) {
                                                                              return "${date.year.toString().padLeft(4, '0')}-"
                                                                                  "${date.month.toString().padLeft(2, '0')}-"
                                                                                  "${date.day.toString().padLeft(2, '0')}";
                                                                            }

                                                                            mainBilling_Controller.billingModel.dashboard_startDateController.value.text = formatDate(firstDay);
                                                                            mainBilling_Controller.billingModel.dashboard_endDateController.value.text = formatDate(lastDay);
                                                                            // widget.get_VoucherList();
                                                                          } else {
                                                                            mainBilling_Controller.billingModel.dashboard_startDateController.value.clear();
                                                                            mainBilling_Controller.billingModel.dashboard_endDateController.value.clear();
                                                                            // widget.get_VoucherList();
                                                                          }
                                                                          widget.GetDashboardData();
                                                                        },
                                                                        decoration: const InputDecoration(
                                                                          isDense: true,
                                                                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                                                                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                                                        ),
                                                                        style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 154, 152, 152)),
                                                                        dropdownColor: Primary_colors.Dark,
                                                                      ),
                                                                    );
                                                                  }),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 15),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: SizedBox(
                                                                      height: 35,
                                                                      child: TextFormField(
                                                                        style: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                                                                        controller: mainBilling_Controller.billingModel.dashboard_startDateController.value,
                                                                        readOnly: true,
                                                                        onTap: () async {
                                                                          await widget.select_previousDates(context, mainBilling_Controller.billingModel.dashboard_startDateController.value);
                                                                          widget.GetDashboardData();
                                                                          // await widget.get_VoucherList();
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          labelText: 'From',
                                                                          labelStyle: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                                                                          suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Color.fromARGB(255, 85, 84, 84)),
                                                                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                                                          enabledBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                                                            borderRadius: BorderRadius.circular(8),
                                                                          ),
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                                                            borderRadius: BorderRadius.circular(8),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(width: 10),
                                                                  Expanded(
                                                                    child: SizedBox(
                                                                      height: 35,
                                                                      child: TextFormField(
                                                                        style: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                                                                        controller: mainBilling_Controller.billingModel.dashboard_endDateController.value,
                                                                        readOnly: true,
                                                                        onTap: () async {
                                                                          await widget.select_previousDates(context, mainBilling_Controller.billingModel.dashboard_endDateController.value);
                                                                          widget.GetDashboardData();
                                                                          // await widget.get_VoucherList();
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          labelText: 'To',
                                                                          labelStyle: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                                                                          suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Color.fromARGB(255, 85, 84, 84)),
                                                                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                                                          enabledBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                                                            borderRadius: BorderRadius.circular(8),
                                                                          ),
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                                                            borderRadius: BorderRadius.circular(8),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 35),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(flex: 1, child: Container()),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right: 10),
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 35,
                                                            child: Obx(
                                                              () => DropdownButtonFormField<String>(
                                                                value: mainBilling_Controller.billingModel.type.value, // Use the state variable for the selected value
                                                                items: [
                                                                  "Sales",
                                                                  "Subscription",
                                                                  "Purchase",
                                                                  "Receivables",
                                                                  "Payables",
                                                                  "All",
                                                                ]
                                                                    .map((String value) => DropdownMenuItem<String>(
                                                                          value: value,
                                                                          child: Text(value, style: const TextStyle(fontSize: 13, color: Colors.white)),
                                                                        ))
                                                                    .toList(),
                                                                onChanged: (String? newValue) {
                                                                  if (newValue != null) {
                                                                    mainBilling_Controller.update_dashBoardtype(newValue);
                                                                    widget.GetDashboardData();
                                                                    // mainBilling_Controller.updatesalesperiod(newValue == "Monthly view" ? 'monthly' : 'yearly');

                                                                    // if (newValue == "Monthly view") {
                                                                    //   widget.GetSalesData('monthly');
                                                                    // } else if (newValue == "Yearly view") {
                                                                    //   widget.GetSalesData('yearly');
                                                                    // }
                                                                  }
                                                                },
                                                                decoration: InputDecoration(
                                                                  alignLabelWithHint: false,
                                                                  contentPadding: const EdgeInsets.all(10),
                                                                  filled: true,
                                                                  fillColor: Primary_colors.Dark,
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(30),
                                                                    borderSide: const BorderSide(color: Color.fromARGB(226, 50, 50, 50)),
                                                                  ),
                                                                  enabledBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(30),
                                                                    borderSide: const BorderSide(color: Color.fromARGB(255, 51, 50, 50)),
                                                                  ),
                                                                  hintText: 'Data View',
                                                                  hintStyle: const TextStyle(
                                                                    fontSize: Primary_font_size.Text7,
                                                                    color: Primary_colors.Color1,
                                                                    letterSpacing: 1,
                                                                  ),
                                                                ),
                                                                dropdownColor: Primary_colors.Dark,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                }),
                                                Expanded(
                                                  child: Obx(
                                                    () {
                                                      return Container(
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
                                                                  Text(
                                                                    formatCurrency(mainBilling_Controller.billingModel.dashBoard_data.value.totalAmount ?? 0.0),
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
                                                                    child: Padding(
                                                                      padding: EdgeInsets.all(4),
                                                                      child: Text(
                                                                        '${mainBilling_Controller.billingModel.dashBoard_data.value.totalInvoices} invoices',
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
                                                                  Text(
                                                                    formatCurrency(mainBilling_Controller.billingModel.dashBoard_data.value.paidAmount ?? 0.0),
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
                                                                    child: Padding(
                                                                      padding: EdgeInsets.all(4),
                                                                      child: Text(
                                                                        '${mainBilling_Controller.billingModel.dashBoard_data.value.paidInvoices} invoices',
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
                                                                  Text(
                                                                    formatCurrency(mainBilling_Controller.billingModel.dashBoard_data.value.pendingAmount ?? 0.0),
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
                                                                    child: Padding(
                                                                      padding: EdgeInsets.all(4),
                                                                      child: Text(
                                                                        '${mainBilling_Controller.billingModel.dashBoard_data.value.pendingInvoices} invoices',
                                                                        style: TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 234, 29, 15)),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
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
                                                      onEnter: (_) => setState(() => isHovered = true),
                                                      onExit: (_) => setState(() => isHovered = false),
                                                      cursor: SystemMouseCursors.forbidden,
                                                      child: Tooltip(
                                                        message: 'Work in progress',
                                                        child: Opacity(
                                                          opacity: 0.2,
                                                          child: AbsorbPointer(
                                                            absorbing: isHovered, // Prevent clicks when hovered
                                                            child: _buildIconWithLabel(
                                                              image: 'assets/images/transaction.png',
                                                              label: 'View Transaction',
                                                              color: Primary_colors.Color5,
                                                              onPressed: () {
                                                                // Optional: disable logic here too if needed
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                                                      onEnter: (_) => setState(() => isHovered = true),
                                                      onExit: (_) => setState(() => isHovered = false),
                                                      cursor: SystemMouseCursors.forbidden,
                                                      child: Tooltip(
                                                        message: 'Work in progress',
                                                        child: Opacity(
                                                          opacity: 0.2,
                                                          child: AbsorbPointer(
                                                            absorbing: isHovered, // Prevent clicks when hovered
                                                            child: _buildIconWithLabel(
                                                              image: 'assets/images/balancesheet.png',
                                                              label: 'Balance Sheet',
                                                              color: Primary_colors.Color8,
                                                              onPressed: () {
                                                                // Optional: disable logic here too if needed
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
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
                                            child: Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Obx(
                                                () {
                                                  return Pie_chart(
                                                    totalInvoices: mainBilling_Controller.billingModel.dashBoard_data.value.totalInvoices,
                                                    paidInvoices: mainBilling_Controller.billingModel.dashBoard_data.value.paidInvoices,
                                                    pendingInvoices: mainBilling_Controller.billingModel.dashBoard_data.value.pendingInvoices,
                                                  );
                                                },
                                              ),
                                            ),
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
                                    child: Obx(() {
                                      return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: mainBilling_Controller.billingModel.activeTab.value == "Subscription"
                                              ? SubscriptionHeaders()
                                              : mainBilling_Controller.billingModel.activeTab.value == 'Sales'
                                                  ? SalesHeaders()
                                                  : SubscriptionHeaders());
                                    }),
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
            textAlign: TextAlign.center,
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
          flex: 4,
          child: Text(
            textAlign: TextAlign.start,
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
                                        showPDF(context, mainBilling_Controller.billingModel.subscriptionInvoiceList[index].invoiceNo, mainBilling_Controller.billingModel.pdfFile.value);
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
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () async {
                                            widget.get_VoucherDetails(context, mainBilling_Controller.billingModel.subscriptionInvoiceList[index].voucher_id);
                                          },
                                          child: Text(
                                            mainBilling_Controller.billingModel.subscriptionInvoiceList[index].voucher_number,
                                            style: const TextStyle(color: Colors.blue, fontSize: Primary_font_size.Text7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                              // SizedBox(width: 5),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Rs. ${formatCurrency(double.parse(mainBilling_Controller.billingModel.subscriptionInvoiceList[index].totalAmount.toString()))}',
                                  style: const TextStyle(
                                    color: Primary_colors.Color1,
                                    fontSize: Primary_font_size.Text7,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
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
                                                ? mainBilling_Controller.billingModel.subscriptionInvoiceList[index].dueDate!
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
                                  textAlign: TextAlign.left,
                                  (mainBilling_Controller.billingModel.subscriptionInvoiceList[index].overdueDays ?? '-').toString(),
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
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () async {
                                    bool success = await widget.GetSalesPDFfile(context: context, invoiceNo: mainBilling_Controller.billingModel.salesInvoiceList[index].invoiceNumber);
                                    if (success) {
                                      showPDF(context, mainBilling_Controller.billingModel.salesInvoiceList[index].invoiceNumber, mainBilling_Controller.billingModel.pdfFile.value);
                                    }
                                  },
                                  child: Text(
                                    mainBilling_Controller.billingModel.salesInvoiceList[index].invoiceNumber,
                                    style: const TextStyle(color: Colors.blue, fontSize: Primary_font_size.Text7),
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   flex: 2,
                            //   child: Text(
                            //     mainBilling_Controller.billingModel.salesInvoiceList[index].invoiceNumber,
                            //     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            //   ),
                            // ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () async {
                                          widget.get_VoucherDetails(context, mainBilling_Controller.billingModel.salesInvoiceList[index].voucherId);
                                        },
                                        child: Text(
                                          mainBilling_Controller.billingModel.salesInvoiceList[index].voucherNumber,
                                          style: const TextStyle(color: Colors.blue, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
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
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                // textAlign: TextAlign.center,
                                // mainBilling_Controller.billingModel.salesInvoiceList[index].clientAddress,
                                'Rs. ${formatCurrency(double.parse(mainBilling_Controller.billingModel.salesInvoiceList[index].invoiceAmount.toString()))}',
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
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
                                        color: mainBilling_Controller.billingModel.salesInvoiceList[index].paymentStatus == 1
                                            ? const Color.fromARGB(193, 103, 223, 109)
                                            : const Color.fromARGB(208, 245, 85, 74),
                                      ),
                                      child: Center(
                                        child: Text(
                                          mainBilling_Controller.billingModel.salesInvoiceList[index].paymentStatus == 1 ? 'Paid' : 'Pending',
                                          style: TextStyle(
                                              color: mainBilling_Controller.billingModel.salesInvoiceList[index].paymentStatus == 1
                                                  ? const Color.fromARGB(255, 0, 0, 0)
                                                  : const Color.fromARGB(255, 0, 0, 0),
                                              fontSize: Primary_font_size.Text5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
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
      final date = item.date;
      final feedback = item.feedback;

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
