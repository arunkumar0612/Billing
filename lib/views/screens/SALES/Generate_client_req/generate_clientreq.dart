import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_client_req/clientreq_details.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_client_req/clientreq_details/customer_details.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_client_req/clientreq_details/enquiry_details.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_client_req/clientreq_note.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_client_req/clientreq_products.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../controllers/SALEScontrollers/ClientReq_actions.dart';

class Generate_clientreq extends StatefulWidget {
  final String? value;

  const Generate_clientreq({super.key, required this.value});

  @override
  _GenerateclientreqState createState() => _GenerateclientreqState();
}

class _GenerateclientreqState extends State<Generate_clientreq> with SingleTickerProviderStateMixin {
  // final File _selectedPdf = File('E://Client_requirement.pdf');
  final ClientreqController clientreqController = Get.find<ClientreqController>();

  @override
  void initState() {
    super.initState();
    clientreqController.initializeTabController(TabController(length: 3, vsync: this));
  }

  @override
  void dispose() {
    clientreqController.clientReqModel.tabController.value?.dispose();
    super.dispose();
  }

  // ignore: unused_element
  void _showReadablePdf() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
          height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
          child: SfPdfViewer.file(clientreqController.clientReqModel.selectedPdf.value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Primary_colors.Dark,
        body: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      // Primary_colors.Dark,
                      Color.fromARGB(255, 4, 6, 10), // Slightly lighter blue-grey
                      Primary_colors.Light, // Dark purple/blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      color: Primary_colors.Dark,
                      child: PreferredSize(
                        preferredSize: const Size.fromHeight(50),
                        child: IgnorePointer(
                          child: TabBar(
                            unselectedLabelStyle: const TextStyle(
                              color: Primary_colors.Color1,
                              fontSize: Primary_font_size.Text7,
                            ),
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 227, 77, 60),
                              fontSize: Primary_font_size.Text10,
                              fontWeight: FontWeight.bold,
                            ),
                            controller: clientreqController.clientReqModel.tabController.value,
                            indicator: const BoxDecoration(),
                            tabs: const [
                              Tab(text: "Details"),
                              Tab(text: "Product"),
                              Tab(text: "Note"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: clientreqController.clientReqModel.tabController.value,
                        children: [
                          widget.value == "Enquiry" ? enquryDetails() : customerDetails(),
                          clientreqProducts(),
                          ClientreqNote(customer_type: widget.value),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
