// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/Sales_actions.dart';
import 'package:ssipl_billing/4_SALES/services/Process/Quotation_services/QuoteDetails_service.dart';
import 'package:ssipl_billing/4_SALES/views/Process/Generate_Quote/post_Quote.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/PDFviewonly.dart';
import 'package:ssipl_billing/THEMES/style.dart';

import '../../../controllers/Process/Quote_actions.dart';
import 'quote_details.dart';
import 'quote_note.dart';
import 'quote_products.dart';

class GenerateQuote extends StatefulWidget with QuotedetailsService {
  GenerateQuote({super.key, required this.quoteType, required this.eventID});
  int eventID;
  String quoteType;
  @override
  _GenerateQuoteState createState() => _GenerateQuoteState();
}

class _GenerateQuoteState extends State<GenerateQuote> with SingleTickerProviderStateMixin {
  final QuoteController quoteController = Get.find<QuoteController>();
  final SalesController salesController = Get.find<SalesController>();
  @override
  void initState() {
    super.initState();
    // GenerateQuote._tabController = ;
    quoteController.initializeTabController(TabController(length: 4, vsync: this));
    widget.get_requiredData(context, widget.quoteType, widget.eventID);
    widget.get_productSuggestionList(context);
  }

  @override
  void dispose() {
    // GenerateQuote._tabController.dispose();
    quoteController.quoteModel.tabController.value?.dispose();
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
                    widget.quoteType == "quotation" ? "CLIENT REQUEST" : "QUOTATION",
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
                          PDFviewonly.dialogWidget(salesController.salesModel.pdfFile.value!),
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
                        PDFviewonly.show(context, salesController.salesModel.pdfFile.value!);
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
                          controller: quoteController.quoteModel.tabController.value,
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
                      controller: quoteController.quoteModel.tabController.value,
                      children: [
                        QuoteDetails(
                          eventtype: widget.quoteType,
                          eventID: widget.eventID,
                        ),
                        QuoteProducts(),
                        QuoteNote(),
                        PostQuote(type: 'E:/${(quoteController.quoteModel.Quote_no.value ?? "default_filename").replaceAll("/", "-")}.pdf', eventtype: widget.quoteType
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
