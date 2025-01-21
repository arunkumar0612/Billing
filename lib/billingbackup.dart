// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// import 'package:ssipl_billing/Generate_Invoice/generateInvoice.dart';
// import 'package:ssipl_billing/Generate_Invoice/invoice_template.dart';
// import 'package:ssipl_billing/Generate_Quotation/generateQuotaion.dart';
// import 'package:ssipl_billing/Generate_Quotation/quotation_template.dart';

// import 'package:ssipl_billing/piechart.dart';
// import 'package:ssipl_billing/style.dart';

// // import 'package:dropdown_search/dropdown_search.dart';

// class Billing extends StatefulWidget {
//   const Billing({super.key});
//   static late dynamic Function() quote_Callback;
//   static late dynamic Function() invoice_Callback;

//   @override
//   _BillingState createState() => _BillingState();
// }

// class _BillingState extends State<Billing> {
//   String? selectedCustomer;
//   String? selecteddays;
//   bool showfilter = false;
//   List<String> customerList = [
//     'Customer 1',
//     'Customer 2',
//     'Customer 3',
//     'Customer 4',
//     'Customer 5',
//   ];

//   List<String> dayList = [
//     'Last hours',
//     'Last 24hours',
//     'Last 1week',
//     'Last Month',
//   ];
//   final List<Map<String, dynamic>> invoice_list = [
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//   ];

//   // Adding a controller and isAdding flag for each item
//   late List<bool> isAddingList;
//   late List<TextEditingController> controllers;
//   int showcustomerprocess = 0;
//   List<String> list = <String>['One', 'Two', 'Three', 'Four'];
//   String BillingSearchQuery = '';
//   @override
//   void initState() {
//     super.initState();
//   }

//   dynamic GenerateQuotation_dialougebox() async {
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: Primary_colors.Dark,
//           content: const SizedBox(height: 600, width: 900, child: GenerateQuotation()),
//         );
//       },
//     ); // Returns false if dialog is dismissed by clicking outside
//     products.clear();
//     gstTotals.clear();
//     noteList.clear();
//     recommendationList.clear();
//     productDetails.clear();
//     client_addr_name = null;
//     client_addr = null;
//     bill_addr_name = null;
//     bill_addr = null;
//     estimate_no = null;
//     title = null;
//     table_heading = null;
//   }

// // ##################################################################################################################################################################################################################################################################################################################################################################

//   dynamic GenerateInvoice_dialougebox() async {
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: Primary_colors.Dark,
//           content: const SizedBox(height: 600, width: 900, child: GenerateInvoice()),
//         );
//       },
//     ); // Returns false if dialog is dismissed by clicking outside

//     invoice_products.clear();
//     invoice_gstTotals.clear();
//     invoice_client_addr_name = "";
//     invoice_client_addr = "";
//     invoice_bill_addr_name = "";
//     invoice_bill_addr = "";
//     Invoice_no = "";
//     invoice_title = "";
//     invoice_table_heading = "";
//     invoice_noteList.clear();
//     invoice_recommendationList.clear();
//     invoice_productDetails.clear();
//   }

