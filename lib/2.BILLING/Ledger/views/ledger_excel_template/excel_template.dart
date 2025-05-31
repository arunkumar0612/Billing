// import 'dart:io';
// import 'dart:typed_data';
// import 'package:http/http.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/GST_ledger_entities.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

// class ExcelGSTledger {
//   final GSTSummaryModel data;
//   final DateTime currentDate;

//   ExcelGSTledger({
//     required this.data,
//     required this.currentDate,
//   });
// }

// Future<Uint8List> GST_generateExcel(GSTSummaryModel gstLedgerData) async {
//   final gstLedger = ExcelGSTledger(data: gstLedgerData, currentDate: DateTime.now());

//   final workbook = xlsio.Workbook();
//   final sheet1 = workbook.worksheets[0];
//   sheet1.name = 'GST SUMMARY';

//   // ==== 1. Add Company Header ====
//   sheet1.getRangeByName('A1:D1').merge();
//   sheet1.getRangeByName('A1').setText('SPORADA SECURE INDIA PRIVATE LIMITED');
//   sheet1.getRangeByName('A1').cellStyle.bold = true;
//   sheet1.getRangeByName('A1').cellStyle.fontSize = 13;
//   sheet1.getRangeByName('A1').cellStyle.hAlign = xlsio.HAlignType.center;
//   sheet1.getRangeByName('A1').cellStyle.vAlign = xlsio.VAlignType.center;
//   sheet1.getRangeByName('A1').cellStyle.wrapText = true;

//   // ==== 2. Add GST Summary Heading ====
//   sheet1.getRangeByName('B2:C2').merge();
//   sheet1.getRangeByName('B2').setText('GST SUMMARY');
//   sheet1.getRangeByName('B2').cellStyle.bold = true;
//   sheet1.getRangeByName('B2').cellStyle.fontSize = 12;
//   sheet1.getRangeByName('B2').cellStyle.hAlign = xlsio.HAlignType.center;
//   // sheet.getRangeByName('M6').cellStyle.backColor = '#D9E1F2'; // light blue

//   // ==== 3. Add Sample Data Below Heading ====
//   sheet1.getRangeByName('A3').columnWidth = 25; // Category (merged with L)
//   sheet1.getRangeByName('B3').columnWidth = 20; // CGST
//   sheet1.getRangeByName('C3').columnWidth = 20; // SGST
//   sheet1.getRangeByName('D3').columnWidth = 20; // IGST
//   sheet1.getRangeByName('E3').columnWidth = 20; // TOTAL GST

//   sheet1.getRangeByName('A3').setText('Category');
//   sheet1.getRangeByName('B3').setText('CGST (Rs.)');
//   sheet1.getRangeByName('C3').setText('SGST (Rs.)');
//   sheet1.getRangeByName('D3').setText('IGST (Rs.)');
//   sheet1.getRangeByName('E3').setText('TOTAL GST (Rs.)');

//   sheet1.getRangeByName('A4').setText('Output GST');
//   sheet1.getRangeByName('B4').setNumber(gstLedgerData.outputCgst);
//   sheet1.getRangeByName('C4').setNumber(gstLedgerData.outputSgst);
//   sheet1.getRangeByName('D4').setNumber(gstLedgerData.outputIgst);
//   sheet1.getRangeByName('E4').setNumber(gstLedgerData.outputGst);

//   sheet1.getRangeByName('A5').setText('Input GST');
//   sheet1.getRangeByName('B5').setNumber(gstLedgerData.inputCgst);
//   sheet1.getRangeByName('C5').setNumber(gstLedgerData.inputSgst);
//   sheet1.getRangeByName('D5').setNumber(gstLedgerData.inputIgst);
//   sheet1.getRangeByName('E5').setNumber(gstLedgerData.inputGst);

//   sheet1.getRangeByName('A6').setText('GST Payable/refundable');
//   sheet1.getRangeByName('B6').setNumber(gstLedgerData.totalCgst);
//   sheet1.getRangeByName('C6').setNumber(gstLedgerData.totalSgst);
//   sheet1.getRangeByName('D6').setNumber(gstLedgerData.totalIgst);
//   sheet1.getRangeByName('E6').setNumber(gstLedgerData.totalGst);

