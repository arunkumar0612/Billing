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
  static late dynamic Function() fetchsite_Callback;

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

  @override
  void initState() {
    super.initState();
    // widget.GetCustomerList(context);
    salesController.updateshowcustomerprocess(null);
    widget.GetProcesscustomerList(context);
    widget.GetProcessList(context, 0);
  }

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
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    salesController.salesModel.processList[index].processid.toString(),
                                                    // items[showcustomerprocess]['process'][index]['id'],
                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    salesController.salesModel.processList[index].title,
                                                    // items[showcustomerprocess]['name'],
                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    salesController.salesModel.processList[index].Process_date,
                                                    // items[showcustomerprocess]['process'][index]['date'],
                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    salesController.salesModel.processList[index].age_in_days.toString(),
                                                    // items[showcustomerprocess]['process'][index]['daycounts'],
                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  ),
                                                ),
                                              ],
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
                                                                  // print(
                                                                  //   salesController.salesModel.processList[index].TimelineEvents[childIndex].pdfpath,
                                                                  // );
                                                                  widget.GetPDFfile(context, salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid);
                                                                  // showDialog(
                                                                  //   context: context,
                                                                  //   builder: (context) => Dialog(
                                                                  //     insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
                                                                  //     child: SizedBox(
                                                                  //       width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
                                                                  //       height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
                                                                  //       child: SfPdfViewer.file(
                                                                  //         File('E://Quote.pdf'
                                                                  //             // salesController.salesModel.processList[index].TimelineEvents[childIndex].pdfpath,
                                                                  //             ),
                                                                  //       ),
                                                                  //     ),
                                                                  //   ),
                                                                  // );
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
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.credit_note == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                widget.GenerateCredit_dialougebox(context);
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
                                                                          if (salesController.salesModel.processList[index].TimelineEvents[childIndex].Allowed_process.debit_note == true)
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                widget.GenerateDebit_dialougebox(context);
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
                                                                    Obx(
                                                                      () => SizedBox(
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
                                                                            widget.UpdateFeedback(context, salesController.salesModel.customerId.value!, salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid, salesController.salesModel.processList[index].TimelineEvents[childIndex].feedback.text);
                                                                          },
                                                                        ),
                                                                      ),
                                                                      // GestureDetector(
                                                                      //   child: const Icon(
                                                                      //     Icons.check_circle,
                                                                      //     color: Colors.green,
                                                                      //   ),
                                                                      //   onTap: () {
                                                                      //     widget.UpdateFeedback(
                                                                      //         context,
                                                                      //         salesController.salesModel.customerId.value!,
                                                                      //         salesController.salesModel.processList[index].TimelineEvents[childIndex].Eventid,
                                                                      //         salesController.salesModel.processList[index].TimelineEvents[childIndex].feedback.text);
                                                                      //   },
                                                                      // )
                                                                    )
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
                                  onSelected: (String value) async {
                                    await widget.Generate_client_reqirement_dialougebox(value, context);
                                    salesController.updateshowcustomerprocess(null);
                                    widget.GetProcesscustomerList(context);
                                    widget.GetProcessList(context, 0);
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
                                  final customername = salesController.salesModel.processcustomerList[index].customerName;
                                  final customerid = salesController.salesModel.processcustomerList[index].customerId;
                                  return _buildSales_ClientCard(customername, customerid, index);
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
                    ? [
                        Primary_colors.Color3,
                        Primary_colors.Color3
                      ]
                    : [
                        Primary_colors.Light,
                        Primary_colors.Light
                      ],
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
}
