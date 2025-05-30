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
import 'package:ssipl_billing/2.BILLING/Vouchers/models/entities/voucher_entities.dart';

Future<Uint8List> ReceiptPDFtemplate(PdfPageFormat pageFormat, ClearVoucher clear_voucher) async {
  final receiptData = VoucherReceipt(data: clear_voucher);

  final fontRegular = pw.Font.ttf(await rootBundle.load('assets/fonts/roboto.ttf'));
  final fontBold = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Bold.ttf'));

  final pdf = pw.Document(
    theme: pw.ThemeData.withFont(
      base: fontRegular,
      bold: fontBold,
    ),
  );

  pw.PageTheme _buildTheme(PdfPageFormat format) {
    return pw.PageTheme(
      pageFormat: format,
      margin: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    );
  }

  pdf.addPage(pw.MultiPage(
    pageTheme: _buildTheme(pageFormat),
    header: _buildHeader,
    footer: _buildFooter,
    build: (context) => [
      _buildReceiptent(context, receiptData),
      _buildReceipt(context, receiptData),
    ],
  ));

  return pdf.save();
}

class VoucherReceipt {
  final ClearVoucher data;

  VoucherReceipt({
    required this.data,
  });
}

const detailsColor = PdfColors.grey900;
const tableHeaderColor = PdfColors.grey200;
const _darkColor = PdfColors.blueGrey800;
const _lightColor = PdfColors.white;
const contentHeading = PdfColors.grey;
const accentColor = PdfColors.blueGrey900;

pw.Widget _buildHeader(
  pw.Context context,
) {
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
          fontSize: 10,
          color: PdfColors.grey900,
        ),
      ),

      // Right side
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          if (isNotLastPage)
            pw.Text(
              'Continued...',
              style: const pw.TextStyle(
                fontSize: 9,
                color: PdfColors.grey900,
              ),
            ),
          // pw.Text(
          //   'Printed on: $formattedDate',
          //   style: const pw.TextStyle(
          //     fontSize: 10,
          //     color: PdfColors.grey900,
          //   ),
          // ),
        ],
      ),
    ],
  );
}

pw.Widget _buildReceiptent(pw.Context context, VoucherReceipt receiptData) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Container(
        width: 250,
        alignment: pw.Alignment.topLeft,
        padding: pw.EdgeInsets.zero,
        margin: pw.EdgeInsets.zero,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Text(
              'To,',
              style: const pw.TextStyle(
                fontSize: 12,
                color: detailsColor,
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Text(
              receiptData.data.clientAddressName,
              style: pw.TextStyle(
                fontSize: 10,
                color: detailsColor,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 3),
            pw.Text(
              receiptData.data.clientAddress,
              style: const pw.TextStyle(
                fontSize: 10,
                color: detailsColor,
              ),
            ),
            pw.SizedBox(height: 3),
          ],
        ),
      ),
      pw.SizedBox(height: 5),
      pw.Divider(
        thickness: 1,
        color: PdfColors.grey600,
      ),
    ],
  );
}

// pw.Widget _buildDivider(pw.Context context) {
//   return pw.Container(
//     width: double.infinity, // Ensure full width
//     child: pw.Column(git
//       crossAxisAlignment: pw.CrossAxisAlignment.stretch,
//       children: [
//         pw.SizedBox(height: 5),
//         pw.Divider(
//           thickness: 1,
//           color: PdfColors.amber,
//         ),
//       ],
//     ),
//   );
// }

