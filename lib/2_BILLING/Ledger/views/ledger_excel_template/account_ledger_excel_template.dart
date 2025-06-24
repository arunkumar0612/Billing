import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/models/entities/account_ledger_entities.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

class ExcelAccountLedger {
  final PDF_AccountLedgerSummary data;
  final DateTime currentDate;

  ExcelAccountLedger({
    required this.data,
    required this.currentDate,
  });
}

Future<Uint8List> accountLedger_generateExcel(bool useLedgerTemplate, PDF_AccountLedgerSummary data) {
  return useLedgerTemplate ? Client_AccountLedger_excelTemplate(data) : Consolidated_AccountLedger_excelTemplate(data); // Define another template function
}

Future<Uint8List> Consolidated_AccountLedger_excelTemplate(PDF_AccountLedgerSummary accountLedgerData) async {
  final accountledger = ExcelAccountLedger(data: accountLedgerData, currentDate: DateTime.now());

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
  sheet1
      .getRangeByName('A2')
      .setText('CONSOLIDATED LEDGER SUMMARY (From ${_formatDate(DateTime.parse(accountledger.data.fromDate.toString()))} to ${_formatDate(DateTime.parse(accountledger.data.toDate.toString()))})');
  sheet1.getRangeByName('A2').cellStyle.bold = true;
  sheet1.getRangeByName('A2').cellStyle.fontSize = 12;
  sheet1.getRangeByName('A2').cellStyle.hAlign = xlsio.HAlignType.center;
  sheet1.getRangeByName('A2').cellStyle.italic = true;
  // sheet.getRangeByName('M6').cellStyle.backColor = '#D9E1F2'; // light blue

  sheet1.getRangeByName('A3:B3').merge();
  sheet1.getRangeByName('A3').setText('Date    :  ${_formatDate(DateTime.now())}');
  sheet1.getRangeByName('A3').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  final headers = ['Date', 'Invoice No', 'Description', 'Debit', 'Credit', 'Balance'];

  for (int i = 0; i < headers.length; i++) {
    final cell = sheet1.getRangeByIndex(4, i + 1);
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
      sheet1.setColumnWidthInPixels(i + 1, 400);
    } else {
      // Standard width for other columns
      sheet1.setColumnWidthInPixels(i + 1, 160);
    } // or use autoFitColumn
  }

  sheet1.setRowHeightInPixels(4, 40);

  int startRow = 5; // Assuming data starts from row 4
  int endRow = startRow + (accountledger.data.ledgerDetails.ledgerList.length) - 1;

  for (int i = 0; i < accountledger.data.ledgerDetails.ledgerList.length; i++) {
    final item = accountledger.data.ledgerDetails.ledgerList[i];
    int row = i + 5; // +2 because headers are on row 1

    sheet1.getRangeByIndex(row, 1).setText(_formatDate(item.updatedDate));
    sheet1.getRangeByIndex(row, 2).setText(item.invoiceNumber);
    sheet1.getRangeByIndex(row, 3).setText('${item.description}\nNet: ${_formatCurrency(item.billDetails.subtotal)}, GST: ${_formatCurrency(item.billDetails.totalGST)}, TDS: ${item.tdsAmount}');
    sheet1.getRangeByIndex(row, 4).setText(_formatCurrency(item.debitAmount));
    sheet1.getRangeByIndex(row, 5).setText(_formatCurrency(item.creditAmount));
    final parsedBalance = parseBalanceWithSuffix(item.balance.toString());
    final formattedBalance = _formatCurrency(parsedBalance.abs()) + (parsedBalance < 0 ? ' (Dr)' : ' (Cr)');
    sheet1.getRangeByIndex(row, 6).setText(formattedBalance);

    for (int col = 1; col <= 6; col++) {
      final cell = sheet1.getRangeByIndex(row, col);
      cell.cellStyle
        ..borders.all.lineStyle = xlsio.LineStyle.thin
        ..borders.all.color = '#000000'
        ..hAlign = xlsio.HAlignType.center
        ..vAlign = xlsio.VAlignType.center
        ..wrapText = true;

      if (col == 4 || col == 5 || col == 6) {
        cell.cellStyle.hAlign = xlsio.HAlignType.right; // Right align debit, credit, balance
      } else {
        cell.cellStyle.hAlign = xlsio.HAlignType.center; // Center align other columns
      }
    }
  }

  for (int i = 5; i < startRow + accountledger.data.ledgerDetails.ledgerList.length; i++) {
    sheet1.autoFitRow(i + 5);
  }

  int totalRow = endRow + 1;
  int closingRow = totalRow + 1;
  sheet1.setRowHeightInPixels(totalRow, 35);
  sheet1.setRowHeightInPixels(closingRow, 35);

  final totalDebit = accountledger.data.ledgerDetails.debitAmount;
  final totalCredit = accountledger.data.ledgerDetails.creditAmount;

  sheet1.getRangeByIndex(totalRow, 4).cellStyle.hAlign = xlsio.HAlignType.right;
  sheet1.getRangeByIndex(totalRow, 5).cellStyle.hAlign = xlsio.HAlignType.right;

  sheet1.getRangeByIndex(closingRow, 4).cellStyle.hAlign = xlsio.HAlignType.right;
  sheet1.getRangeByIndex(closingRow, 5).cellStyle.hAlign = xlsio.HAlignType.right;

  sheet1.getRangeByIndex(totalRow, 3).setText('Total');
  sheet1.getRangeByIndex(totalRow, 3).cellStyle.bold = true;
  sheet1.getRangeByIndex(totalRow, 4).setText(_formatCurrency(totalDebit));
  sheet1.getRangeByIndex(totalRow, 5).setText(_formatCurrency(totalCredit));

  sheet1.getRangeByIndex(closingRow, 3).setText('Closing Balance');
  sheet1.getRangeByIndex(closingRow, 3).cellStyle.bold = true;

  final closingBalance = accountledger.data.ledgerDetails.balanceAmount.abs();

  if (totalDebit > totalCredit) {
    final cell = sheet1.getRangeByIndex(closingRow, 4);
    cell.setText(_formatCurrency(closingBalance));
    cell.cellStyle.bold = true;
  } else {
    final cell = sheet1.getRangeByIndex(closingRow, 5);
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

// Apply thin border to totalRow and closingRow columns 3 to 5
  for (int col = 3; col <= 6; col++) {
    setThinBorder(sheet1.getRangeByIndex(totalRow, col));
    setThinBorder(sheet1.getRangeByIndex(closingRow, col));
  }

  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  return Uint8List.fromList(bytes);
}

