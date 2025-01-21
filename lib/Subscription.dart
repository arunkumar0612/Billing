import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_Invoice/sub_generateInvoice.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_Invoice/sub_invoice_template.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_Quotation/sub_generateQuotaion.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_Quotation/sub_quotation_template.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_client_req/sub_clientreq_details.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_client_req/sub_clientreq_template.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_client_req/sub_generate_clientreq.dart';
import 'package:ssipl_billing/cards.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/view_send_pdf.dart';

class Subscription_Client extends StatefulWidget {
  const Subscription_Client({super.key});
  static late dynamic Function() sub_clientreq_Callback;
  static late dynamic Function() sub_quote_Callback;
  static late dynamic Function() sub_invoice_Callback;

  @override
  _Subscription_ClientState createState() => _Subscription_ClientState();
}

class _Subscription_ClientState extends State<Subscription_Client> {
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
              "generate_Invoice": true,
            },
            {
              "name": "Invoice 2",
              "feedback": "Hello",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 3",
              "feedback": "Hello",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
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
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 2",
              "feedback": "Hello",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 3",
              "feedback": "Hello",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 4",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
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
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 3",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 4",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 5",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
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
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            }
          ]
        }
      ]
    },
    {
      "name": "Nexa Subscription and service",
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
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 3",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
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
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 3",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 4",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
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
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 3",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 4",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 5",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
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
              "generate_Invoice": false,
            },
            {
              "name": "Invoice 2",
              "feedback": "",
              "generate_Quote": true,
              "generate_revisedQuote": false,
              "generate_Invoice": false,
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
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String Subscription_ClientSearchQuery = '';
  @override
  void initState() {
    super.initState();
    Subscription_Client.sub_quote_Callback = () async => {await generate_quotation()};
    Subscription_Client.sub_invoice_Callback = () async => {await generate_invoice()};

    Subscription_Client.sub_clientreq_Callback = () async => {await generate_client_requirement()};
    // Initialize isAddingList and controllers based on the number of items
    isAddingList = List<bool>.filled(items.length, false);
    controllers = List<TextEditingController>.generate(items.length, (index) => TextEditingController());
  }

  dynamic GenerateQuotation_dialougebox() async {
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
                child: Generatesub_Quotation(),
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
                    if ((sub_quote_products.isNotEmpty) ||
                        (sub_quote_gstTotals.isNotEmpty) ||
                        (sub_quote_noteList.isNotEmpty) ||
                        (sub_quote_recommendationList.isNotEmpty) ||
                        sub_quote_client_addr_name.isNotEmpty ||
                        sub_quote_client_addr.isNotEmpty ||
                        sub_quote_bill_addr_name.isNotEmpty ||
                        sub_quote_bill_addr.isNotEmpty ||
                        sub_quote_title.isNotEmpty ||
                        sub_quote_table_heading.isNotEmpty) {
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
                        sub_quote_products.clear();
                        sub_quote_gstTotals.clear();
                        sub_quote_noteList.clear();
                        sub_quote_recommendationList.clear();
                        sub_quote_client_addr_name = "";
                        sub_quote_client_addr = "";
                        sub_quote_bill_addr_name = "";
                        sub_quote_bill_addr = "";
                        sub_quote_estimate_no = "";
                        sub_quote_title = "";
                        sub_quote_table_heading = "";
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

  dynamic generate_quotation() async {
    // bool confirmed = await GenerateQuotation_dialougebox();

    // if (confirmed) {
    // Only proceed if the dialog was confirmed
    Future.delayed(const Duration(seconds: 4), () {
      Generate_popup.callback();
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://sub_Quotation.pdf',
            ));
      },
    );
    // }
  }

// ##################################################################################################################################################################################################################################################################################################################################################################

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
                child: Generatesub_invoice(),
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
                    if ((sub_invoice_products.isNotEmpty) ||
                        (sub_invoice_gstTotals.isNotEmpty) ||
                        (sub_invoice_noteList.isNotEmpty) ||
                        (sub_invoice_recommendationList.isNotEmpty) ||
                        (sub_invoice_productDetails.isNotEmpty) ||
                        (sub_invoice_client_addr_name != "") ||
                        (sub_invoice_client_addr != "") ||
                        (sub_invoice_bill_addr_name != "") ||
                        (sub_invoice_bill_addr != "") ||
                        (sub_invoice_no != "") ||
                        (sub_invoice_title != "") ||
                        (sub_invoice_table_heading != "")) {
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
                        sub_invoice_products.clear();
                        sub_invoice_gstTotals.clear();
                        sub_invoice_noteList.clear();
                        sub_invoice_recommendationList.clear();
                        sub_invoice_productDetails.clear();
                        sub_invoice_client_addr_name = "";
                        sub_invoice_client_addr = "";
                        sub_invoice_bill_addr_name = "";
                        sub_invoice_bill_addr = "";
                        sub_invoice_no = "";
                        sub_invoice_title = "";
                        sub_invoice_table_heading = "";
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

// ##################################################################################################################################################################################################################################################################################################################################################################

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
                height: 600,
                width: 900,
                child: Generate_sub_clientreq(
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
                    // Check if any data exists in sub_clientreq variables
                    if ((sub_clientreq_products.isNotEmpty) ||
                        (sub_clientreq_noteList.isNotEmpty) ||
                        (sub_clientreq_recommendationList.isNotEmpty) ||
                        (sub_clientreq_productDetails.isNotEmpty) ||
                        sub_clientreq_client_addr_name != "" ||
                        sub_clientreq_client_addr != "" ||
                        sub_clientreq_bill_addr_name != "" ||
                        sub_clientreq_bill_addr != "" ||
                        sub_clientreq_no != "" ||
                        sub_clientreq_table_heading != "" ||
                        sub_clientreq_MOR != "" ||
                        sub_clientreq_GST != "" ||
                        sub_clientreq_email != "" ||
                        sub_clientreq_contact_number != "") {
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
                        sub_clientreq_products.clear();
                        sub_clientreq_noteList.clear();
                        sub_clientreq_recommendationList.clear();
                        sub_clientreq_productDetails.clear();
                        sub_clientreq_client_addr_name = "";
                        sub_clientreq_client_addr = "";
                        sub_clientreq_bill_addr_name = "";
                        sub_clientreq_bill_addr = "";
                        sub_clientreq_no = "";
                        sub_clientreq_MOR = "";
                        sub_clientreq_GST = "";
                        sub_clientreq_email = "";
                        sub_clientreq_contact_number = "";
                        sub_clientreq_table_heading = "";
                        sub_clientreqDetailsState.pickedFile = null;
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
                                        'Subscription_Client Name',
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
                                                                              GenerateQuotation_dialougebox();
                                                                            },
                                                                            child: const Text(
                                                                              "Quotation",
                                                                              style: TextStyle(color: Colors.blue, fontSize: 12),
                                                                            ),
                                                                          ),
                                                                        if (items[showcustomerprocess]['process'][index]['child'][childIndex]["generate_revisedQuote"] == true)
                                                                          TextButton(
                                                                            onPressed: () {
                                                                              GenerateQuotation_dialougebox();
                                                                            },
                                                                            child: const Text(
                                                                              "RevisedQuotation",
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
                                                          ),
                                                        )
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
                                      hintText: 'Search Subscription_Client from the list',
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

                                  // items.add(
                                  //   {
                                  //     "name": "Pandi Groups",
                                  //     "type": "Customer",
                                  //     "process": [
                                  //       {
                                  //         "id": "EST/SSIPL - 101",
                                  //         "date": "16/03/2023",
                                  //         "daycounts": "21 days",
                                  //         "child": [
                                  //           {"name": "Requirement", "generate_po": true, "generate_RFQ": false},
                                  //         ]
                                  //       },
                                  //     ]
                                  //   },
                                  // );
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
                                final Subscription_Client = items[index]['name'];
                                return _buildSubscription_ClientCard(Subscription_Client, items[index]['type'], index);
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

  Widget _buildSubscription_ClientCard(String Subscription_Client, String type, int index) {
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
            color: type == 'Customer' ? Colors.white : Colors.red,
            size: 25,
          ),
          title: Text(
            Subscription_Client,
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
            // Implement Subscription_Client details or actions here
          },
        ),
      ),
    );
  }
}
