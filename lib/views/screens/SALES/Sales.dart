import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ssipl_billing/controllers/ClientReq_actions.dart';
import 'package:ssipl_billing/controllers/DC_actions.dart';
import 'package:ssipl_billing/controllers/Debit_actions.dart';
import 'package:ssipl_billing/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/controllers/Quote_actions.dart';
import 'package:ssipl_billing/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/controllers/Credit_actions.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_DC/DC_template.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_DC/generateDC.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_Invoice/generateInvoice.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_Invoice/invoice_template.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_Quotation/generateQuotaion.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_Quotation/quotation_template.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_RFQ/RFQ_template.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_RFQ/generateRFQ.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_client_requirements/clientreq_details.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_client_requirements/clientreq_note.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_client_requirements/clientreq_products.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_client_requirements/generate_clientreq.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_creditnote/creditnote_template.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_creditnote/generate_creditnote.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_debitnote/debitnote_template.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_debitnote/generate_debitnote.dart';
import 'package:ssipl_billing/views/components/cards.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_RFQ/generateRFQ.dart';
// import 'package:ssipl_billing/view_send_pdf.dart';

import '../../components/view_send_pdf.dart';
import 'Generate_DC/generateDC.dart';
import 'Generate_DebitNote/generateDebit.dart';
import 'Generate_Invoice/generateInvoice.dart';
import 'Generate_Quote/generateQuote.dart';
import 'Generate_client_req/generate_clientreq.dart';
import 'Generate_creditNote/generateCredit.dart';

class Sales_Client extends StatefulWidget {
  const Sales_Client({super.key});
  static late dynamic Function() rfq_Callback;
  static late dynamic Function() invoice_Callback;
  static late dynamic Function() RFQ_Callback;
  // static late dynamic Function() Delivery_challan_Callback;
  static late dynamic Function() creditnote_Callback;
  static late dynamic Function() debitnote_Callback;
  // static late dynamic Function() clientreq_Callback;

  @override
  _Sales_ClientState createState() => _Sales_ClientState();
}

class _Sales_ClientState extends State<Sales_Client> {
  final DCController dcController = Get.find<DCController>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final QuoteController quoteController = Get.find<QuoteController>();
  final RFQController rfqController = Get.find<RFQController>();
  final CreditController creditController = Get.find<CreditController>();
  final DebitController debitController = Get.find<DebitController>();
  final ClientreqController clientreqController = Get.find<ClientreqController>();

