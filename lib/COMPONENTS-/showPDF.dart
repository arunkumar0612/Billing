import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:ssipl_billing/COMPONENTS-/downloadPDF.dart';
import 'package:ssipl_billing/COMPONENTS-/sharePDF.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

Widget buildPdfViewer(File file, PdfViewerController controller) {
  try {
    return IgnorePointer(
      ignoring: true,
      child: SfPdfViewer.file(
        file,
        controller: controller,
        enableTextSelection: false,
        canShowScrollHead: false,
        canShowScrollStatus: false,
      ),
    );
  } catch (e) {
    return Center(child: Text('Failed to load PDF: $e'));
  }
}

void showPDF(BuildContext context, String filename, File? pdfFile) async {
  await Future.delayed(Duration(milliseconds: 500)); // ensure file write is completed

  if (pdfFile != null) {
    final PdfViewerController _pdfController = PdfViewerController();

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.95,
          child: Stack(
            children: [
              buildPdfViewer(pdfFile, _pdfController),

              // Navigation Arrows
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_left,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _pdfController.previousPage();
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_right,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _pdfController.nextPage();
                  },
                ),
              ),

              // Bottom download & share buttons
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              downloadPdf(context, path.basename(filename).replaceAll(RegExp(r'[\/\\:*?"<>|.]'), '').replaceAll(" ", ""), pdfFile);
                            },
                            icon: const Icon(Icons.download, color: Colors.green),
                          ),
                          Text('download'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              shareAnyPDF(context, path.basename(filename).replaceAll(RegExp(r'[\/\\:*?"<>|.]'), '').replaceAll(" ", ""), pdfFile);
                            },
                            icon: const Icon(Icons.share, color: Colors.blue),
                          ),
                          Text('share'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