pw.Widget _buildReceipt(pw.Context context, VoucherReceipt receiptData) {
  final List<pw.TextSpan> remarks = [
    pw.TextSpan(
      style: pw.TextStyle(fontSize: 10),
      children: [
        const pw.TextSpan(text: 'Against invoice Number '), // Normal brackets (not italic)
        pw.TextSpan(
          text: '${receiptData.data.invoiceNumber} dated on ${_formatDate(receiptData.data.date)},',
          style: pw.TextStyle(fontStyle: pw.FontStyle.italic), // only this is italic
        ),

        pw.TextSpan(text: ' total amount: Rs.${_formatCurrency(receiptData.data.grossAmount)}. '),
        if (receiptData.data.tdsStatus) pw.TextSpan(text: ' Adjusted amount: Rs.${_formatCurrency(receiptData.data.grossAmount - receiptData.data.tds)}.'),
      ],
    ),
    pw.TextSpan(
      style: pw.TextStyle(fontSize: 10),
      children: [
        if (receiptData.data.tdsStatus)
          pw.TextSpan(
            children: [
              const pw.TextSpan(text: 'Against TDS ('),
              pw.TextSpan(
                text: 'PAN:ABECS0625B dated on ${_formatDate(receiptData.data.date)}',
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
              ),
              pw.TextSpan(text: ') adjusted amount: Rs.${_formatCurrency(receiptData.data.tds)}.\n'),
              pw.TextSpan(
                text: 'Narration: Auto generated from Voucher Number: ${receiptData.data.voucherNumber}.',
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
              ),
            ],
          )
        else
          pw.TextSpan(
            children: [
              const pw.TextSpan(text: 'No TDS has been deducted for this transaction.\n'),
              pw.TextSpan(
                text: 'Narration: Auto generated from Voucher Number: ${receiptData.data.voucherNumber}.',
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
              ),
            ],
          ),
      ],
    ),
  ];
  return pw.Padding(
    padding: const pw.EdgeInsets.only(left: 32, right: 32, top: 10),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Center(
          child: pw.Text(
            'PAYMENT CONFIRMATION RECEIPT',
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 20),

        // Table section
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey700),
          columnWidths: {
            0: pw.FlexColumnWidth(3),
            1: pw.FlexColumnWidth(5),
          },
          children: [
            _buildTableRow('Received from', receiptData.data.clientAddressName),
            _buildTableRow('Amount', 'Rs.${_formatCurrency(receiptData.data.paidAmount)}'),
            _buildTableRow('Date of Payment', _formatDate(receiptData.data.date)),
            _buildTableRow('Payment Method', receiptData.data.paymentmode),
            _buildTableRow('Transaction ID', receiptData.data.transactionDetails),
          ],
        ),

        pw.SizedBox(height: 20),

        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Remarks:',
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 4),
            ...List.generate(
              remarks.length,
              (index) => pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 2),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Number
                    pw.Container(
                      width: 20, // fixed width for numbers
                      child: pw.Text(
                        '${index + 1}.',
                        style: pw.TextStyle(fontSize: 10),
                      ),
                    ),
                    // Text
                    pw.Expanded(
                      child: pw.RichText(
                        text: remarks[index],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Center(
          child: pw.Text(
            'Thank you for your payment. This transaction has been successfully processed and is now complete.',
            style: pw.TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
          ),
        ),

        SizedBox(height: 1),
        pw.Divider(),
        SizedBox(height: 3),

        // Confirmation message
        Center(
          child: pw.Text(
            '[This is a computer generated advice and does not requires a signature.]',
            style: pw.TextStyle(fontSize: 10),
          ),
        )
      ],
    ),
  );
}

// Helper function to build table rows
pw.TableRow _buildTableRow(String label, String value) {
  return pw.TableRow(
    verticalAlignment: pw.TableCellVerticalAlignment.top,
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(8),
        // color: PdfColors.grey200,
        child: pw.Text(label, maxLines: 3, softWrap: true, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(8),
        child: pw.Text(value, maxLines: 3, softWrap: true, style: pw.TextStyle(fontSize: 11)),
      ),
    ],
  );
}

String _formatDate(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

String _formatCurrency(double amount) {
  final formatter = NumberFormat('#,##,##0.00'); // Indian number format
  return formatter.format(amount);
}