//   @override
//   void dispose() {
//     // Dispose controllers to avoid memory leaks
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           backgroundColor: Primary_colors.Dark,
//           body: Center(
//             child: SizedBox(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 235,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                   flex: 2,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(16),
//                                       gradient: const LinearGradient(
//                                         colors: [Primary_colors.Light, Color.fromARGB(255, 40, 39, 59), Primary_colors.Light],
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                       ),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Colors.black12,
//                                           offset: Offset(0, 10),
//                                           blurRadius: 20,
//                                         ),
//                                       ],
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(0),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           // const Text(
//                                           //   'Overview',
//                                           //   style: TextStyle(color: Primary_colors.Color1, fontSize: 20),
//                                           // ),
//                                           // const SizedBox(
//                                           //   height: 10,
//                                           // ),
//                                           Expanded(
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(16),
//                                                 // gradient: const LinearGradient(
//                                                 //   colors: [Primary_colors.Light, Color.fromARGB(255, 40, 39, 59), Primary_colors.Light],
//                                                 //   begin: Alignment.topLeft,
//                                                 //   end: Alignment.bottomRight,
//                                                 // ),
//                                                 // boxShadow: const [
//                                                 //   BoxShadow(
//                                                 //     color: Colors.black12,
//                                                 //     offset: Offset(0, 10),
//                                                 //     blurRadius: 20,
//                                                 //   ),
//                                                 // ],
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(16),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                   children: [
//                                                     Column(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         const Text(
//                                                           'TOTAL',
//                                                           style: TextStyle(
//                                                             color: Color.fromARGB(255, 186, 185, 185),
//                                                             fontSize: 12,
//                                                             fontWeight: FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                         const Text(
//                                                           "\$17,6232",
//                                                           style: TextStyle(
//                                                             color: Primary_colors.Color3,
//                                                             fontSize: 28,
//                                                             fontWeight: FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           decoration: BoxDecoration(
//                                                             borderRadius: BorderRadius.circular(10),
//                                                             color: const Color.fromARGB(255, 202, 227, 253),
//                                                           ),
//                                                           child: const Padding(
//                                                             padding: EdgeInsets.all(4),
//                                                             child: Text(
//                                                               '210 invoices',
//                                                               style: TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 15, 139, 234)),
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                     Column(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         const Text(
//                                                           'PAID',
//                                                           style: TextStyle(
//                                                             color: Color.fromARGB(255, 186, 185, 185),
//                                                             fontSize: 12,
//                                                             fontWeight: FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                         const Text(
//                                                           "\$18,6232",
//                                                           style: TextStyle(
//                                                             color: Primary_colors.Color3,
//                                                             fontSize: 28,
//                                                             fontWeight: FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           decoration: BoxDecoration(
//                                                             borderRadius: BorderRadius.circular(10),
//                                                             color: const Color.fromARGB(255, 202, 253, 223),
//                                                           ),
//                                                           child: const Padding(
//                                                             padding: EdgeInsets.all(4),
//                                                             child: Text(
//                                                               '210 invoices',
//                                                               style: TextStyle(fontSize: Primary_font_size.Text5, color: Colors.green),
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                     Column(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         const Text(
//                                                           'UNPAID',
//                                                           style: TextStyle(
//                                                             color: Color.fromARGB(255, 186, 185, 185),
//                                                             fontSize: 12,
//                                                             fontWeight: FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                         const Text(
//                                                           "\$6,232",
//                                                           style: TextStyle(
//                                                             color: Primary_colors.Color3,
//                                                             fontSize: 28,
//                                                             fontWeight: FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           decoration: BoxDecoration(
//                                                             borderRadius: BorderRadius.circular(10),
//                                                             color: const Color.fromARGB(255, 253, 206, 202),
//                                                           ),
//                                                           child: const Padding(
//                                                             padding: EdgeInsets.all(4),
//                                                             child: Text(
//                                                               '110 invoices',
//                                                               style: TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 234, 29, 15)),
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   )),
//                               const SizedBox(
//                                 width: 15,
//                               ),
//                               // Column(
//                               //   mainAxisAlignment: MainAxisAlignment.center,
//                               //   children: [
//                               //     Container(
//                               //       height: 180,
//                               //       width: 2,
//                               //       color: const Color.fromARGB(255, 111, 110, 110),
//                               //     ),
//                               //   ],
//                               // ),
//                               // const SizedBox(
//                               //   width: 10,
//                               // ),
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(16),
//                                     gradient: const LinearGradient(
//                                       colors: [
//                                         Primary_colors.Light,
//                                         Color.fromARGB(255, 40, 39, 59),
//                                         Primary_colors.Light,
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     ),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                         color: Colors.black26,
//                                         offset: Offset(0, 6),
//                                         blurRadius: 12,
//                                       ),
//                                     ],
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         // First row of icons and labels
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                           children: [
//                                             _buildIconWithLabel(
//                                               icon: Icons.book_outlined,
//                                               label: 'View Ledger',
//                                             ),
//                                             _buildIconWithLabel(
//                                               icon: Icons.receipt_long_outlined,
//                                               label: 'View Transaction',
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 20),
//                                         // Second row of icons and labels
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                           children: [
//                                             _buildIconWithLabel(
//                                               icon: Icons.info_outline,
//                                               label: 'View Details',
//                                             ),
//                                             _buildIconWithLabel(
//                                               icon: Icons.person_outline,
//                                               label: 'View Customer',
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),

//                                 // Reusable function to build icon with label for consistency
//                               )
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         Expanded(
//                           flex: 1,
//                           child: Padding(
//                             padding: const EdgeInsets.all(0),
//                             child: Column(
//                               children: [
//                                 // const Text(
//                                 //   'Invoice status',
//                                 //   style: TextStyle(color: Primary_colors.Color1, fontSize: 20),
//                                 // ),
//                                 // const SizedBox(
//                                 //   height: 10,
//                                 // ),
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(16),
//                                       gradient: const LinearGradient(
//                                         colors: [Primary_colors.Light, Color.fromARGB(255, 40, 39, 59), Primary_colors.Light],
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                       ),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Colors.black12,
//                                           offset: Offset(0, 10),
//                                           blurRadius: 20,
//                                         ),
//                                       ],
//                                     ),
//                                     child: const Padding(padding: EdgeInsets.all(16), child: Pie_chart()),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   Row(
//                     children: [
//                       const SizedBox(
//                         width: 350,
//                         child: TabBar(
//                           indicatorColor: Primary_colors.Color5,
//                           tabs: [
//                             Text('All invoice'),
//                             Text('Paid'),
//                             Text('Unpaid'),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             SizedBox(
//                               width: 400,
//                               height: 40,
//                               child: TextFormField(
//                                 style: const TextStyle(fontSize: 13, color: Colors.white),
//                                 decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.all(1),
//                                   filled: true,
//                                   fillColor: Primary_colors.Light,
//                                   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
//                                   // enabledBorder: InputBorder.none, // Removes the enabled border
//                                   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
//                                   hintStyle: const TextStyle(
//                                     fontSize: Primary_font_size.Text7,
//                                     color: Color.fromARGB(255, 167, 165, 165),
//                                   ),
//                                   hintText: 'select customer',
//                                   prefixIcon: const Icon(
//                                     Icons.search,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   showfilter = showfilter == true ? false : true;
//                                 });
//                               },
//                               icon: Icon(
//                                 Icons.filter_alt_outlined,
//                                 color: showfilter == true ? Colors.blue : Primary_colors.Color1,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   Expanded(
//                     child: Container(
//                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
//                         padding: const EdgeInsets.all(10),
//                         child: Column(
//                           children: [
//                             if (showfilter == true)
//                               SizedBox(
//                                 height: 60,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     SizedBox(
//                                       width: 300,
//                                       height: 40,
//                                       child: DropdownButtonFormField<String>(
//                                         style: const TextStyle(fontSize: 13, color: Colors.white),
//                                         decoration: InputDecoration(
//                                             contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Adjust padding to center the hint
//                                             filled: true,
//                                             fillColor: Primary_colors.Dark,
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(30),
//                                               borderSide: const BorderSide(color: Colors.transparent),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(30),
//                                               borderSide: const BorderSide(color: Colors.transparent),
//                                             ),
//                                             // hintStyle: const TextStyle(
//                                             //   fontSize: Primary_font_size.Text7,
//                                             //   color: Color.fromARGB(255, 167, 165, 165),
//                                             // ),
//                                             // hintText: 'Select customer',
//                                             // alignLabelWithHint: true, // Helps to align hint text
//                                             label: const Text(
//                                               'Select Customer',
//                                               style: TextStyle(color: Color.fromARGB(255, 162, 162, 162), fontSize: Primary_font_size.Text7),
//                                             )),
//                                         dropdownColor: Primary_colors.Dark,
//                                         value: selectedCustomer, // Bind your selected value here
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             selectedCustomer = newValue; // Update the selected value
//                                           });
//                                         },
//                                         items: customerList.map<DropdownMenuItem<String>>((String customer) {
//                                           return DropdownMenuItem<String>(
//                                             value: customer,
//                                             child: Text(customer),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     SizedBox(
//                                       width: 300,
//                                       height: 40,
//                                       child: DropdownButtonFormField<String>(
//                                         style: const TextStyle(fontSize: 13, color: Colors.white),
//                                         decoration: InputDecoration(
//                                             contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Adjust padding to center the hint
//                                             filled: true,
//                                             fillColor: Primary_colors.Dark,
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(30),
//                                               borderSide: const BorderSide(color: Colors.transparent),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(30),
//                                               borderSide: const BorderSide(color: Colors.transparent),
//                                             ),
//                                             // hintStyle: const TextStyle(
//                                             //   fontSize: Primary_font_size.Text7,
//                                             //   color: Color.fromARGB(255, 167, 165, 165),
//                                             // ),
//                                             // hintText: 'Select customer',
//                                             // alignLabelWithHint: true, // Helps to align hint text
//                                             label: const Text(
//                                               'Select Days',
//                                               style: TextStyle(color: Color.fromARGB(255, 162, 162, 162), fontSize: Primary_font_size.Text7),
//                                             )),
//                                         dropdownColor: Primary_colors.Dark,
//                                         value: selecteddays, // Bind your selected value here
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             selecteddays = newValue; // Update the selected value
//                                           });
//                                         },
//                                         items: dayList.map<DropdownMenuItem<String>>((String customer) {
//                                           return DropdownMenuItem<String>(
//                                             value: customer,
//                                             child: Text(customer),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Container(
//                                       width: 80,
//                                       decoration: BoxDecoration(
//                                         color: const Color.fromARGB(255, 95, 179, 247),
//                                         borderRadius: BorderRadius.circular(15), // Ensure border radius for smooth corners
//                                       ),
//                                       child: TextButton(
//                                           onPressed: () {},
//                                           child: const Text(
//                                             'Search',
//                                             style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                           )),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             Container(
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [Primary_colors.Color4, Primary_colors.Color5], // Example gradient colors
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10), // Ensure border radius for smooth corners
//                               ),
//                               child: const Padding(
//                                 padding: EdgeInsets.all(10),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         'Invoice ID',
//                                         style: TextStyle(color: Primary_colors.Color2, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 4,
//                                       child: Text(
//                                         'Client Name',
//                                         style: TextStyle(color: Primary_colors.Color2, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 4,
//                                       child: Text(
//                                         'Product',
//                                         style: TextStyle(color: Primary_colors.Color2, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         'Date',
//                                         style: TextStyle(color: Primary_colors.Color2, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         'Amount',
//                                         style: TextStyle(color: Primary_colors.Color2, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         'Status',
//                                         style: TextStyle(color: Primary_colors.Color2, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         '',
//                                         style: TextStyle(color: Primary_colors.Color2, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Expanded(
//                               child: TabBarView(
//                                 children: [Allinvoices(), paid(), unpaid()],
//                               ),
//                             ),
//                           ],
//                         )),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   Widget _buildIconWithLabel({required IconData icon, required String label}) {
//     return Column(
//       children: [
//         Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color.fromARGB(162, 107, 153, 195), Color.fromARGB(152, 195, 103, 209)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             shape: BoxShape.circle,
//           ),
//           padding: const EdgeInsets.all(12),
//           child: Icon(
//             icon,
//             size: 25,
//             color: Primary_colors.Color1,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: Primary_font_size.Text5,
//             color: Primary_colors.Color1,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget Allinvoices() {
//     return ListView.separated(
//       separatorBuilder: (context, index) => Container(
//         height: 1,
//         color: const Color.fromARGB(94, 125, 125, 125),
//       ),
//       itemCount: invoice_list.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Primary_colors.Light,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         invoice_list[index]['invoice_id'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                         flex: 4,
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 35,
//                               height: 35,
//                               decoration: BoxDecoration(
//                                 color: Primary_colors.Color5.withOpacity(0.1),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: ClipOval(
//                                 child: Image.asset(
//                                   invoice_list[index]['image'],
//                                   fit: BoxFit.cover, // Ensures the image covers the container
//                                   width: double.infinity, // Makes the image fill the container's width
//                                   height: double.infinity, // Makes the image fill the container's height
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             Text(
//                               invoice_list[index]['clientname'],
//                               style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                             ),
//                           ],
//                         )),
//                     Expanded(
//                       flex: 4,
//                       child: Text(
//                         invoice_list[index]['product'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         invoice_list[index]['date'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         invoice_list[index]['amount'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                         flex: 2,
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 22,
//                               width: 60,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: invoice_list[index]['Status'] == 'Paid' ? const Color.fromARGB(193, 222, 244, 223) : const Color.fromARGB(208, 244, 214, 212),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   invoice_list[index]['Status'],
//                                   style: TextStyle(
//                                       color: invoice_list[index]['Status'] == 'Paid' ? const Color.fromARGB(255, 0, 122, 4) : Colors.red,
//                                       fontSize: Primary_font_size.Text5,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                     const Expanded(flex: 2, child: Icon(Icons.keyboard_control))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget paid() {
//     return ListView.separated(
//       separatorBuilder: (context, index) => Container(
//         height: 1,
//         color: const Color.fromARGB(94, 125, 125, 125),
//       ),
//       itemCount: invoice_list.where((invoice) => invoice['Status'] == 'Paid').length,
//       itemBuilder: (context, index) {
//         // Filter the list to include only 'Paid' invoices
//         final paidInvoices = invoice_list.where((invoice) => invoice['Status'] == 'Paid').toList();

//         return Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Primary_colors.Light,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         paidInvoices[index]['invoice_id'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 4,
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 35,
//                             height: 35,
//                             decoration: BoxDecoration(
//                               color: Primary_colors.Color5.withOpacity(0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: ClipOval(
//                               child: Image.asset(
//                                 paidInvoices[index]['image'],
//                                 fit: BoxFit.cover,
//                                 width: double.infinity,
//                                 height: double.infinity,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 5),
//                           Text(
//                             paidInvoices[index]['clientname'],
//                             style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 4,
//                       child: Text(
//                         paidInvoices[index]['product'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         paidInvoices[index]['date'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         paidInvoices[index]['amount'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 22,
//                             width: 60,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: const Color.fromARGB(193, 222, 244, 223),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 paidInvoices[index]['Status'],
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 0, 122, 4),
//                                   fontSize: Primary_font_size.Text5,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Expanded(
//                       flex: 2,
//                       child: Icon(Icons.keyboard_control),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget unpaid() {
//     return ListView.separated(
//       separatorBuilder: (context, index) => Container(
//         height: 1,
//         color: const Color.fromARGB(94, 125, 125, 125),
//       ),
//       itemCount: invoice_list.where((invoice) => invoice['Status'] == 'Pending').length,
//       itemBuilder: (context, index) {
//         // Filter the list to include only 'Paid' invoices
//         final paidInvoices = invoice_list.where((invoice) => invoice['Status'] == 'Pending').toList();

//         return Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Primary_colors.Light,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         paidInvoices[index]['invoice_id'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 4,
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 35,
//                             height: 35,
//                             decoration: BoxDecoration(
//                               color: Primary_colors.Color5.withOpacity(0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: ClipOval(
//                               child: Image.asset(
//                                 paidInvoices[index]['image'],
//                                 fit: BoxFit.cover,
//                                 width: double.infinity,
//                                 height: double.infinity,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 5),
//                           Text(
//                             paidInvoices[index]['clientname'],
//                             style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 4,
//                       child: Text(
//                         paidInvoices[index]['product'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         paidInvoices[index]['date'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         paidInvoices[index]['amount'],
//                         style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 22,
//                             width: 60,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: const Color.fromARGB(208, 244, 214, 212),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 paidInvoices[index]['Status'],
//                                 style: const TextStyle(
//                                   color: Colors.red,
//                                   fontSize: Primary_font_size.Text5,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Expanded(
//                       flex: 2,
//                       child: Icon(Icons.keyboard_control),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