//   final sheet1_headerRange = sheet1.getRangeByName('A3:E3');
//   sheet1_headerRange.cellStyle
//     ..borders.all.lineStyle = xlsio.LineStyle.thin
//     ..borders.all.color = '#000000'
//     ..hAlign = xlsio.HAlignType.center
//     ..vAlign = xlsio.VAlignType.center
//     ..bold = true
//     ..wrapText = true;

//   final sheet1_rowStyle = sheet1.getRangeByName('A4:E5');
//   sheet1_rowStyle.cellStyle
//     ..borders.all.lineStyle = xlsio.LineStyle.thin
//     ..borders.all.color = '#000000'
//     ..hAlign = xlsio.HAlignType.center
//     ..vAlign = xlsio.VAlignType.center
//     ..wrapText = true;

//   final finalRowStyle = sheet1.getRangeByName('A6:E6');
//   finalRowStyle.cellStyle
//     ..borders.all.lineStyle = xlsio.LineStyle.thin
//     ..borders.all.color = '#000000'
//     ..hAlign = xlsio.HAlignType.center
//     ..vAlign = xlsio.VAlignType.center
//     ..bold = true
//     ..wrapText = true;

//   for (int sheet_1Row = 3; sheet_1Row <= 6; sheet_1Row++) {
//     sheet1.getRangeByIndex(sheet_1Row, 12).rowHeight = 25; // Column 12 is 'L', any column will work here
//   }

//   // ========== Sheet 2: PAYMENT RECEIPT ==========
//   final sheet2 = workbook.worksheets.addWithName('GST TRANSACTION LOG');

//   sheet2.getRangeByName('A1:D1').merge();
//   sheet2.getRangeByName('A1').setText('SPORADA SECURE INDIA PRIVATE LIMITED');
//   sheet2.getRangeByName('A1').cellStyle.bold = true;
//   sheet2.getRangeByName('A1').cellStyle.fontSize = 13;
//   sheet2.getRangeByName('A1').cellStyle.hAlign = xlsio.HAlignType.center;
//   sheet2.getRangeByName('A1').cellStyle.vAlign = xlsio.VAlignType.center;
//   sheet2.getRangeByName('A1').cellStyle.wrapText = true;

//   sheet2.getRangeByName('B2:C2').merge();
//   sheet2.getRangeByName('B2').setText('GST TRANSACTION LOG');
//   sheet2.getRangeByName('B2').cellStyle.bold = true;
//   sheet2.getRangeByName('B2').cellStyle.fontSize = 12;
//   sheet2.getRangeByName('B2').cellStyle.hAlign = xlsio.HAlignType.center;

//   // sheet2.getRangeByName('A3').columnWidth = 15; //date
//   // sheet2.getRangeByName('B3').columnWidth = 35; //invoice no
//   // sheet2.getRangeByName('C3').columnWidth = 45; // details
//   // sheet2.getRangeByName('D3').columnWidth = 15; //gst type
//   // sheet2.getRangeByName('E3').columnWidth = 25; //taxable value
//   // sheet2.getRangeByName('F3').columnWidth = 25; //CGST
//   // sheet2.getRangeByName('G3').columnWidth = 25; //SGST
//   // sheet2.getRangeByName('H3').columnWidth = 25; //IGST
//   // sheet2.getRangeByName('I3').columnWidth = 25; //total GST
//   // sheet2.getRangeByName('J3').columnWidth = 25; // gross amount

