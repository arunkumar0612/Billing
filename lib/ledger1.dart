// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:ssipl_billing/common_modules/style.dart';

// class ViewLedger extends StatefulWidget {
//   const ViewLedger({super.key});

//   @override
//   State<ViewLedger> createState() => _ViewLedgerState();
// }

// class _ViewLedgerState extends State<ViewLedger> {
//   String? Selected_ledger_type;

//   List<String> accounting_ledger_type_list = ['Client', 'Vendor', 'Output GST', 'Input GST', 'Receiveable TDS', 'Payable TDS', 'Consolidate Ledger'];
//   List<String> Inventory_ledger_type_list = ['Petty Cash Ledger', 'Inward Ledger', 'Outward Ledger'];
//   String selectedContent = "Consolidate Ledger"; // Default content
//   String selectedMenu = "Accounting Ledger"; // Tracks the currently selected menu item
//   final List<Map<String, dynamic>> invoice_list = [
//     {
//       'sno': '1',
//       'date': '2024-12-01',
//       'reference_no': '12345',
//       'particulars': 'Purchase of goods',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via card',
//     },
//     {
//       'sno': '2',
//       'date': '2024-12-02',
//       'reference_no': '12346',
//       'particulars': 'Sale of goods',
//       'debit': '0',
//       'credit': '300',
//       'notes': 'Paid via cash',
//     },
//     {
//       'sno': '3',
//       'date': '2024-12-03',
//       'reference_no': '12347',
//       'particulars': 'Office supplies',
//       'debit': '200',
//       'credit': '0',
//       'notes': 'Paid via cheque',
//     },
//     {
//       'sno': '4',
//       'date': '2024-12-04',
//       'reference_no': '12348',
//       'particulars': 'Service income',
//       'debit': '0',
//       'credit': '450',
//       'notes': 'Received via bank transfer',
//     },
//     {
//       'sno': '5',
//       'date': '2024-12-05',
//       'reference_no': '12349',
//       'particulars': 'Rent payment',
//       'debit': '1000',
//       'credit': '0',
//       'notes': 'Paid via online banking',
//     },
//     {
//       'sno': '6',
//       'date': '2024-12-06',
//       'reference_no': '12350',
//       'particulars': 'Consulting fees',
//       'debit': '0',
//       'credit': '600',
//       'notes': 'Paid via cheque',
//     },
//     {
//       'sno': '7',
//       'date': '2024-12-07',
//       'reference_no': '12351',
//       'particulars': 'Product refund',
//       'debit': '200',
//       'credit': '0',
//       'notes': 'Refunded to customer',
//     },
//     {
//       'sno': '8',
//       'date': '2024-12-08',
//       'reference_no': '12352',
//       'particulars': 'Electricity bill payment',
//       'debit': '150',
//       'credit': '0',
//       'notes': 'Paid via card',
//     },
//     {
//       'sno': '9',
//       'date': '2024-12-09',
//       'reference_no': '12353',
//       'particulars': 'Sale of equipment',
//       'debit': '0',
//       'credit': '1200',
//       'notes': 'Received via cash',
//     },
//     {
//       'sno': '10',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '11',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '12',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '13',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '14',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '15',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '16',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '17',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '18',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '19',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '20',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '21',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '22',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '23',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '24',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '25',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '26',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//     {
//       'sno': '27',
//       'date': '2024-12-10',
//       'reference_no': '12354',
//       'particulars': 'Loan repayment',
//       'debit': '500',
//       'credit': '0',
//       'notes': 'Paid via bank transfer',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Primary_colors.Dark,
//       body: Row(
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 Container(
//                   height: 150,
//                   color: Primary_colors.Light,
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(
//                           Icons.arrow_back,
//                           color: Colors.white, // Set the color of the back icon to white
//                         ),
//                         onPressed: () {
//                           // Navigate back to the previous page
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           SizedBox(
//                               child: Text(
//                             selectedContent,
//                             style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text12),
//                           )),
//                           Expanded(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 SizedBox(
//                                   width: max(screenWidth - 1480, 200),
//                                   height: 40,
//                                   child: TextFormField(
//                                     style: const TextStyle(fontSize: 13, color: Colors.white),
//                                     decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(1),
//                                       filled: true,
//                                       fillColor: Primary_colors.Light,
//                                       focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
//                                       // enabledBorder: InputBorder.none, // Removes the enabled border
//                                       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
//                                       hintStyle: const TextStyle(
//                                         fontSize: Primary_font_size.Text7,
//                                         color: Color.fromARGB(255, 167, 165, 165),
//                                       ),
//                                       hintText: 'Search from ledger',
//                                       prefixIcon: const Icon(
//                                         Icons.search,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                                 SizedBox(
//                                   width: 300,
//                                   height: 40,
//                                   child: DropdownButtonFormField<String>(
//                                     style: const TextStyle(fontSize: 13, color: Colors.white),
//                                     decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Adjust padding to center the hint
//                                       filled: true,
//                                       fillColor: Primary_colors.Light,
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: const BorderSide(color: Colors.transparent),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: const BorderSide(color: Colors.transparent),
//                                       ),
//                                       label: const Text(
//                                         'Select type',
//                                         style: TextStyle(
//                                           color: Color.fromARGB(255, 162, 162, 162),
//                                           fontSize: Primary_font_size.Text7,
//                                         ),
//                                       ),
//                                     ),
//                                     dropdownColor: Primary_colors.Dark,
//                                     value: Selected_ledger_type, // Bind your selected value here
//                                     onChanged: (String? newValue) {
//                                       setState(() {
//                                         Selected_ledger_type = newValue; // Update the selected value
//                                       });
//                                     },
//                                     items: selectedMenu == "Accounting Ledger"
//                                         ? accounting_ledger_type_list.map<DropdownMenuItem<String>>(
//                                             (String customer) {
//                                               return DropdownMenuItem<String>(
//                                                 value: customer,
//                                                 child: Text(customer),
//                                               );
//                                             },
//                                           ).toList()
//                                         : Inventory_ledger_type_list.map<DropdownMenuItem<String>>(
//                                             (String customer) {
//                                               return DropdownMenuItem<String>(
//                                                 value: customer,
//                                                 child: Text(customer),
//                                               );
//                                             },
//                                           ).toList(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         height: 40,
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [Primary_colors.Color3, Primary_colors.Color3], // Example gradient colors
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(10), // Ensure border radius for smooth corners
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(0),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text(
//                                     'S.No',
//                                     style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text(
//                                     'Date',
//                                     style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 3,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text(
//                                     'Reference No',
//                                     style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 3,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text(
//                                     'Particulars',
//                                     style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text(
//                                     'Debit',
//                                     style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text(
//                                     'Credit',
//                                     style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 3,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text(
//                                     'Notes',
//                                     style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Padding(
//                                     padding: EdgeInsets.only(right: 20, left: 10, top: 10, bottom: 10),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Text(
//                                           'Balance',
//                                           style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Expanded(child: LedgerData()),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           const Expanded(
//                             flex: 1,
//                             child: Padding(
//                               padding: EdgeInsets.all(10),
//                               child: Text(
//                                 '',
//                                 style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           const Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: EdgeInsets.all(10),
//                               child: Text(
//                                 '',
//                                 style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           const Expanded(
//                             flex: 3,
//                             child: Padding(
//                               padding: EdgeInsets.all(10),
//                               child: Text(
//                                 '',
//                                 style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           const Expanded(
//                             flex: 3,
//                             child: Padding(
//                               padding: EdgeInsets.all(10),
//                               child: Text(
//                                 '',
//                                 style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Container(
//                               decoration: const BoxDecoration(color: Primary_colors.Color3, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
//                               height: 80,
//                               child: const Padding(
//                                 padding: EdgeInsets.all(10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Rs 35123',
//                                       style: TextStyle(color: Primary_colors.Dark, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text15),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                               flex: 2,
//                               child: Container(
//                                 height: 80,
//                                 color: Primary_colors.Color3,
//                                 child: const Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'Rs 34623',
//                                           style: TextStyle(color: Primary_colors.Dark, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text15),
//                                         ),
//                                       ],
//                                     )),
//                               )),
//                           Expanded(
//                             flex: 3,
//                             child: Container(
//                               height: 80,
//                               color: Primary_colors.Color3,
//                               child: const Padding(
//                                 padding: EdgeInsets.all(10),
//                                 child: Text(
//                                   '',
//                                   style: TextStyle(color: Primary_colors.Dark, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text15),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Container(
//                               height: 80,
//                               decoration: const BoxDecoration(color: Primary_colors.Color3, borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
//                               child: const Padding(
//                                 padding: EdgeInsets.only(right: 20, left: 10, top: 10, bottom: 10),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       'Rs 7645',
//                                       style: TextStyle(color: Primary_colors.Dark, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text15),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           SizedBox(
//             width: 300,
//             // color: Primary_colors.Color3,
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 ExpansionTile(
//                   collapsedIconColor: Primary_colors.Color1, iconColor: Primary_colors.Color3,
//                   // leading: Icon(Icons.dashboard, color: selectedMenu == "Dashboard" || selectedMenu == "Settings" ? Colors.blue : Primary_colors.Color1),
//                   title: Text(
//                     "Ledger",
//                     style: TextStyle(
//                       fontSize: Primary_font_size.Text10,
//                       color: selectedMenu == "Accounting Ledger" || selectedMenu == "Inventory Ledger" ? Primary_colors.Color3 : Primary_colors.Color1,
//                     ),
//                   ),
//                   children: [
//                     ListTile(
//                       // leading: icon != null ? Icon(icon, color: isSelected ? Colors.blue : Primary_colors.Color1) : null,
//                       title: Text(
//                         "          Accounting Ledger",
//                         style: TextStyle(color: selectedMenu == "Accounting Ledger" ? Primary_colors.Color8 : Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                       ),
//                       // tileColor: selectedMenu == "Accounting Ledger" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
//                       hoverColor: Colors.blue.withOpacity(0.05),
//                       onTap: () {
//                         setState(() {
//                           selectedMenu = "Accounting Ledger";
//                           selectedContent = "Accounting Ledger";
//                           Selected_ledger_type = null;
//                         });
//                       },
//                     ),
//                     ListTile(
//                       // leading: icon != null ? Icon(icon, color: isSelected ? Colors.blue : Primary_colors.Color1) : null,
//                       title: Text(
//                         "          Inventory Ledger",
//                         style: TextStyle(
//                           fontSize: Primary_font_size.Text7,
//                           color: selectedMenu == "Inventory Ledger" ? Primary_colors.Color8 : Primary_colors.Color1,
//                           fontWeight: selectedMenu == "Inventory Ledger" ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                       // tileColor: selectedMenu == "Inventory Ledger" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
//                       hoverColor: Colors.blue.withOpacity(0.05),
//                       onTap: () {
//                         setState(
//                           () {
//                             selectedMenu = "Inventory Ledger";
//                             selectedContent = "Inventory Ledger";
//                             Selected_ledger_type = null;
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 ExpansionTile(
//                   collapsedIconColor: Primary_colors.Color1, iconColor: Primary_colors.Color3,
//                   // leading: Icon(Icons.account_circle, color: selectedMenu == "Create voucher" || selectedMenu == "View voucher" ? Colors.blue : Primary_colors.Color1),
//                   title: Text(
//                     "Voucher",
//                     style: TextStyle(fontSize: Primary_font_size.Text10, color: selectedMenu == "Create voucher" || selectedMenu == "View voucher" ? Primary_colors.Color3 : Primary_colors.Color1),
//                   ),
//                   children: [
//                     ListTile(
//                       // leading: icon != null ? Icon(icon, color: isSelected ? Colors.blue : Primary_colors.Color1) : null,
//                       title: Text(
//                         "          Create voucher",
//                         style: TextStyle(
//                           fontSize: Primary_font_size.Text7,
//                           color: selectedMenu == "Create voucher" ? Primary_colors.Color8 : Primary_colors.Color1,
//                           // fontWeight: selectedMenu == "Create voucher" ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                       // tileColor: selectedMenu == "Create voucher" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
//                       hoverColor: Colors.blue.withOpacity(0.05),
//                       onTap: () {
//                         // setState(() {
//                         //   selectedMenu = "Create voucher";
//                         //   selectedContent = "Create voucher";
//                         // });
//                       },
//                     ),
//                     ListTile(
//                       // leading: icon != null ? Icon(icon, color: isSelected ? Colors.blue : Primary_colors.Color1) : null,
//                       title: Text(
//                         "          View voucher",
//                         style: TextStyle(
//                             color: selectedMenu == "View voucher" ? Primary_colors.Color8 : Primary_colors.Color1,
//                             // fontWeight: selectedMenu == "View voucher" ? FontWeight.bold : FontWeight.normal,
//                             fontSize: Primary_font_size.Text7),
//                       ),
//                       // tileColor: selectedMenu == "View voucher" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
//                       hoverColor: Colors.blue.withOpacity(0.05),
//                       onTap: () {
//                         setState(() {
//                           selectedMenu = "View voucher";
//                           selectedContent = "View voucher";
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 // Divider(),
//                 // // Static Menu Item 1
//                 ListTile(
//                   // leading: Icon(Icons.notifications, color: selectedMenu == "Notifications" ? Colors.blue : Primary_colors.Color1),
//                   title: Text(
//                     "Balance sheet",
//                     style: TextStyle(
//                       fontSize: Primary_font_size.Text10,
//                       color: selectedMenu == "Balance sheet" ? Primary_colors.Color3 : Primary_colors.Color1,
//                       fontWeight: selectedMenu == "Balance sheet" ? FontWeight.bold : FontWeight.normal,
//                     ),
//                   ),
//                   // tileColor: selectedMenu == "Balance sheet" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
//                   hoverColor: Colors.blue.withOpacity(0.05),
//                   onTap: () {
//                     setState(() {
//                       selectedMenu = "Balance sheet";
//                       selectedContent = "Balance sheet";
//                     });
//                   },
//                 ),
//                 // Static Menu Item 2

//                 // ListTile(
//                 //   leading: Icon(Icons.info, color: selectedMenu == "Notifications" ? Colors.blue : Primary_colors.Color1),
//                 //   title: Text(
//                 //     "About",
//                 //     style: TextStyle(
//                 //       color: selectedMenu == "About" ? Colors.blue : Primary_colors.Color1,
//                 //       fontWeight: selectedMenu == "About" ? FontWeight.bold : FontWeight.normal,
//                 //     ),
//                 //   ),
//                 //   tileColor: selectedMenu == "About" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
//                 //   hoverColor: Colors.blue.withOpacity(0.05),
//                 //   onTap: () {
//                 //     setState(() {
//                 //       selectedMenu = "About";
//                 //       selectedContent = "About Page Content";
//                 //     });
//                 //   },
//                 // ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget LedgerData() {
//     return ListView.separated(
//       separatorBuilder: (context, index) => Container(
//         height: 1,
//         color: const Color.fromARGB(94, 125, 125, 125),
//       ),
//       itemCount: invoice_list.length,
//       itemBuilder: (context, index) {
//         return index % 2 == 0
//             ? Padding(
//                 padding: const EdgeInsets.only(top: 0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(5),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Primary_colors.Light,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 1,
//                             child: Container(
//                               decoration: const BoxDecoration(),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Text(
//                                   invoice_list[index]['sno'],
//                                   style: const TextStyle(
//                                     color: Primary_colors.Color1,
//                                     fontSize: Primary_font_size.Text7,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),

//                           Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Text(
//                                 invoice_list[index]['date'],
//                                 style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Date' column

//                           Expanded(
//                             flex: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Text(
//                                 invoice_list[index]['reference_no'],
//                                 style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Reference No' column

//                           Expanded(
//                             flex: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     invoice_list[index]['particulars'],
//                                     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Particulars' column

//                           Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     invoice_list[index]['debit'],
//                                     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   const Text(
//                                     'Net : 5533',
//                                     style: TextStyle(color: Primary_colors.Color6, fontSize: Primary_font_size.Text5),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   const Text(
//                                     'GST : 500',
//                                     style: TextStyle(color: Primary_colors.Color6, fontSize: Primary_font_size.Text5),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Debit' column
//                           Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Text(
//                                 invoice_list[index]['credit'],
//                                 style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Text(
//                                 invoice_list[index]['notes'],
//                                 style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Credit' column
//                           const Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: EdgeInsets.only(right: 20, left: 10, top: 10, bottom: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     '8233',
//                                     style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text10),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           // Vertical line after 'Notes' column
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             : Padding(
//                 padding: const EdgeInsets.only(top: 0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(5),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Primary_colors.Light,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 1,
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                   // border: Border(
//                                   //   right: BorderSide(color: Primary_colors.Color1, width: 0.2),
//                                   // ),
//                                   ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Text(
//                                   invoice_list[index]['sno'],
//                                   style: const TextStyle(
//                                     color: Primary_colors.Color1,
//                                     fontSize: Primary_font_size.Text7,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Text(
//                                 invoice_list[index]['date'],
//                                 style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Date' column

//                           Expanded(
//                             flex: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Text(
//                                 invoice_list[index]['reference_no'],
//                                 style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Reference No' column

//                           Expanded(
//                             flex: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     invoice_list[index]['particulars'],
//                                     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   const Text(
//                                     'GST : Paid',
//                                     style: TextStyle(color: Primary_colors.Color7, fontSize: Primary_font_size.Text5),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   const Text(
//                                     'TDS : Deducted',
//                                     style: TextStyle(color: Primary_colors.Color7, fontSize: Primary_font_size.Text5),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Particulars' column

//                           Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Text(
//                                 invoice_list[index]['debit'],
//                                 style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Debit' column
//                           Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     invoice_list[index]['credit'],
//                                     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   const Text(
//                                     'Net : +5533',
//                                     style: TextStyle(color: Color.fromARGB(255, 85, 237, 90), fontSize: Primary_font_size.Text5),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   const Tooltip(
//                                     message: "KHV/INGST/241215",
//                                     child: Text(
//                                       'GST : +500',
//                                       style: TextStyle(color: Color.fromARGB(255, 85, 237, 90), fontSize: Primary_font_size.Text5),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   const Tooltip(
//                                     message: "KHV/INTDS/948484",
//                                     child: Text(
//                                       'TDS : -500',
//                                       style: TextStyle(color: Color.fromRGBO(250, 84, 72, 1), fontSize: Primary_font_size.Text5),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Credit' column
//                           Expanded(
//                             flex: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Text(
//                                 invoice_list[index]['notes'],
//                                 style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                               ),
//                             ),
//                           ),
//                           const Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: EdgeInsets.only(right: 20, left: 10, top: 10, bottom: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     '8233',
//                                     style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text10),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Vertical line after 'Notes' column
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//       },
//     );
//   }
// }
