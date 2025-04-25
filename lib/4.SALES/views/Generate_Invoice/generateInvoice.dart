// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4.SALES/controllers/Sales_actions.dart';
import 'package:ssipl_billing/4.SALES/services/Invoice_services/InvoiceDetails_service.dart';
import 'package:ssipl_billing/4.SALES/views/Generate_Invoice/invoice_details.dart';
import 'package:ssipl_billing/4.SALES/views/Generate_Invoice/invoice_note.dart';
import 'package:ssipl_billing/4.SALES/views/Generate_Invoice/invoice_products.dart';
import 'package:ssipl_billing/4.SALES/views/Generate_Invoice/post_Invoice.dart';
import 'package:ssipl_billing/THEMES-/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../controllers/Invoice_actions.dart';

class GenerateInvoice extends StatefulWidget with InvoicedetailsService {
  GenerateInvoice({super.key, required this.eventID});
  int eventID;
  @override
  _GenerateInvoiceState createState() => _GenerateInvoiceState();
}

class _GenerateInvoiceState extends State<GenerateInvoice> with SingleTickerProviderStateMixin {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final SalesController salesController = Get.find<SalesController>();
  @override
  void initState() {
    super.initState();
    // GenerateInvoice._tabController = ;
    invoiceController.initializeTabController(TabController(length: 4, vsync: this));
    widget.get_requiredData(context, widget.eventID, "invoice");
    widget.get_productSuggestionList(context);
    widget.get_noteSuggestionList(context);
  }

  @override
  void dispose() {
    // GenerateInvoice._tabController.dispose();
    invoiceController.invoiceModel.tabController.value?.dispose();
    super.dispose();
  }

  void _showReadablePdf() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
          height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
          child: SfPdfViewer.file(salesController.salesModel.pdfFile.value!),
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
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "APPROVED QUOTATION",
                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
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
                        _showReadablePdf();
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
                          controller: invoiceController.invoiceModel.tabController.value,
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
                      controller: invoiceController.invoiceModel.tabController.value,
                      children: [
                        InvoiceDetails(
                          eventID: widget.eventID,
                        ),
                        InvoiceProducts(),
                        InvoiceNote(),
                        PostInvoice(type: 'E:/${(invoiceController.invoiceModel.Invoice_no.value ?? "default_filename").replaceAll("/", "-")}.pdf'
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
