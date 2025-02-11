import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/DC_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Debit_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Invoice_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Quote_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/RFQ_actions.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Credit_actions.dart';
import 'package:ssipl_billing/services/SALES/sales_service.dart';
import 'package:ssipl_billing/views/components/cards.dart';
import 'package:ssipl_billing/themes/style.dart';

import '../../../controllers/SALEScontrollers/Sales_actions.dart';

class Sales_Client extends StatefulWidget with SalesServices {
  Sales_Client({super.key});

  @override
  _Sales_ClientState createState() => _Sales_ClientState();
}

class _Sales_ClientState extends State<Sales_Client> {
  final SalesController salesController = Get.find<SalesController>();
  final DCController dcController = Get.find<DCController>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final QuoteController quoteController = Get.find<QuoteController>();
  final RFQController rfqController = Get.find<RFQController>();
  final CreditController creditController = Get.find<CreditController>();
  final DebitController debitController = Get.find<DebitController>();
  // final List<Map<String, dynamic>> items = [
  //   {
  //     "name": "Khivraj Groups",
  //     "type": "Customer",
  //     "process": [
  //       {
  //         "id": "EST/SSIPL - 1001",
  //         "date": "16/03/2023",
  //         "daycounts": "21 days",
  //         "child": [
  //           {
  //             "name": "Invoice 1",
  //             "feedback": "Hello",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": true,
  //             "generate_RFQ": true,
  //             "generate_Invoice": true,
  //             "generate_deliverychallan": true,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 2",
  //             "feedback": "Hello",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 3",
  //             "feedback": "Hello",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //         ]
  //       },
  //       {
  //         "id": "EST/SSIPL - 1006",
  //         "date": "16/03/2023",
  //         "daycounts": "21 days",
  //         "child": [
  //           {
  //             "name": "Invoice 1",
  //             "feedback": "Hello",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 2",
  //             "feedback": "Hello",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 3",
  //             "feedback": "Hello",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 4",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           }
  //         ]
  //       },
  //       {
  //         "id": "EST/SSIPL - 1008",
  //         "date": "16/03/2023",
  //         "daycounts": "21 days",
  //         "child": [
  //           {
  //             "name": "Invoice 1",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 2",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 3",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 4",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 5",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           }
  //         ]
  //       },
  //       {
  //         "id": "EST/SSIPL - 1010",
  //         "date": "16/03/2023",
  //         "daycounts": "21 days",
  //         "child": [
  //           {
  //             "name": "Invoice 1",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 2",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           }
  //         ]
  //       }
  //     ]
  //   },
  //   {
  //     "name": "Nexa sales and service",
  //     "type": "Customer",
  //     "process": [
  //       {
  //         "id": "EST/SSIPL - 1001",
  //         "date": "16/03/2023",
  //         "daycounts": "21 days",
  //         "child": [
  //           {
  //             "name": "Invoice 1",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 2",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 3",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           }
  //         ]
  //       },
  //       {
  //         "id": "EST/SSIPL - 1006",
  //         "date": "16/03/2023",
  //         "daycounts": "21 days",
  //         "child": [
  //           {
  //             "name": "Invoice 1",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 2",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 3",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 4",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           }
  //         ]
  //       },
  //       {
  //         "id": "EST/SSIPL - 1008",
  //         "date": "16/03/2023",
  //         "daycounts": "21 days",
  //         "child": [
  //           {
  //             "name": "Invoice 1",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 2",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 3",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 4",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 5",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           }
  //         ]
  //       },
  //       {
  //         "id": "EST/SSIPL - 1010",
  //         "date": "16/03/2023",
  //         "daycounts": "21 days",
  //         "child": [
  //           {
  //             "name": "Invoice 1",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           },
  //           {
  //             "name": "Invoice 2",
  //             "feedback": "",
  //             "generate_Quote": true,
  //             "generate_revisedQuote": false,
  //             "generate_RFQ": false,
  //             "generate_Invoice": false,
  //             "generate_deliverychallan": false,
  //             "credit_note": true,
  //             "debit_note": true,
  //           }
  //         ]
  //       }
  //     ]
  //   }
  // ];

