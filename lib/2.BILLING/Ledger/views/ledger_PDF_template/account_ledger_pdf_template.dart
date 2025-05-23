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

import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/ledger_pdf_entities/account_ledger_PDF_entities.dart';

Future<Uint8List> generateAccountLedger(PdfPageFormat pageFormat) async {
  final List<Map<String, dynamic>> ledgerList = [
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
    {
      'date': '01-04-2023',
      'voucherNo': 'SSIPL-V01032025',
      'description': ' Demo Repair & Maintenance Computer BEING SURVEILLANCE CHARGES FOR THE MONTH APRIL 2023',
      'debit': '',
      'credit': '3675',
      'balance': '345647.99 Dr',
      'invoiceNo': 'INV-1001',
    },
    {
      'date': '01-04-2024',
      'voucherNo': 'V34532',
      'description': 'SP SALELOCAL18  Cust. SPORADA SECURE INDIA PRIVATE LIMITED 1-4HKTKSIU  No.:MEERBC009K8003096',
      'debit': '235454433.44',
      'credit': '4533434323.99',
      'balance': '36467.99 Dr',
      'invoiceNo': 'INV-1002',
    },
  ];

  final clientDetails = ClientDetails(
    clientName: 'Anamallais Agencies Private Limited ',
    clientAddress: '131b, Raja Street, Rivoli 75001 Paris, Palani Road, Rivoli 75001 Paris, Palani Road, Rivoli 75001 Paris, France',
    GSTIN: '27AAEPM1234C1Z5',
    PAN: 'ABCDE1234F',
    fromDate: DateTime(2025, 5, 1),
    toDate: DateTime(2025, 5, 3),
  );

  List<LedgerDetails> parsedLedgerList = ledgerList.map((item) => LedgerDetails.fromJson(item)).toList();

  final temp = {'clientDetails': clientDetails.toJson(), 'ledgerDetails': parsedLedgerList};

  ClientLedger value = ClientLedger.fromJson(temp);

  final invoice = Invoice(
    clientLedger: value,
    // clientLedger.clientDetails: clientLedger.clientDetails,
    // invoiceLedgerList: parsedLedgerList,
    currentDate: DateTime.now(),
  );

  return await invoice.buildPdf(pageFormat);
}

class Invoice {
  final ClientLedger clientLedger;
  final DateTime currentDate;