  final List<Map<String, dynamic>> items = [
    {
      "name": "Khivraj Groups",
      "type": "Customer",
      "process": [
        {
          "id": "EST/SSIPL - 1001",
          "date": "16/03/2023",
          "daycounts": "21 days",
          "child": [
            {
              "name": "Invoice 1",
              "feedback": "Hello",
              "generate_Quote": true,
              "generate_revisedQuote": true,
              "generate_RFQ": true,
              "generate_Invoice": true,
              "generate_deliverychallan": true,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 2",
              "feedback": "Hello",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 3",
              "feedback": "Hello",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
          ]
        },
        {
          "id": "EST/SSIPL - 1006",
          "date": "16/03/2023",
          "daycounts": "21 days",
          "child": [
            {
              "name": "Invoice 1",
              "feedback": "Hello",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 2",
              "feedback": "Hello",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 3",
              "feedback": "Hello",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 4",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            }
          ]
        },
        {
          "id": "EST/SSIPL - 1008",
          "date": "16/03/2023",
          "daycounts": "21 days",
          "child": [
            {
              "name": "Invoice 1",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 3",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 4",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 5",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            }
          ]
        },
        {
          "id": "EST/SSIPL - 1010",
          "date": "16/03/2023",
          "daycounts": "21 days",
          "child": [
            {
              "name": "Invoice 1",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            }
          ]
        }
      ]
    },
    {
      "name": "Nexa sales and service",
      "type": "Customer",
      "process": [
        {
          "id": "EST/SSIPL - 1001",
          "date": "16/03/2023",
          "daycounts": "21 days",
          "child": [
            {
              "name": "Invoice 1",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 3",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            }
          ]
        },
        {
          "id": "EST/SSIPL - 1006",
          "date": "16/03/2023",
          "daycounts": "21 days",
          "child": [
            {
              "name": "Invoice 1",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 3",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 4",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            }
          ]
        },
        {
          "id": "EST/SSIPL - 1008",
          "date": "16/03/2023",
          "daycounts": "21 days",
          "child": [
            {
              "name": "Invoice 1",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 3",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 4",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 5",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            }
          ]
        },
        {
          "id": "EST/SSIPL - 1010",
          "date": "16/03/2023",
          "daycounts": "21 days",
          "child": [
            {
              "name": "Invoice 1",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_RFQ": false,
              "generate_Invoice": false,
              "generate_deliverychallan": false,
              "credit_note": true,
              "debit_note": true,
            }
          ]
        }
      ]
    }
  ];

  // Adding a controller and isAdding flag for each item
  late List<bool> isAddingList;
  late List<TextEditingController> controllers;
  int showcustomerprocess = 1;
  List<String> list = <String>[
    'One',
    'Two',
    'Three',
    'Four'
  ];
  String Sales_ClientSearchQuery = '';
  @override
  void initState() {
    super.initState();

    // Sales_Client.quote_Callback = () async => {
    //       await generate_quotation()
    //     };
    // Sales_Client.invoice_Callback = () async => {
    //       await generate_invoice()
    //     };
    // Sales_Client.RFQ_Callback = () async => {
    //       await generate_RFQ()
    //     };
    // // Sales_Client.Delivery_challan_Callback = () async => {
    // //       await generate_Delivery_challan()
    // //     };

    // Sales_Client.creditnote_Callback = () async => {
    //       await generate_creditnote()
    //     };
    // Sales_Client.debitnote_Callback = () async => {
    //       await generate_debitnote()
    //     };
    // Sales_Client.clientreq_Callback = () async => {await generate_client_requirement()};
    // Initialize isAddingList and controllers based on the number of items
    isAddingList = List<bool>.filled(items.length, false);
    controllers = List<TextEditingController>.generate(items.length, (index) => TextEditingController());
  }

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
//                     if ((quote_products.isNotEmpty) || (quote_gstTotals.isNotEmpty) || (quote_noteList.isNotEmpty) || (quote_recommendationList.isNotEmpty) || (quote_productDetails.isNotEmpty) || quote_client_addr_name.isNotEmpty || quote_client_addr.isNotEmpty || quote_bill_addr_name.isNotEmpty || quote_bill_addr.isNotEmpty || quote_title.isNotEmpty || quote_table_heading.isNotEmpty) {
//                       // Show confirmation dialog
//                       bool? proceed = await showDialog<bool>(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Warning"),
//                             content: const Text(
//                               "IAMy be lost. Do you want to proceed?",
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

  dynamic GenerateInvoice_dialougebox() async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by clicking outside
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Primary_colors.Dark,
          content: Stack(
            children: [
              const SizedBox(
                height: 650,
                width: 1300,
                child: GenerateInvoice(),
              ),
              Positioned(
                top: 3,
                right: 0,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 219, 216, 216),
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                  onPressed: () async {
                    // Check if the data has any value
                    // || ( invoiceController.invoiceModel.Invoice_gstTotals.isNotEmpty)
                    if ((invoiceController.invoiceModel.Invoice_products.isNotEmpty) || (invoiceController.invoiceModel.Invoice_noteList.isNotEmpty) || (invoiceController.invoiceModel.Invoice_recommendationList.isNotEmpty) || (invoiceController.invoiceModel.clientAddressNameController.value.text != "") || (invoiceController.invoiceModel.clientAddressController.value.text != "") || (invoiceController.invoiceModel.billingAddressNameController.value.text != "") || (invoiceController.invoiceModel.billingAddressController.value.text != "") || (invoiceController.invoiceModel.Invoice_no.value != "") || (invoiceController.invoiceModel.TitleController.value.text != "") || (invoiceController.invoiceModel.Invoice_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  invoiceController.clearAll();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        // Clear all the data when dialog is closed
                        invoiceController.invoiceModel.Invoice_products.clear();
                        //  invoiceController.invoiceModel.Invoice_gstTotals.clear();
                        invoiceController.invoiceModel.Invoice_noteList.clear();
                        invoiceController.invoiceModel.Invoice_recommendationList.clear();
                        //  invoiceController.invoiceModel.iInvoice_productDetails.clear();
                        invoiceController.invoiceModel.clientAddressNameController.value.clear();
                        invoiceController.invoiceModel.clientAddressController.value.clear();
                        invoiceController.invoiceModel.billingAddressNameController.value.clear();
                        invoiceController.invoiceModel.billingAddressController.value.clear();
                        invoiceController.invoiceModel.Invoice_no.value = "";
                        invoiceController.invoiceModel.TitleController.value.clear();
                        invoiceController.invoiceModel.Invoice_table_heading.value = "";
                      }
                    } else {
                      // If no data, just close the dialog
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  dynamic generate_invoice() async {
    // bool confirmed = await GenerateInvoice_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    Future.delayed(const Duration(seconds: 4), () {
      Generate_popup.callback();
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://Invoice.pdf',
            ));
      },
    );
    // }
  }

  dynamic GenerateQuote_dialougebox() async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by clicking outside
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Primary_colors.Dark,
          content: Stack(
            children: [
              const SizedBox(
                height: 650,
                width: 1300,
                child: GenerateQuote(),
              ),
              Positioned(
                top: 3,
                right: 0,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 219, 216, 216),
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                  onPressed: () async {
                    // Check if the data has any value
                    // || ( quoteController.quoteModel.Quote_gstTotals.isNotEmpty)
                    if ((quoteController.quoteModel.Quote_products.isNotEmpty) || (quoteController.quoteModel.Quote_noteList.isNotEmpty) || (quoteController.quoteModel.Quote_recommendationList.isNotEmpty) || (quoteController.quoteModel.clientAddressNameController.value.text != "") || (quoteController.quoteModel.clientAddressController.value.text != "") || (quoteController.quoteModel.billingAddressNameController.value.text != "") || (quoteController.quoteModel.billingAddressController.value.text != "") || (quoteController.quoteModel.Quote_no.value != "") || (quoteController.quoteModel.TitleController.value.text != "") || (quoteController.quoteModel.Quote_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  quoteController.clearAll();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        // Clear all the data when dialog is closed
                        quoteController.quoteModel.Quote_products.clear();
                        //  quoteController.quoteModel.Quote_gstTotals.clear();
                        quoteController.quoteModel.Quote_noteList.clear();
                        quoteController.quoteModel.Quote_recommendationList.clear();
                        //  quoteController.quoteModel.iQuote_productDetails.clear();
                        quoteController.quoteModel.clientAddressNameController.value.clear();
                        quoteController.quoteModel.clientAddressController.value.clear();
                        quoteController.quoteModel.billingAddressNameController.value.clear();
                        quoteController.quoteModel.billingAddressController.value.clear();
                        quoteController.quoteModel.Quote_no.value = "";
                        quoteController.quoteModel.TitleController.value.clear();
                        quoteController.quoteModel.Quote_table_heading.value = "";
                      }
                    } else {
                      // If no data, just close the dialog
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  dynamic generate_quote() async {
    // bool confirmed = await GenerateQuote_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    Future.delayed(const Duration(seconds: 4), () {
      Generate_popup.callback();
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://Quote.pdf',
            ));
      },
    );
    // }
  }

  dynamic GenerateRFQ_dialougebox() async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by clicking outside
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Primary_colors.Dark,
          content: Stack(
            children: [
              const SizedBox(
                height: 650,
                width: 1300,
                child: GenerateRFQ(),
              ),
              Positioned(
                top: 3,
                right: 0,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 219, 216, 216),
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                  onPressed: () async {
                    // Check if the data has any value
                    // || ( rfqController.rfqModel.RFQ_gstTotals.isNotEmpty)
                    if ((rfqController.rfqModel.RFQ_products.isNotEmpty) || (rfqController.rfqModel.RFQ_noteList.isNotEmpty) || (rfqController.rfqModel.RFQ_recommendationList.isNotEmpty) || (rfqController.rfqModel.vendor_address_controller.value.text != "") || (rfqController.rfqModel.vendor_email_controller.value.text != "") || (rfqController.rfqModel.vendor_name_controller.value.text != "") || (rfqController.rfqModel.vendor_phone_controller.value.text != "") || (rfqController.rfqModel.RFQ_no.value != "") || (rfqController.rfqModel.RFQ_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  rfqController.clearAll();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        // Clear all the data when dialog is closed
                        rfqController.rfqModel.RFQ_products.clear();
                        //  rfqController.rfqModel.RFQ_gstTotals.clear();
                        rfqController.rfqModel.RFQ_noteList.clear();
                        rfqController.rfqModel.RFQ_recommendationList.clear();
                        //  rfqController.rfqModel.iRFQ_productDetails.clear();
                        rfqController.rfqModel.vendor_address_controller.value.clear();
                        rfqController.rfqModel.vendor_email_controller.value.clear();
                        rfqController.rfqModel.vendor_name_controller.value.clear();
                        rfqController.rfqModel.vendor_phone_controller.value.clear();
                        rfqController.rfqModel.RFQ_no.value = "";

                        rfqController.rfqModel.RFQ_table_heading.value = "";
                      }
                    } else {
                      // If no data, just close the dialog
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  dynamic generate_rfq() async {
    // bool confirmed = await GenerateRFQ_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    Future.delayed(const Duration(seconds: 4), () {
      Generate_popup.callback();
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://RFQ.pdf',
            ));
      },
    );
    // }
  }
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

  dynamic GenerateDelivery_challan_dialougebox() async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by clicking outside
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Primary_colors.Dark,
          content: Stack(
            children: [
              const SizedBox(
                height: 650,
                width: 1300,
                child: GenerateDelivery_challan(),
              ),
              Positioned(
                top: 3,
                right: 0,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 219, 216, 216),
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                  onPressed: () async {
                    // Check if the data has any value

                    if ((dcController.dcModel.Delivery_challan_products.isNotEmpty) || (dcController.dcModel.Delivery_challan_noteList.isNotEmpty) || (dcController.dcModel.Delivery_challan_recommendationList.isNotEmpty) || dcController.dcModel.clientAddressNameController.value.text != "" || dcController.dcModel.clientAddressController.value.text != "" || dcController.dcModel.billingAddressNameController.value.text != "" || dcController.dcModel.billingAddressController.value.text != "" || dcController.dcModel.Delivery_challan_no.value != "" || dcController.dcModel.TitleController.value.text != "" || dcController.dcModel.Delivery_challan_table_heading.value != "") {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  dcController.clearAll();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        // Clear all the data when dialog is closed
                        dcController.dcModel.Delivery_challan_products.clear();
                        dcController.dcModel.Delivery_challan_noteList.clear();
                        dcController.dcModel.Delivery_challan_recommendationList.clear();
                        // dcController.dcModel.Delivery_challan_productDetails.clear();
                        dcController.dcModel.clientAddressNameController.value.clear();
                        dcController.dcModel.clientAddressController.value.clear();
                        dcController.dcModel.billingAddressNameController.value.clear();
                        dcController.dcModel.billingAddressController.value.clear();
                        dcController.dcModel.Delivery_challan_no.value = "";
                        dcController.dcModel.TitleController.value.clear();
                        dcController.dcModel.Delivery_challan_table_heading.value = "";
                      }
                    } else {
                      // If no data, just close the dialog
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // dynamic generate_Delivery_challan() async {
  //   // bool confirmed = await GenerateDelivery_challan_dialougebox();

  //   // if (confirmed) {
  //   // Proceed only if the dialog was confirmed
  //   Future.delayed(const Duration(seconds: 4), () {
  //     Generate_popup.callback();
  //   });

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //           backgroundColor: Primary_colors.Light,
  //           content: Generate_popup(
  //             type: 'E://Delivery_challan.pdf',
  //           ));
  //     },
  //   );
  //   // }
  // }

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
//                     if ((creditnote_products.isNotEmpty) || (Credit_gstTotals.isNotEmpty) || (creditnote_noteList.isNotEmpty) || (creditnote_recommendationList.isNotEmpty) || (creditnote_productDetails.isNotEmpty) || creditnote_client_addr_name != "" || creditnote_client_addr != "" || creditnote_bill_addr_name != "" || creditnote_bill_addr != "" || creditnote_no != "" || creditnote_table_heading != "") {
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
//                         Credit_gstTotals.clear();
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
//                     if ((debitnote_products.isNotEmpty) || (debitnote_gstTotals.isNotEmpty) || (debitnote_noteList.isNotEmpty) || (debitnote_recommendationList.isNotEmpty) || (debitnote_productDetails.isNotEmpty) || debitnote_client_addr_name != "" || debitnote_client_addr != "" || debitnote_bill_addr_name != "" || debitnote_bill_addr != "" || debitnote_no != "" || debitnote_table_heading != "") {
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

  dynamic Generate_client_reqirement_dialougebox(String value) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by clicking outside
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Primary_colors.Dark,
          content: Stack(
            children: [
              SizedBox(
                height: 650,
                width: 900,
                child: Generate_clientreq(
                  value: value,
                ),
              ),
              Positioned(
                top: 3,
                right: 0,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 219, 216, 216),
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                  onPressed: () async {
                    // Check if any data exists in clientreq variables
                    if ((clientreqController.clientReqModel.clientReqProductDetails.isNotEmpty) || (clientreqController.clientReqModel.clientReqNoteList.isNotEmpty) || (clientreqController.clientReqModel.clientReqRecommendationList.isNotEmpty) || (clientreqController.clientReqModel.clientNameController.value.text.isNotEmpty) || (clientreqController.clientReqModel.clientAddressController.value.text.isNotEmpty) || (clientreqController.clientReqModel.billingAddressNameController.value.text.isNotEmpty) || (clientreqController.clientReqModel.billingAddressController.value.text.isNotEmpty) || (clientreqController.clientReqModel.clientReqNo.value.isNotEmpty) || (clientreqController.clientReqModel.clientReqTableHeading.value.isNotEmpty) || (clientreqController.clientReqModel.morController.value.text.isNotEmpty) || (clientreqController.clientReqModel.gstController.value.text.isNotEmpty) || (clientreqController.clientReqModel.emailController.value.text.isNotEmpty) || (clientreqController.clientReqModel.phoneController.value.text.isNotEmpty)) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        // Clear all the data when dialog is closed
                        clientreqController.clientReqModel.clientReqProductDetails.clear();
                        clientreqController.clientReqModel.clientReqNoteList.clear();
                        clientreqController.clientReqModel.clientReqRecommendationList.clear();
                        clientreqController.clientReqModel.clientNameController.value.clear();
                        clientreqController.clientReqModel.clientAddressController.value.clear();
                        clientreqController.clientReqModel.billingAddressNameController.value.clear();
                        clientreqController.clientReqModel.billingAddressController.value.clear();
                        clientreqController.clientReqModel.morController.value.clear();
                        clientreqController.clientReqModel.gstController.value.clear();
                        clientreqController.clientReqModel.emailController.value.clear();
                        clientreqController.clientReqModel.phoneController.value.clear();
                        clientreqController.clientReqModel.clientReqNo.value = '';
                        clientreqController.clientReqModel.clientReqTableHeading.value = '';
                        clientreqController.clientReqModel.pickedFile.value = null;
                      }
                    } else {
                      // If no data, just close the dialog
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  dynamic generate_client_requirement() async {
    // bool confirmed = await GenerateInvoice_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    Future.delayed(const Duration(seconds: 4), () {
      Generate_popup.callback();
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://Client_requirement.pdf',
            ));
      },
    );
    // }
  }

  dynamic GenerateDebit_dialougebox() async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by clicking outside
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Primary_colors.Dark,
          content: Stack(
            children: [
              const SizedBox(
                height: 650,
                width: 1300,
                child: GenerateDebit(),
              ),
              Positioned(
                top: 3,
                right: 0,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 219, 216, 216),
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                  onPressed: () async {
                    // Check if the data has any value
                    // || ( debitController.debitModel.Debit_gstTotals.isNotEmpty)
                    if ((debitController.debitModel.Debit_products.isNotEmpty) || (debitController.debitModel.Debit_noteList.isNotEmpty) || (debitController.debitModel.Debit_recommendationList.isNotEmpty) || (debitController.debitModel.clientAddressNameController.value.text != "") || (debitController.debitModel.clientAddressController.value.text != "") || (debitController.debitModel.billingAddressNameController.value.text != "") || (debitController.debitModel.billingAddressController.value.text != "") || (debitController.debitModel.Debit_no.value != "") || (debitController.debitModel.Debit_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  debitController.clearAll();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        debitController.debitModel.Debit_products.clear();
                        debitController.debitModel.Debit_noteList.clear();
                        debitController.debitModel.Debit_recommendationList.clear();
                        debitController.debitModel.Debit_no.value = "";
                        debitController.debitModel.Debit_table_heading.value = "";
                      }
                    } else {
                      // If no data, just close the dialog
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  dynamic generate_debit() async {
    // bool confirmed = await GenerateDebit_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    Future.delayed(const Duration(seconds: 4), () {
      Generate_popup.callback();
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://Debit.pdf',
            ));
      },
    );
    // }
  }

  dynamic GenerateCredit_dialougebox() async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by clicking outside
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Primary_colors.Dark,
          content: Stack(
            children: [
              const SizedBox(
                height: 650,
                width: 1300,
                child: GenerateCredit(),
              ),
              Positioned(
                top: 3,
                right: 0,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 219, 216, 216),
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                  onPressed: () async {
                    // Check if the data has any value
                    // || ( creditController.creditModel.Credit_gstTotals.isNotEmpty)
                    if ((creditController.creditModel.Credit_products.isNotEmpty) || (creditController.creditModel.Credit_noteList.isNotEmpty) || (creditController.creditModel.Credit_recommendationList.isNotEmpty) || (creditController.creditModel.clientAddressNameController.value.text != "") || (creditController.creditModel.clientAddressController.value.text != "") || (creditController.creditModel.billingAddressNameController.value.text != "") || (creditController.creditModel.billingAddressController.value.text != "") || (creditController.creditModel.Credit_no.value != "") || (creditController.creditModel.Credit_table_heading.value != "")) {
                      // Show confirmation dialog
                      bool? proceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Warning"),
                            content: const Text(
                              "The data may be lost. Do you want to proceed?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // No action
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  creditController.clearAll();
                                  Navigator.of(context).pop(true); // Yes action
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      // If user confirms (Yes), clear data and close the dialog
                      if (proceed == true) {
                        Navigator.of(context).pop(); // Close the dialog
                        // Clear all the data when dialog is closed
                        creditController.creditModel.Credit_products.clear();
                        //  creditController.creditModel.Credit_gstTotals.clear();
                        creditController.creditModel.Credit_noteList.clear();
                        creditController.creditModel.Credit_recommendationList.clear();
                        //  creditController.creditModel.iCredit_productDetails.clear();
                        creditController.creditModel.clientAddressNameController.value.clear();
                        creditController.creditModel.clientAddressController.value.clear();
                        creditController.creditModel.billingAddressNameController.value.clear();
                        creditController.creditModel.billingAddressController.value.clear();
                        creditController.creditModel.Credit_no.value = "";
                        creditController.creditModel.Credit_table_heading.value = "";
                      }
                    } else {
                      // If no data, just close the dialog
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  dynamic generate_credit() async {
    // bool confirmed = await GenerateCredit_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed
    Future.delayed(const Duration(seconds: 4), () {
      Generate_popup.callback();
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://Credit.pdf',
            ));
      },
    );
    // }
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                  colors: [
                                    Primary_colors.Color3,
                                    Primary_colors.Color3
                                  ], // Example gradient colors
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              child: ListView.builder(
                                itemCount: items[showcustomerprocess]['process'].length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Primary_colors.Dark,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: ExpansionTile(
                                          collapsedIconColor: const Color.fromARGB(255, 135, 132, 132),
                                          iconColor: Colors.red,
                                          collapsedBackgroundColor: Primary_colors.Dark,
                                          backgroundColor: Primary_colors.Dark,
                                          title: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  items[showcustomerprocess]['process'][index]['id'],
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  items[showcustomerprocess]['name'],
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  items[showcustomerprocess]['process'][index]['date'],
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  items[showcustomerprocess]['process'][index]['daycounts'],
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ],
                                          ),
                                          children: [
                                            SizedBox(
                                              height: ((items[showcustomerprocess]['process'][index]['child'].length * 80) + 20).toDouble(),
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: ListView.builder(
                                                  itemCount: items[showcustomerprocess]['process'][index]['child'].length, // +1 for "Add Event" button
                                                  itemBuilder: (context, childIndex) {
                                                    return Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets.all(8),
                                                              decoration: const BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: Colors.green,
                                                              ),
                                                              child: const Icon(
                                                                Icons.event,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                            if (childIndex != items[showcustomerprocess]['process'][index]['child'].length - 1)
                                                              Container(
                                                                width: 2,
                                                                height: 40,
                                                                color: Colors.green,
                                                              ),
                                                          ],
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(top: 2.0, left: 10),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          items[showcustomerprocess]['process'][index]['child'][childIndex]["name"],
                                                                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                                                        ),
                                                                        // const SizedBox(width: 5),
                                                                        // Expanded(
                                                                        //   child: Text(
                                                                        //     overflow: TextOverflow.ellipsis,
                                                                        //     items[showcustomerprocess]['process'][index]['child'][childIndex]["feedback"],
                                                                        //     style: const TextStyle(color: Colors.red, fontSize: Primary_font_size.Text5),
                                                                        //   ),
                                                                        // )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_Quote"] == true)
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            GenerateQuote_dialougebox();
                                                                          },
                                                                          child: const Text(
                                                                            "Quotation",
                                                                            style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_revisedQuote"] == true)
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            // GenerateQuotation_dialougebox();
                                                                          },
                                                                          child: const Text(
                                                                            "RevisedQuotation",
                                                                            style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_RFQ"] == true)
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            GenerateRFQ_dialougebox();
                                                                          },
                                                                          child: const Text(
                                                                            "Generate RFQ",
                                                                            style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_Invoice"] == true)
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            GenerateInvoice_dialougebox();
                                                                          },
                                                                          child: const Text(
                                                                            "Invoice",
                                                                            style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_deliverychallan"] == true)
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            GenerateDelivery_challan_dialougebox();
                                                                            // (items[showcustomerprocess]['process'][index]['child'] as List).add({
                                                                            //   "name": "Requirement4",
                                                                            //   "generate_po": true,
                                                                            //   "generate_RFQ": false,
                                                                            // });
                                                                          },
                                                                          child: const Text(
                                                                            "Deliverychallan",
                                                                            style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      if (items[showcustomerprocess]['process'][index]['child'][childIndex]["credit_note"] == true)
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            GenerateCredit_dialougebox();
                                                                            // (items[showcustomerprocess]['process'][index]['child'] as List).add({
                                                                            //   "name": "Requirement4",
                                                                            //   "generate_po": true,
                                                                            //   "generate_RFQ": false,
                                                                            // });
                                                                          },
                                                                          child: const Text(
                                                                            "Credit",
                                                                            style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      if (items[showcustomerprocess]['process'][index]['child'][childIndex]["debit_note"] == true)
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            GenerateDebit_dialougebox();
                                                                            // (items[showcustomerprocess]['process'][index]['child'] as List).add({
                                                                            //   "name": "Requirement4",
                                                                            //   "generate_po": true,
                                                                            //   "generate_RFQ": false,
                                                                            // });
                                                                          },
                                                                          child: const Text(
                                                                            "Debit",
                                                                            style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 40,
                                                                  width: 2,
                                                                  color: const Color.fromARGB(78, 172, 170, 170),
                                                                ),
                                                                SizedBox(
                                                                  width: 200,
                                                                  child: TextFormField(
                                                                    maxLines: 2,
                                                                    style: const TextStyle(
                                                                      fontSize: Primary_font_size.Text7,
                                                                      color: Colors.white,
                                                                    ),
                                                                    decoration: const InputDecoration(
                                                                      filled: true,
                                                                      fillColor: Primary_colors.Dark,
                                                                      hintText: 'Enter Feedback',
                                                                      hintStyle: TextStyle(
                                                                        fontSize: Primary_font_size.Text7,
                                                                        color: Color.fromARGB(255, 179, 178, 178),
                                                                      ),
                                                                      border: InputBorder.none, // Remove default border
                                                                      contentPadding: EdgeInsets.all(10), // Adjust padding
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ))
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
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
                                  Generate_client_reqirement_dialougebox(value);

                                  items.add(
                                    {
                                      "name": "Pandi Groups",
                                      "type": "Customer",
                                      "process": [
                                        {
                                          "id": "EST/SSIPL - 101",
                                          "date": "16/03/2023",
                                          "daycounts": "21 days",
                                          "child": [
                                            {
                                              "name": "Requirement",
                                              "generate_po": true,
                                              "generate_RFQ": false
                                            },
                                          ]
                                        },
                                      ]
                                    },
                                  );
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
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final Sales_Client = items[index]['name'];
                                return _buildSales_ClientCard(Sales_Client, items[index]['type'], index);
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
  }

  Widget _buildSales_ClientCard(String Sales_Client, String type, int index) {
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
                ? [
                    Primary_colors.Color3,
                    Primary_colors.Color3
                  ]
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
            color: type == 'Customer' ? Colors.white : Colors.red,
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
