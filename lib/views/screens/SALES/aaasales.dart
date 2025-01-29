// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:ssipl_billing/SALES/Generate_DC/DC_template.dart';
// import 'package:ssipl_billing/SALES/Generate_DC/generateDC.dart';
// import 'package:ssipl_billing/SALES/Generate_Invoice/generateInvoice.dart';
// import 'package:ssipl_billing/SALES/Generate_Invoice/invoice_template.dart';
// import 'package:ssipl_billing/SALES/Generate_Quotation/generateQuotaion.dart';
// import 'package:ssipl_billing/SALES/Generate_Quotation/quotation_template.dart';
// import 'package:ssipl_billing/SALES/Generate_RFQ/RFQ_template.dart';
// import 'package:ssipl_billing/SALES/Generate_RFQ/generateRFQ.dart';
// import 'package:ssipl_billing/SALES/Generate_client_requirements/clientreq_details.dart';
// import 'package:ssipl_billing/SALES/Generate_client_requirements/clientreq_template.dart';
// import 'package:ssipl_billing/SALES/Generate_client_requirements/generate_clientreq.dart';
// import 'package:ssipl_billing/SALES/Generate_creditnote/creditnote_template.dart';
// import 'package:ssipl_billing/SALES/Generate_creditnote/generate_creditnote.dart';
// import 'package:ssipl_billing/SALES/Generate_debitnote/debitnote_template.dart';
// import 'package:ssipl_billing/SALES/Generate_debitnote/generate_debitnote.dart';

// import 'package:ssipl_billing/cards.dart';
// import 'package:ssipl_billing/common_modules/style.dart';

// import 'package:ssipl_billing/view_send_pdf.dart';

// // ignore: depend_on_referenced_packages

// // import 'package:dropdown_search/dropdown_search.dart';
// import 'dart:ui';

// class Sales_Client extends StatefulWidget {
//   const Sales_Client({super.key});
//   static late dynamic Function() quote_Callback;
//   static late dynamic Function() invoice_Callback;
//   static late dynamic Function() RFQ_Callback;
//   static late dynamic Function() Delivery_challan_Callback;
//   static late dynamic Function() creditnote_Callback;
//   static late dynamic Function() debitnote_Callback;
//   static late dynamic Function() clientreq_Callback;

//   @override
//   _Sales_ClientState createState() => _Sales_ClientState();
// }

// class _Sales_ClientState extends State<Sales_Client> {
//   final List<Map<String, dynamic>> items = [
//     {
//       "name": "Khivraj Groups",
//       "type": "Customer",
//       "process": [
//         {
//           "id": "EST/SSIPL - 1001",
//           "date": "16/03/2023",
//           "daycounts": "21 days",
//           "child": [
//             {
//               "name": "Invoice 1",
//               "feedback": "Hello",
//               "generate_Quote": true,
//               "generate_revisedQuote": true,
//               "generate_RFQ": true,
//               "generate_Invoice": true,
//               "generate_deliverychallan": true,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "Hello",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "Hello",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//           ]
//         },
//         {
//           "id": "EST/SSIPL - 1006",
//           "date": "16/03/2023",
//           "daycounts": "21 days",
//           "child": [
//             {
//               "name": "Invoice 1",
//               "feedback": "Hello",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "Hello",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "Hello",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 4",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             }
//           ]
//         },
//         {
//           "id": "EST/SSIPL - 1008",
//           "date": "16/03/2023",
//           "daycounts": "21 days",
//           "child": [
//             {
//               "name": "Invoice 1",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 4",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 5",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             }
//           ]
//         },
//         {
//           "id": "EST/SSIPL - 1010",
//           "date": "16/03/2023",
//           "daycounts": "21 days",
//           "child": [
//             {
//               "name": "Invoice 1",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             }
//           ]
//         }
//       ]
//     },
//     {
//       "name": "Nexa sales and service",
//       "type": "Customer",
//       "process": [
//         {
//           "id": "EST/SSIPL - 1001",
//           "date": "16/03/2023",
//           "daycounts": "21 days",
//           "child": [
//             {
//               "name": "Invoice 1",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             }
//           ]
//         },
//         {
//           "id": "EST/SSIPL - 1006",
//           "date": "16/03/2023",
//           "daycounts": "21 days",
//           "child": [
//             {
//               "name": "Invoice 1",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 4",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             }
//           ]
//         },
//         {
//           "id": "EST/SSIPL - 1008",
//           "date": "16/03/2023",
//           "daycounts": "21 days",
//           "child": [
//             {
//               "name": "Invoice 1",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 4",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 5",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             }
//           ]
//         },
//         {
//           "id": "EST/SSIPL - 1010",
//           "date": "16/03/2023",
//           "daycounts": "21 days",
//           "child": [
//             {
//               "name": "Invoice 1",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_RFQ": false,
//               "generate_Invoice": false,
//               "generate_deliverychallan": false,
//               "credit_note": true,
//               "debit_note": true,
//             }
//           ]
//         }
//       ]
//     }
//   ];