  Invoice({
    required this.clientLedger,
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
    final doc = pw.Document(
      theme: pw.ThemeData.withFont(
        base: pw.Font.helvetica(),
        bold: pw.Font.helveticaBold(),
        italic: pw.Font.helveticaOblique(),
        boldItalic: pw.Font.helveticaBoldOblique(),
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
          _contentHeader(context),
          pw.SizedBox(height: 15),
          ..._contentTable(context, clientLedger.ledgerDetails),
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

  pw.Widget _contentHeader(pw.Context context) {
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
                  fontSize: 11,
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
                  fontSize: 11,
                  fontWeight: pw.FontWeight.normal,
                  color: PdfColors.black,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                value,
                style: const pw.TextStyle(
                  fontSize: 11,
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
                  buildInfoRow('Client Name', clientLedger.clientDetails.clientName),
                  buildInfoRow('Client Address', clientLedger.clientDetails.clientAddress),
                ],
              ),
            ),
            pw.SizedBox(width: 30),
            pw.Expanded(
              flex: 5,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildInfoRow('GSTIN', clientLedger.clientDetails.GSTIN),
                  buildInfoRow('PAN Number', clientLedger.clientDetails.PAN),
                  buildInfoRow('From Date', _formatDate(clientLedger.clientDetails.fromDate)),
                  buildInfoRow('To Date', _formatDate(clientLedger.clientDetails.toDate)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<pw.Widget> _contentTable(pw.Context context, List invoiceLedgerList) {
    const tableHeaders = ['S.No', 'Date', 'Voucher No', 'Description', 'Debit', 'Credit', 'Balance'];

    final dataRows = List<pw.TableRow>.generate(
      invoiceLedgerList.length,
      (index) {
        final item = invoiceLedgerList[index];
        return pw.TableRow(
          children: [
            _buildCell((index + 1).toString()),
            _buildCell(item.date),
            _buildCell(item.voucherNo),
            _builddescription(item.description, item.invoiceNo, isDescription: true),
            _buildCell(_formatCurrency(double.tryParse(item.debit) ?? 0), alignRight: true),
            _buildCell(_formatCurrency(double.tryParse(item.credit) ?? 0), alignRight: true),
            _buildCell(
              _formatCurrency(parseBalanceWithSuffix(item.balance).abs()) + (item.balance.toLowerCase().contains('dr') ? ' Dr' : ' Cr'),
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
          0: const pw.FlexColumnWidth(3),
          1: const pw.FlexColumnWidth(5),
          2: const pw.FlexColumnWidth(5),
          3: const pw.FlexColumnWidth(12),
          4: const pw.FlexColumnWidth(6),
          5: const pw.FlexColumnWidth(6),
          6: const pw.FlexColumnWidth(6),
        },
        children: [
          pw.TableRow(
            decoration: const pw.BoxDecoration(
              color: PdfColors.green500,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
            ),
            children: tableHeaders.map((h) => _buildHeaderCell(h)).toList(),
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
          0: const pw.FlexColumnWidth(3),
          1: const pw.FlexColumnWidth(5),
          2: const pw.FlexColumnWidth(5),
          3: const pw.FlexColumnWidth(12),
          4: const pw.FlexColumnWidth(6),
          5: const pw.FlexColumnWidth(6),
          6: const pw.FlexColumnWidth(6),
        },
        children: dataRows,
      ),
    ];
  }

  double parseBalanceWithSuffix(String balance) {
    final cleaned = balance.toLowerCase().trim();

    if (cleaned.endsWith('dr')) {
      return double.tryParse(cleaned.replaceAll('dr', '').trim()) ?? 0.0;
    } else if (cleaned.endsWith('cr')) {
      return -(double.tryParse(cleaned.replaceAll('cr', '').trim()) ?? 0.0);
    } else {
      // Fallback if no suffix
      return double.tryParse(cleaned) ?? 0.0;
    }
  }

  pw.Widget totalRow() {
    final totalDebit = clientLedger.ledgerDetails.fold<double>(
      0.0,
      (sum, item) => sum + (double.tryParse(item.debit) ?? 0),
    );
    final totalCredit = clientLedger.ledgerDetails.fold<double>(0.0, (sum, item) => sum + (double.tryParse(item.credit) ?? 0));

    return pw.Row(
      children: [
        pw.Expanded(flex: 13, child: pw.Container()), // Spacer
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
                  _buildCalculationCell(_formatCurrency(totalDebit)),
                  _buildCalculationCell(_formatCurrency(totalCredit)),
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
    final totalDebit = clientLedger.ledgerDetails.fold<double>(
      0.0,
      (sum, item) => sum + (double.tryParse(item.debit) ?? 0),
    );
    final totalCredit = clientLedger.ledgerDetails.fold<double>(
      0.0,
      (sum, item) => sum + (double.tryParse(item.credit) ?? 0),
    );
    final closingAmount = (totalDebit - totalCredit).abs();
    final isDebit = totalDebit > totalCredit;

    final formatter = NumberFormat('#,##,##0.00'); // Indian number format
    final closingBalanceStr = formatter.format(closingAmount);

    return pw.Row(
      children: [
        pw.Expanded(flex: 13, child: pw.Container()), // Spacer
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
          fontSize: 9.5,
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
        style: const pw.TextStyle(fontSize: 9.5),
        softWrap: true,
        // overflow: isDescription ? pw.TextOverflow.clip : pw.TextOverflow.clip,
        textAlign: alignRight ? pw.TextAlign.right : pw.TextAlign.left, // 👈 added
      ),
    );
  }

  pw.Widget _builddescription(String text, String Sub_text, {bool isDescription = false, bool alignRight = false}) {
    return pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
        alignment: isDescription ? pw.Alignment.topLeft : (alignRight ? pw.Alignment.centerRight : pw.Alignment.centerLeft),
        child: pw.Column(children: [
          pw.Text(
            text,
            style: const pw.TextStyle(fontSize: 9.5),
            softWrap: true,
            // overflow: isDescription ? pw.TextOverflow.clip : pw.TextOverflow.clip,
          ),
          pw.SizedBox(height: 3),
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
              Sub_text,
              style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic, color: PdfColors.blue900),
              softWrap: true,
              // overflow: isDescription ? pw.TextOverflow.clip : pw.TextOverflow.clip,
            ),
          ),
        ]));
  }

  pw.Widget _buildHeaderCell(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
      alignment: pw.Alignment.center,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9.5,
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
