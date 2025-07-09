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

class PDFviewonly extends StatefulWidget {
  final File pdfFile;

  const PDFviewonly({super.key, required this.pdfFile});

  /// Call this from anywhere in one line
  static Future<void> show(BuildContext context, File? file) async {
    if (file == null) return;
    await Future.delayed(const Duration(milliseconds: 500));
    await showDialog(
      context: context,
      builder: (context) => PDFviewonly(pdfFile: file),
    );
  }

  static Widget dialogWidget(File file) {
    return PDFviewonly(pdfFile: file);
  }

  @override
  State<PDFviewonly> createState() => _PDFviewonlyState();
}

class _PDFviewonlyState extends State<PDFviewonly> {
  final PdfViewerController _pdfController = PdfViewerController();
  int currentPage = 1;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        totalPages = _pdfController.pageCount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.95,
        child: Stack(
          children: [
            buildPdfViewer(
              widget.pdfFile,
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
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 2, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => _pdfController.previousPage(),
                                icon: Container(
                                  decoration: const BoxDecoration(
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
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                onPressed: () => _pdfController.nextPage(),
                                icon: Container(
                                  decoration: const BoxDecoration(
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
  }
}
