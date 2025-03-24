// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/Subscription_actions.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_Quote/post_Quote.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_Quote_actions.dart';
import 'quote_details.dart';
import 'quote_note.dart';
import 'quote_products.dart';

class SUBSCRIPTION_GenerateQuote extends StatefulWidget {
  SUBSCRIPTION_GenerateQuote({super.key, required this.quoteType, required this.eventID});
  int eventID;
  String quoteType;
  @override
  _SUBSCRIPTION_GenerateQuoteState createState() => _SUBSCRIPTION_GenerateQuoteState();
}

class _SUBSCRIPTION_GenerateQuoteState extends State<SUBSCRIPTION_GenerateQuote> with SingleTickerProviderStateMixin {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  final SubscriptionController subscriptionController = Get.find<SubscriptionController>();
  @override
  void initState() {
    super.initState();
    // SUBSCRIPTION_GenerateQuote._tabController = ;
    quoteController.initializeTabController(TabController(length: 4, vsync: this));
  }

  @override
  void dispose() {
    // SUBSCRIPTION_GenerateQuote._tabController.dispose();
    quoteController.quoteModel.tabController.value?.dispose();
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
          child: SfPdfViewer.file(subscriptionController.subscriptionModel.pdfFile.value!),
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
                          SfPdfViewer.file(subscriptionController.subscriptionModel.pdfFile.value!),
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
