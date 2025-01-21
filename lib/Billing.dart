import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ssipl_billing/Ledger/ViewLedger.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'package:ssipl_billing/filter.dart';

import 'package:ssipl_billing/piechart.dart';
import 'package:ssipl_billing/common_modules/style.dart';

// import 'package:dropdown_search/dropdown_search.dart';
PageRouteBuilder _createCustomPageRoute(Widget Function() navigation) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => navigation(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Define custom animation (slide from the right)
      var begin = const Offset(1.0, 0.0); // Start from the right
      var end = Offset.zero; // End at the center
      var curve = Curves.easeInOut; // Animation curve

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class Billing extends StatefulWidget {
  const Billing({super.key});
  static late dynamic Function() quote_Callback;
  static late dynamic Function() invoice_Callback;

  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  String? selectedCustomer;
  String? Selected_billingtype;

  List<String> customerList = [
    'Customer 1',
    'Customer 2',
    'Customer 3',
    'Customer 4',
    'Customer 5',
  ];

  List<String> billing_type = [
    'All',
    'Subscription',
    'Vendor',
    'Sales',
  ];
  final List<Map<String, dynamic>> invoice_list = [
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56546",
      "clientname": "Khivraj Groups",
      "image": "assets/images/human.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "06 oct 24",
      "amount": "15000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56534",
      "clientname": "Maharaja",
      "image": "assets/images/download.jpg",
      "type": "Sales",
      "product": "Secure 360",
      "date": "10 Nov 24",
      "amount": "50000",
      "Status": "Paid",
    },
    {
      "invoice_id": "56556",
      "clientname": "Anamalais Groups",
      "image": "assets/images/car.jpg",
      "type": "Vendor",
      "product": "Secure Shutter",
      "date": "13 Dec 24",
      "amount": "43000",
      "Status": "Pending",
    },
    {
      "invoice_id": "56545",
      "clientname": "Honda Groups",
      "image": "assets/images/bay.jpg",
      "type": "Subscription",
      "product": "Secure Shutter",
      "date": "13 oct 24",
      "amount": "15000",
      "Status": "Paid",
    },
  ];

  // Adding a controller and isAdding flag for each item
  late List<bool> isAddingList;
  // late List<TextEditingController> controllers;
  int showcustomerprocess = 0;
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String BillingSearchQuery = '';
  @override
  void initState() {
    super.initState();
  }

// ##################################################################################################################################################################################################################################################################################################################################################################

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        primarySwatch: Colors.blue,
        useMaterial3: false,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.orange,
          selectionColor: Color.fromARGB(255, 72, 191, 147),
        ),
        scrollbarTheme: ScrollbarThemeData(
          trackColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 229, 204, 10),
          ),
          trackBorderColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 10, 183, 206),
          ),
          thumbColor: const WidgetStatePropertyAll(
            Color.fromARGB(255, 90, 90, 90),
          ),
        ),
        fontFamily: 'Poppins',
      ),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            endDrawer: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Container(
                  width: 414,
                )),
                Expanded(
                  flex: 3,
                  child: Container(width: 414, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Dark), child: const FilterScreen()),
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
                                        )),
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
                                                  _buildIconWithLabel(
                                                      icon: Icons.book_outlined,
                                                      label: 'View Ledger',
                                                      color: Primary_colors.Color4,
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                          _createCustomPageRoute(() => const ViewLedger()),
                                                        );
                                                      }),
                                                  _buildIconWithLabel(icon: Icons.receipt_long_outlined, label: 'View Transaction', color: Primary_colors.Color5, onPressed: () {}),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              // Second row of icons and labels
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  _buildIconWithLabel(icon: Icons.info_outline, label: 'View Details', color: Primary_colors.Color6, onPressed: () {}),
                                                  _buildIconWithLabel(icon: Icons.person_outline, label: 'View Customer', color: Primary_colors.Color8, onPressed: () {}),
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
                            const SizedBox(
                              width: 350,
                              child: TabBar(
                                indicatorColor: Primary_colors.Color5,
                                tabs: [
                                  Text('All invoice'),
                                  Text('Paid'),
                                  Text('Unpaid'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: max(screenWidth - 1480, 200),
                                    height: 40,
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(1),
                                        filled: true,
                                        fillColor: Primary_colors.Light,
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
                                        // enabledBorder: InputBorder.none, // Removes the enabled border
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
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
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 40,
                                    child: DropdownButtonFormField<String>(
                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Adjust padding to center the hint
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
                                          // hintStyle: const TextStyle(
                                          //   fontSize: Primary_font_size.Text7,
                                          //   color: Color.fromARGB(255, 167, 165, 165),
                                          // ),
                                          // hintText: 'Select customer',
                                          // alignLabelWithHint: true, // Helps to align hint text
                                          label: const Text(
                                            'Select type',
                                            style: TextStyle(color: Color.fromARGB(255, 162, 162, 162), fontSize: Primary_font_size.Text7),
                                          )),
                                      dropdownColor: Primary_colors.Dark,
                                      value: Selected_billingtype, // Bind your selected value here
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          Selected_billingtype = newValue; // Update the selected value
                                        });
                                      },
                                      items: billing_type.map<DropdownMenuItem<String>>((String customer) {
                                        return DropdownMenuItem<String>(
                                          value: customer,
                                          child: Text(customer),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
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
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Invoice ID',
                                            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            'Client Name',
                                            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Type',
                                            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            'Product',
                                            style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                          ),
                                        ),
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
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Expanded(
                                  child: TabBarView(
                                    children: [Allinvoices(), paid(), unpaid()],
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
          )),
    );
  }

  Widget _buildIconWithLabel({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              size: 25,
              color: Primary_colors.Color1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: Primary_font_size.Text5,
              color: Primary_colors.Color1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget Allinvoices() {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: const Color.fromARGB(94, 125, 125, 125),
      ),
      itemCount: invoice_list.length,
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
                        invoice_list[index]['invoice_id'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
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
                                  invoice_list[index]['image'],
                                  fit: BoxFit.cover, // Ensures the image covers the container
                                  width: double.infinity, // Makes the image fill the container's width
                                  height: double.infinity, // Makes the image fill the container's height
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              invoice_list[index]['clientname'],
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 2,
                      child: Text(
                        invoice_list[index]['type'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        invoice_list[index]['product'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        invoice_list[index]['date'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        invoice_list[index]['amount'],
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
                                color: invoice_list[index]['Status'] == 'Paid' ? const Color.fromARGB(193, 222, 244, 223) : const Color.fromARGB(208, 244, 214, 212),
                              ),
                              child: Center(
                                child: Text(
                                  invoice_list[index]['Status'],
                                  style: TextStyle(
                                      color: invoice_list[index]['Status'] == 'Paid' ? const Color.fromARGB(255, 0, 122, 4) : Colors.red,
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
  }

  Widget paid() {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: const Color.fromARGB(94, 125, 125, 125),
      ),
      itemCount: invoice_list.where((invoice) => invoice['Status'] == 'Paid').length,
      itemBuilder: (context, index) {
        // Filter the list to include only 'Paid' invoices
        final paidInvoices = invoice_list.where((invoice) => invoice['Status'] == 'Paid').toList();

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
                        paidInvoices[index]['invoice_id'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
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
                                paidInvoices[index]['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            paidInvoices[index]['clientname'],
                            style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        paidInvoices[index]['type'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        paidInvoices[index]['product'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        paidInvoices[index]['date'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        paidInvoices[index]['amount'],
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
                              color: const Color.fromARGB(193, 222, 244, 223),
                            ),
                            child: Center(
                              child: Text(
                                paidInvoices[index]['Status'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 122, 4),
                                  fontSize: Primary_font_size.Text5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Icon(Icons.keyboard_control),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget unpaid() {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: const Color.fromARGB(94, 125, 125, 125),
      ),
      itemCount: invoice_list.where((invoice) => invoice['Status'] == 'Pending').length,
      itemBuilder: (context, index) {
        // Filter the list to include only 'Paid' invoices
        final paidInvoices = invoice_list.where((invoice) => invoice['Status'] == 'Pending').toList();

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
                        paidInvoices[index]['invoice_id'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
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
                                paidInvoices[index]['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            paidInvoices[index]['clientname'],
                            style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        paidInvoices[index]['type'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        paidInvoices[index]['product'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        paidInvoices[index]['date'],
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        paidInvoices[index]['amount'],
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
                              color: const Color.fromARGB(208, 244, 214, 212),
                            ),
                            child: Center(
                              child: Text(
                                paidInvoices[index]['Status'],
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: Primary_font_size.Text5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Icon(Icons.keyboard_control),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
