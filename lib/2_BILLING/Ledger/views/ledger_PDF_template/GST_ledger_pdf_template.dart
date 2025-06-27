/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/models/entities/GST_ledger_entities.dart';

Future<Uint8List> generateGSTledger(PdfPageFormat pageFormat, GSTSummaryModel gstLedgerData) async {
  final gstLedger = GSTLedger(data: gstLedgerData, currentDate: DateTime.now());

  return await gstLedger.buildPdf(pageFormat);
}

class GSTLedger {
  final GSTSummaryModel data;
  final DateTime currentDate;

  GSTLedger({
    required this.data,
    required this.currentDate,
  });

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;
  static const detailsColor = PdfColors.grey900;
  static const contentHeading = PdfColors.grey;
  static const accentColor = PdfColors.blueGrey900;
  static const baseColor = PdfColors.green500;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  final helveticaFont = Font.helvetica();
  // final robotoFont=pw.Font.ttf( await  rootBundle.load('assets/fonts/Roboto.ttf'));

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final fontRegular = pw.Font.ttf(await rootBundle.load('assets/fonts/roboto.ttf'));
    final fontBold = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Bold.ttf'));

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(
        base: fontRegular,
        bold: fontBold,
      ),
    );

    // Add page to the PDF
    // First page
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(pageFormat),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          pw.SizedBox(height: 10),
          _contentHeader(context),
          pw.SizedBox(height: 20),
          summaryTitleContent(context),
          pw.SizedBox(height: 20),
          _summaryTable(context),
          totalRow(),
        ],
      ),
    );

