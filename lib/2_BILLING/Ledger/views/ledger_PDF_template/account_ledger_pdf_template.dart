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
import 'package:ssipl_billing/2_BILLING/Ledger/models/entities/account_ledger_entities.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

Future<Uint8List> generateAccountLedger(PdfPageFormat pageFormat, PDF_AccountLedgerSummary accountLedgerData) async {
  final invoice = Invoice(
    data: accountLedgerData,
    // data.clientDetails: data.clientDetails,
    // invoiceLedgerList: parsedLedgerList,
    currentDate: DateTime.now(),
  );

  return await invoice.buildPdf(pageFormat);
}

class Invoice {
  final PDF_AccountLedgerSummary data;
  final DateTime currentDate;

  Invoice({
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
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(pageFormat),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          pw.SizedBox(height: 5),
          data.clientDetails != null ? _clientDetailsHeader(context) : _consolidatedLedgerHeader(context),
          pw.SizedBox(height: 15),
          ..._contentTable(context),
          totalRow(),
          closingBalanceRow(),
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
                  // pw.SizedBox(height: 3),
                  // pw.Text(
                  //   'Telephone: +91-422-2312363, E-mail: support@ sporadasecure.com,Website: www.sporadasecure.com',
                  //   style: const pw.TextStyle(
                  //     fontSize: 10,
                  //     color: PdfColors.blueGrey900,
                  //   ),
                  // ),
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
      margin: const pw.EdgeInsets.only(top: 30, bottom: 20, right: 15, left: 15),
      pageFormat: pageFormat,
      // theme: pw.ThemeData.withFont(
      //   base: base,
      //   bold: bold,
      //   italic: italic,
      // ),
    );
  }

