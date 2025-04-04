// import 'dart:math';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/CustomPDF_Controllers/CustomPDF_Invoice_actions.dart';
// import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/Subscription_actions.dart';
// import 'package:ssipl_billing/services/SUBSCRIPTION/CustomPDF_services/Subscription_CustomPDF_Invoice_services.dart';
// import 'package:ssipl_billing/views/screens/BILLING/piechart.dart';
// import 'package:ssipl_billing/views/screens/SUBSCRIPTION/CustomPDF/Subscription_CustomPDF_invoicePDF.dart';
// import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_Invoice/sub_generateInvoice.dart';
// import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_Invoice/sub_invoice_template.dart';
// import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_Quotation/sub_generateQuotaion.dart';
// import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_Quotation/sub_quotation_template.dart';
// import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_client_req/sub_clientreq_details.dart';
// import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_client_req/sub_clientreq_template.dart';
// import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_client_req/sub_generate_clientreq.dart';
// import 'package:ssipl_billing/themes/style.dart';

// class Subscription_Client extends StatefulWidget {
//   const Subscription_Client({super.key});
//   static late dynamic Function() sub_clientreq_Callback;
//   static late dynamic Function() sub_quote_Callback;
//   static late dynamic Function() sub_invoice_Callback;

//   @override
//   _Subscription_ClientState createState() => _Subscription_ClientState();
// }

// class _Subscription_ClientState extends State<Subscription_Client> with SingleTickerProviderStateMixin {
//   var inst_CustomPDF_Services = Subscription_CustomPDF_Services();
//   final Subscription_CustomPDF_InvoiceController pdfpopup_controller = Get.find<Subscription_CustomPDF_InvoiceController>();
//   final SubscriptionController subscriptionController = Get.find<SubscriptionController>();
//   var inst = Subscription_CustomPDF_InvoicePDF();
//   void _startAnimation() {
//     if (!subscriptionController.subscriptionModel.animationController.isAnimating) {
//       subscriptionController.subscriptionModel.animationController.forward(from: 0).then((_) {
//         // widget.refresh(context);
//       });
//     }
//   }

//   void initState() {
//     super.initState();
//     Subscription_Client.sub_quote_Callback = () async => {await generate_quotation()};
//     Subscription_Client.sub_invoice_Callback = () async => {await generate_invoice()};

//     Subscription_Client.sub_clientreq_Callback = () async => {await generate_client_requirement()};
//     // Initialize isAddingList and controllers based on the number of items
//     isAddingList = List<bool>.filled(items.length, false);
//     controllers = List<TextEditingController>.generate(items.length, (index) => TextEditingController());
//     subscriptionController.subscriptionModel.animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//   }

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
//               "generate_Invoice": true,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "Hello",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "Hello",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
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
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "Hello",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "Hello",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 4",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
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
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 4",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 5",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
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
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             }
//           ]
//         }
//       ]
//     },
//     {
//       "name": "Nexa Subscription and service",
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
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
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
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 4",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
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
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 3",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 4",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 5",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
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
//               "generate_Invoice": false,
//             },
//             {
//               "name": "Invoice 2",
//               "feedback": "",
//               "generate_Quote": true,
//               "generate_revisedQuote": false,
//               "generate_Invoice": false,
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
//   String Subscription_ClientSearchQuery = '';
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
//                 child: Generatesub_Quotation(),
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
//                     if ((sub_quote_products.isNotEmpty) ||
//                         (sub_quote_gstTotals.isNotEmpty) ||
//                         (sub_quote_noteList.isNotEmpty) ||
//                         (sub_quote_recommendationList.isNotEmpty) ||
//                         sub_quote_client_addr_name.isNotEmpty ||
//                         sub_quote_client_addr.isNotEmpty ||
//                         sub_quote_bill_addr_name.isNotEmpty ||
//                         sub_quote_bill_addr.isNotEmpty ||
//                         sub_quote_title.isNotEmpty ||
//                         sub_quote_table_heading.isNotEmpty) {
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
//                         sub_quote_products.clear();
//                         sub_quote_gstTotals.clear();
//                         sub_quote_noteList.clear();
//                         sub_quote_recommendationList.clear();
//                         sub_quote_client_addr_name = "";
//                         sub_quote_client_addr = "";
//                         sub_quote_bill_addr_name = "";
//                         sub_quote_bill_addr = "";
//                         sub_quote_estimate_no = "";
//                         sub_quote_title = "";
//                         sub_quote_table_heading = "";
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

