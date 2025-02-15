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
import 'package:ssipl_billing/themes/style.dart';

import 'package:ssipl_billing/views/screens/SALES/Sales_chart.dart';
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

  @override
  void initState() {
    super.initState();
    // widget.GetCustomerList(context);
    salesController.updateshowcustomerprocess(null);
    salesController.updatecustomerId(0);
    widget.GetProcesscustomerList(context);
    widget.GetProcessList(context, 0);
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
                // const SizedBox(height: 185, child: cardview()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Primary_colors.Color3, Primary_colors.Color4], // Example gradient
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: const Icon(
                            Icons.trending_up,
                            size: 25.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Sales Customer',
                          style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text13),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(0),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/reload.png',
                                fit: BoxFit.cover, // Ensures the image covers the container
                                width: 30, // Makes the image fill the container's width
                                height: 30, // Makes the image fill the container's height
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 400,
                          height: 40,
                          child: TextFormField(
                            style: const TextStyle(fontSize: 13, color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              fillColor: Primary_colors.Light,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(227, 79, 78, 78),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 77, 76, 76),
                                ),
                              ),
                              hintStyle: TextStyle(
                                fontSize: Primary_font_size.Text7,
                                color: Primary_colors.Color1,
                                letterSpacing: 1,
                              ),
                              hintText: 'Search from the list',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none, // No additional border
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),
                        // ShaderMask(
                        //   shaderCallback: (bounds) => const LinearGradient(
                        //     colors: [Primary_colors.Color5, Primary_colors.Color4], // Example gradient
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //   ).createShader(bounds),
                        //   child: const Icon(
                        //     Icons.people,
                        //     size: 20.0,
                        //   ),
                        // ),
                        // Container(
                        //   width: 35, // Diameter of the CircleAvatar (2 * radius)
                        //   height: 35, // Diameter of the CircleAvatar (2 * radius)
                        //   decoration: const BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     gradient: LinearGradient(
                        //       colors: [
                        //         Primary_colors.Color3,
                        //         Primary_colors.Color4,
                        //       ],
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //     ),
                        //   ),
                        //   child: const CircleAvatar(
                        //     backgroundColor: Colors.transparent, // Make background transparent to show gradient
                        //     radius: 20,
                        //     child: Icon(
                        //       Icons.person,
                        //       color: Primary_colors.Color1,
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        // const Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       'User Name',
                        //       style: TextStyle(
                        //         color: Primary_colors.Color1,
                        //         fontSize: Primary_font_size.Text8,
                        //       ),
                        //     ),
                        //     Text(
                        //       'User',
                        //       style: TextStyle(color: Color.fromARGB(255, 198, 198, 198), fontSize: Primary_font_size.Text6),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              'PROCESS DATA',
                                              style: TextStyle(letterSpacing: 2, color: Primary_colors.Color3, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: SizedBox(
                                              width: 200,
                                              height: 35,
                                              child: DropdownButtonFormField<String>(
                                                items: [
                                                  "Yearly",
                                                  "Monthly",
                                                ] // Replace with your data
                                                    .map((String value) => DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value, style: const TextStyle(fontSize: 13, color: Colors.white)),
                                                        ))
                                                    .toList(),
                                                onChanged: (String? newValue) {
                                                  // Handle dropdown selection
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
                                                    label: const Text(
                                                      'Data View',
                                                      style: TextStyle(
                                                        fontSize: Primary_font_size.Text7,
                                                        color: Primary_colors.Color1,
                                                        letterSpacing: 1,
                                                      ),
                                                    )
                                                    // prefixIcon: const Icon(Icons.search, color: Colors.white),
                                                    ),
                                                dropdownColor: Primary_colors.Light,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
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
                                                      "₹ 17,6232",
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
                                                          style: TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 1, 53, 92), letterSpacing: 1, fontWeight: FontWeight.bold),
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
                                                      'RECEIVED',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(255, 186, 185, 185),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "₹ 18,6232",
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
                                                          style: TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 2, 87, 4), letterSpacing: 1, fontWeight: FontWeight.bold),
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
                                                      'PENDING',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(255, 186, 185, 185),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "₹ 6,232",
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
                                                          style: TextStyle(fontSize: Primary_font_size.Text5, color: Color.fromARGB(255, 118, 9, 1), fontWeight: FontWeight.bold, letterSpacing: 1),
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
                                        children: [
                                          Expanded(
                                            child: _buildIconWithLabel(
                                              image: 'assets/images/addcustomer.png',
                                              label: 'Add Customer',
                                              color: Primary_colors.Color4,
                                              onPressed: () {
                                                widget.Generate_client_reqirement_dialougebox('Customer', context);
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: _buildIconWithLabel(
                                                image: 'assets/images/addenquiry.png',
                                                label: 'Add Enquiry',
                                                color: Primary_colors.Color5,
                                                onPressed: () {
                                                  widget.Generate_client_reqirement_dialougebox('Enquiry', context);
                                                }),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      // Second row of icons and labels
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _buildIconWithLabel(image: 'assets/images/viewarchivelist.png', label: 'Archive List', color: Primary_colors.Color8, onPressed: () {}),
                                          ),
                                          Expanded(
                                            child: _buildIconWithLabel(image: 'assets/images/settings.png', label: 'Settings', color: Primary_colors.Dark, onPressed: () {}),
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
                                  child: const Padding(padding: EdgeInsets.all(16), child: Sales_chart()),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
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
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      'ACTIVE PROCESS LIST',
                                      style: TextStyle(letterSpacing: 2, color: Primary_colors.Color3, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      if (salesController.salesModel.selectedIndices.isNotEmpty)
                                        Container(
                                          width: 80,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Primary_colors.Color3,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3), // Shadow color
                                                blurRadius: 6, // Blur effect
                                                spreadRadius: 2, // Spread effect
                                                offset: const Offset(2, 3), // Shadow position
                                              ),
                                            ],
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              // widget.DeleteProcess(
                                              //     context, salesController.salesModel.selectedIndices.map((index) => salesController.salesModel.processList[index].processid).toList());
                                            },
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(color: Primary_colors.Color1),
                                            ),
                                          ),
                                        )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
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
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 47),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: salesController.salesModel.isAllSelected.value,
                                        onChanged: (bool? value) {
                                          salesController.salesModel.isAllSelected.value = value ?? false;
                                          if (salesController.salesModel.isAllSelected.value) {
                                            salesController.updateselectedIndices(List.generate(salesController.salesModel.processList.length, (index) => index));
                                          } else {
                                            salesController.salesModel.selectedIndices.clear();
                                          }
                                        },
                                        activeColor: Colors.white, // More vibrant color
                                        checkColor: Primary_colors.Color3, // White checkmark for contrast
                                        side: const BorderSide(color: Primary_colors.Color1, width: 2), // Styled border
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4), // Soft rounded corners
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      const Expanded(
                                        flex: 4,
                                        child: Text(
                                          'Process ID',
                                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 15,
                                        child: Text(
                                          'Sales_Client Name',
                                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 4,
                                        child: Text(
                                          'Date',
                                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 4,
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
                                // child: Container(),
                                child: ListView.builder(
                                  itemCount: salesController.salesModel.processList.length,
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
                                            title: Obx(
                                              () => Row(
                                                children: [
                                                  Checkbox(
                                                    value: salesController.salesModel.selectedIndices.contains(index),
                                                    onChanged: (bool? value) {
                                                      if (value == true) {
                                                        salesController.salesModel.selectedIndices.add(index);
                                                      } else {
                                                        salesController.salesModel.selectedIndices.remove(index);
                                                        salesController.updateisAllSelected(salesController.salesModel.selectedIndices.length == salesController.salesModel.processList.length);
                                                      }
                                                    },
                                                    activeColor: Primary_colors.Color3, // More vibrant color
                                                    checkColor: Colors.white, // White checkmark for contrast
                                                    side: const BorderSide(color: Primary_colors.Color3, width: 2), // Styled border
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(4), // Soft rounded corners
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      salesController.salesModel.processList[index].processid.toString(),
                                                      // items[showcustomerprocess]['process'][index]['id'],
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 15,
                                                    child: Text(
                                                      salesController.salesModel.processList[index].title,
                                                      // items[showcustomerprocess]['name'],
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      salesController.salesModel.processList[index].Process_date,
                                                      // items[showcustomerprocess]['process'][index]['date'],
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      salesController.salesModel.processList[index].age_in_days.toString(),
                                                      // items[showcustomerprocess]['process'][index]['daycounts'],
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            children: [
                                              SizedBox(
                                                height: ((salesController.salesModel.processList[index].TimelineEvents.length * 80) + 20).toDouble(),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: ListView.builder(
                                                    itemCount: salesController.salesModel.processList[index].TimelineEvents.length, // +1 for "Add Event" button
                                                    itemBuilder: (context, childIndex) {
                                                      final Rx<Color> textColor = const Color.fromARGB(255, 199, 198, 198).obs;
                                                      return Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              GestureDetector(
                                                                child: Container(
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
                                                                onTap: () {
                                                                  widget.GetPDFfile(context, salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                },
                                                              ),
                                                              if (childIndex != salesController.salesModel.processList[index].TimelineEvents.length - 1)
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
                                                                              salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventname,
                                                                              // items[showcustomerprocess]['process'][index]['child'][childIndex]["name"],
                                                                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.quotation == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                widget.GenerateQuote_dialougebox(context);
                                                                              },
                                                                              child: const Text(
                                                                                "Quotation",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.revised_quatation == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                // GenerateQuotation_dialougebox();
                                                                              },
                                                                              child: const Text(
                                                                                "RevisedQuotation",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.rfq == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                widget.GenerateRFQ_dialougebox(context);
                                                                              },
                                                                              child: const Text(
                                                                                "Generate RFQ",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.invoice == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                widget.GenerateInvoice_dialougebox(context);
                                                                              },
                                                                              child: const Text(
                                                                                "Invoice",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.delivery_challan == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                widget.GenerateDelivery_challan_dialougebox(context);
                                                                              },
                                                                              child: const Text(
                                                                                "Deliverychallan",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.credit_note == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                widget.GenerateCredit_dialougebox(context);
                                                                              },
                                                                              child: const Text(
                                                                                "Credit",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.debit_note == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                widget.GenerateDebit_dialougebox(context);
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
                                                                        // maxLines: 2,
                                                                        style: TextStyle(fontSize: Primary_font_size.Text7, color: textColor.value),
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
                                                                        controller: salesController.salesModel.processList[index].TimelineEvents[childIndex].feedback,

                                                                        onChanged: (value) {
                                                                          textColor.value = Colors.white;
                                                                        },
                                                                        onFieldSubmitted: (newValue) {
                                                                          // textColor = Colors.green;
                                                                          widget.UpdateFeedback(
                                                                              context,
                                                                              salesController.salesModel.customerId.value!,
                                                                              salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid,
                                                                              salesController.salesModel.processList[index].TimelineEvents[childIndex].feedback.text);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
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
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10, top: 5),
                                    child: Text(
                                      'ACTIVE CUSTOMER LIST',
                                      style: TextStyle(letterSpacing: 2, color: Primary_colors.Color3, fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: salesController.salesModel.processcustomerList.length,
                                      itemBuilder: (context, index) {
                                        final customername = salesController.salesModel.processcustomerList[index].customerName;
                                        final customerid = salesController.salesModel.processcustomerList[index].customerId;
                                        return _buildSales_ClientCard(customername, customerid, index);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
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

  Widget _buildSales_ClientCard(String customername, int customerid, int index) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(15),
            // ),
            // elevation: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: (salesController.salesModel.showcustomerprocess.value != null && salesController.salesModel.showcustomerprocess.value == index)
                    ? [Primary_colors.Color3, Primary_colors.Color3]
                    : [Primary_colors.Dark, Primary_colors.Dark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20), // Ensure border radius for smooth corners
            ),
            child: ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                customername,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  size: 20,
                  Icons.notifications,
                  color: salesController.salesModel.showcustomerprocess.value == index ? Colors.red : Colors.amber,
                ),
              ),
              onTap: salesController.salesModel.showcustomerprocess.value != index
                  ? () {
                      salesController.updateshowcustomerprocess(index);
                      salesController.updatecustomerId(customerid);

                      widget.GetProcessList(context, customerid);
                    }
                  : () {
                      salesController.updateshowcustomerprocess(null);
                      salesController.updatecustomerId(0);
                      widget.GetProcessList(context, salesController.salesModel.customerId.value!);
                      print('object');
                    },
            ),
          ),
        );
      },
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
          Container(
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
                fit: BoxFit.cover, // Ensures the image covers the container
                width: 50, // Makes the image fill the container's width
                height: 50, // Makes the image fill the container's height
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(letterSpacing: 1, fontSize: Primary_font_size.Text5, color: Primary_colors.Color1, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
