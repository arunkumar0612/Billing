import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../controllers/SALEScontrollers/Quote_actions.dart';
import 'quote_details.dart';
import 'quote_note.dart';
import 'quote_products.dart';

class GenerateQuote extends StatefulWidget {
  const GenerateQuote({super.key});

  @override
  _GenerateQuoteState createState() => _GenerateQuoteState();
}

class _GenerateQuoteState extends State<GenerateQuote> with SingleTickerProviderStateMixin {
  final File _selectedPdf = File('E://Quote.pdf');
  final QuoteController quoteController = Get.find<QuoteController>();

  @override
  void initState() {
    super.initState();
    // GenerateQuote._tabController = ;
    quoteController.initializeTabController(TabController(length: 3, vsync: this));
  }

  @override
  void dispose() {
    // GenerateQuote._tabController.dispose();
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
          child: SfPdfViewer.file(_selectedPdf),
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
                    "Client Requirement",
                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 420,
                    child: GestureDetector(
                      child: Stack(
                        children: [
                          SfPdfViewer.file(_selectedPdf),
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
              color: Primary_colors.Light,
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
                      controller: quoteController.quoteModel.tabController.value,
                      children: [
                        QuoteDetails(),
                        Container(
                          color: Primary_colors.Light,
                          child: QuoteProducts(),
                        ),
                        QuoteNote(),
                      ],
                    ),
                  ),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: GenerateQuote.backTab,
                  //       child: Text("Back"),
                  //     ),
                  //     ElevatedButton(
                  //       onPressed: GenerateQuote.nextTab,
                  //       child: Text("Next"),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ))
          ],
        ));
  }
}
