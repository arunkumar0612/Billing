// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';

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

void PDFviewonly(BuildContext context, File? pdfFile) async {
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

                    // Bottom Buttons
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Download & Share

                          // Page Navigation
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 2, bottom: 10),
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20), boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                    ),
                                  ]),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _pdfController.previousPage();
                                        },
                                        icon: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: const Icon(Icons.arrow_left_sharp, color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Text(
                                          'Page ($currentPage / $totalPages)',
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _pdfController.nextPage();
                                        },
                                        icon: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: const Icon(Icons.arrow_right_sharp, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
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
