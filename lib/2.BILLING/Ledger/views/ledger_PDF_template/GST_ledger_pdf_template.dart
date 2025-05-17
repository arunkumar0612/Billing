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
import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/ledger_pdf_entities/GST_ledger_PDF_entities.dart';


Future<Uint8List> generateGSTledger  (
    PdfPageFormat pageFormat) async {

  final List<Map<String, dynamic>> summaryList = [
    {
    'category': 'Input',
    'CGST' :'34454545454.67',
    'SGST': '453454545454.5',
    'IGST': '',
    'totalGST': '4323.54',
    },
     {
    'category': 'Output',
    'CGST' :'4545',
    'SGST': '',
    'IGST': '3333445423.55',
    'totalGST': '4323.54',
    },
  ];

 final List<Map<String, dynamic>> logList = [
  {
    'logDate': '30-01-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Output',
    'taxValue': '9000',
    'CGST': '4500',
    'SGST': '4500',
    'IGST': '',
    'totalGST': '9000',
    'grossAmount': '9000' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Subscription Service Sold',
    'GSTtype': 'Input',
    'taxValue': '9000',
    'CGST': '4500',
    'SGST': '450',
    'IGST': '',
    'totalGST': '903400',
    'grossAmount': '900' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Input',
    'taxValue': '453366',
    'CGST': '',
    'SGST': '',
    'IGST': '4564346',
    'totalGST': '654365',
    'grossAmount': '9643800' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Output',
    'taxValue': '34550',
    'CGST': '676450',
    'SGST': '2332',
    'IGST': '',
    'totalGST': '5673466',
    'grossAmount': '3454' 
  },
   {
    'logDate': '30-01-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Output',
    'taxValue': '9000',
    'CGST': '4500',
    'SGST': '4500',
    'IGST': '',
    'totalGST': '9000',
    'grossAmount': '9000' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Subscription Service Sold',
    'GSTtype': 'Input',
    'taxValue': '9000',
    'CGST': '4500',
    'SGST': '450',
    'IGST': '',
    'totalGST': '903400',
    'grossAmount': '900' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Input',
    'taxValue': '453366',
    'CGST': '',
    'SGST': '',
    'IGST': '4564346',
    'totalGST': '654365',
    'grossAmount': '9643800' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Output',
    'taxValue': '34550',
    'CGST': '676450',
    'SGST': '2332',
    'IGST': '',
    'totalGST': '5673466',
    'grossAmount': '3454' 
  },
   {
    'logDate': '30-01-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Output',
    'taxValue': '9000',
    'CGST': '4500',
    'SGST': '4500',
    'IGST': '',
    'totalGST': '9000',
    'grossAmount': '9000' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Subscription Service Sold',
    'GSTtype': 'Input',
    'taxValue': '9000',
    'CGST': '4500',
    'SGST': '450',
    'IGST': '',
    'totalGST': '903400',
    'grossAmount': '900' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Input',
    'taxValue': '453366',
    'CGST': '',
    'SGST': '',
    'IGST': '4564346',
    'totalGST': '654365',
    'grossAmount': '9643800' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Output',
    'taxValue': '34550',
    'CGST': '676450',
    'SGST': '2332',
    'IGST': '',
    'totalGST': '5673466',
    'grossAmount': '3454' 
  },
   {
    'logDate': '30-01-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Output',
    'taxValue': '9000',
    'CGST': '4500',
    'SGST': '4500',
    'IGST': '',
    'totalGST': '9000',
    'grossAmount': '9000' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Subscription Service Sold',
    'GSTtype': 'Input',
    'taxValue': '9000',
    'CGST': '4500',
    'SGST': '450',
    'IGST': '',
    'totalGST': '903400',
    'grossAmount': '900' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Input',
    'taxValue': '453366',
    'CGST': '',
    'SGST': '',
    'IGST': '4564346',
    'totalGST': '654365',
    'grossAmount': '9643800' 
  },
    {
    'logDate': '27-04-2025',
    'invoiceNo': 'INV-3423',
    'particulars': 'Goods Purchased',
    'GSTtype': 'Output',
    'taxValue': '34550',
    'CGST': '676450',
    'SGST': '2332',
    'IGST': '',
    'totalGST': '5673466',
    'grossAmount': '3454' 
  },
  
  
  
   
  
 ];


DateTime fromDate = DateFormat('dd-MM-yyyy').parse('03-09-2024');
DateTime toDate = DateFormat('dd-MM-yyyy').parse('04-03-2025');

List<SummaryDetails> summaryParsedList = summaryList.map((item) => SummaryDetails.fromJson(item)).toList();
List<GSTlogDetails> logParsedList = logList.map((item) => GSTlogDetails.fromJson(item)).toList();

GSTledger value = GSTledger(
  fromDate: fromDate,
  toDate: toDate,
  summaryDetails: summaryParsedList,
  gstLogDetails: logParsedList,
);

final gstStatement = GSTstatement(
  gstLedger: value,
  currentDate: DateTime.now(),
);


  return await gstStatement.buildPdf(pageFormat);
}

