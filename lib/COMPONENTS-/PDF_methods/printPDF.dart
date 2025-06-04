import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';

void printPDF(BuildContext context, Uint8List pdfBytes) async {
  final loader = LoadingOverlay();

  try {
    loader.start(context);

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
    loader.stop();

    if (kDebugMode) {
      print('PDF printed successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error printing PDF: $e');
    }
    // Show error dialog if needed
    Error_dialog(
      context: context,
      title: "Print Error",
      content: "An error occurred while printing:\n$e",
    );
  }
}