// Second page — for GST Log section
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(pageFormat),
        footer: _buildFooter,
        build: (context) => [
          pw.SizedBox(height: 10),
          logTitleContent(context),
          pw.SizedBox(height: 20),
          ..._GSTtransactionLog(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    if (context.pageNumber > 1) {
      return pw.SizedBox(); // Empty header for pages > 1
    }

    return pw.Container(
      child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                // cr
                children: [
                  pw.Text(
                    'GST STATEMENT',
                    style: pw.TextStyle(
                      fontSize: 13,
                      color: detailsColor,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline,
                      decorationColor: detailsColor,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'SPORADA SECURE INDIA PRIVATE LIMITED',
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: detailsColor,
                      fontWeight: pw.FontWeight.bold,
                      fontStyle: pw.FontStyle.italic,
                    ),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Text(
                    '687/7, 3rd Floor, Sakthivel tower, Trichy road, Ramanathapuram, Coimbatore -641045',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: detailsColor,
                    ),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Text(
                    'Telephone: +91-422-2312363, E-mail: support@ sporadasecure.com,Website: www.sporadasecure.com',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: detailsColor,
                    ),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Text(
                    'CIN: U30007TZ2020PTC03414  |  GSTIN: 33ABECS0625B1Z0',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: detailsColor,
                    ),
                  ),
                ]),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Divider(
          thickness: 1,
          color: PdfColors.grey600,
        ),
      ]),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    final isNotLastPage = context.pageNumber != context.pagesCount;

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        // Left-aligned page number
        pw.Text(
          '${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 9,
            color: PdfColors.grey900,
          ),
        ),

        // Right-aligned "Continued..." only if not last page
        if (isNotLastPage)
          pw.Text(
            'Continued...',
            style: const pw.TextStyle(
              fontSize: 9,
              color: PdfColors.grey900,
            ),
          )
        else
          pw.SizedBox(),
      ],
    );
  }

  pw.PageTheme _buildTheme(PdfPageFormat pageFormat) {
    return pw.PageTheme(
      margin: const pw.EdgeInsets.only(top: 25, bottom: 20, right: 15, left: 15),
      pageFormat: pageFormat,
      // theme: pw.ThemeData.withFont(
      //   base: base,
      //   bold: bold,
      //   italic: italic,
      // ),
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    pw.Widget buildInfoRow(String label, String value) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 5),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          // mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: [
            pw.Container(
              width: 100, // fixed width for alignment
              child: pw.Text(
                label,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.normal,
                  color: detailsColor,
                ),
              ),
            ),
            pw.Container(
              width: 10, // fixed width for colon
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                ':',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.normal,
                  color: PdfColors.black,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                value,
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: detailsColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 7,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Date', _formatDate(DateTime.now())),
                  buildInfoRow('GSTIN', '33ABECS0625B1Z0'),
                  buildInfoRow('PAN Number', 'ABECS0625B'),
                ],
              ),
            ),
            pw.SizedBox(width: 140),
            pw.Expanded(
              flex: 7,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Registration Type', 'Regular'),
                  buildInfoRow('From Date', _formatDate(DateTime.parse(data.startdate ?? ''))),
                  buildInfoRow('To Date', _formatDate(DateTime.parse(data.enddate ?? ''))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget summaryTitleContent(pw.Context context) {
    return pw.Center(
      child: pw.Text(
        'GST SUMMARY',
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
          color: detailsColor,
        ),
      ),
    );
  }

  pw.Widget _summaryTable(pw.Context context) {
    const tableHeaders = ['Category', 'CGST', 'SGST', 'IGST', 'Total GST'];

    final dataRows = List<pw.TableRow>.generate(
      2,
      (index) {
        final item = data;
        return pw.TableRow(
          children: [
            _buildCell(index == 0 ? 'Output GST' : 'Input GST'),
            _buildCell(
              _formatCurrency(index == 0 ? (item.outputCgst ?? 0) : (item.inputCgst ?? 0)),
              alignRight: true,
            ),
            _buildCell(
              _formatCurrency(index == 0 ? (item.outputSgst ?? 0) : (item.inputSgst ?? 0)),
              alignRight: true,
            ),
            _buildCell(
              _formatCurrency(index == 0 ? (item.outputIgst ?? 0) : (item.inputIgst ?? 0)),
              alignRight: true,
            ),
            _buildCell(
              _formatCurrency(index == 0 ? (item.outputGst) : (item.inputGst)),
              alignRight: true,
            ),
          ],
        );
      },
    );

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Header table (no horizontalInside border)
        pw.Table(
          border: const pw.TableBorder(
            // bottom: pw.BorderSide(color: accentColor, width: 0.5),
            left: pw.BorderSide.none,
            right: pw.BorderSide.none,
            horizontalInside: pw.BorderSide.none,
            verticalInside: pw.BorderSide.none,
          ),
          columnWidths: {
            0: const pw.FlexColumnWidth(10),
            1: const pw.FlexColumnWidth(5),
            2: const pw.FlexColumnWidth(5),
            3: const pw.FlexColumnWidth(5),
            4: const pw.FlexColumnWidth(5),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                color: PdfColors.green500,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
              ),
              children: List.generate(tableHeaders.length, (index) {
                return _buildHeaderCell(
                  tableHeaders[index],
                  alignment: index == 0 ? pw.Alignment.centerLeft : pw.Alignment.centerRight,
                );
              }),
            ),
          ],
        ),

        // Data table (with horizontalInside border)
        pw.Table(
          border: const pw.TableBorder(
            bottom: pw.BorderSide(color: accentColor, width: 0.5),
            left: pw.BorderSide.none,
            right: pw.BorderSide.none,
            horizontalInside: pw.BorderSide(color: accentColor, width: 0.5),
            verticalInside: pw.BorderSide.none,
          ),
          columnWidths: {
            0: const pw.FlexColumnWidth(10),
            1: const pw.FlexColumnWidth(5),
            2: const pw.FlexColumnWidth(5),
            3: const pw.FlexColumnWidth(5),
            4: const pw.FlexColumnWidth(5),
          },
          children: dataRows,
        ),
      ],
    );
  }

  pw.Widget totalRow() {
    final totalCGST = data.totalCgst;
    final totalSGST = data.totalSgst;
    final totalIGST = data.totalIgst;
    final totalGSTValue = data.totalGst;
    return pw.Row(
      children: [
        // pw.Expanded( child: pw.Container()), // Spacer
        pw.Expanded(
          flex: 30,
          child: pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(10),
              1: const pw.FlexColumnWidth(5),
              2: const pw.FlexColumnWidth(5),
              3: const pw.FlexColumnWidth(5),
              4: const pw.FlexColumnWidth(5),
            },
            border: const pw.TableBorder(
              bottom: pw.BorderSide(color: accentColor, width: 0.5),
            ),
            children: [
              pw.TableRow(
                children: [
                  _buildCalculationCell('GST Payable / refundable', align: pw.Alignment.centerLeft, isBold: true),
                  _buildCalculationCell(_formatCurrency(totalCGST ?? 0), align: pw.Alignment.centerRight, isBold: true),
                  _buildCalculationCell(_formatCurrency(totalSGST ?? 0), align: pw.Alignment.centerRight, isBold: true),
                  _buildCalculationCell(_formatCurrency(totalIGST ?? 0), align: pw.Alignment.centerRight, isBold: true),
                  _buildCalculationCell(_formatCurrency(totalGSTValue), align: pw.Alignment.centerRight, isBold: true)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget logTitleContent(pw.Context context) {
    return pw.Center(
      child: pw.Text(
        'GST TRANSACTION LOG',
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
          color: detailsColor,
        ),
      ),
    );
  }

  List<pw.Widget> _GSTtransactionLog(pw.Context context) {
    const tableHeaders = ['Date', 'Invoice No', 'Details', 'GST \nType', 'Taxable Value', 'CGST', 'SGST', 'IGST', 'Total GST', 'Gross Amount'];

    final dataRows = List<pw.TableRow>.generate(
      data.gstList.length,
      (index) {
        final item = data.gstList[index];
        return pw.TableRow(
          children: [
            _buildCell(
              _formatDate(item.date),
            ),
            _buildCell(item.invoice_number, alignRight: true),
            _buildCell(item.description ?? ''),
            _buildCell(item.gstType, alignRight: true),
            _buildCell(_formatCurrency(item.subTotal), alignRight: true),
            _buildCell(_formatCurrency(item.cgst), alignRight: true),
            _buildCell(_formatCurrency(item.sgst), alignRight: true),
            _buildCell(_formatCurrency(item.igst), alignRight: true),
            _buildCell(
              _formatCurrency(item.totalGst),
              alignRight: true,
            ),
            _buildCell(
              _formatCurrency(item.totalAmount),
              alignRight: true,
            ),
          ],
        );
      },
    );

    return [
      // Header table (fixed height, doesn't overflow)
      pw.Table(
        border: const pw.TableBorder(
          left: pw.BorderSide.none,
          right: pw.BorderSide.none,
          horizontalInside: pw.BorderSide.none,
          verticalInside: pw.BorderSide.none,
        ),
        columnWidths: {
          0: const pw.FlexColumnWidth(3.5),
          1: const pw.FlexColumnWidth(3),
          2: const pw.FlexColumnWidth(4.5),
          3: const pw.FlexColumnWidth(2),
          4: const pw.FlexColumnWidth(3),
          5: const pw.FlexColumnWidth(3),
          6: const pw.FlexColumnWidth(3),
          7: const pw.FlexColumnWidth(3),
          8: const pw.FlexColumnWidth(3),
          9: const pw.FlexColumnWidth(3),
        },
        children: [
          pw.TableRow(
            decoration: const pw.BoxDecoration(
              color: PdfColors.green500,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
            ),
            children: List.generate(tableHeaders.length, (index) {
              return _buildHeaderCell(
                tableHeaders[index],
                alignment: index <= 4 ? pw.Alignment.center : pw.Alignment.centerRight,
              );
            }),
          ),
        ],
      ),

      // Data table that can break across pages
      pw.Table(
        border: const pw.TableBorder(
          bottom: pw.BorderSide(color: accentColor, width: 0.5),
          left: pw.BorderSide.none,
          right: pw.BorderSide.none,
          horizontalInside: pw.BorderSide(color: accentColor, width: 0.5),
          verticalInside: pw.BorderSide.none,
        ),
        columnWidths: {
          0: const pw.FlexColumnWidth(3.5),
          1: const pw.FlexColumnWidth(3),
          2: const pw.FlexColumnWidth(4.5),
          3: const pw.FlexColumnWidth(2),
          4: const pw.FlexColumnWidth(3),
          5: const pw.FlexColumnWidth(3),
          6: const pw.FlexColumnWidth(3),
          7: const pw.FlexColumnWidth(3),
          8: const pw.FlexColumnWidth(3),
          9: const pw.FlexColumnWidth(3),
        },
        children: dataRows,
      ),
    ];
  }

  pw.Widget _buildCalculationCell(String text, {pw.Alignment align = pw.Alignment.centerRight, bool isBold = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      alignment: align,
      child: pw.Text(
        text,
        textAlign: align == pw.Alignment.centerLeft ? pw.TextAlign.left : pw.TextAlign.right,
        softWrap: true,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  pw.Widget _buildCell(String text, {bool isCommonAlignment = false, bool alignRight = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
      alignment: isCommonAlignment ? pw.Alignment.topLeft : (alignRight ? pw.Alignment.centerRight : pw.Alignment.centerLeft),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 9),
        softWrap: true,
        textAlign: alignRight ? pw.TextAlign.right : pw.TextAlign.left,
      ),
    );
  }

  pw.Widget _buildHeaderCell(String text, {pw.Alignment alignment = pw.Alignment.centerLeft}) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
      alignment: alignment,
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
          color: _baseTextColor,
        ),
      ),
    );
  }
}

String _formatCurrency(double amount) {
  final formatter = NumberFormat('#,##,##0.00'); // Indian number format
  return formatter.format(amount);
}

String _formatDate(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}