//   // sheet2.getRangeByName('A3').setText('Date'); //date
//   // sheet2.getRangeByName('B3').setText('Invoice No'); //invoice no
//   // sheet2.getRangeByName('C3').setText('Details'); // details
//   // sheet2.getRangeByName('D3').setText('GST Type'); //gst type
//   // sheet2.getRangeByName('E3').setText('Taxable Value'); //taxable value
//   // sheet2.getRangeByName('F3').setText('CGST (Rs.)'); //CGST
//   // sheet2.getRangeByName('G3').setText('SGST (Rs.)'); //SGST
//   // sheet2.getRangeByName('H3').setText('IGST (Rs.)'); //IGST
//   // sheet2.getRangeByName('I3').setText('Total GST (Rs.)'); //total GST
//   // sheet2.getRangeByName('J3').setText('Gross Amount (Rs.)'); // gross amount

//   final headers = ['Date', 'Invoice No', 'Details', 'GST Type', 'Taxable Value', 'CGST (Rs.)', 'SGST (Rs.)', 'IGST (Rs.)', 'Total GST (Rs.)', 'Gross Amount (Rs.)'];

//   for (int i = 0; i < headers.length; i++) {
//     sheet2.getRangeByIndex(1, i + 1).setText(headers[i]);

//     sheet2.setColumnWidthInPixels(i + 1, 30);
//   }

//   sheet2.setRowHeightInPixels(1, 25);

//   for (int i = 0; i < gstLedgerData.gstList.length; i++) {
//     final item = gstLedgerData.gstList[i];
//     int row = i + 2; // +2 because headers are on row 1

//     sheet2.getRangeByIndex(row, 1).setText(item.date.toString());
//     sheet2.getRangeByIndex(row, 2).setText(item.invoice_number);
//     sheet2.getRangeByIndex(row, 3).setText(item.description);
//     sheet2.getRangeByIndex(row, 4).setText(item.gstType);
//     sheet2.getRangeByIndex(row, 5).setNumber(item.subTotal);
//     sheet2.getRangeByIndex(row, 6).setNumber(item.cgst);
//     sheet2.getRangeByIndex(row, 7).setNumber(item.sgst);
//     sheet2.getRangeByIndex(row, 7).setNumber(item.igst);
//     sheet2.getRangeByIndex(row, 7).setNumber(item.totalGst);
//     sheet2.getRangeByIndex(row, 7).setNumber(item.totalAmount);
//   }

//   final sheet2_headerRange = sheet2.getRangeByName('A3:J3');
//   sheet2_headerRange.cellStyle
//     ..borders.all.lineStyle = xlsio.LineStyle.thin
//     ..borders.all.color = '#000000'
//     ..hAlign = xlsio.HAlignType.center
//     ..vAlign = xlsio.VAlignType.center
//     ..bold = true
//     ..wrapText = true;

//   int startRow = 4; // Assuming data starts from row 4
//   int endRow = startRow + (gstLedgerData.gstList.length) - 1;

//   final sheet2_rowStyle = sheet2.getRangeByName('A$startRow:J$endRow');
//   sheet2_rowStyle.cellStyle
//     ..borders.all.lineStyle = xlsio.LineStyle.thin
//     ..borders.all.color = '#000000'
//     ..hAlign = xlsio.HAlignType.center
//     ..vAlign = xlsio.VAlignType.center
//     ..wrapText = true;

//   for (int sheet_2Row = startRow; sheet_2Row <= endRow; sheet_2Row++) {
//     sheet2.autoFitRow(sheet_2Row);
//   }

//   // for (int col = 1; col <= 10; col++) {
//   //   sheet2.getRangeByIndex(3, col).rowHeight = 35;
//   // }

//   sheet2.autoFitColumn(1);
//   sheet2.autoFitColumn(2);

//   // ==== 4. Save Excel File ====
//   final List<int> bytes = workbook.saveAsStream();
//   workbook.dispose();

//   return Uint8List.fromList(bytes);

// //   // Get the device's download or document directory
// //   final directory = await getApplicationDocumentsDirectory(); // use getDownloadsDirectory() on Windows/Linux
// //   final String filePath = '${directory.path}/GST_Summary_${DateTime.now().millisecondsSinceEpoch}.xlsx';

// //   // Write the file
// //   final File file = File(filePath);
// //   await file.writeAsBytes(bytes, flush: true);

// //   print('Excel file saved: $filePath');
// }