//     // showDialog(
//     //   context: context,
//     //   builder: (context) {
//     //     return AlertDialog(
//     //         backgroundColor: Primary_colors.Light,
//     //         content: Generate_popup(
//     //           type: 'E://sub_Quotation.pdf',
//     //         ));
//     //   },
//     // );
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
//                 child: Generatesub_invoice(),
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
//                     if ((sub_invoice_products.isNotEmpty) ||
//                         (sub_invoice_gstTotals.isNotEmpty) ||
//                         (sub_invoice_noteList.isNotEmpty) ||
//                         (sub_invoice_recommendationList.isNotEmpty) ||
//                         (sub_invoice_productDetails.isNotEmpty) ||
//                         (sub_invoice_client_addr_name != "") ||
//                         (sub_invoice_client_addr != "") ||
//                         (sub_invoice_bill_addr_name != "") ||
//                         (sub_invoice_bill_addr != "") ||
//                         (sub_invoice_no != "") ||
//                         (sub_invoice_title != "") ||
//                         (sub_invoice_table_heading != "")) {
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
//                         sub_invoice_products.clear();
//                         sub_invoice_gstTotals.clear();
//                         sub_invoice_noteList.clear();
//                         sub_invoice_recommendationList.clear();
//                         sub_invoice_productDetails.clear();
//                         sub_invoice_client_addr_name = "";
//                         sub_invoice_client_addr = "";
//                         sub_invoice_bill_addr_name = "";
//                         sub_invoice_bill_addr = "";
//                         sub_invoice_no = "";
//                         sub_invoice_title = "";
//                         sub_invoice_table_heading = "";
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

//     // showDialog(
//     //   context: context,
//     //   builder: (context) {
//     //     return AlertDialog(
//     //         backgroundColor: Primary_colors.Light,
//     //         content: Generate_popup(
//     //           type: 'E://Invoice.pdf',
//     //         ));
//     //   },
//     // );
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
//                 height: 600,
//                 width: 900,
//                 child: Generate_sub_clientreq(
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
//                     // Check if any data exists in sub_clientreq variables
//                     if ((sub_clientreq_products.isNotEmpty) ||
//                         (sub_clientreq_noteList.isNotEmpty) ||
//                         (sub_clientreq_recommendationList.isNotEmpty) ||
//                         (sub_clientreq_productDetails.isNotEmpty) ||
//                         sub_clientreq_client_addr_name != "" ||
//                         sub_clientreq_client_addr != "" ||
//                         sub_clientreq_bill_addr_name != "" ||
//                         sub_clientreq_bill_addr != "" ||
//                         sub_clientreq_no != "" ||
//                         sub_clientreq_table_heading != "" ||
//                         sub_clientreq_MOR != "" ||
//                         sub_clientreq_GST != "" ||
//                         sub_clientreq_email != "" ||
//                         sub_clientreq_contact_number != "") {
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
//                         sub_clientreq_products.clear();
//                         sub_clientreq_noteList.clear();
//                         sub_clientreq_recommendationList.clear();
//                         sub_clientreq_productDetails.clear();
//                         sub_clientreq_client_addr_name = "";
//                         sub_clientreq_client_addr = "";
//                         sub_clientreq_bill_addr_name = "";
//                         sub_clientreq_bill_addr = "";
//                         sub_clientreq_no = "";
//                         sub_clientreq_MOR = "";
//                         sub_clientreq_GST = "";
//                         sub_clientreq_email = "";
//                         sub_clientreq_contact_number = "";
//                         sub_clientreq_table_heading = "";
//                         sub_clientreqDetailsState.pickedFile = null;
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