class GSTstatement {
  final GSTledger gstLedger;
  final DateTime currentDate;

  GSTstatement({
    required this.gstLedger,
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
    final doc = pw.Document(
      theme: pw.ThemeData.withFont(
        base: pw.Font.helvetica(),
        bold: pw.Font.helveticaBold(),
        italic: pw.Font.helveticaOblique(),
        boldItalic: pw.Font.helveticaBoldOblique(),
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
      _summaryTable(context, gstLedger.summaryDetails),
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
      ..._GSTtransactionLog(context, gstLedger.gstLogDetails),
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
      child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
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
      if (isNotLastPage) pw.Text(
              'Continued...',
              style: const pw.TextStyle(
                fontSize: 9,
                color: PdfColors.grey900,
              ),
            ) else pw.SizedBox(),
      
    ],
  );
}


  pw.PageTheme _buildTheme(PdfPageFormat pageFormat) {
    return pw.PageTheme(
      margin:
          const pw.EdgeInsets.only(top: 25, bottom: 20, right: 15, left: 15),
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
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 7,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                buildInfoRow('Date', _formatDate(DateTime.now())),
                buildInfoRow('GSTIN','33ABECS0625B1Z0'),
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
                buildInfoRow('Registration Type','Regular'),
                buildInfoRow('From Date', _formatDate(gstLedger.fromDate)),
                buildInfoRow('To Date', _formatDate(gstLedger.toDate)),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}


pw.Widget summaryTitleContent(pw.Context context){
  return  pw.Center(
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



  pw.Widget _summaryTable(pw.Context context, List<SummaryDetails> summaryDetailsList) {
  const tableHeaders = [
    'Category',
    'CGST(Rs.)',
    'SGST(Rs.) ',
    'IGST(Rs.)',
    'Total GST(Rs.)'
  ];

  final dataRows = List<pw.TableRow>.generate(
    summaryDetailsList.length,
    (index) {
      final item = summaryDetailsList[index];
      return pw.TableRow(
        children: [
          _buildCell(item.category, ),
          _buildCell(_formatCurrency(double.tryParse(item.CGST) ?? 0), alignRight: true,),
          _buildCell(_formatCurrency(double.tryParse(item.SGST) ?? 0),alignRight: true,),
          _buildCell(_formatCurrency(double.tryParse(item.IGST)?? 0), alignRight: true),
          _buildCell(_formatCurrency((double.tryParse(item.CGST) ?? 0) +(double.tryParse(item.SGST) ?? 0) +(double.tryParse(item.IGST) ?? 0)),alignRight: true,),
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
  final totalCGST = gstLedger.summaryDetails.fold<double>(0.0,(sum, item) => sum + (double.tryParse(item.CGST)?? 0));
  final totalSGST = gstLedger.summaryDetails.fold<double>(0.0, (sum, item) => sum + (double.tryParse(item.SGST) ?? 0));
  final totalIGST = gstLedger.summaryDetails.fold<double>(0.0, (sum, item) => sum + (double.tryParse(item.IGST) ?? 0));
  final totalGSTValue = gstLedger.summaryDetails.fold<double>(0.0, (sum, item) =>sum +(double.tryParse(item.CGST) ?? 0) +(double.tryParse(item.SGST) ?? 0) +(double.tryParse(item.IGST) ?? 0));
  

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
                _buildCalculationCell(_formatCurrency(totalCGST), align: pw.Alignment.centerRight, isBold: true),
                _buildCalculationCell(_formatCurrency(totalSGST),align: pw.Alignment.centerRight, isBold: true),
                _buildCalculationCell(_formatCurrency(totalIGST),align: pw.Alignment.centerRight, isBold: true),
                _buildCalculationCell(_formatCurrency(totalGSTValue),align: pw.Alignment.centerRight, isBold: true)
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

pw.Widget logTitleContent(pw.Context context){
  return  pw.Center(
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

List<pw.Widget> _GSTtransactionLog(pw.Context context, List<GSTlogDetails> gstLogDetails) {
  const tableHeaders = [
    'Date',
    'Invoice No',
    'Details',
    'GST \nType',
    'Taxable Value',
    'CGST\n(Rs.)',
    'SGST\n(Rs.)',
    'IGST\n(Rs.)',
    'Total GST\n(Rs.)',
    'Gross Amount\n(Rs.)'
  ];

  final dataRows = List<pw.TableRow>.generate(
    gstLogDetails.length,
    (index) {
      final item = gstLogDetails[index];
      return pw.TableRow(
        children: [
          _buildCell(_formatDate(item.logDate), alignRight: true),
          _buildCell(item.invoiceNo, alignRight: true),
          _buildCell(item.particulars),
          _buildCell(item.GSTtype),
          _buildCell(_formatCurrency(double.tryParse(item.taxValue) ?? 0), alignRight: true),
          _buildCell(_formatCurrency(double.tryParse(item.CGST) ?? 0), alignRight: true),
          _buildCell(_formatCurrency(double.tryParse(item.SGST) ?? 0), alignRight: true),
          _buildCell(_formatCurrency(double.tryParse(item.IGST) ?? 0), alignRight: true),
          _buildCell(
            _formatCurrency(
              (double.tryParse(item.CGST) ?? 0) +
              (double.tryParse(item.SGST) ?? 0) +
              (double.tryParse(item.IGST) ?? 0)
            ),
            alignRight: true,
          ),
          _buildCell(
            _formatCurrency(
              (double.tryParse(item.taxValue) ?? 0) +
              (double.tryParse(item.CGST) ?? 0) +
              (double.tryParse(item.SGST) ?? 0) +
              (double.tryParse(item.IGST) ?? 0)
            ),
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
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(3),
        2: const pw.FlexColumnWidth(4),
        3: const pw.FlexColumnWidth(3),
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
              alignment: index <= 3 ? pw.Alignment.centerLeft : pw.Alignment.center,
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
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(3),
        2: const pw.FlexColumnWidth(4),
        3: const pw.FlexColumnWidth(3),
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






  pw.Widget _buildCalculationCell(String text,
    {pw.Alignment align = pw.Alignment.centerRight, bool isBold = false}) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    alignment: align,
    child: pw.Text(
      text,
      textAlign: align == pw.Alignment.centerLeft ? pw.TextAlign.left : pw.TextAlign.right,
      softWrap: true,
      style: pw.TextStyle(
        fontSize: 8,
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    ),
  );
}


  pw.Widget _buildCell(String text,
      {bool isCommonAlignment = false, bool alignRight = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
      alignment: isCommonAlignment
          ? pw.Alignment.topLeft
          : (alignRight ? pw.Alignment.centerRight : pw.Alignment.centerLeft),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 8),
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
        fontSize: 8,
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
