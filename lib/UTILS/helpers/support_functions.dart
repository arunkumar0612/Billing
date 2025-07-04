// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ssipl_billing/THEMES/style.dart';

dynamic Helvetica;
dynamic Helvetica_bold;

Future<void> savePdfToNetwork(Uint8List pdfData) async {
  try {
    const networkPath = '\\\\192.198.0.198\\backup\\Hari\\invoice.pdf';

    final file = File(networkPath);

    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print('PDF saved to $networkPath');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error saving PDF: $e');
    }
  }
}

Future<pw.Font> loadFont_regular() async {
  final helvetica = await rootBundle.load('assets/fonts/Helvetica.ttf');
  return pw.Font.ttf(helvetica);
}

Future<pw.Font> loadFont_bold() async {
  final helveticaBold = await rootBundle.load('assets/fonts/Helvetica-Bold.ttf');
  return pw.Font.ttf(helveticaBold);
}

pw.Widget regular(String value, int size) {
  // loadFont();
  return pw.Text(
    value,
    style: pw.TextStyle(
      font: Helvetica,
      fontSize: size.toDouble(),
      color: PdfColors.blueGrey800,
      // fontWeight: pw.FontWeight.bold,
    ),
  );
}

pw.Widget footerRegular(String value, int size) {
  // loadFont();
  return pw.Text(
    value,
    style: pw.TextStyle(
      font: Helvetica,
      fontSize: size.toDouble(),
      color: PdfColors.black,
      // fontWeight: pw.FontWeight.bold,
    ),
  );
}

pw.Widget bold(value, size) {
  // loadFont();
  return pw.Text(
    value,
    style: pw.TextStyle(
      font: Helvetica_bold,
      fontSize: size.toDouble(),
      color: PdfColors.blueGrey800,
      // fontWeight: pw.FontWeight.bold,
    ),
  );
}

pw.Widget footerBold(value, size) {
  // loadFont();
  return pw.Text(
    value,
    style: pw.TextStyle(
      font: Helvetica_bold,
      fontSize: size.toDouble(),
      color: PdfColors.black,
      // fontWeight: pw.FontWeight.bold,
    ),
  );
}

String formatCurrencyRoundedPaisa(double amount) {
  // Round the paisa (decimal) values to the nearest integer
  double roundedAmount = amount.roundToDouble();

  // Format the amount with comma separation and two decimal places
  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 2);
  return formatter.format(roundedAmount);
}

String calculateFormattedDifference(double grandTotal) {
  double formattedValue = double.parse(formatCurrencyRoundedPaisa(grandTotal).replaceAll(',', ''));
  double difference = formattedValue - grandTotal;

  return "${difference >= 0 ? '+' : ''}${difference.toStringAsFixed(2)}";
}

String removeCommasAndFormat(String valueWithCommas) {
  final cleaned = valueWithCommas.replaceAll(',', '');
  final parsed = double.tryParse(cleaned);
  return parsed != null ? parsed.toStringAsFixed(2) : '0.00';
}

String formatCurrency(double amount) {
  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 2);
  return formatter.format(amount);
}

String convertAmountWithDrCr(String input) {
  final sanitized = input.replaceAll(',', '');
  final value = double.tryParse(sanitized);

  if (value == null) return input; // fallback if input is not valid

  final formatted = input.replaceAll('-', '');
  return value < 0 ? '$formatted (Dr)' : '$formatted (Cr)';
}

String formatzero(double amount) {
  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 2);
  return formatter.format(amount);
}

String formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  return "$now";
}

String generateRandomString(int length) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join('');
}

String extractPanFromGst(String gstNumber) {
  if (gstNumber.isEmpty || gstNumber == '-' || gstNumber.length < 12) {
    return '-';
  } else {
    return gstNumber.substring(2, 12); // characters 3 to 12 (0-based index)
  }
}

Future<Uint8List> convertFileToUint8List(File file) async {
  return await file.readAsBytes();
}

bool isGST_Local(String gstNumber) {
  // Check if the GST number is valid and has at least 2 characters
  if (gstNumber.length < 2) return false;

  // Extract the first two digits (state code)
  String stateCode = gstNumber.substring(0, 2);

  // Return true if Tamil Nadu (33), else false
  return stateCode == '33';
}

Future<File> savePdfToTemp(Uint8List pdfData) async {
  final tempDir = await getTemporaryDirectory();
  final tempFile = File('${tempDir.path}/temp_pdf.pdf');
  await tempFile.writeAsBytes(pdfData, flush: true);
  return tempFile;
}

String formatNumber(int number) {
  if (number >= 10000000) {
    return "₹ ${(number / 10000000).toStringAsFixed(1)}Cr";
  } else if (number >= 100000) {
    return "₹ ${(number / 100000).toStringAsFixed(1)}L";
  } else if (number >= 1000) {
    return "₹ ${(number / 1000).toStringAsFixed(1)}K";
  } else {
    return "₹ $number";
  }
}

Future<void> select_previousDates(BuildContext context, TextEditingController controller) async {
  final DateTime now = DateTime.now();
  final DateTime pastLimit = DateTime(2000); // You can set your own earliest allowed date

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: pastLimit, // Allow dates from the past
    lastDate: now, // Prevent selecting future dates
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Primary_colors.Color3,
            onPrimary: Colors.white,
            onSurface: Colors.black87,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Primary_colors.Color3,
            ),
          ),
          dialogTheme: const DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    final formatted = "${pickedDate.year.toString().padLeft(4, '0')}-"
        "${pickedDate.month.toString().padLeft(2, '0')}-"
        "${pickedDate.day.toString().padLeft(2, '0')}";
    controller.text = formatted;
  }
}

Future<void> select_nextDates(BuildContext context, TextEditingController controller) async {
  final DateTime now = DateTime.now();
  final DateTime futureLimit = DateTime(2100); // You can customize how far into the future is allowed

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: now, // ⬅️ Start from today
    lastDate: futureLimit, // ⬅️ Allow selecting into the future
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Primary_colors.Color3,
            onPrimary: Colors.white,
            onSurface: Colors.black87,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Primary_colors.Color3,
            ),
          ),
          dialogTheme: const DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    final formatted = "${pickedDate.year.toString().padLeft(4, '0')}-"
        "${pickedDate.month.toString().padLeft(2, '0')}-"
        "${pickedDate.day.toString().padLeft(2, '0')}";
    controller.text = formatted;
  }
}
