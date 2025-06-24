// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/Sales_actions.dart';
import 'package:ssipl_billing/4_SALES/services/DC_services/DC_Details_service.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_DC/DC_details.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_DC/DC_note.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_DC/DC_products.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_DC/post_DC.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/PDFviewonly.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GenerateDc extends StatefulWidget with DcdetailsService {
  GenerateDc({super.key, required this.eventID, required this.eventName});
  int eventID;
  String eventName;
  @override
  _GenerateDcState createState() => _GenerateDcState();
}

class _GenerateDcState extends State<GenerateDc> with SingleTickerProviderStateMixin {
  final DcController dcController = Get.find<DcController>();
  final SalesController salesController = Get.find<SalesController>();
  @override
  void initState() {
    widget.get_requiredData(context, widget.eventID, "deliverychallan");
    widget.get_noteSuggestionList(context);
    super.initState();
    // GenerateDc._tabController = ;
    dcController.initializeTabController(TabController(length: 4, vsync: this));
  }

  @override
  void dispose() {
    // GenerateDc._tabController.dispose();
    dcController.dcModel.tabController.value?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Primary_colors.Dark,
        body: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.eventName == 'Invoice' ? "INVOICE" : 'DELIVERY CHALLAN',
                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 420,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 3, color: const Color.fromARGB(255, 161, 232, 250)),
                    // ),
                    child: GestureDetector(
                      child: Stack(
                        children: [
                          if (salesController.salesModel.pdfFile.value != null) SfPdfViewer.file(salesController.salesModel.pdfFile.value!),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      onDoubleTap: () {
                        PDFviewonly(context, salesController.salesModel.pdfFile.value!);
                        // _showReadablePdf();
                      },
                    ),
                  ),
                )
              ],
            ),
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
                          controller: dcController.dcModel.tabController.value,
                          indicator: const BoxDecoration(),
                          tabs: const [
                            Tab(text: "DETAILS"),
                            Tab(text: "PRODUCT"),
                            Tab(text: "NOTE"),
                            Tab(text: "POST"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: dcController.dcModel.tabController.value,
                      children: [
                        DcDetails(
                          eventID: widget.eventID,
                          eventName: widget.eventName,
                        ),
                        DcProducts(),
                        DcNote(),
                        PostDc(type: 'E:/${(dcController.dcModel.Dc_no.value ?? "default_filename").replaceAll("/", "-")}.pdf'
                            // Pass the expected file path
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
