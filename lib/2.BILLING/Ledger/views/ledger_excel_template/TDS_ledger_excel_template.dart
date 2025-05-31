import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/TDS_ledger_entities.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

Future<Uint8List> TDSledger_excelTemplate(TDSSummaryModel tds_Ledger_list) async {
  // final accountledger = ExcelTDSledger(data: tds_Ledger_list, currentDate: DateTime.now());

  final workbook = xlsio.Workbook();
  final sheet1 = workbook.worksheets[0];
  sheet1.name = 'LEDGER SUMMARY';

  // ==== 1. Add Company Header ====
  sheet1.getRangeByName('A1:F1').merge();
  sheet1.getRangeByName('A1').setText('SPORADA SECURE INDIA PRIVATE LIMITED');
  sheet1.getRangeByName('A1').cellStyle.bold = true;
  sheet1.getRangeByName('A1').cellStyle.fontSize = 13;
  sheet1.getRangeByName('A1').cellStyle.hAlign = xlsio.HAlignType.center;
  sheet1.getRangeByName('A1').cellStyle.vAlign = xlsio.VAlignType.center;
  sheet1.getRangeByName('A1').cellStyle.wrapText = true;

  // ==== 2. Add GST Summary Heading ====
  sheet1.getRangeByName('A2:F2').merge();
  sheet1.getRangeByName('A2').setText('TDS LEDGER SUMMARY (From ${_formatDate(DateTime.parse(tds_Ledger_list.startdate.toString()))} to ${_formatDate(DateTime.parse(tds_Ledger_list.enddate.toString()))})');
  sheet1.getRangeByName('A2').cellStyle.bold = true;
  sheet1.getRangeByName('A2').cellStyle.fontSize = 12;
  sheet1.getRangeByName('A2').cellStyle.hAlign = xlsio.HAlignType.center;
  sheet1.getRangeByName('A2').cellStyle.italic = true;
  // sheet.getRangeByName('M6').cellStyle.backColor = '#D9E1F2'; // light blue

// === 3. Add Client Name ===
  sheet1.getRangeByName('A3:B3').merge();
  sheet1.getRangeByName('A3').setText('Firm Name           :');
  sheet1.getRangeByName('A3').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  sheet1.getRangeByName('C3:F3').merge();
  sheet1.getRangeByName('C3').setText('SPORADA SECURE INDIA PRIVATE LIMITED');
  sheet1.getRangeByName('C3').cellStyle
    ..hAlign = xlsio.HAlignType.left
    ..wrapText = true;

// === 4. Add Client Address ===
  sheet1.getRangeByName('A4:B4').merge();
  sheet1.getRangeByName('A4').setText('TAN Number       :');
  sheet1.getRangeByName('A4').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  sheet1.getRangeByName('C4:F4').merge();
  sheet1.getRangeByName('C4').setText('ABECS0625B');
  sheet1.getRangeByName('C4').cellStyle
    ..hAlign = xlsio.HAlignType.left
    ..wrapText = true;

// === 5. Add Client GSTIN ===
  sheet1.getRangeByName('A5:B5').merge();
  sheet1.getRangeByName('A5').setText('PAN Number       :');
  sheet1.getRangeByName('A5').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  sheet1.getRangeByName('C5:F5').merge();
  sheet1.getRangeByName('C5').setText('ABECS0625B');
  sheet1.getRangeByName('C5').cellStyle
    ..hAlign = xlsio.HAlignType.left
    ..wrapText = true;

  sheet1.getRangeByName('A6:B6').merge();
  sheet1.getRangeByName('A6').setText('Date                        :');
  sheet1.getRangeByName('A6').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  sheet1.getRangeByName('C6:F6').merge();
  sheet1.getRangeByName('C6').setText(_formatDate(DateTime.now()));
  sheet1.getRangeByName('C6').cellStyle
    ..hAlign = xlsio.HAlignType.left
    ..wrapText = true;

  final headers = ['Date', 'Invoice No', 'PAN No', 'Particulars', 'Invoice\nAmount', 'Debit', 'Credit'];

  for (int i = 0; i < headers.length; i++) {
    final cell = sheet1.getRangeByIndex(7, i + 1);
    cell.setText(headers[i]);
    cell.cellStyle
      ..bold = true
      ..borders.all.lineStyle = xlsio.LineStyle.thin
      ..borders.all.color = '#000000'
      ..hAlign = xlsio.HAlignType.center
      ..vAlign = xlsio.VAlignType.center
      ..wrapText = true;

    if (i == 3) {
      // Set wider width for "Details" column
      sheet1.setColumnWidthInPixels(i + 1, 350);
    } else {
      // Standard width for other columns
      sheet1.setColumnWidthInPixels(i + 1, 160);
    } // or use autoFitColumn
  }

  sheet1.setRowHeightInPixels(7, 40);

  int startRow = 8; // Assuming data starts from row 4
  int endRow = startRow + (tds_Ledger_list.tdsList.length) - 1;

  for (int i = 0; i < tds_Ledger_list.tdsList.length; i++) {
    final item = tds_Ledger_list.tdsList[i];
    int row = startRow + i; // +2 because headers are on row 1

    sheet1.getRangeByIndex(row, 1).setText(_formatDate(item.rowUpdatedDate));
    sheet1.getRangeByIndex(row, 2).setText(item.invoice_number);
    sheet1.getRangeByIndex(row, 3).setText(extractPanFromGst(item.gstNumber));
    sheet1.getRangeByIndex(row, 4).setText(item.description);
    sheet1.getRangeByIndex(row, 5).setText(_formatCurrency(item.totalAmount));
    sheet1.getRangeByIndex(row, 6).setText(_formatCurrency(item.debitAmount));
    sheet1.getRangeByIndex(row, 7).setText(_formatCurrency(item.creditAmount));

    // final parsedBalance = parseBalanceWithSuffix(item.balance.toString());
    // final formattedBalance = _formatCurrency(parsedBalance.abs()) + (parsedBalance < 0 ? ' (Dr)' : ' (Cr)');
    // sheet1.getRangeByIndex(row, 6).setText(formattedBalance);

    for (int col = 1; col <= 7; col++) {
      final cell = sheet1.getRangeByIndex(row, col);
      cell.cellStyle
        ..borders.all.lineStyle = xlsio.LineStyle.thin
        ..borders.all.color = '#000000'
        ..hAlign = xlsio.HAlignType.center
        ..vAlign = xlsio.VAlignType.center
        ..wrapText = true;

      if (col == 5 || col == 6 || col == 7) {
        cell.cellStyle.hAlign = xlsio.HAlignType.right; // Right align debit, credit, balance
      } else {
        cell.cellStyle.hAlign = xlsio.HAlignType.center; // Center align other columns
      }
    }
  }

  for (int i = startRow; i <= endRow; i++) {
    sheet1.autoFitRow(i);
  }

  int totalTDS = endRow + 1;
  int TDSnetBalanceRow = totalTDS + 1;
  sheet1.setRowHeightInPixels(totalTDS, 35);
  sheet1.setRowHeightInPixels(TDSnetBalanceRow, 35);

  final totalPayables = tds_Ledger_list.totalPayables;
  final totalReceivables = tds_Ledger_list.totalReceivables;

  sheet1.getRangeByIndex(totalTDS, 6).cellStyle.hAlign = xlsio.HAlignType.right;
  sheet1.getRangeByIndex(totalTDS, 7).cellStyle.hAlign = xlsio.HAlignType.right;

  sheet1.getRangeByIndex(TDSnetBalanceRow, 6).cellStyle.hAlign = xlsio.HAlignType.right;
  sheet1.getRangeByIndex(TDSnetBalanceRow, 7).cellStyle.hAlign = xlsio.HAlignType.right;

  sheet1.getRangeByIndex(totalTDS, 5).setText('Total TDS');
  sheet1.getRangeByIndex(totalTDS, 5).cellStyle.bold = true;
  sheet1.getRangeByIndex(totalTDS, 6).setText(_formatCurrency(totalPayables));
  sheet1.getRangeByIndex(totalTDS, 7).setText(_formatCurrency(totalReceivables));

  sheet1.getRangeByIndex(TDSnetBalanceRow, 5).setText('TDS Claimable/payable');
  sheet1.getRangeByIndex(TDSnetBalanceRow, 5).cellStyle.bold = true;

  final closingBalance = tds_Ledger_list.totalTds;

  if (totalPayables > totalReceivables) {
    final cell = sheet1.getRangeByIndex(TDSnetBalanceRow, 6);
    cell.setText(_formatCurrency(closingBalance));
    cell.cellStyle.bold = true;
  } else {
    final cell = sheet1.getRangeByIndex(TDSnetBalanceRow, 7);
    cell.setText(_formatCurrency(closingBalance));
    cell.cellStyle.bold = true;
  }

  void setThinBorder(xlsio.Range cell) {
    final borders = cell.cellStyle.borders;
    borders.left.lineStyle = xlsio.LineStyle.thin;
    borders.right.lineStyle = xlsio.LineStyle.thin;
    borders.top.lineStyle = xlsio.LineStyle.thin;
    borders.bottom.lineStyle = xlsio.LineStyle.thin;
  }

// Apply thin border to totalTDS and TDSnetBalanceRow columns 3 to 5
  for (int col = 5; col <= 7; col++) {
    setThinBorder(sheet1.getRangeByIndex(totalTDS, col));
    setThinBorder(sheet1.getRangeByIndex(TDSnetBalanceRow, col));
  }

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

double parseBalanceWithSuffix(String balance) {
  // Simply parse the numeric value (remove any existing formatting)
  return double.tryParse(balance.replaceAll(',', '').trim()) ?? 0.0;
}
