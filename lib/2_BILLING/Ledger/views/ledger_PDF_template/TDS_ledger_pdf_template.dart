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
import 'package:ssipl_billing/2_BILLING/Ledger/models/entities/TDS_ledger_entities.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

Future<Uint8List> generateTDSledger(PdfPageFormat pageFormat, TDSSummaryModel tds_Ledger_list) async {
  final tdsLedger = TDSledger(
    data: tds_Ledger_list,
    currentDate: DateTime.now(),
  );

  return await tdsLedger.buildPdf(pageFormat);
}

class TDSledger {
  final TDSSummaryModel data;
  final DateTime currentDate;

  TDSledger({
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
          pw.SizedBox(height: 5),
          _contentHeader(context),
          pw.SizedBox(height: 15),
          ..._TDStransactionLog(context),
          totalRow(),
          TDSnetBalance(),
          pw.SizedBox(height: 20),
          // _contentFooter(context),
          pw.SizedBox(height: 20),
          // _termsAndConditions(context),
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
        pw.Center(
          child: pw.Text(
            'TDS LEDGER SUMMARY',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: detailsColor,
            ),
          ),
        ),
        pw.SizedBox(height: 15),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 8,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Date', _formatDate(DateTime.now())),
                  buildInfoRow('Firm Name', 'SPORADA SECURE INDIA PRIVATE LIMITED'),
                  buildInfoRow('TAN Number', 'ABECS0625B'),
                ],
              ),
            ),
            pw.SizedBox(width: 90),
            pw.Expanded(
              flex: 8,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildInfoRow('PAN Number', 'ABECS0625B'),
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

  List<pw.Widget> _TDStransactionLog(pw.Context context) {
    const tableHeaders = ['Date', 'Invoice No', 'PAN No', 'Particulars', 'Invoice\nAmount', 'Debit', 'Credit'];
    final dataRows = List<pw.TableRow>.generate(
      data.tdsList.length,
      (index) {
        final item = data.tdsList[index];
        return pw.TableRow(
          children: [
            _buildCell(_formatDate(item.rowUpdatedDate), alignRight: true),
            _buildCell(item.invoice_number, alignRight: true),
            _buildCell(extractPanFromGst(item.gstNumber), alignRight: true),
            _buildCell(item.description ?? ''),
            // _buildCell(item.tdsType),
            _buildCell(item.totalAmount.toString(), alignRight: true),
            _buildCell(_formatCurrency(item.debitAmount), alignRight: true),
            _buildCell(_formatCurrency(item.creditAmount), alignRight: true),
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
          1: const pw.FlexColumnWidth(5),
          2: const pw.FlexColumnWidth(4.5),
          3: const pw.FlexColumnWidth(8),
          4: const pw.FlexColumnWidth(3.5),
          5: const pw.FlexColumnWidth(3),
          6: const pw.FlexColumnWidth(3)
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
                alignment: index <= 3 ? pw.Alignment.center : pw.Alignment.centerRight,
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
          1: const pw.FlexColumnWidth(5),
          2: const pw.FlexColumnWidth(4.5),
          3: const pw.FlexColumnWidth(8),
          4: const pw.FlexColumnWidth(3.5),
          5: const pw.FlexColumnWidth(3),
          6: const pw.FlexColumnWidth(3)
        },
        children: dataRows,
      ),
    ];
  }

  pw.Widget totalRow() {
    // final totalDebit = data.ledgerDetails.fold<double>(
    //   0.0,
    //   (sum, item) => sum + (double.tryParse(item.debit) ?? 0),
    // );
    // final totalCredit = data.ledgerDetails.fold<double>(0.0, (sum, item) => sum + (double.tryParse(item.credit) ?? 0));

    return pw.Row(
      children: [
        pw.Expanded(flex: 60, child: pw.Container()), // Spacer
        pw.Expanded(
          flex: 30,
          child: pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(12),
              1: const pw.FlexColumnWidth(6),
              2: const pw.FlexColumnWidth(6),
            },
            border: const pw.TableBorder(
              bottom: pw.BorderSide(color: accentColor, width: 0.5),
            ),
            children: [
              pw.TableRow(
                children: [
                  _buildCalculationCell('Total TDS', align: pw.Alignment.centerLeft, isBold: false),
                  _buildCalculationCell(_formatCurrency(data.totalPayables), align: data.totalPayables == 0 ? pw.Alignment.center : pw.Alignment.centerRight),
                  _buildCalculationCell(_formatCurrency(data.totalReceivables), align: pw.Alignment.centerRight),
                  // _buildCalculationCell(''),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget TDSnetBalance() {
    final totalPayable = data.totalPayables;
    final totalReceivable = data.totalReceivables;
    final closingAmount = data.totalTds;
    final isClaimable = totalPayable > totalReceivable;

    final formatter = NumberFormat('#,##,##0.00'); // Indian number format
    final closingBalanceStr = formatter.format(closingAmount);

    return pw.Row(
      children: [
        pw.Expanded(flex: 60, child: pw.Container()), // Spacer
        pw.Expanded(
          flex: 30,
          child: pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(12),
              1: const pw.FlexColumnWidth(6),
              2: const pw.FlexColumnWidth(6),
              // 3: const pw.FlexColumnWidth(6),
            },
            border: const pw.TableBorder(
              bottom: pw.BorderSide(color: accentColor, width: 0.5),
            ),
            children: [
              pw.TableRow(
                children: [
                  _buildCalculationCell(' TDS Claimable/payable', align: pw.Alignment.centerLeft, isBold: true),
                  _buildCalculationCell(isClaimable ? closingBalanceStr : '', isBold: true, align: pw.Alignment.centerRight),
                  _buildCalculationCell(!isClaimable ? closingBalanceStr : '', isBold: true, align: pw.Alignment.centerRight),
                  // _buildCalculationCell('', isBold: false, align: pw.Alignment.centerRight),
                ],
              ),
            ],
          ),
        ),
      ],
    );
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
