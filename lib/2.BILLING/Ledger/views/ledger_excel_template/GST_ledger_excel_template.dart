import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/GST_ledger_entities.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

class ExcelGSTledger {
  final GSTSummaryModel data;
  final DateTime currentDate;

  ExcelGSTledger({
    required this.data,
    required this.currentDate,
  });
}

Future<Uint8List> GSTledger_excelTemplate(GSTSummaryModel gstLedgerData) async {
  // final gstLedger = ExcelGSTledger(data: gstLedgerData, currentDate: DateTime.now());

  final workbook = xlsio.Workbook();
  final sheet1 = workbook.worksheets[0];
  sheet1.name = 'GST SUMMARY';

  // ==== 1. Add Company Header ====
  sheet1.getRangeByName('A1:D1').merge();
  sheet1.getRangeByName('A1').setText('SPORADA SECURE INDIA PRIVATE LIMITED');
  sheet1.getRangeByName('A1').cellStyle.bold = true;
  sheet1.getRangeByName('A1').cellStyle.fontSize = 13;
  sheet1.getRangeByName('A1').cellStyle.hAlign = xlsio.HAlignType.center;
  sheet1.getRangeByName('A1').cellStyle.vAlign = xlsio.VAlignType.center;
  sheet1.getRangeByName('A1').cellStyle.wrapText = true;

  // ==== 2. Add GST Summary Heading ====
  sheet1.getRangeByName('A2:D2').merge();
  sheet1.getRangeByName('A2').setText('GST SUMMARY (From ${_formatDate(DateTime.parse(gstLedgerData.startdate.toString()))} to ${_formatDate(DateTime.parse(gstLedgerData.enddate.toString()))})');
  sheet1.getRangeByName('A2').cellStyle.bold = true;
  sheet1.getRangeByName('A2').cellStyle.fontSize = 12;
  sheet1.getRangeByName('A2').cellStyle.hAlign = xlsio.HAlignType.center;
  sheet1.getRangeByName('A2').cellStyle.italic = true;
  // sheet.getRangeByName('M6').cellStyle.backColor = '#D9E1F2'; // light blue

  // ==== 3. Add Sample Data Below Heading ====

  sheet1.getRangeByName('A3:B3').merge();
  sheet1.getRangeByName('A3').setText('Date    :  ${_formatDate(DateTime.now())}');
  sheet1.getRangeByName('A3').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  sheet1.getRangeByName('A4').columnWidth = 25; // Category (merged with L)
  sheet1.getRangeByName('B4').columnWidth = 20; // CGST
  sheet1.getRangeByName('C4').columnWidth = 20; // SGST
  sheet1.getRangeByName('D4').columnWidth = 20; // IGST
  sheet1.getRangeByName('E4').columnWidth = 20; // TOTAL GST

  sheet1.getRangeByName('A4').setText('Category');
  sheet1.getRangeByName('B4').setText('CGST (Rs.)');
  sheet1.getRangeByName('C4').setText('SGST (Rs.)');
  sheet1.getRangeByName('D4').setText('IGST (Rs.)');
  sheet1.getRangeByName('E4').setText('TOTAL GST (Rs.)');

  sheet1.getRangeByName('A5').setText('Output GST');
  sheet1.getRangeByName('B5').setText(_formatCurrency(gstLedgerData.outputCgst ?? 0));
  sheet1.getRangeByName('C5').setText(_formatCurrency(gstLedgerData.outputCgst ?? 0));
  sheet1.getRangeByName('D5').setText(_formatCurrency(gstLedgerData.outputIgst ?? 0));
  sheet1.getRangeByName('E5').setText(_formatCurrency(gstLedgerData.outputGst));

  sheet1.getRangeByName('A6').setText('Input GST');
  sheet1.getRangeByName('B6').setText(_formatCurrency(gstLedgerData.inputCgst ?? 0));
  sheet1.getRangeByName('C6').setText(_formatCurrency(gstLedgerData.inputSgst ?? 0));
  sheet1.getRangeByName('D6').setValue(_formatCurrency(gstLedgerData.inputIgst ?? 0));
  sheet1.getRangeByName('E6').setText(_formatCurrency(gstLedgerData.inputGst));

  sheet1.getRangeByName('A7').setText('GST Payable/refundable');
  sheet1.getRangeByName('B7').setText(_formatCurrency(gstLedgerData.inputGst));
  sheet1.getRangeByName('C7').setText(_formatCurrency(gstLedgerData.inputGst));
  sheet1.getRangeByName('D7').setText(_formatCurrency(gstLedgerData.inputGst));
  sheet1.getRangeByName('E7').setText(_formatCurrency(gstLedgerData.inputGst));

  final sheet1_headerRange = sheet1.getRangeByName('A4:E4');
  sheet1_headerRange.cellStyle
    ..borders.all.lineStyle = xlsio.LineStyle.thin
    ..borders.all.color = '#000000'
    ..hAlign = xlsio.HAlignType.center
    ..vAlign = xlsio.VAlignType.center
    ..bold = true
    ..wrapText = true;

  final sheet1_rowStyle = sheet1.getRangeByName('A5:E6');
  sheet1_rowStyle.cellStyle
    ..borders.all.lineStyle = xlsio.LineStyle.thin
    ..borders.all.color = '#000000'
    ..hAlign = xlsio.HAlignType.center
    ..vAlign = xlsio.VAlignType.center
    ..wrapText = true;

  final finalRowStyle = sheet1.getRangeByName('A7:E7');
  finalRowStyle.cellStyle
    ..borders.all.lineStyle = xlsio.LineStyle.thin
    ..borders.all.color = '#000000'
    ..hAlign = xlsio.HAlignType.center
    ..vAlign = xlsio.VAlignType.center
    ..bold = true
    ..wrapText = true;

  for (int sheet_1Row = 4; sheet_1Row <= 7; sheet_1Row++) {
    sheet1.getRangeByIndex(sheet_1Row, 12).rowHeight = 30; // Column 12 is 'L', any column will work here
  }

  final sheet2 = workbook.worksheets.addWithName('GST TRANSACTION LOG');

  sheet2.getRangeByName('A1:J1').merge();
  sheet2.getRangeByName('A1').setText('SPORADA SECURE INDIA PRIVATE LIMITED');
  sheet2.getRangeByName('A1').cellStyle.bold = true;
  sheet2.getRangeByName('A1').cellStyle.fontSize = 13;
  sheet2.getRangeByName('A1').cellStyle.hAlign = xlsio.HAlignType.center;
  sheet2.getRangeByName('A1').cellStyle.vAlign = xlsio.VAlignType.center;
  sheet2.getRangeByName('A1').cellStyle.wrapText = true;

  sheet2.getRangeByName('A2:J2').merge();
  sheet2.getRangeByName('A2').setText('GST TRANSACTION LOG  (From ${_formatDate(DateTime.parse(gstLedgerData.startdate.toString()))} to ${_formatDate(DateTime.parse(gstLedgerData.enddate.toString()))})');
  sheet2.getRangeByName('A2').cellStyle.bold = true;
  sheet2.getRangeByName('A2').cellStyle.fontSize = 12;
  sheet2.getRangeByName('A2').cellStyle.hAlign = xlsio.HAlignType.center;
  sheet2.getRangeByName('A2').cellStyle.italic = true;

  sheet2.getRangeByName('A3:J3').merge();
  sheet2.getRangeByName('A3').setText('Date    : ${_formatDate(DateTime.now())}');
  sheet2.getRangeByName('A3').cellStyle..bold = true;
  // ..hAlign = xlsio.HAlignType.left;

  final headers = ['Date', 'Invoice No', 'Client Name', 'GST No', 'GST Type', 'Taxable Value', 'CGST (Rs.)', 'SGST (Rs.)', 'IGST (Rs.)', 'Total GST (Rs.)', 'Gross Amount (Rs.)'];

  for (int i = 0; i < headers.length; i++) {
    final cell = sheet2.getRangeByIndex(4, i + 1);
    cell.setText(headers[i]);
    cell.cellStyle
      ..bold = true
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000'
      ..hAlign = xlsio.HAlignType.center
      ..vAlign = xlsio.VAlignType.center
      ..wrapText = true;

    if (i == 2) {
      // Set wider width for "Details" column
      sheet2.setColumnWidthInPixels(i + 1, 350);
    } else {
      // Standard width for other columns
      sheet2.setColumnWidthInPixels(i + 1, 160);
    } // or use autoFitColumn
  }

  sheet2.setRowHeightInPixels(4, 40);

  int startRow = 5; // Assuming data starts from row 4
  // int endRow = startRow + (gstLedgerData.gstList.length) - 1;

  for (int i = 0; i < gstLedgerData.gstList.length; i++) {
    final row = startRow + i;
    final item = gstLedgerData.gstList[i];

    sheet2.getRangeByIndex(row, 1).setText(_formatDate(item.date));
    sheet2.getRangeByIndex(row, 2).setText(item.invoice_number);
    sheet2.getRangeByIndex(row, 3).setText(item.clientName);
    sheet2.getRangeByIndex(row, 4).setText(item.gstNumber);
    sheet2.getRangeByIndex(row, 5).setText(item.gstType);
    sheet2.getRangeByIndex(row, 6).setText(_formatCurrency(item.subTotal));
    sheet2.getRangeByIndex(row, 7).setText(_formatCurrency(item.cgst));
    sheet2.getRangeByIndex(row, 8).setText(_formatCurrency(item.sgst));
    sheet2.getRangeByIndex(row, 9).setText(_formatCurrency(item.igst));
    sheet2.getRangeByIndex(row, 10).setText(_formatCurrency(item.totalGst));
    sheet2.getRangeByIndex(row, 11).setText(_formatCurrency(item.totalAmount));

    // Add borders and alignment to each row cell
    for (int col = 1; col <= 11; col++) {
      final cell = sheet2.getRangeByIndex(row, col);
      cell.cellStyle
        ..borders.all.lineStyle = xlsio.LineStyle.thin
        ..borders.all.color = '#000000'
        ..hAlign = xlsio.HAlignType.center
        ..vAlign = xlsio.VAlignType.center
        ..wrapText = true;

      if (col == 6 || col == 7 || col == 8 || col == 9 || col == 10 || col == 11) {
        cell.cellStyle.hAlign = xlsio.HAlignType.left; // Right align debit, credit, balance
      } else {
        cell.cellStyle.hAlign = xlsio.HAlignType.center; // Center align other columns
      }
    }
  }

  for (int i = startRow; i < startRow + gstLedgerData.gstList.length; i++) {
    sheet2.autoFitRow(i);
  }

  // ==== 4. Save Excel File ====
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  return Uint8List.fromList(bytes);
}

String _formatCurrency(double amount) {
  final formatter = NumberFormat('#,##,##0.00'); // Indian number format
  return formatter.format(amount);
}

String _formatDate(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}