//     // showDialog(
//     //   context: context,
//     //   builder: (context) {
//     //     return AlertDialog(
//     //         backgroundColor: Primary_colors.Light,
//     //         content: Generate_popup(
//     //           type: 'E://Client_requirement.pdf',
//     //         ));
//     //   },
//     // );
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
//     // double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//         backgroundColor: Primary_colors.Dark,
//         body: DefaultTabController(
//           length: 2,
//           child: Center(
//             child: SizedBox(
//               // width: 1500,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           ShaderMask(
//                             shaderCallback: (bounds) => const LinearGradient(
//                               colors: [Primary_colors.Color3, Primary_colors.Color4], // Example gradient
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ).createShader(bounds),
//                             child: const Icon(
//                               Icons.subscriptions,
//                               size: 25.0,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           const Text(
//                             'Subscription',
//                             style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text13),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: _startAnimation,
//                             child: AnimatedBuilder(
//                               animation: subscriptionController.subscriptionModel.animationController,
//                               builder: (context, child) {
//                                 return Transform.rotate(
//                                   angle: -subscriptionController.subscriptionModel.animationController.value * 2 * pi, // Counterclockwise rotation
//                                   child: Transform.scale(
//                                     scale: TweenSequence([
//                                       TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 50),
//                                       TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 50),
//                                     ]).animate(CurvedAnimation(parent: subscriptionController.subscriptionModel.animationController, curve: Curves.easeInOut)).value, // Zoom in and return to normal
//                                     child: Opacity(
//                                       opacity: TweenSequence([
//                                         TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.5), weight: 50),
//                                         TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.0), weight: 50),
//                                       ]).animate(CurvedAnimation(parent: subscriptionController.subscriptionModel.animationController, curve: Curves.easeInOut)).value, // Fade and return to normal
//                                       child: ClipOval(
//                                         child: Image.asset(
//                                           'assets/images/reload.png',
//                                           fit: BoxFit.cover,
//                                           width: 30,
//                                           height: 30,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           SizedBox(
//                             width: 400,
//                             height: 40,
//                             child: Stack(
//                               alignment: Alignment.centerLeft,
//                               children: [
//                                 TextFormField(
//                                   // controller: salesController.salesModel.searchQuery.value,
//                                   // onChanged: salesController.search,
//                                   style: const TextStyle(fontSize: 13, color: Colors.white),
//                                   decoration: const InputDecoration(
//                                     contentPadding: EdgeInsets.all(10),
//                                     filled: true,
//                                     focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Color.fromARGB(226, 89, 147, 255),
//                                       ),
//                                     ),
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Color.fromARGB(255, 104, 93, 255),
//                                       ),
//                                     ),
//                                     hintText: "", // Hide default hintText
//                                     border: UnderlineInputBorder(borderSide: BorderSide.none),
//                                     prefixIcon: Icon(
//                                       Icons.search,
//                                       color: Color.fromARGB(255, 151, 151, 151),
//                                     ),
//                                   ),
//                                 ),
//                                 // if (salesController.salesModel.searchQuery.value.text.isEmpty)
//                                 Positioned(
//                                   left: 40, // Adjust positioning as needed
//                                   child: IgnorePointer(
//                                     child: AnimatedTextKit(
//                                       repeatForever: true,
//                                       animatedTexts: [
//                                         TypewriterAnimatedText(
//                                           "Search from the list...",
//                                           textStyle: const TextStyle(
//                                             fontSize: 13,
//                                             color: Color.fromARGB(255, 185, 183, 183),
//                                             letterSpacing: 1,
//                                           ),
//                                           speed: const Duration(milliseconds: 100),
//                                         ),
//                                         TypewriterAnimatedText(
//                                           "Enter customer name...",
//                                           textStyle: const TextStyle(
//                                             fontSize: 13,
//                                             color: Color.fromARGB(255, 185, 183, 183),
//                                             letterSpacing: 1,
//                                           ),
//                                           speed: const Duration(milliseconds: 100),
//                                         ),
//                                         TypewriterAnimatedText(
//                                           "Find an invoice...",
//                                           textStyle: const TextStyle(
//                                             fontSize: 13,
//                                             color: Color.fromARGB(255, 185, 183, 183),
//                                             letterSpacing: 1,
//                                           ),
//                                           speed: const Duration(milliseconds: 100),
//                                         ),
//                                         TypewriterAnimatedText(
//                                           "Find an Quotation...",
//                                           textStyle: const TextStyle(
//                                             fontSize: 13,
//                                             color: Color.fromARGB(255, 185, 183, 183),
//                                             letterSpacing: 1,
//                                           ),
//                                           speed: const Duration(milliseconds: 100),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
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
//                                 flex: 2,
//                                 child: Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   elevation: 10,
//                                   color: Primary_colors.Light,
//                                   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Primary_colors.Light),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(0),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         const SizedBox(
//                                           height: 20,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             const Padding(
//                                               padding: EdgeInsets.only(left: 15),
//                                               child: Text(
//                                                 'SALES DATA',
//                                                 style: TextStyle(letterSpacing: 1, wordSpacing: 3, color: Primary_colors.Color3, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(right: 10),
//                                               child: SizedBox(
//                                                 width: 200,
//                                                 height: 35,
//                                                 child: Obx(
//                                                   () => DropdownButtonFormField<String>(
//                                                     value: subscriptionController.subscriptionModel.subscriptionperiod.value == 'monthly'
//                                                         ? "Monthly view"
//                                                         : "Yearly view", // Use the state variable for the selected value
//                                                     items: [
//                                                       "Monthly view",
//                                                       "Yearly view",
//                                                     ]
//                                                         .map((String value) => DropdownMenuItem<String>(
//                                                               value: value,
//                                                               child: Text(value, style: const TextStyle(fontSize: 13, color: Colors.white)),
//                                                             ))
//                                                         .toList(),
//                                                     onChanged: (String? newValue) {
//                                                       if (newValue != null) {
//                                                         subscriptionController.updatesalesperiod(newValue == "Monthly view" ? 'monthly' : 'yearly');