Future<Uint8List> Client_AccountLedger_excelTemplate(PDF_AccountLedgerSummary accountLedgerData) async {
  final accountledger = ExcelAccountLedger(data: accountLedgerData, currentDate: DateTime.now());

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
  sheet1
      .getRangeByName('A2')
      .setText('LEDGER SUMMARY (From ${_formatDate(DateTime.parse(accountledger.data.fromDate.toString()))} to ${_formatDate(DateTime.parse(accountledger.data.toDate.toString()))})');
  sheet1.getRangeByName('A2').cellStyle.bold = true;
  sheet1.getRangeByName('A2').cellStyle.fontSize = 12;
  sheet1.getRangeByName('A2').cellStyle.hAlign = xlsio.HAlignType.center;
  sheet1.getRangeByName('A2').cellStyle.italic = true;
  // sheet.getRangeByName('M6').cellStyle.backColor = '#D9E1F2'; // light blue

// === 3. Add Client Name ===
  sheet1.getRangeByName('A3:B3').merge();
  sheet1.getRangeByName('A3').setText('Client Name            :');
  sheet1.getRangeByName('A3').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  sheet1.getRangeByName('C3:F3').merge();
  sheet1.getRangeByName('C3').setText(accountledger.data.clientDetails?.clientName);
  sheet1.getRangeByName('C3').cellStyle
    ..hAlign = xlsio.HAlignType.left
    ..wrapText = true;

// === 4. Add Client Address ===
  sheet1.getRangeByName('A4:B4').merge();
  sheet1.getRangeByName('A4').setText('Client Address        :');
  sheet1.getRangeByName('A4').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  sheet1.getRangeByName('C4:F4').merge();
  sheet1.getRangeByName('C4').setText(accountledger.data.clientDetails?.clientAddress);
  sheet1.getRangeByName('C4').cellStyle
    ..hAlign = xlsio.HAlignType.left
    ..wrapText = true;

// === 5. Add Client GSTIN ===
  sheet1.getRangeByName('A5:B5').merge();
  sheet1.getRangeByName('A5').setText('GSTIN                         :');
  sheet1.getRangeByName('A5').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  sheet1.getRangeByName('C5:F5').merge();
  sheet1.getRangeByName('C5').setText(accountledger.data.clientDetails?.GSTIN);
  sheet1.getRangeByName('C5').cellStyle
    ..hAlign = xlsio.HAlignType.left
    ..wrapText = true;

  sheet1.getRangeByName('A6:B6').merge();
  sheet1.getRangeByName('A6').setText('PAN                            :');
  sheet1.getRangeByName('A6').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  sheet1.getRangeByName('C6:F6').merge();
  sheet1.getRangeByName('C6').setText(accountledger.data.clientDetails?.PAN);
  sheet1.getRangeByName('C6').cellStyle
    ..hAlign = xlsio.HAlignType.left
    ..wrapText = true;

  sheet1.getRangeByName('A7:B7').merge();
  sheet1.getRangeByName('A7').setText('Date                           :');
  sheet1.getRangeByName('A7').cellStyle
    ..bold = true
    ..hAlign = xlsio.HAlignType.left;

  sheet1.getRangeByName('C7:F7').merge();
  sheet1.getRangeByName('C7').setText(_formatDate(DateTime.now()));
  sheet1.getRangeByName('C7').cellStyle
    ..hAlign = xlsio.HAlignType.left
    ..wrapText = true;

  final headers = ['Date', 'Invoice No', 'Description', 'Debit', 'Credit', 'Balance'];

  for (int i = 0; i < headers.length; i++) {
    final cell = sheet1.getRangeByIndex(8, i + 1);
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
      sheet1.setColumnWidthInPixels(i + 1, 400);
    } else {
      // Standard width for other columns
      sheet1.setColumnWidthInPixels(i + 1, 130);
    } // or use autoFitColumn
  }

  sheet1.setRowHeightInPixels(8, 40);

  int startRow = 9; // Assuming data starts from row 4
  int endRow = startRow + (accountledger.data.ledgerDetails.ledgerList.length) - 1;

  for (int i = 0; i < accountledger.data.ledgerDetails.ledgerList.length; i++) {
    final item = accountledger.data.ledgerDetails.ledgerList[i];
    int row = startRow + i; // +2 because headers are on row 1

    sheet1.getRangeByIndex(row, 1).setText(_formatDate(item.updatedDate));
    sheet1.getRangeByIndex(row, 2).setText(item.invoiceNumber);
    sheet1.getRangeByIndex(row, 3).setText('${item.description}\nNet: ${_formatCurrency(item.billDetails.subtotal)}, GST: ${_formatCurrency(item.billDetails.totalGST)}, TDS: ${item.tdsAmount}');
    sheet1.getRangeByIndex(row, 4).setText(_formatCurrency(item.debitAmount));
    sheet1.getRangeByIndex(row, 5).setText(_formatCurrency(item.creditAmount));
    final parsedBalance = parseBalanceWithSuffix(item.balance.toString());
    final formattedBalance = _formatCurrency(parsedBalance.abs()) + (parsedBalance < 0 ? ' (Dr)' : ' (Cr)');
    sheet1.getRangeByIndex(row, 6).setText(formattedBalance);

    for (int col = 1; col <= 6; col++) {
      final cell = sheet1.getRangeByIndex(row, col);
      cell.cellStyle
        ..borders.all.lineStyle = xlsio.LineStyle.thin
        ..borders.all.color = '#000000'
        ..hAlign = xlsio.HAlignType.center
        ..vAlign = xlsio.VAlignType.center
        ..wrapText = true;

      if (col == 4 || col == 5 || col == 6) {
        cell.cellStyle.hAlign = xlsio.HAlignType.right; // Right align debit, credit, balance
      } else {
        cell.cellStyle.hAlign = xlsio.HAlignType.center; // Center align other columns
      }
    }
  }

  for (int i = startRow; i <= endRow; i++) {
    sheet1.autoFitRow(i);
  }

  int totalRow = endRow + 1;
  int closingRow = totalRow + 1;
  sheet1.setRowHeightInPixels(totalRow, 35);
  sheet1.setRowHeightInPixels(closingRow, 35);

  final totalDebit = accountledger.data.ledgerDetails.debitAmount;
  final totalCredit = accountledger.data.ledgerDetails.creditAmount;

  sheet1.getRangeByIndex(totalRow, 4).cellStyle.hAlign = xlsio.HAlignType.right;
  sheet1.getRangeByIndex(totalRow, 5).cellStyle.hAlign = xlsio.HAlignType.right;

  sheet1.getRangeByIndex(closingRow, 4).cellStyle.hAlign = xlsio.HAlignType.right;
  sheet1.getRangeByIndex(closingRow, 5).cellStyle.hAlign = xlsio.HAlignType.right;

  sheet1.getRangeByIndex(totalRow, 3).setText('Total');
  sheet1.getRangeByIndex(totalRow, 3).cellStyle.bold = true;
  sheet1.getRangeByIndex(totalRow, 4).setText(_formatCurrency(totalDebit));
  sheet1.getRangeByIndex(totalRow, 5).setText(_formatCurrency(totalCredit));

  sheet1.getRangeByIndex(closingRow, 3).setText('Closing Balance');
  sheet1.getRangeByIndex(closingRow, 3).cellStyle.bold = true;

  final closingBalance = accountledger.data.ledgerDetails.balanceAmount.abs();

  if (totalDebit > totalCredit) {
    final cell = sheet1.getRangeByIndex(closingRow, 4);
    cell.setText(_formatCurrency(closingBalance));
    cell.cellStyle.bold = true;
  } else {
    final cell = sheet1.getRangeByIndex(closingRow, 5);
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

// Apply thin border to totalRow and closingRow columns 3 to 5
  for (int col = 3; col <= 6; col++) {
    setThinBorder(sheet1.getRangeByIndex(totalRow, col));
    setThinBorder(sheet1.getRangeByIndex(closingRow, col));
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