//   // Adding a controller and isAdding flag for each item
//   late List<bool> isAddingList;
//   late List<TextEditingController> controllers;
//   int showcustomerprocess = 1;
//   List<String> list = <String>['One', 'Two', 'Three', 'Four'];
//   String Sales_ClientSearchQuery = '';
//   @override
//   void initState() {
//     super.initState();
//     Sales_Client.quote_Callback = () async => {await generate_quotation()};
//     Sales_Client.invoice_Callback = () async => {await generate_invoice()};
//     Sales_Client.RFQ_Callback = () async => {await generate_RFQ()};
//     Sales_Client.Delivery_challan_Callback = () async => {await generate_Delivery_challan()};

//     Sales_Client.creditnote_Callback = () async => {await generate_creditnote()};
//     Sales_Client.debitnote_Callback = () async => {await generate_debitnote()};
//     Sales_Client.clientreq_Callback = () async => {await generate_client_requirement()};
//     // Initialize isAddingList and controllers based on the number of items
//     isAddingList = List<bool>.filled(items.length, false);
//     controllers = List<TextEditingController>.generate(items.length, (index) => TextEditingController());
//   }

//   dynamic GenerateQuotation_dialougebox() async {
//     await showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents closing the dialog by clicking outside
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: Primary_colors.Dark,
//           content: Stack(
//             children: [
//               const SizedBox(
//                 height: 650,
//                 width: 1300,
//                 child: GenerateQuotation(),
//               ),
//               Positioned(
//                 top: 3,
//                 right: 0,
//                 child: IconButton(
//                   icon: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: const Color.fromARGB(255, 219, 216, 216),
//                     ),
//                     height: 30,
//                     width: 30,
//                     child: const Icon(Icons.close, color: Colors.red),
//                   ),
//                   onPressed: () async {
//                     // Check if the data has any value
//                     if ((quote_products.isNotEmpty) ||
//                         (quote_gstTotals.isNotEmpty) ||
//                         (quote_noteList.isNotEmpty) ||
//                         (quote_recommendationList.isNotEmpty) ||
//                         (quote_productDetails.isNotEmpty) ||
//                         quote_client_addr_name.isNotEmpty ||
//                         quote_client_addr.isNotEmpty ||
//                         quote_bill_addr_name.isNotEmpty ||
//                         quote_bill_addr.isNotEmpty ||
//                         quote_title.isNotEmpty ||
//                         quote_table_heading.isNotEmpty) {
//                       // Show confirmation dialog
//                       bool? proceed = await showDialog<bool>(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Warning"),
//                             content: const Text(
//                               "The data may be lost. Do you want to proceed?",
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(false); // No action
//                                 },
//                                 child: const Text("No"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(true); // Yes action
//                                 },
//                                 child: const Text("Yes"),
//                               ),
//                             ],
//                           );
//                         },
//                       );

