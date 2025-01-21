import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ssipl_billing/SALES/Generate_RFQ/RFQ_details.dart';
import 'package:ssipl_billing/SALES/Generate_RFQ/RFQ_note.dart';
import 'package:ssipl_billing/SALES/Generate_RFQ/RFQ_products.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GenerateRFQ extends StatefulWidget {
  const GenerateRFQ({super.key});
  static late TabController _tabController;

  static void nextTab() {
    if (_tabController.index < _tabController.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  static void backTab() {
    if (_tabController.index > 0) {
      _tabController.animateTo(_tabController.index - 1);
    }
  }

  @override
  _GenerateRFQState createState() => _GenerateRFQState();
}

class _GenerateRFQState extends State<GenerateRFQ> with SingleTickerProviderStateMixin {
  final File _selectedPdf = File('E://RFQ.pdf');
  @override
  void initState() {
    super.initState();
    GenerateRFQ._tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    GenerateRFQ._tabController.dispose();
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
                          controller: GenerateRFQ._tabController,
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
                      controller: GenerateRFQ._tabController,
                      children: [
                        const RFQDetails(),
                        Container(
                          color: Primary_colors.Light,
                          child: const RFQProducts(),
                        ),
                        const RFQNote(),
                      ],
                    ),
                  ),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: GenerateRFQ.backTab,
                  //       child: Text("Back"),
                  //     ),
                  //     ElevatedButton(
                  //       onPressed: GenerateRFQ.nextTab,
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
