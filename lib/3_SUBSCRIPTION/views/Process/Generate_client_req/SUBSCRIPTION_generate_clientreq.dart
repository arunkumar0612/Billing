import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/Process/SUBSCRIPTION_ClientReq_actions.dart' show SUBSCRIPTION_ClientreqController;
import 'package:ssipl_billing/3_SUBSCRIPTION/services/Process/ClientReq_services/SUBSCRIPTION_ClientreqDetails_service.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/views/Process/Generate_client_req/SUBSCRIPTION_Cus_Enq_Details.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/views/Process/Generate_client_req/SUBSCRIPTION_clientreq_note.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/views/Process/Generate_client_req/SUBSCRIPTION_clientreq_sites.dart';
import 'package:ssipl_billing/THEMES/style.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SUBSCRIPTION_Generate_clientreq extends StatefulWidget with SUBSCRIPTION_ClientreqDetailsService {
  final String? value;

  SUBSCRIPTION_Generate_clientreq({super.key, required this.value});

  @override
  _GenerateclientreqState createState() => _GenerateclientreqState();
}

class _GenerateclientreqState extends State<SUBSCRIPTION_Generate_clientreq> with SingleTickerProviderStateMixin {
  // final File _selectedPdf = File('E://Client_requirement.pdf');
  final SUBSCRIPTION_ClientreqController clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();

  @override
  void initState() {
    super.initState();
    clientreqController.initializeTabController(TabController(length: 3, vsync: this));
    widget.get_OrganizationList(context);
    widget.get_CompanyList(context, 0);
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
                              Tab(text: "Sites"),
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
                          // widget.value == "Enquiry" ?
                          enquryDetails(),
                          // : customerDetails(),
                          SUBSCRIPTION_clientreqSites(),
                          SingleChildScrollView(
                            child: SUBSCRIPTION_ClientreqNote(customer_type: widget.value),
                          )
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