//                       // If user confirms (Yes), clear data and close the dialog
//                       if (proceed == true) {
//                         Navigator.of(context).pop(); // Close the dialog
//                         // Clear all the data when dialog is closed
//                         quote_products.clear();
//                         quote_gstTotals.clear();
//                         quote_noteList.clear();
//                         quote_recommendationList.clear();
//                         quote_productDetails.clear();
//                         quote_client_addr_name = "";
//                         quote_client_addr = "";
//                         quote_bill_addr_name = "";
//                         quote_bill_addr = "";
//                         quote_estimate_no = "";
//                         quote_title = "";
//                         quote_table_heading = "";
//                       }
//                     } else {
//                       // If no data, just close the dialog
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   dynamic generate_quotation() async {
//     // bool confirmed = await GenerateQuotation_dialougebox();

//     // if (confirmed) {
//     // Only proceed if the dialog was confirmed
//     Future.delayed(const Duration(seconds: 4), () {
//       Generate_popup.callback();
//     });

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//             backgroundColor: Primary_colors.Light,
//             content: Generate_popup(
//               type: 'E://Quotation.pdf',
//             ));
//       },
//     );
//     // }
//   }

// // ##################################################################################################################################################################################################################################################################################################################################################################

//   dynamic GenerateInvoice_dialougebox() async {
//     await showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents closing the dialog by clicking outside
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: Primary_colors.Dark,
//           content: Stack(
//             children: [
//               const SizedBox(
//                 height: 650,
//                 width: 1300,
//                 child: GenerateInvoice(),
//               ),
//               Positioned(
//                 top: 3,
//                 right: 0,
//                 child: IconButton(
//                   icon: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: const Color.fromARGB(255, 219, 216, 216),
//                     ),
//                     height: 30,
//                     width: 30,
//                     child: const Icon(Icons.close, color: Colors.red),
//                   ),
//                   onPressed: () async {
//                     // Check if the data has any value
//                     if ((invoice_products.isNotEmpty) ||
//                         (invoice_gstTotals.isNotEmpty) ||
//                         (invoice_noteList.isNotEmpty) ||
//                         (invoice_recommendationList.isNotEmpty) ||
//                         (invoice_productDetails.isNotEmpty) ||
//                         (invoice_client_addr_name != "") ||
//                         (invoice_client_addr != "") ||
//                         (invoice_bill_addr_name != "") ||
//                         (invoice_bill_addr != "") ||
//                         (Invoice_no != "") ||
//                         (invoice_title != "") ||
//                         (invoice_table_heading != "")) {
//                       // Show confirmation dialog
//                       bool? proceed = await showDialog<bool>(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Warning"),
//                             content: const Text(
//                               "The data may be lost. Do you want to proceed?",
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(false); // No action
//                                 },
//                                 child: const Text("No"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(true); // Yes action
//                                 },
//                                 child: const Text("Yes"),
//                               ),
//                             ],
//                           );
//                         },
//                       );

//                       // If user confirms (Yes), clear data and close the dialog
//                       if (proceed == true) {
//                         Navigator.of(context).pop(); // Close the dialog
//                         // Clear all the data when dialog is closed
//                         invoice_products.clear();
//                         invoice_gstTotals.clear();
//                         invoice_noteList.clear();
//                         invoice_recommendationList.clear();
//                         invoice_productDetails.clear();
//                         invoice_client_addr_name = "";
//                         invoice_client_addr = "";
//                         invoice_bill_addr_name = "";
//                         invoice_bill_addr = "";
//                         Invoice_no = "";
//                         invoice_title = "";
//                         invoice_table_heading = "";
//                       }
//                     } else {
//                       // If no data, just close the dialog
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   dynamic generate_invoice() async {
//     // bool confirmed = await GenerateInvoice_dialougebox();

//     // if (confirmed) {
//     // Proceed only if the dialog was confirmed
//     Future.delayed(const Duration(seconds: 4), () {
//       Generate_popup.callback();
//     });

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//             backgroundColor: Primary_colors.Light,
//             content: Generate_popup(
//               type: 'E://Invoice.pdf',
//             ));
//       },
//     );
//     // }
//   }

// // ##################################################################################################################################################################################################################################################################################################################################################################

//   dynamic GenerateRFQ_dialougebox() async {
//     await showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents closing the dialog by clicking outside
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: Primary_colors.Dark,
//           content: Stack(
//             children: [
//               const SizedBox(
//                 height: 650,
//                 width: 1300,
//                 child: GenerateRFQ(),
//               ),
//               Positioned(
//                 top: 3,
//                 right: 0,
//                 child: IconButton(
//                   icon: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: const Color.fromARGB(255, 219, 216, 216),
//                     ),
//                     height: 30,
//                     width: 30,
//                     child: const Icon(Icons.close, color: Colors.red),
//                   ),
//                   onPressed: () async {
//                     // Check if any data exists in RFQ variables
//                     if (RFQ_products.isNotEmpty || RFQ_noteList.isNotEmpty || RFQ_recommendationList.isNotEmpty || RFQ_productDetails.isNotEmpty || RFQ_table_heading != "") {
//                       // Show confirmation dialog
//                       bool? proceed = await showDialog<bool>(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Warning"),
//                             content: const Text(
//                               "The data may be lost. Do you want to proceed?",
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(false); // No action
//                                 },
//                                 child: const Text("No"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(true); // Yes action
//                                 },
//                                 child: const Text("Yes"),
//                               ),
//                             ],
//                           );
//                         },
//                       );

//                       // If user confirms (Yes), clear data and close the dialog
//                       if (proceed == true) {
//                         Navigator.of(context).pop(); // Close the dialog
//                         // Clear all the data when dialog is closed
//                         RFQ_products.clear();

//                         RFQ_noteList.clear();
//                         RFQ_recommendationList.clear();
//                         RFQ_productDetails.clear();

//                         RFQ_table_heading = "";
//                       }
//                     } else {
//                       // If no data, just close the dialog
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   dynamic generate_RFQ() async {
//     // bool confirmed = await GenerateInvoice_dialougebox();

//     // if (confirmed) {
//     // Proceed only if the dialog was confirmed
//     Future.delayed(const Duration(seconds: 4), () {
//       Generate_popup.callback();
//     });

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//             backgroundColor: Primary_colors.Light,
//             content: Generate_popup(
//               type: 'E://RFQ.pdf',
//             ));
//       },
//     );
//     // }
//   }

// // ##################################################################################################################################################################################################################################################################################################################################################################

//   dynamic GenerateDelivery_challan_dialougebox() async {
//     await showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents closing the dialog by clicking outside
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: Primary_colors.Dark,
//           content: Stack(
//             children: [
//               const SizedBox(
//                 height: 650,
//                 width: 1300,
//                 child: GenerateDelivery_challan(),
//               ),
//               Positioned(
//                 top: 3,
//                 right: 0,
//                 child: IconButton(
//                   icon: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: const Color.fromARGB(255, 219, 216, 216),
//                     ),
//                     height: 30,
//                     width: 30,
//                     child: const Icon(Icons.close, color: Colors.red),
//                   ),
//                   onPressed: () async {
//                     // Check if the data has any value
//                     if ((Delivery_challan_products.isNotEmpty) ||
//                         (Delivery_challan_noteList.isNotEmpty) ||
//                         (Delivery_challan_recommendationList.isNotEmpty) ||
//                         (Delivery_challan_productDetails.isNotEmpty) ||
//                         Delivery_challan_client_addr_name != "" ||
//                         Delivery_challan_client_addr != "" ||
//                         Delivery_challan_bill_addr_name != "" ||
//                         Delivery_challan_bill_addr != "" ||
//                         Delivery_challan_no != "" ||
//                         Delivery_challan_title != "" ||
//                         Delivery_challan_table_heading != "") {
//                       // Show confirmation dialog
//                       bool? proceed = await showDialog<bool>(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Warning"),
//                             content: const Text(
//                               "The data may be lost. Do you want to proceed?",
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(false); // No action
//                                 },
//                                 child: const Text("No"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(true); // Yes action
//                                 },
//                                 child: const Text("Yes"),
//                               ),
//                             ],
//                           );
//                         },
//                       );

//                       // If user confirms (Yes), clear data and close the dialog
//                       if (proceed == true) {
//                         Navigator.of(context).pop(); // Close the dialog
//                         // Clear all the data when dialog is closed
//                         Delivery_challan_products.clear();
//                         Delivery_challan_noteList.clear();
//                         Delivery_challan_recommendationList.clear();
//                         Delivery_challan_productDetails.clear();
//                         Delivery_challan_client_addr_name = "";
//                         Delivery_challan_client_addr = "";
//                         Delivery_challan_bill_addr_name = "";
//                         Delivery_challan_bill_addr = "";
//                         Delivery_challan_no = "";
//                         Delivery_challan_title = "";
//                         Delivery_challan_table_heading = "";
//                       }
//                     } else {
//                       // If no data, just close the dialog
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   dynamic generate_Delivery_challan() async {
//     // bool confirmed = await GenerateDelivery_challan_dialougebox();

//     // if (confirmed) {
//     // Proceed only if the dialog was confirmed
//     Future.delayed(const Duration(seconds: 4), () {
//       Generate_popup.callback();
//     });

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//             backgroundColor: Primary_colors.Light,
//             content: Generate_popup(
//               type: 'E://Delivery_challan.pdf',
//             ));
//       },
//     );
//     // }
//   }

// // ##################################################################################################################################################################################################################################################################################################################################################################

//   dynamic Generate_creditnote_dialougebox() async {
//     await showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents closing the dialog by clicking outside
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: Primary_colors.Dark,
//           content: Stack(
//             children: [
//               const SizedBox(
//                 height: 650,
//                 width: 1300,
//                 child: Generate_creditnote(),
//               ),
//               Positioned(
//                 top: 3,
//                 right: 0,
//                 child: IconButton(
//                   icon: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: const Color.fromARGB(255, 219, 216, 216),
//                     ),
//                     height: 30,
//                     width: 30,
//                     child: const Icon(Icons.close, color: Colors.red),
//                   ),
//                   onPressed: () async {
//                     // Check if any data exists in creditnote variables
//                     if ((creditnote_products.isNotEmpty) ||
//                         (creditnote_gstTotals.isNotEmpty) ||
//                         (creditnote_noteList.isNotEmpty) ||
//                         (creditnote_recommendationList.isNotEmpty) ||
//                         (creditnote_productDetails.isNotEmpty) ||
//                         creditnote_client_addr_name != "" ||
//                         creditnote_client_addr != "" ||
//                         creditnote_bill_addr_name != "" ||
//                         creditnote_bill_addr != "" ||
//                         creditnote_no != "" ||
//                         creditnote_table_heading != "") {
//                       // Show confirmation dialog
//                       bool? proceed = await showDialog<bool>(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Warning"),
//                             content: const Text(
//                               "The data may be lost. Do you want to proceed?",
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(false); // No action
//                                 },
//                                 child: const Text("No"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(true); // Yes action
//                                 },
//                                 child: const Text("Yes"),
//                               ),
//                             ],
//                           );
//                         },
//                       );

//                       // If user confirms (Yes), clear data and close the dialog
//                       if (proceed == true) {
//                         Navigator.of(context).pop(); // Close the dialog
//                         // Clear all the data when dialog is closed
//                         creditnote_products.clear();
//                         creditnote_gstTotals.clear();
//                         creditnote_noteList.clear();
//                         creditnote_recommendationList.clear();
//                         creditnote_productDetails.clear();
//                         creditnote_client_addr_name = "";
//                         creditnote_client_addr = "";
//                         creditnote_bill_addr_name = "";
//                         creditnote_bill_addr = "";
//                         creditnote_no = "";
//                         // creditnote_title = "";
//                         creditnote_table_heading = "";
//                       }
//                     } else {
//                       // If no data, just close the dialog
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   dynamic generate_creditnote() async {
//     // bool confirmed = await GenerateInvoice_dialougebox();

//     // if (confirmed) {
//     // Proceed only if the dialog was confirmed
//     Future.delayed(const Duration(seconds: 4), () {
//       Generate_popup.callback();
//     });

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//             backgroundColor: Primary_colors.Light,
//             content: Generate_popup(
//               type: 'E://Credit_note.pdf',
//             ));
//       },
//     );
//     // }
//   }

// // ##################################################################################################################################################################################################################################################################################################################################################################

//   dynamic Generate_debitnote_dialougebox() async {
//     await showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents closing the dialog by clicking outside
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: Primary_colors.Dark,
//           content: Stack(
//             children: [
//               const SizedBox(
//                 height: 650,
//                 width: 1300,
//                 child: Generate_debitnote(),
//               ),
//               Positioned(
//                 top: 3,
//                 right: 0,
//                 child: IconButton(
//                   icon: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: const Color.fromARGB(255, 219, 216, 216),
//                     ),
//                     height: 30,
//                     width: 30,
//                     child: const Icon(Icons.close, color: Colors.red),
//                   ),
//                   onPressed: () async {
//                     // Check if any data exists in debitnote variables
//                     if ((debitnote_products.isNotEmpty) ||
//                         (debitnote_gstTotals.isNotEmpty) ||
//                         (debitnote_noteList.isNotEmpty) ||
//                         (debitnote_recommendationList.isNotEmpty) ||
//                         (debitnote_productDetails.isNotEmpty) ||
//                         debitnote_client_addr_name != "" ||
//                         debitnote_client_addr != "" ||
//                         debitnote_bill_addr_name != "" ||
//                         debitnote_bill_addr != "" ||
//                         debitnote_no != "" ||
//                         debitnote_table_heading != "") {
//                       // Show confirmation dialog
//                       bool? proceed = await showDialog<bool>(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Warning"),
//                             content: const Text(
//                               "The data may be lost. Do you want to proceed?",
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(false); // No action
//                                 },
//                                 child: const Text("No"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(true); // Yes action
//                                 },
//                                 child: const Text("Yes"),
//                               ),
//                             ],
//                           );
//                         },
//                       );

//                       // If user confirms (Yes), clear data and close the dialog
//                       if (proceed == true) {
//                         Navigator.of(context).pop(); // Close the dialog
//                         // Clear all the data when dialog is closed
//                         debitnote_products.clear();
//                         debitnote_gstTotals.clear();
//                         debitnote_noteList.clear();
//                         debitnote_recommendationList.clear();
//                         debitnote_productDetails.clear();
//                         debitnote_client_addr_name = "";
//                         debitnote_client_addr = "";
//                         debitnote_bill_addr_name = "";
//                         debitnote_bill_addr = "";
//                         debitnote_no = "";
//                         // debitnote_title = "";
//                         debitnote_table_heading = "";
//                       }
//                     } else {
//                       // If no data, just close the dialog
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   dynamic generate_debitnote() async {
//     // bool confirmed = await GenerateInvoice_dialougebox();

//     // if (confirmed) {
//     // Proceed only if the dialog was confirmed
//     Future.delayed(const Duration(seconds: 4), () {
//       Generate_popup.callback();
//     });

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//             backgroundColor: Primary_colors.Light,
//             content: Generate_popup(
//               type: 'E://Debit_note.pdf',
//             ));
//       },
//     );
//     // }
//   }

// // ##################################################################################################################################################################################################################################################################################################################################################################

//   dynamic Generate_client_reqirement_dialougebox(String value) async {
//     await showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents closing the dialog by clicking outside
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           backgroundColor: Primary_colors.Dark,
//           content: Stack(
//             children: [
//               SizedBox(
//                 height: 650,
//                 width: 900,
//                 child: Generate_clientreq(
//                   value: value,
//                 ),
//               ),
//               Positioned(
//                 top: 3,
//                 right: 0,
//                 child: IconButton(
//                   icon: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: const Color.fromARGB(255, 219, 216, 216),
//                     ),
//                     height: 30,
//                     width: 30,
//                     child: const Icon(Icons.close, color: Colors.red),
//                   ),
//                   onPressed: () async {
//                     // Check if any data exists in clientreq variables
//                     if ((clientreq_products.isNotEmpty) ||
//                         (clientreq_noteList.isNotEmpty) ||
//                         (clientreq_recommendationList.isNotEmpty) ||
//                         (clientreq_productDetails.isNotEmpty) ||
//                         clientreq_client_addr_name != "" ||
//                         clientreq_client_addr != "" ||
//                         clientreq_bill_addr_name != "" ||
//                         clientreq_bill_addr != "" ||
//                         clientreq_no != "" ||
//                         clientreq_table_heading != "" ||
//                         clientreq_MOR != "" ||
//                         clientreq_GST != "" ||
//                         clientreq_email != "" ||
//                         clientreq_contact_number != "") {
//                       // Show confirmation dialog
//                       bool? proceed = await showDialog<bool>(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Warning"),
//                             content: const Text(
//                               "The data may be lost. Do you want to proceed?",
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(false); // No action
//                                 },
//                                 child: const Text("No"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(true); // Yes action
//                                 },
//                                 child: const Text("Yes"),
//                               ),
//                             ],
//                           );
//                         },
//                       );

//                       // If user confirms (Yes), clear data and close the dialog
//                       if (proceed == true) {
//                         Navigator.of(context).pop(); // Close the dialog
//                         // Clear all the data when dialog is closed
//                         clientreq_products.clear();

//                         clientreq_noteList.clear();
//                         clientreq_recommendationList.clear();
//                         clientreq_productDetails.clear();
//                         clientreq_client_addr_name = "";
//                         clientreq_client_addr = "";
//                         clientreq_bill_addr_name = "";
//                         clientreq_bill_addr = "";
//                         clientreq_no = "";
//                         clientreq_MOR = "";
//                         clientreq_GST = "";
//                         clientreq_email = "";
//                         clientreq_contact_number = "";
//                         clientreq_table_heading = "";
//                         clientreqDetailsState.pickedFile = null;
//                       }
//                     } else {
//                       // If no data, just close the dialog
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   dynamic generate_client_requirement() async {
//     // bool confirmed = await GenerateInvoice_dialougebox();

//     // if (confirmed) {
//     // Proceed only if the dialog was confirmed
//     Future.delayed(const Duration(seconds: 4), () {
//       Generate_popup.callback();
//     });

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//             backgroundColor: Primary_colors.Light,
//             content: Generate_popup(
//               type: 'E://Client_requirement.pdf',
//             ));
//       },
//     );
//     // }
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
//     return Scaffold(
//       backgroundColor: Primary_colors.Dark,
//       body: Center(
//         child: SizedBox(
//           // width: 1500,
//           child: Column(
//             children: [
//               const SizedBox(height: 185, child: cardview()),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
//                         padding: const EdgeInsets.all(10),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [Primary_colors.Color3, Primary_colors.Color3], // Example gradient colors
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ),
//                                 borderRadius: BorderRadius.circular(15), // Ensure border radius for smooth corners
//                               ),
//                               child: const Padding(
//                                 padding: EdgeInsets.only(left: 16, right: 47),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         'Process ID',
//                                         style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 4,
//                                       child: Text(
//                                         'Sales_Client Name',
//                                         style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         'Date',
//                                         style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         'Days',
//                                         style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Expanded(
//                               child: ListView.builder(
//                                 itemCount: items[showcustomerprocess]['process'].length,
//                                 itemBuilder: (context, index) {
//                                   return Padding(
//                                     padding: const EdgeInsets.only(top: 10),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: Primary_colors.Dark,
//                                           borderRadius: BorderRadius.circular(15),
//                                         ),
//                                         child: ExpansionTile(
//                                           collapsedIconColor: const Color.fromARGB(255, 135, 132, 132),
//                                           iconColor: Colors.red,
//                                           collapsedBackgroundColor: Primary_colors.Dark,
//                                           backgroundColor: Primary_colors.Dark,
//                                           title: Row(
//                                             children: [
//                                               Expanded(
//                                                 flex: 2,
//                                                 child: Text(
//                                                   items[showcustomerprocess]['process'][index]['id'],
//                                                   style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 4,
//                                                 child: Text(
//                                                   items[showcustomerprocess]['name'],
//                                                   style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 2,
//                                                 child: Text(
//                                                   items[showcustomerprocess]['process'][index]['date'],
//                                                   style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 2,
//                                                 child: Text(
//                                                   items[showcustomerprocess]['process'][index]['daycounts'],
//                                                   style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           children: [
//                                             SizedBox(
//                                               height: ((items[showcustomerprocess]['process'][index]['child'].length * 80) + 20).toDouble(),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(16.0),
//                                                 child: ListView.builder(
//                                                   itemCount: items[showcustomerprocess]['process'][index]['child'].length, // +1 for "Add Event" button
//                                                   itemBuilder: (context, childIndex) {
//                                                     return Row(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Column(
//                                                           children: [
//                                                             Container(
//                                                               padding: const EdgeInsets.all(8),
//                                                               decoration: const BoxDecoration(
//                                                                 shape: BoxShape.circle,
//                                                                 color: Colors.green,
//                                                               ),
//                                                               child: const Icon(
//                                                                 Icons.event,
//                                                                 color: Colors.white,
//                                                               ),
//                                                             ),
//                                                             if (childIndex != items[showcustomerprocess]['process'][index]['child'].length - 1)
//                                                               Container(
//                                                                 width: 2,
//                                                                 height: 40,
//                                                                 color: Colors.green,
//                                                               ),
//                                                           ],
//                                                         ),
//                                                         Expanded(
//                                                             child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                           children: [
//                                                             Expanded(
//                                                               child: Column(
//                                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                                 children: [
//                                                                   Padding(
//                                                                     padding: const EdgeInsets.only(top: 2.0, left: 10),
//                                                                     child: Row(
//                                                                       children: [
//                                                                         Text(
//                                                                           items[showcustomerprocess]['process'][index]['child'][childIndex]["name"],
//                                                                           style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
//                                                                         ),
//                                                                         // const SizedBox(width: 5),
//                                                                         // Expanded(
//                                                                         //   child: Text(
//                                                                         //     overflow: TextOverflow.ellipsis,
//                                                                         //     items[showcustomerprocess]['process'][index]['child'][childIndex]["feedback"],
//                                                                         //     style: const TextStyle(color: Colors.red, fontSize: Primary_font_size.Text5),
//                                                                         //   ),
//                                                                         // )
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Row(
//                                                                     mainAxisAlignment: MainAxisAlignment.start,
//                                                                     children: [
//                                                                       if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_Quote"] == true)
//                                                                         TextButton(
//                                                                           onPressed: () {
//                                                                             GenerateQuotation_dialougebox();
//                                                                           },
//                                                                           child: const Text(
//                                                                             "Quotation",
//                                                                             style: TextStyle(color: Colors.blue, fontSize: 12),
//                                                                           ),
//                                                                         ),
//                                                                       if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_revisedQuote"] == true)
//                                                                         TextButton(
//                                                                           onPressed: () {
//                                                                             GenerateQuotation_dialougebox();
//                                                                           },
//                                                                           child: const Text(
//                                                                             "RevisedQuotation",
//                                                                             style: TextStyle(color: Colors.blue, fontSize: 12),
//                                                                           ),
//                                                                         ),
//                                                                       if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_RFQ"] == true)
//                                                                         TextButton(
//                                                                           onPressed: () {
//                                                                             GenerateRFQ_dialougebox();
//                                                                           },
//                                                                           child: const Text(
//                                                                             "Generate RFQ",
//                                                                             style: TextStyle(color: Colors.blue, fontSize: 12),
//                                                                           ),
//                                                                         ),
//                                                                       if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_Invoice"] == true)
//                                                                         TextButton(
//                                                                           onPressed: () {
//                                                                             GenerateInvoice_dialougebox();
//                                                                           },
//                                                                           child: const Text(
//                                                                             "Invoice",
//                                                                             style: TextStyle(color: Colors.blue, fontSize: 12),
//                                                                           ),
//                                                                         ),
//                                                                       if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_deliverychallan"] == true)
//                                                                         TextButton(
//                                                                           onPressed: () {
//                                                                             GenerateDelivery_challan_dialougebox();
//                                                                             // (items[showcustomerprocess]['process'][index]['child'] as List).add({
//                                                                             //   "name": "Requirement4",
//                                                                             //   "generate_po": true,
//                                                                             //   "generate_RFQ": false,
//                                                                             // });
//                                                                           },
//                                                                           child: const Text(
//                                                                             "Deliverychallan",
//                                                                             style: TextStyle(color: Colors.blue, fontSize: 12),
//                                                                           ),
//                                                                         ),
//                                                                       if (items[showcustomerprocess]['process'][index]['child'][childIndex]["credit_note"] == true)
//                                                                         TextButton(
//                                                                           onPressed: () {
//                                                                             Generate_creditnote_dialougebox();
//                                                                             // (items[showcustomerprocess]['process'][index]['child'] as List).add({
//                                                                             //   "name": "Requirement4",
//                                                                             //   "generate_po": true,
//                                                                             //   "generate_RFQ": false,
//                                                                             // });
//                                                                           },
//                                                                           child: const Text(
//                                                                             "Credit",
//                                                                             style: TextStyle(color: Colors.blue, fontSize: 12),
//                                                                           ),
//                                                                         ),
//                                                                       if (items[showcustomerprocess]['process'][index]['child'][childIndex]["debit_note"] == true)
//                                                                         TextButton(
//                                                                           onPressed: () {
//                                                                             Generate_debitnote_dialougebox();
//                                                                             // (items[showcustomerprocess]['process'][index]['child'] as List).add({
//                                                                             //   "name": "Requirement4",
//                                                                             //   "generate_po": true,
//                                                                             //   "generate_RFQ": false,
//                                                                             // });
//                                                                           },
//                                                                           child: const Text(
//                                                                             "Debit",
//                                                                             style: TextStyle(color: Colors.blue, fontSize: 12),
//                                                                           ),
//                                                                         ),
//                                                                     ],
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 Container(
//                                                                   height: 40,
//                                                                   width: 2,
//                                                                   color: const Color.fromARGB(78, 172, 170, 170),
//                                                                 ),
//                                                                 SizedBox(
//                                                                   width: 200,
//                                                                   child: TextFormField(
//                                                                     maxLines: 2,
//                                                                     style: const TextStyle(
//                                                                       fontSize: Primary_font_size.Text7,
//                                                                       color: Colors.white,
//                                                                     ),
//                                                                     decoration: const InputDecoration(
//                                                                       filled: true,
//                                                                       fillColor: Primary_colors.Dark,
//                                                                       hintText: 'Enter Feedback',
//                                                                       hintStyle: TextStyle(
//                                                                         fontSize: Primary_font_size.Text7,
//                                                                         color: Color.fromARGB(255, 179, 178, 178),
//                                                                       ),
//                                                                       border: InputBorder.none, // Remove default border
//                                                                       contentPadding: EdgeInsets.all(10), // Adjust padding
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             )
//                                                           ],
//                                                         ))
//                                                       ],
//                                                     );
//                                                   },
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       flex: 1,
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Expanded(
//                                 child: SizedBox(
//                                   height: 40,
//                                   child: TextFormField(
//                                     style: const TextStyle(fontSize: 13, color: Colors.white),
//                                     decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(1),
//                                       filled: true,
//                                       fillColor: Primary_colors.Light,
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: const BorderSide(
//                                           color: Color.fromARGB(0, 0, 0, 0),
//                                         ),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.black)),
//                                       hintStyle: const TextStyle(
//                                         fontSize: Primary_font_size.Text7,
//                                         color: Color.fromARGB(255, 167, 165, 165),
//                                       ),
//                                       hintText: 'Search Sales Client from the list',
//                                       prefixIcon: const Icon(
//                                         Icons.search,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(
//                                   size: 30,
//                                   Icons.filter_alt,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               const SizedBox(width: 5),
//                               PopupMenuButton<String>(
//                                 color: const Color.fromARGB(255, 86, 86, 114),
//                                 onSelected: (String value) {
//                                   Generate_client_reqirement_dialougebox(value);

//                                   // items.add(
//                                   //   {
//                                   //     "name": "Pandi Groups",
//                                   //     "type": "Customer",
//                                   //     "process": [
//                                   //       {
//                                   //         "id": "EST/SSIPL - 101",
//                                   //         "date": "16/03/2023",
//                                   //         "daycounts": "21 days",
//                                   //         "child": [
//                                   //           {"name": "Requirement", "generate_po": true, "generate_RFQ": false},
//                                   //         ]
//                                   //       },
//                                   //     ]
//                                   //   },
//                                   // );
//                                 },
//                                 itemBuilder: (BuildContext context) {
//                                   return <PopupMenuEntry<String>>[
//                                     const PopupMenuItem<String>(
//                                       value: "Enquiry",
//                                       child: Text(
//                                         "Enquiry",
//                                         style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                     const PopupMenuItem<String>(
//                                       value: "Customer",
//                                       child: Text(
//                                         "Customer",
//                                         style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                       ),
//                                     ),
//                                   ];
//                                 },
//                                 child: const Icon(size: 30, Icons.add, color: Primary_colors.Color3),
//                               )
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount: items.length,
//                               itemBuilder: (context, index) {
//                                 final Sales_Client = items[index]['name'];
//                                 return _buildSales_ClientCard(Sales_Client, items[index]['type'], index);
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSales_ClientCard(String Sales_Client, String type, int index) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Container(
//         // shape: RoundedRectangleBorder(
//         //   borderRadius: BorderRadius.circular(15),
//         // ),
//         // elevation: 3,

//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: showcustomerprocess == index
//                 ? [Primary_colors.Color3, Primary_colors.Color3]
//                 : [
//                     Primary_colors.Light,
//                     Primary_colors.Light,
//                   ], // Example gradient colors
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20), // Ensure border radius for smooth corners
//         ),
//         child: ListTile(
//           leading: Icon(
//             Icons.people,
//             color: type == 'Customer' ? Colors.white : Colors.red,
//             size: 25,
//           ),
//           title: Text(
//             Sales_Client,
//             style: GoogleFonts.lato(
//               textStyle: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
//             ),
//           ),
//           trailing: IconButton(
//             onPressed: () {},
//             icon: Icon(
//               size: 20,
//               Icons.notifications,
//               color: showcustomerprocess == index ? Colors.red : Colors.amber,
//             ),
//           ),
//           // const SizedBox(width: 5),
//           // const Icon(
//           //   Icons.arrow_forward_ios,
//           //   color: Colors.grey,
//           //   size: 15,
//           // ),
//           onTap: () {
//             setState(() {
//               showcustomerprocess = index;
//             });
//             // Implement Sales_Client details or actions here
//           },
//         ),
//       ),
//     );
//   }
// }
