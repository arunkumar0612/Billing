import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_client_req/sub_clientreq_details.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_client_req/sub_clientreq_note.dart';

import 'package:ssipl_billing/common_modules/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Generate_sub_clientreq extends StatefulWidget {
  final String? value;

  const Generate_sub_clientreq({super.key, required this.value});
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
  _Generatesub_clientreqState createState() => _Generatesub_clientreqState();
}

class _Generatesub_clientreqState extends State<Generate_sub_clientreq> with SingleTickerProviderStateMixin {
  final File _selectedPdf = File('E://Client_requirement.pdf');
  @override
  void initState() {
    super.initState();
    Generate_sub_clientreq._tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    Generate_sub_clientreq._tabController.dispose();
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
                          controller: Generate_sub_clientreq._tabController,
                          indicator: const BoxDecoration(),
                          tabs: const [
                            Tab(text: "Details"),
                            // Tab(text: "Product"),
                            Tab(text: "Note"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: Generate_sub_clientreq._tabController,
                      children: [
                        sub_clientreqDetails(
                          customer_type: widget.value!,
                        ),
                        // Container(
                        //   color: Primary_colors.Light,
                        //   child: const sub_clientreqProducts(),
                        // ),
                        const sub_clientreqNote(),
                      ],
                    ),
                  ),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: Generatesub_clientreq.backTab,
                  //       child: Text("Back"),
                  //     ),
                  //     ElevatedButton(
                  //       onPressed: Generatesub_clientreq.nextTab,
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