  int showcustomerprocess = 1;

  @override
  void initState() {
    super.initState();
    // widget.GetCustomerList(context);
    widget.GetProcesscustomerList(context);
  }

// // ##################################################################################################################################################################################################################################################################################################################################################################

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Primary_colors.Dark,
        body: Center(
          child: SizedBox(
            // width: 1500,
            child: Column(
              children: [
                const SizedBox(height: 185, child: cardview()),
                const SizedBox(height: 20),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
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
                                  borderRadius: BorderRadius.circular(15), // Ensure border radius for smooth corners
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 16, right: 47),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Process ID',
                                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          'Sales_Client Name',
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
                                          'Days',
                                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: Container(),
                                // child: ListView.builder(
                                //   itemCount: items[showcustomerprocess]['process'].length,
                                //   itemBuilder: (context, index) {
                                //     return Padding(
                                //       padding: const EdgeInsets.only(top: 10),
                                //       child: ClipRRect(
                                //         borderRadius: BorderRadius.circular(15),
                                //         child: Container(
                                //           decoration: BoxDecoration(
                                //             color: Primary_colors.Dark,
                                //             borderRadius: BorderRadius.circular(15),
                                //           ),
                                //           child: ExpansionTile(
                                //             collapsedIconColor: const Color.fromARGB(255, 135, 132, 132),
                                //             iconColor: Colors.red,
                                //             collapsedBackgroundColor: Primary_colors.Dark,
                                //             backgroundColor: Primary_colors.Dark,
                                //             title: Row(
                                //               children: [
                                //                 Expanded(
                                //                   flex: 2,
                                //                   child: Text(
                                //                     items[showcustomerprocess]['process'][index]['id'],
                                //                     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                //                   ),
                                //                 ),
                                //                 Expanded(
                                //                   flex: 4,
                                //                   child: Text(
                                //                     items[showcustomerprocess]['name'],
                                //                     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                //                   ),
                                //                 ),
                                //                 Expanded(
                                //                   flex: 2,
                                //                   child: Text(
                                //                     items[showcustomerprocess]['process'][index]['date'],
                                //                     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                //                   ),
                                //                 ),
                                //                 Expanded(
                                //                   flex: 2,
                                //                   child: Text(
                                //                     items[showcustomerprocess]['process'][index]['daycounts'],
                                //                     style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //             children: [
                                //               SizedBox(
                                //                 height: ((items[showcustomerprocess]['process'][index]['child'].length * 80) + 20).toDouble(),
                                //                 child: Padding(
                                //                   padding: const EdgeInsets.all(16.0),
                                //                   child: ListView.builder(
                                //                     itemCount: items[showcustomerprocess]['process'][index]['child'].length, // +1 for "Add Event" button
                                //                     itemBuilder: (context, childIndex) {
                                //                       return Row(
                                //                         crossAxisAlignment: CrossAxisAlignment.start,
                                //                         children: [
                                //                           Column(
                                //                             children: [
                                //                               Container(
                                //                                 padding: const EdgeInsets.all(8),
                                //                                 decoration: const BoxDecoration(
                                //                                   shape: BoxShape.circle,
                                //                                   color: Colors.green,
                                //                                 ),
                                //                                 child: const Icon(
                                //                                   Icons.event,
                                //                                   color: Colors.white,
                                //                                 ),
                                //                               ),
                                //                               if (childIndex != items[showcustomerprocess]['process'][index]['child'].length - 1)
                                //                                 Container(
                                //                                   width: 2,
                                //                                   height: 40,
                                //                                   color: Colors.green,
                                //                                 ),
                                //                             ],
                                //                           ),
                                //                           Expanded(
                                //                               child: Row(
                                //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                             children: [
                                //                               Expanded(
                                //                                 child: Column(
                                //                                   mainAxisAlignment: MainAxisAlignment.start,
                                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                                //                                   children: [
                                //                                     Padding(
                                //                                       padding: const EdgeInsets.only(top: 2.0, left: 10),
                                //                                       child: Row(
                                //                                         children: [
                                //                                           Text(
                                //                                             items[showcustomerprocess]['process'][index]['child'][childIndex]["name"],
                                //                                             style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                //                                           ),
                                //                                           // const SizedBox(width: 5),
                                //                                           // Expanded(
                                //                                           //   child: Text(
                                //                                           //     overflow: TextOverflow.ellipsis,
                                //                                           //     items[showcustomerprocess]['process'][index]['child'][childIndex]["feedback"],
                                //                                           //     style: const TextStyle(color: Colors.red, fontSize: Primary_font_size.Text5),
                                //                                           //   ),
                                //                                           // )
                                //                                         ],
                                //                                       ),
                                //                                     ),
                                //                                     Row(
                                //                                       mainAxisAlignment: MainAxisAlignment.start,
                                //                                       children: [
                                //                                         if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_Quote"] == true)
                                //                                           TextButton(
                                //                                             onPressed: () {
                                //                                               widget.GenerateQuote_dialougebox(context);
                                //                                             },
                                //                                             child: const Text(
                                //                                               "Quotation",
                                //                                               style: TextStyle(color: Colors.blue, fontSize: 12),
                                //                                             ),
                                //                                           ),
                                //                                         if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_revisedQuote"] == true)
                                //                                           TextButton(
                                //                                             onPressed: () {
                                //                                               // GenerateQuotation_dialougebox();
                                //                                             },
                                //                                             child: const Text(
                                //                                               "RevisedQuotation",
                                //                                               style: TextStyle(color: Colors.blue, fontSize: 12),
                                //                                             ),
                                //                                           ),
                                //                                         if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_RFQ"] == true)
                                //                                           TextButton(
                                //                                             onPressed: () {
                                //                                               widget.GenerateRFQ_dialougebox(context);
                                //                                             },
                                //                                             child: const Text(
                                //                                               "Generate RFQ",
                                //                                               style: TextStyle(color: Colors.blue, fontSize: 12),
                                //                                             ),
                                //                                           ),
                                //                                         if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_Invoice"] == true)
                                //                                           TextButton(
                                //                                             onPressed: () {
                                //                                               widget.GenerateInvoice_dialougebox(context);
                                //                                             },
                                //                                             child: const Text(
                                //                                               "Invoice",
                                //                                               style: TextStyle(color: Colors.blue, fontSize: 12),
                                //                                             ),
                                //                                           ),
                                //                                         if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_deliverychallan"] == true)
                                //                                           TextButton(
                                //                                             onPressed: () {
                                //                                               widget.GenerateDelivery_challan_dialougebox(context);
                                //                                               // (items[showcustomerprocess]['process'][index]['child'] as List).add({
                                //                                               //   "name": "Requirement4",
                                //                                               //   "generate_po": true,
                                //                                               //   "generate_RFQ": false,
                                //                                               // });
                                //                                             },
                                //                                             child: const Text(
                                //                                               "Deliverychallan",
                                //                                               style: TextStyle(color: Colors.blue, fontSize: 12),
                                //                                             ),
                                //                                           ),
                                //                                         if (items[showcustomerprocess]['process'][index]['child'][childIndex]["credit_note"] == true)
                                //                                           TextButton(
                                //                                             onPressed: () {
                                //                                               widget.GenerateCredit_dialougebox(context);
                                //                                               // (items[showcustomerprocess]['process'][index]['child'] as List).add({
                                //                                               //   "name": "Requirement4",
                                //                                               //   "generate_po": true,
                                //                                               //   "generate_RFQ": false,
                                //                                               // });
                                //                                             },
                                //                                             child: const Text(
                                //                                               "Credit",
                                //                                               style: TextStyle(color: Colors.blue, fontSize: 12),
                                //                                             ),
                                //                                           ),
                                //                                         if (items[showcustomerprocess]['process'][index]['child'][childIndex]["debit_note"] == true)
                                //                                           TextButton(
                                //                                             onPressed: () {
                                //                                               widget.GenerateDebit_dialougebox(context);
                                //                                               // (items[showcustomerprocess]['process'][index]['child'] as List).add({
                                //                                               //   "name": "Requirement4",
                                //                                               //   "generate_po": true,
                                //                                               //   "generate_RFQ": false,
                                //                                               // });
                                //                                             },
                                //                                             child: const Text(
                                //                                               "Debit",
                                //                                               style: TextStyle(color: Colors.blue, fontSize: 12),
                                //                                             ),
                                //                                           ),
                                //                                       ],
                                //                                     )
                                //                                   ],
                                //                                 ),
                                //                               ),
                                //                               Row(
                                //                                 children: [
                                //                                   Container(
                                //                                     height: 40,
                                //                                     width: 2,
                                //                                     color: const Color.fromARGB(78, 172, 170, 170),
                                //                                   ),
                                //                                   SizedBox(
                                //                                     width: 200,
                                //                                     child: TextFormField(
                                //                                       maxLines: 2,
                                //                                       style: const TextStyle(
                                //                                         fontSize: Primary_font_size.Text7,
                                //                                         color: Colors.white,
                                //                                       ),
                                //                                       decoration: const InputDecoration(
                                //                                         filled: true,
                                //                                         fillColor: Primary_colors.Dark,
                                //                                         hintText: 'Enter Feedback',
                                //                                         hintStyle: TextStyle(
                                //                                           fontSize: Primary_font_size.Text7,
                                //                                           color: Color.fromARGB(255, 179, 178, 178),
                                //                                         ),
                                //                                         border: InputBorder.none, // Remove default border
                                //                                         contentPadding: EdgeInsets.all(10), // Adjust padding
                                //                                       ),
                                //                                     ),
                                //                                   ),
                                //                                 ],
                                //                               )
                                //                             ],
                                //                           ))
                                //                         ],
                                //                       );
                                //                     },
                                //                   ),
                                //                 ),
                                //               )
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(1),
                                        filled: true,
                                        fillColor: Primary_colors.Light,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(0, 0, 0, 0),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.black)),
                                        hintStyle: const TextStyle(
                                          fontSize: Primary_font_size.Text7,
                                          color: Color.fromARGB(255, 167, 165, 165),
                                        ),
                                        hintText: 'Search Sales Client from the list',
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    size: 30,
                                    Icons.filter_alt,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                PopupMenuButton<String>(
                                  color: const Color.fromARGB(255, 86, 86, 114),
                                  onSelected: (String value) {
                                    widget.Generate_client_reqirement_dialougebox(value, context);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: "Enquiry",
                                        child: Text(
                                          "Enquiry",
                                          style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: "Customer",
                                        child: Text(
                                          "Customer",
                                          style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                    ];
                                  },
                                  child: const Icon(size: 30, Icons.add, color: Primary_colors.Color3),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: ListView.builder(
                                itemCount: salesController.salesModel.processcustomerList.length,
                                itemBuilder: (context, index) {
                                  final Sales_Processcustomer = salesController.salesModel.processcustomerList[index].customerName;
                                  return _buildSales_ClientCard(Sales_Processcustomer, index);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSales_ClientCard(String Sales_Client, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(15),
        // ),
        // elevation: 3,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: showcustomerprocess == index
                ? [Primary_colors.Color3, Primary_colors.Color3]
                : [
                    Primary_colors.Light,
                    Primary_colors.Light,
                  ], // Example gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20), // Ensure border radius for smooth corners
        ),
        child: ListTile(
          leading: Icon(
            Icons.people,
            color: Colors.white,
            size: 25,
          ),
          title: Text(
            Sales_Client,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              size: 20,
              Icons.notifications,
              color: showcustomerprocess == index ? Colors.red : Colors.amber,
            ),
          ),
          // const SizedBox(width: 5),
          // const Icon(
          //   Icons.arrow_forward_ios,
          //   color: Colors.grey,
          //   size: 15,
          // ),
          onTap: () {
            setState(() {
              showcustomerprocess = index;
            });
            // Implement Sales_Client details or actions here
          },
        ),
      ),
    );
  }
}
