// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/Subscription_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/services/Quotation_services/SUBSCRIPTION_QuoteDetails_service.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/views/Process/Generate_Quote/SUBSCRIPTION_post_Quote.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/views/Process/Generate_Quote/SUBSCRIPTION_quote_package.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/PDFviewonly.dart';
import 'package:ssipl_billing/THEMES/style.dart';

import '../../../controllers/SUBSCRIPTION_Quote_actions.dart';
import 'SUBSCRIPTION_quote_details.dart';
import 'SUBSCRIPTION_quote_note.dart';
import 'SUBSCRIPTION_quote_sites.dart';

class SUBSCRIPTION_GenerateQuote extends StatefulWidget with SUBSCRIPTION_QuotedetailsService {
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
    quoteController.initializeTabController(TabController(length: 5, vsync: this));
    widget.get_requiredData(context, widget.quoteType, widget.eventID);
  }

  @override
  void dispose() {
    // SUBSCRIPTION_GenerateQuote._tabController.dispose();
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
                        if (subscriptionController.subscriptionModel.pdfFile.value != null) PDFviewonly.dialogWidget(subscriptionController.subscriptionModel.pdfFile.value!),
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
                        ),
                      ],
                    ),
                    onDoubleTap: () {
                      PDFviewonly.show(context, subscriptionController.subscriptionModel.pdfFile.value!);
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
                            Tab(text: "SITE"),
                            Tab(text: "PACKAGE"),
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
                        SUBSCRIPTION_QuoteDetails(
                          eventtype: widget.quoteType,
                          eventID: widget.eventID,
                        ),
                        SUBSCRIPTION_QuoteSites(),
                        SUBSCRIPTION_QuotePackage(),
                        SUBSCRIPTION_QuoteNote(),
                        SUBSCRIPTION_PostQuote(type: 'E:/${(quoteController.quoteModel.Quote_no.value ?? "default_filename").replaceAll("/", "-")}.pdf', eventtype: widget.quoteType
                            // Pass the expected file path
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