  pw.Widget _clientDetailsHeader(pw.Context context) {
    pw.Widget buildInfoRow(String label, String value) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 5),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: 80, // fixed width for alignment
              child: pw.Text(
                label,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
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
            'LEDGER SUMMARY',
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
              flex: 6,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Date', _formatDate(DateTime.now())),
                  buildInfoRow('Client Name', data.clientDetails!.clientName),
                  buildInfoRow('Client Address', data.clientDetails!.clientAddress),
                ],
              ),
            ),
            pw.SizedBox(width: 30),
            pw.Expanded(
              flex: 5,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildInfoRow('GSTIN', data.clientDetails!.GSTIN),
                  buildInfoRow('PAN Number', data.clientDetails!.PAN),
                  buildInfoRow('From Date', _formatDate(data.fromDate)),
                  buildInfoRow('To Date', _formatDate(data.toDate)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _consolidatedLedgerHeader(pw.Context context) {
    pw.Widget buildInfoRow(String label, String value) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 5),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: 80, // fixed width for alignment
              child: pw.Text(
                label,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
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
            ' CONSOLIDATED LEDGER SUMMARY',
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
              flex: 4,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Date', _formatDate(DateTime.now())),
                ],
              ),
            ),
            pw.SizedBox(width: 40),
            pw.Expanded(
              flex: 4,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildInfoRow('From Date', _formatDate(data.fromDate)),
                ],
              ),
            ),
            pw.SizedBox(width: 40),
            pw.Expanded(
              flex: 4,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildInfoRow('To Date', _formatDate(data.toDate)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<pw.Widget> _contentTable(pw.Context context) {
    const tableHeaders = ['Date', 'Invoice No', 'Description', 'Debit', 'Credit', 'Balance'];

    final dataRows = List<pw.TableRow>.generate(
      data.ledgerDetails.ledgerList.length,
      (index) {
        final item = data.ledgerDetails.ledgerList[index];
        return pw.TableRow(
          children: [
            // _buildCell((index + 1).toString()),
            _buildCell(formatDate(item.updatedDate)),
            _buildCell(item.invoiceNumber, alignRight: true),
            _builddescription(item.description, item.billDetails.subtotal.toString(), item.billDetails.totalGST.toString(), item.tdsAmount.toString(), isDescription: true),
            _buildCell(_formatCurrency(item.debitAmount), alignRight: true),
            _buildCell(_formatCurrency(item.creditAmount), alignRight: true),
            _buildCell(
              _formatCurrency(parseBalanceWithSuffix(item.balance.toString()).abs()) + (parseBalanceWithSuffix(item.balance.toString()) < 0 ? ' (Dr)' : ' (Cr)'),
              alignRight: true,
            ),
          ],
        );
      },
    );

    return [
      // Header Table (fixed, non-paginating)
      pw.Table(
        border: const pw.TableBorder(
          left: pw.BorderSide.none,
          right: pw.BorderSide.none,
          horizontalInside: pw.BorderSide.none,
          verticalInside: pw.BorderSide.none,
        ),
        columnWidths: {
          0: const pw.FlexColumnWidth(5),
          1: const pw.FlexColumnWidth(7),
          2: const pw.FlexColumnWidth(10),
          3: const pw.FlexColumnWidth(5),
          4: const pw.FlexColumnWidth(5),
          5: const pw.FlexColumnWidth(5),
          // 6: const pw.FlexColumnWidth(5),
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

      // Data Table (paginatable)
      pw.Table(
        border: const pw.TableBorder(
          bottom: pw.BorderSide(color: accentColor, width: 0.5),
          left: pw.BorderSide.none,
          right: pw.BorderSide.none,
          horizontalInside: pw.BorderSide(color: accentColor, width: 0.5),
          verticalInside: pw.BorderSide.none,
        ),
        columnWidths: {
          // 0: const pw.FlexColumnWidth(3),
          0: const pw.FlexColumnWidth(5),
          1: const pw.FlexColumnWidth(7),
          2: const pw.FlexColumnWidth(10),
          3: const pw.FlexColumnWidth(5),
          4: const pw.FlexColumnWidth(5),
          5: const pw.FlexColumnWidth(5),
        },
        children: dataRows,
      ),
    ];
  }

  double parseBalanceWithSuffix(String balance) {
    // Simply parse the numeric value (remove any existing formatting)
    return double.tryParse(balance.replaceAll(',', '').trim()) ?? 0.0;
  }

  pw.Widget totalRow() {
    // final totalDebit = data.ledgerDetails.fold<double>(
    //   0.0,
    //   (sum, item) => sum + (double.tryParse(item.debit) ?? 0),
    // );
    // final totalCredit = data.ledgerDetails.fold<double>(0.0, (sum, item) => sum + (double.tryParse(item.credit) ?? 0));

    return pw.Row(
      children: [
        pw.Expanded(flex: 16, child: pw.Container()), // Spacer
        pw.Expanded(
          flex: 30,
          child: pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(12),
              1: const pw.FlexColumnWidth(6),
              2: const pw.FlexColumnWidth(6),
              3: const pw.FlexColumnWidth(6),
            },
            border: const pw.TableBorder(
              bottom: pw.BorderSide(color: accentColor, width: 0.5),
            ),
            children: [
              pw.TableRow(
                children: [
                  _buildCalculationCell('Total', align: pw.Alignment.centerLeft, isBold: false),
                  _buildCalculationCell(_formatCurrency(data.ledgerDetails.debitAmount)),
                  _buildCalculationCell(_formatCurrency(data.ledgerDetails.creditAmount)),
                  _buildCalculationCell(''),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget closingBalanceRow() {
    final totalDebit = data.ledgerDetails.debitAmount;
    final totalCredit = data.ledgerDetails.creditAmount;
    final closingAmount = data.ledgerDetails.balanceAmount;
    final isDebit = totalDebit > totalCredit;

    final formatter = NumberFormat('#,##,##0.00'); // Indian number format
    final closingBalanceStr = formatter.format(closingAmount.abs());

    return pw.Row(
      children: [
        pw.Expanded(flex: 16, child: pw.Container()), // Spacer
        pw.Expanded(
          flex: 30,
          child: pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(12),
              1: const pw.FlexColumnWidth(6),
              2: const pw.FlexColumnWidth(6),
              3: const pw.FlexColumnWidth(6),
            },
            border: const pw.TableBorder(
              bottom: pw.BorderSide(color: accentColor, width: 0.5),
            ),
            children: [
              pw.TableRow(
                children: [
                  _buildCalculationCell('Closing Balance', align: pw.Alignment.centerLeft, isBold: false),
                  _buildCalculationCell(
                    isDebit ? closingBalanceStr : '',
                    isBold: true,
                  ),
                  _buildCalculationCell(
                    !isDebit ? closingBalanceStr : '',
                    isBold: true,
                  ),
                  _buildCalculationCell('', isBold: false),
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

  pw.Widget _buildCell(String text, {bool isDescription = false, bool alignRight = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
      alignment: isDescription ? pw.Alignment.topLeft : (alignRight ? pw.Alignment.centerRight : pw.Alignment.center),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 9),
        softWrap: true,
        // overflow: isDescription ? pw.TextOverflow.clip : pw.TextOverflow.clip,
        textAlign: alignRight ? pw.TextAlign.right : pw.TextAlign.left, // 👈 added
      ),
    );
  }

  pw.Widget _builddescription(String text, String Sub_text1, String Sub_text2, String Sub_text3, {bool isDescription = false, bool alignRight = false}) {
    return pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
        alignment: isDescription ? pw.Alignment.topLeft : (alignRight ? pw.Alignment.centerRight : pw.Alignment.centerLeft),
        child: pw.Column(children: [
          pw.Text(
            text,
            style: const pw.TextStyle(fontSize: 9),
            softWrap: true,
            // overflow: isDescription ? pw.TextOverflow.clip : pw.TextOverflow.clip,
          ),
          pw.SizedBox(height: 3),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              'Net : $Sub_text1,  GST: $Sub_text2,  TDS: $Sub_text3',
              style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic, color: PdfColors.blue900),
              softWrap: true,
              // overflow: isDescription ? pw.TextOverflow.clip : pw.TextOverflow.clip,
            ),
          ),
          // pw.SizedBox(height: 2),
          // pw.Align(
          //   alignment: pw.Alignment.centerLeft,
          //   child: pw.Text(
          //     'GST : $Sub_text2 \n'
          //     'TDS: $Sub_text3',
          //     style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic, color: PdfColors.blue900),
          //     softWrap: true,
          //     // overflow: isDescription ? pw.TextOverflow.clip : pw.TextOverflow.clip,
          //   ),
          // ),
        ]));
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
