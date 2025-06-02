// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:ssipl_billing/COMPONENTS-/downloadPDF.dart';
import 'package:ssipl_billing/COMPONENTS-/sharePDF.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

Widget buildPdfViewer(
  File file,
  PdfViewerController controller,
  void Function(int)? onPageChanged,
  void Function(int)? onDocumentLoaded,
) {
  try {
    return IgnorePointer(
      ignoring: true,
      child: SfPdfViewer.file(
        file,
        controller: controller,
        enableTextSelection: false,
        canShowScrollHead: false,
        canShowScrollStatus: false,
        onPageChanged: (details) => onPageChanged?.call(details.newPageNumber),
        onDocumentLoaded: (details) => onDocumentLoaded?.call(details.document.pages.count),
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
    int currentPage = 1;
    int totalPages = 1;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.95,
                child: Stack(
                  children: [
                    buildPdfViewer(
                      pdfFile,
                      _pdfController,
                      (newPage) {
                        setState(() {
                          currentPage = newPage;
                        });
                      },
                      (pages) {
                        setState(() {
                          totalPages = pages;
                        });
                      },
                    ),

                    // Navigation Arrows
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: IconButton(
                    //     icon: Icon(Icons.arrow_left, size: 30, color: Colors.black),
                    //     onPressed: () {
                    //       _pdfController.previousPage();
                    //     },
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: IconButton(
                    //     icon: Icon(Icons.arrow_right, size: 30, color: Colors.black),
                    //     onPressed: () {
                    //       _pdfController.nextPage();
                    //     },
                    //   ),
                    // ),

                    // Bottom Buttons
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Download & Share
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5, bottom: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        downloadPdf(
                                          context,
                                          path.basename(filename).replaceAll(RegExp(r'[\/\\:*?"<>|.]'), '').replaceAll(" ", ""),
                                          pdfFile,
                                        );
                                      },
                                      icon: const Icon(Icons.download_sharp, color: Colors.green, size: 22),
                                    ),
                                    Text('Download', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20, bottom: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        shareAnyPDF(
                                          context,
                                          path.basename(filename).replaceAll(RegExp(r'[\/\\:*?"<>|.]'), '').replaceAll(" ", ""),
                                          pdfFile,
                                        );
                                      },
                                      icon: const Icon(Icons.share, color: Colors.blue, size: 22),
                                    ),
                                    Text('Share', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Page Indicator
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 2, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _pdfController.previousPage();
                                      },
                                      icon: const Icon(Icons.arrow_left_sharp, color: Colors.black),
                                    ),
                                    Text(
                                      'Page ($currentPage / $totalPages)',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _pdfController.nextPage();
                                      },
                                      icon: const Icon(Icons.arrow_right_sharp, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // Wait for total pages to be available
    Future.delayed(Duration(milliseconds: 700), () async {
      totalPages = _pdfController.pageCount;
    });
  }
}