//                                                         if (newValue == "Monthly view") {
//                                                           // widget.GetSalesData(context, 'monthly');
//                                                         } else if (newValue == "Yearly view") {
//                                                           // widget.GetSalesData(context, 'yearly');
//                                                         }
//                                                       }
//                                                     },
//                                                     decoration: InputDecoration(
//                                                       alignLabelWithHint: false,
//                                                       contentPadding: const EdgeInsets.all(10),
//                                                       filled: true,
//                                                       fillColor: Primary_colors.Dark,
//                                                       focusedBorder: OutlineInputBorder(
//                                                         borderRadius: BorderRadius.circular(30),
//                                                         borderSide: const BorderSide(color: Color.fromARGB(226, 50, 50, 50)),
//                                                       ),
//                                                       enabledBorder: OutlineInputBorder(
//                                                         borderRadius: BorderRadius.circular(30),
//                                                         borderSide: const BorderSide(color: Color.fromARGB(255, 51, 50, 50)),
//                                                       ),
//                                                       hintText: 'Data View',
//                                                       hintStyle: const TextStyle(
//                                                         fontSize: Primary_font_size.Text7,
//                                                         color: Primary_colors.Color1,
//                                                         letterSpacing: 1,
//                                                       ),
//                                                     ),
//                                                     dropdownColor: Primary_colors.Dark,
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                         Expanded(
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(16),
//                                               // gradient: const LinearGradient(
//                                               //   colors: [Primary_colors.Light, Color.fromARGB(255, 40, 39, 59), Primary_colors.Light],
//                                               //   begin: Alignment.topLeft,
//                                               //   end: Alignment.bottomRight,
//                                               // ),
//                                               // boxShadow: const [
//                                               //   BoxShadow(
//                                               //     color: Colors.black12,
//                                               //     offset: Offset(0, 10),
//                                               //     blurRadius: 20,
//                                               //   ),
//                                               // ],
//                                             ),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(16),
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                 children: [
//                                                   Padding(
//                                                     padding: const EdgeInsets.only(left: 10),
//                                                     child: Column(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                       crossAxisAlignment: CrossAxisAlignment.center,
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
//                                                           '732232',
//                                                           // widget.formatNumber(int.tryParse(salesController.salesModel.salesdata.value?.totalamount ?? "0") ?? 0),
//                                                           style: TextStyle(
//                                                             color: Primary_colors.Color1,
//                                                             fontSize: 28,
//                                                             fontWeight: FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           decoration: BoxDecoration(
//                                                             borderRadius: BorderRadius.circular(10),
//                                                             color: const Color.fromARGB(255, 202, 227, 253),
//                                                           ),
//                                                           child: Padding(
//                                                             padding: const EdgeInsets.all(4),
//                                                             child: Text(
//                                                               '210 invoices',

//                                                               // "${salesController.salesModel.salesdata.value?.totalinvoices.toString() ?? "0"} ${((salesController.salesModel.salesdata.value?.totalinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
//                                                               style: const TextStyle(
//                                                                   fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 1, 53, 92), letterSpacing: 1, fontWeight: FontWeight.bold),
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Column(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                                     children: [
//                                                       const Text(
//                                                         'RECEIVED',
//                                                         style: TextStyle(
//                                                           color: Color.fromARGB(255, 186, 185, 185),
//                                                           fontSize: 12,
//                                                           fontWeight: FontWeight.w500,
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         "₹ 18,6232",
//                                                         // widget.formatNumber(int.tryParse(salesController.salesModel.salesdata.value?.paidamount ?? "0") ?? 0),

//                                                         style: const TextStyle(
//                                                           color: Primary_colors.Color1,
//                                                           fontSize: 28,
//                                                           fontWeight: FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         decoration: BoxDecoration(
//                                                           borderRadius: BorderRadius.circular(10),
//                                                           color: const Color.fromARGB(255, 202, 253, 223),
//                                                         ),
//                                                         child: Padding(
//                                                           padding: const EdgeInsets.all(4),
//                                                           child: Text(
//                                                             '210 invoices',
//                                                             // "${salesController.salesModel.salesdata.value?.paidinvoices.toString() ?? "0"} ${((salesController.salesModel.salesdata.value?.paidinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
//                                                             style:
//                                                                 const TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 2, 87, 4), letterSpacing: 1, fontWeight: FontWeight.bold),
//                                                           ),
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                   Padding(
//                                                     padding: const EdgeInsets.only(right: 10),
//                                                     child: Column(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                                       children: [
//                                                         const Text(
//                                                           'PENDING',
//                                                           style: TextStyle(
//                                                             color: Color.fromARGB(255, 186, 185, 185),
//                                                             fontSize: 12,
//                                                             fontWeight: FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           "₹ 6,232",
//                                                           // widget.formatNumber(int.tryParse(salesController.salesModel.salesdata.value?.unpaidamount ?? "0") ?? 0),

//                                                           style: const TextStyle(
//                                                             color: Primary_colors.Color1,
//                                                             fontSize: 28,
//                                                             fontWeight: FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           decoration: BoxDecoration(
//                                                             borderRadius: BorderRadius.circular(10),
//                                                             color: const Color.fromARGB(255, 253, 206, 202),
//                                                           ),
//                                                           child: Padding(
//                                                             padding: const EdgeInsets.all(4),
//                                                             child: Text(
//                                                               '110 invoices',
//                                                               // "${salesController.salesModel.salesdata.value?.unpaidinvoices.toString() ?? "0"} ${((salesController.salesModel.salesdata.value?.unpaidinvoices ?? 0) < 2) ? 'invoice' : 'invoices'}",
//                                                               style: const TextStyle(
//                                                                   fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 118, 9, 1), fontWeight: FontWeight.bold, letterSpacing: 1),
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
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
//                                       borderRadius: BorderRadius.circular(16),
//                                       // gradient: const LinearGradient(
//                                       //   colors: [
//                                       //     Primary_colors.Light,
//                                       //     Color.fromARGB(255, 40, 39, 59),
//                                       //     Primary_colors.Light,
//                                       //   ],
//                                       //   begin: Alignment.topLeft,
//                                       //   end: Alignment.bottomRight,
//                                       // ),
//                                       // boxShadow: const [
//                                       //   BoxShadow(
//                                       //     color: Colors.black26,
//                                       //     offset: Offset(0, 6),
//                                       //     blurRadius: 12,
//                                       //   ),
//                                       // ],
//                                       color: Primary_colors.Light),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         // First row of icons and labels

//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: MouseRegion(
//                                                 cursor: SystemMouseCursors.click,
//                                                 child: _buildIconWithLabel(
//                                                   image: 'assets/images/addcustomer.png',
//                                                   label: 'Add Customer',
//                                                   color: Primary_colors.Color4,
//                                                   onPressed: () {
//                                                     Generate_client_reqirement_dialougebox('Customer');
//                                                   },
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: MouseRegion(
//                                                 cursor: SystemMouseCursors.click,
//                                                 child: _buildIconWithLabel(
//                                                     image: 'assets/images/addenquiry.png',
//                                                     label: 'Add Enquiry',
//                                                     color: Primary_colors.Color5,
//                                                     onPressed: () {
//                                                       Generate_client_reqirement_dialougebox('Enquiry');
//                                                     }),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                         const SizedBox(height: 20),
//                                         // Second row of icons and labels
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: _buildIconWithLabel(
//                                                 // key: ValueKey(salesController.salesModel.type.value), // Ensures re-build
//                                                 image: 'assets/images/mainlist.png',
//                                                 label: 'Main List',
//                                                 color: Primary_colors.Color8,
//                                                 onPressed: () {},
//                                               ),
//                                             ),
//                                             // Expanded(
//                                             //   child: _buildIconWithLabel(
//                                             //     image: 'assets/images/article.png',
//                                             //     label: 'Options',
//                                             //     color: Primary_colors.Dark,
//                                             //     onPressed: () {
//                                             //       widget.pdfpopup_controller.initializeTextControllers();
//                                             //       widget.pdfpopup_controller.initializeCheckboxes();
//                                             //       widget.showA4StyledPopup(context);
//                                             //     },
//                                             //   ),
//                                             // ),
//                                             Expanded(
//                                               child: Column(
//                                                 children: [
//                                                   MouseRegion(
//                                                     cursor: SystemMouseCursors.click,
//                                                     child: PopupMenuButton<String>(
//                                                       splashRadius: 20,
//                                                       padding: const EdgeInsets.all(0),
//                                                       icon: Image.asset(
//                                                         'assets/images/options.png',
//                                                       ),
//                                                       iconSize: 50,
//                                                       shape: const RoundedRectangleBorder(
//                                                         borderRadius: BorderRadius.all(
//                                                           Radius.circular(12.0),
//                                                         ),
//                                                         // side: const BorderSide(color: Primary_colors.Color3, width: 2),
//                                                       ),
//                                                       color: Colors.white,
//                                                       elevation: 6,
//                                                       offset: const Offset(170, 20),
//                                                       onSelected: (String item) async {
//                                                         // Handle menu item selection

//                                                         switch (item) {
//                                                           case 'Invoice':
//                                                             pdfpopup_controller.intAll();
//                                                             inst_CustomPDF_Services.assign_GSTtotals();
//                                                             inst.showA4StyledPopup(context);

//                                                             break;
//                                                           case 'Option2':
//                                                             break;
//                                                           case 'Option':
//                                                             break;
//                                                         }
//                                                       },
//                                                       itemBuilder: (BuildContext context) {
//                                                         // Determine the label for the archive/unarchive action

//                                                         return [
//                                                           const PopupMenuItem<String>(
//                                                             value: "Invoice",
//                                                             child: ListTile(
//                                                               leading: Icon(
//                                                                 Icons.archive_outlined,
//                                                                 color: Colors.blueAccent,
//                                                               ),
//                                                               title: Text(
//                                                                 'Invoice',
//                                                                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           const PopupMenuItem<String>(
//                                                             value: 'Option2',
//                                                             child: ListTile(
//                                                               leading: Icon(Icons.edit_outlined, color: Colors.green),
//                                                               title: Text('Option2', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10)),
//                                                             ),
//                                                           ),
//                                                           const PopupMenuItem<String>(
//                                                             value: 'Option3',
//                                                             child: ListTile(
//                                                               leading: Icon(Icons.delete_outline, color: Colors.redAccent),
//                                                               title: Text('Option3', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Primary_font_size.Text10)),
//                                                             ),
//                                                           ),
//                                                         ];
//                                                       },
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 8),
//                                                   const Text(
//                                                     "Options",
//                                                     style: TextStyle(
//                                                       letterSpacing: 1,
//                                                       fontSize: Primary_font_size.Text5,
//                                                       color: Primary_colors.Color1,
//                                                       fontWeight: FontWeight.w600,
//                                                       overflow: TextOverflow.ellipsis,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )
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
//                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Primary_colors.Light
//                                         // gradient: const LinearGradient(
//                                         //   colors: [Primary_colors.Light, Color.fromARGB(255, 40, 39, 59), Primary_colors.Light],
//                                         //   begin: Alignment.topLeft,
//                                         //   end: Alignment.bottomRight,
//                                         // ),
//                                         // boxShadow: const [
//                                         //   BoxShadow(
//                                         //     color: Colors.black12,
//                                         //     offset: Offset(0, 10),
//                                         //     blurRadius: 20,
//                                         //   ),
//                                         // ],
//                                         ),
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
//                   const SizedBox(height: 20),
//                   const Row(
//                     children: [
//                       SizedBox(
//                         width: 250,
//                         child: TabBar(
//                           indicatorColor: Primary_colors.Color5,
//                           tabs: [
//                             Text('Invoice'),
//                             Text('Process'),
//                           ],
//                         ),
//                       ),
//                       // Expanded(
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.end,
//                       //     children: [
//                       //       SizedBox(
//                       //         width: max(screenWidth - 1480, 200),
//                       //         height: 40,
//                       //         child: TextFormField(
//                       //           style: const TextStyle(fontSize: 13, color: Colors.white),
//                       //           decoration: InputDecoration(
//                       //             contentPadding: const EdgeInsets.all(1),
//                       //             filled: true,
//                       //             fillColor: Primary_colors.Light,
//                       //             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
//                       //             // enabledBorder: InputBorder.none, // Removes the enabled border
//                       //             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
//                       //             hintStyle: const TextStyle(
//                       //               fontSize: Primary_font_size.Text7,
//                       //               color: Color.fromARGB(255, 167, 165, 165),
//                       //             ),
//                       //             hintText: 'Search customer',
//                       //             prefixIcon: const Icon(
//                       //               Icons.search,
//                       //               color: Colors.white,
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //       const SizedBox(
//                       //         width: 20,
//                       //       ),
//                       //       // SizedBox(
//                       //       //   width: 300,
//                       //       //   height: 40,
//                       //       //   child: DropdownButtonFormField<String>(
//                       //       //     style: const TextStyle(fontSize: 13, color: Colors.white),
//                       //       //     decoration: InputDecoration(
//                       //       //         contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Adjust padding to center the hint
//                       //       //         filled: true,
//                       //       //         fillColor: Primary_colors.Light,
//                       //       //         focusedBorder: OutlineInputBorder(
//                       //       //           borderRadius: BorderRadius.circular(30),
//                       //       //           borderSide: const BorderSide(color: Colors.transparent),
//                       //       //         ),
//                       //       //         enabledBorder: OutlineInputBorder(
//                       //       //           borderRadius: BorderRadius.circular(30),
//                       //       //           borderSide: const BorderSide(color: Colors.transparent),
//                       //       //         ),
//                       //       //         // hintStyle: const TextStyle(
//                       //       //         //   fontSize: Primary_font_size.Text7,
//                       //       //         //   color: Color.fromARGB(255, 167, 165, 165),
//                       //       //         // ),
//                       //       //         // hintText: 'Select customer',
//                       //       //         // alignLabelWithHint: true, // Helps to align hint text
//                       //       //         label: const Text(
//                       //       //           'Select type',
//                       //       //           style: TextStyle(color: Color.fromARGB(255, 162, 162, 162), fontSize: Primary_font_size.Text7),
//                       //       //         )),
//                       //       //     dropdownColor: Primary_colors.Dark,
//                       //       //     value: Selected_billingtype, // Bind your selected value here
//                       //       //     onChanged: (String? newValue) {
//                       //       //       setState(() {
//                       //       //         Selected_billingtype = newValue; // Update the selected value
//                       //       //       });
//                       //       //     },
//                       //       //     items: billing_type.map<DropdownMenuItem<String>>((String customer) {
//                       //       //       return DropdownMenuItem<String>(
//                       //       //         value: customer,
//                       //       //         child: Text(customer),
//                       //       //       );
//                       //       //     }).toList(),
//                       //       //   ),
//                       //       // ),
//                       //       const SizedBox(
//                       //         width: 10,
//                       //       ),
//                       //       IconButton(
//                       //         onPressed: () {
//                       //           setState(() {
//                       //             Scaffold.of(context).openEndDrawer();
//                       //           });
//                       //         },
//                       //         icon: const Icon(
//                       //           Icons.filter_alt_outlined,
//                       //           color: Primary_colors.Color1,
//                       //         ),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // )
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: TabBarView(
//                       children: [Recurringinvoices(), _activeprocess()],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   final List<Map<String, dynamic>> invoice_list = [
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56546",
//       "clientname": "Khivraj Groups",
//       "image": "assets/images/human.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "06 oct 24",
//       "amount": "15000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56534",
//       "clientname": "Maharaja",
//       "image": "assets/images/download.jpg",
//       "type": "Sales",
//       "product": "Secure 360",
//       "date": "10 Nov 24",
//       "amount": "50000",
//       "Status": "Paid",
//     },
//     {
//       "invoice_id": "56556",
//       "clientname": "Anamalais Groups",
//       "image": "assets/images/car.jpg",
//       "type": "Vendor",
//       "product": "Secure Shutter",
//       "date": "13 Dec 24",
//       "amount": "43000",
//       "Status": "Pending",
//     },
//     {
//       "invoice_id": "56545",
//       "clientname": "Honda Groups",
//       "image": "assets/images/bay.jpg",
//       "type": "Subscription",
//       "product": "Secure Shutter",
//       "date": "13 oct 24",
//       "amount": "15000",
//       "Status": "Paid",
//     },
//   ];
//   Widget Recurringinvoices() {
//     return Row(
//       children: [
//         Expanded(
//           flex: 2,
//           child: Container(
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Primary_colors.Color3, Primary_colors.Color3], // Example gradient colors
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(10), // Ensure border radius for smooth corners
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Invoice ID',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 4,
//                           child: Text(
//                             'Package',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Date',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Amount',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Status',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Text(
//                             '',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Text(
//                             '',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Text(
//                             '',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Expanded(
//                   child: ListView.separated(
//                     separatorBuilder: (context, index) => Container(
//                       height: 1,
//                       color: const Color.fromARGB(94, 125, 125, 125),
//                     ),
//                     itemCount: invoice_list.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(5),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Primary_colors.Light,
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       invoice_list[index]['invoice_id'],
//                                       style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 4,
//                                     child: Text(
//                                       invoice_list[index]['product'],
//                                       style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       invoice_list[index]['date'],
//                                       style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       invoice_list[index]['amount'],
//                                       style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                     ),
//                                   ),
//                                   Expanded(
//                                       flex: 2,
//                                       child: Row(
//                                         children: [
//                                           Container(
//                                             height: 22,
//                                             width: 60,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(20),
//                                               color: invoice_list[index]['Status'] == 'Paid' ? const Color.fromARGB(193, 222, 244, 223) : const Color.fromARGB(208, 244, 214, 212),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 invoice_list[index]['Status'],
//                                                 style: TextStyle(
//                                                     color: invoice_list[index]['Status'] == 'Paid' ? const Color.fromARGB(255, 0, 122, 4) : Colors.red,
//                                                     fontSize: Primary_font_size.Text5,
//                                                     fontWeight: FontWeight.bold),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       )),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           // widget.showPDF(context, 'weqwer');
//                                         },
//                                         child: Image.asset(height: 30, 'assets/images/pdfdownload.png'),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           // widget.showPDF(context, 'weqwer');
//                                         },
//                                         child: Image.asset(height: 22, 'assets/images/share.png'),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           // widget.showPDF(context, 'weqwer');
//                                         },
//                                         child: Image.asset(height: 20, 'assets/images/download.png'),
//                                       ),
//                                     ),
//                                   ),
//                                   // const Expanded(flex: 2, child: Icon(Icons.keyboard_control)),
//                                   // const Expanded(flex: 2, child: Icon(Icons.keyboard_control)),
//                                   // const Expanded(flex: 2, child: Icon(Icons.keyboard_control))
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//             flex: 1,
//             child: Container(
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Primary_colors.Light),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 10, top: 5),
//                       child: Text(
//                         'CUSTOMER LIST',
//                         style: TextStyle(
//                           letterSpacing: 1,
//                           wordSpacing: 3,
//                           color: Primary_colors.Color3,
//                           fontSize: Primary_font_size.Text10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Expanded(
//                       child: Container(
//                         color: Colors.transparent,
//                         key: const ValueKey(1),
//                         child: ListView.builder(
//                           itemCount: items.length,
//                           itemBuilder: (context, index) {
//                             final Subscription_Client = items[index]['name'];
//                             return _buildSubscription_ClientCard(Subscription_Client, items[index]['type'], index);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//       ],
//     );
//   }

//   Widget _activeprocess() {
//     return Row(
//       children: [
//         Expanded(
//           flex: 2,
//           child: Container(
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Primary_colors.Color3, Primary_colors.Color3], // Example gradient colors
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(15), // Ensure border radius for smooth corners
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.only(left: 16, right: 47),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Process ID',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 4,
//                           child: Text(
//                             'Subscription_Client Name',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Date',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Days',
//                             style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: items[showcustomerprocess]['process'].length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Primary_colors.Dark,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: ExpansionTile(
//                               collapsedIconColor: const Color.fromARGB(255, 135, 132, 132),
//                               iconColor: Colors.red,
//                               collapsedBackgroundColor: Primary_colors.Dark,
//                               backgroundColor: Primary_colors.Dark,
//                               title: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       items[showcustomerprocess]['process'][index]['id'],
//                                       style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 4,
//                                     child: Text(
//                                       items[showcustomerprocess]['name'],
//                                       style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       items[showcustomerprocess]['process'][index]['date'],
//                                       style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       items[showcustomerprocess]['process'][index]['daycounts'],
//                                       style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               children: [
//                                 SizedBox(
//                                   height: ((items[showcustomerprocess]['process'][index]['child'].length * 80) + 20).toDouble(),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(16.0),
//                                     child: ListView.builder(
//                                       itemCount: items[showcustomerprocess]['process'][index]['child'].length, // +1 for "Add Event" button
//                                       itemBuilder: (context, childIndex) {
//                                         return Row(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Column(
//                                               children: [
//                                                 Container(
//                                                   padding: const EdgeInsets.all(8),
//                                                   decoration: const BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     color: Colors.green,
//                                                   ),
//                                                   child: const Icon(
//                                                     Icons.event,
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                                 if (childIndex != items[showcustomerprocess]['process'][index]['child'].length - 1)
//                                                   Container(
//                                                     width: 2,
//                                                     height: 40,
//                                                     color: Colors.green,
//                                                   ),
//                                               ],
//                                             ),
//                                             Expanded(
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Expanded(
//                                                     child: Column(
//                                                       mainAxisAlignment: MainAxisAlignment.start,
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Padding(
//                                                           padding: const EdgeInsets.only(top: 2.0, left: 10),
//                                                           child: Row(
//                                                             children: [
//                                                               Text(
//                                                                 items[showcustomerprocess]['process'][index]['child'][childIndex]["name"],
//                                                                 style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
//                                                               ),
//                                                               // const SizedBox(width: 5),
//                                                               // Expanded(
//                                                               //   child: Text(
//                                                               //     overflow: TextOverflow.ellipsis,
//                                                               //     items[showcustomerprocess]['process'][index]['child'][childIndex]["feedback"],
//                                                               //     style: const TextStyle(color: Colors.red, fontSize: Primary_font_size.Text5),
//                                                               //   ),
//                                                               // )
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.start,
//                                                           children: [
//                                                             if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_Quote"] == true)
//                                                               TextButton(
//                                                                 onPressed: () {
//                                                                   GenerateQuotation_dialougebox();
//                                                                 },
//                                                                 child: const Text(
//                                                                   "Quotation",
//                                                                   style: TextStyle(color: Colors.blue, fontSize: 12),
//                                                                 ),
//                                                               ),
//                                                             if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_revisedQuote"] == true)
//                                                               TextButton(
//                                                                 onPressed: () {
//                                                                   GenerateQuotation_dialougebox();
//                                                                 },
//                                                                 child: const Text(
//                                                                   "RevisedQuotation",
//                                                                   style: TextStyle(color: Colors.blue, fontSize: 12),
//                                                                 ),
//                                                               ),
//                                                             if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_Invoice"] == true)
//                                                               TextButton(
//                                                                 onPressed: () {
//                                                                   GenerateInvoice_dialougebox();
//                                                                 },
//                                                                 child: const Text(
//                                                                   "Invoice",
//                                                                   style: TextStyle(color: Colors.blue, fontSize: 12),
//                                                                 ),
//                                                               ),
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Container(
//                                                         height: 40,
//                                                         width: 2,
//                                                         color: const Color.fromARGB(78, 172, 170, 170),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 200,
//                                                         child: TextFormField(
//                                                           maxLines: 2,
//                                                           style: const TextStyle(
//                                                             fontSize: Primary_font_size.Text7,
//                                                             color: Colors.white,
//                                                           ),
//                                                           decoration: const InputDecoration(
//                                                             filled: true,
//                                                             fillColor: Primary_colors.Dark,
//                                                             hintText: 'Enter Feedback',
//                                                             hintStyle: TextStyle(
//                                                               fontSize: Primary_font_size.Text7,
//                                                               color: Color.fromARGB(255, 179, 178, 178),
//                                                             ),
//                                                             border: InputBorder.none, // Remove default border
//                                                             contentPadding: EdgeInsets.all(10), // Adjust padding
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//             flex: 1,
//             child: Container(
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Primary_colors.Light),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 10, top: 5),
//                       child: Text(
//                         'CUSTOMER LIST',
//                         style: TextStyle(
//                           letterSpacing: 1,
//                           wordSpacing: 3,
//                           color: Primary_colors.Color3,
//                           fontSize: Primary_font_size.Text10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Expanded(
//                       child: Container(
//                         color: Colors.transparent,
//                         key: const ValueKey(1),
//                         child: ListView.builder(
//                           itemCount: items.length,
//                           itemBuilder: (context, index) {
//                             final Subscription_Client = items[index]['name'];
//                             return _buildSubscription_ClientCard(Subscription_Client, items[index]['type'], index);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//       ],
//     );
//   }

//   Widget _buildIconWithLabel({
//     required String image,
//     required String label,
//     required Color color,
//     required VoidCallback onPressed,
//   }) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Column(
//         children: [
//           AnimatedSwitcher(
//             duration: const Duration(milliseconds: 300), // Animation duration
//             transitionBuilder: (Widget child, Animation<double> animation) {
//               return FadeTransition(
//                 opacity: animation,
//                 child: child,
//               );
//             },
//             child: Container(
//               key: ValueKey(image), // ✅ Key ensures animation on image change
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [color, color],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               padding: const EdgeInsets.all(0),
//               child: ClipOval(
//                 child: Image.asset(
//                   image,
//                   key: ValueKey(image), // ✅ Key applied to image
//                   fit: BoxFit.cover,
//                   width: 50,
//                   height: 50,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: const TextStyle(
//               letterSpacing: 1,
//               fontSize: Primary_font_size.Text5,
//               color: Primary_colors.Color1,
//               fontWeight: FontWeight.w600,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubscription_ClientCard(String Subscription_Client, String type, int index) {
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
//                     Primary_colors.Dark,
//                     Primary_colors.Dark,
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
//             Subscription_Client,
//             style: GoogleFonts.lato(
//               textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
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
//             // Implement Subscription_Client details or actions here
//           },
//         ),
//       ),
//     );
//   }
// }
