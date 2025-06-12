import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ssipl_billing/4.SALES/controllers/Quote_actions.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Quote_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/product_entities.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

Future<Uint8List> generate_Quote(PdfPageFormat pageFormat, products, client_addr_name, client_addr, bill_addr_name, bill_addr, estimate_num, GSTIN, quote_gstTotals, isGST_local) async {
  final quotation = Quotation(
    products: products,
    // GST: gst.toDouble(),
    baseColor: PdfColors.green500,
    accentColor: PdfColors.blueGrey900,
    client_addr_name: client_addr_name,
    client_addr: client_addr,
    bill_addr_name: bill_addr_name,
    bill_addr: bill_addr,
    estimate: estimate_num ?? "",
    GSTIN: GSTIN,
    type: '',
    quote_gstTotals: quote_gstTotals,
    isGST_local: isGST_local,
  );

  return await quotation.buildPdf(pageFormat);
}

class Quotation {
  Quotation(
      {required this.products,
      // required this.GST,
      required this.baseColor,
      required this.accentColor,
      required this.client_addr_name,
      required this.client_addr,
      required this.bill_addr_name,
      required this.bill_addr,
      required this.estimate,
      required this.GSTIN,
      required this.type,
      required this.quote_gstTotals,
      required this.isGST_local
      // required this.items,
      });
  final QuoteController quoteController = Get.find<QuoteController>();
  List<QuoteGSTtotals> quote_gstTotals = [];
  String client_addr_name = "";
  String client_addr = "";
  String bill_addr_name = "";
  String bill_addr = "";
  String estimate = "";
  String GSTIN = "";
  String type = "";
  bool isGST_local = true;

  final List<QuoteProduct> products;
  // final double GST;
  final PdfColor baseColor;
  final PdfColor accentColor;
  static const _darkColor = PdfColors.blueGrey800;
  double get CGST_total => quote_gstTotals.map((item) => (item.gst) / 2 * (item.total) / 100).reduce((a, b) => a + b);
  double get SGST_total => quote_gstTotals.map((item) => (item.gst) / 2 * (item.total) / 100).reduce((a, b) => a + b);
  double get _total => products.map<double>((p) => p.total).reduce((a, b) => a + b);
  double get _grandTotal => _total + CGST_total + SGST_total;
  dynamic profileImage;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    Helvetica = await loadFont_regular();
    Helvetica_bold = await loadFont_bold();
    final doc = pw.Document();
    profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/sporada.jpeg')).buffer.asUint8List(),
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: pageFormat.copyWith(
            marginLeft: 15,
            marginRight: 15,
            marginTop: 0,
            marginBottom: 15,
          ),
        ),
        footer: footer,
        header: header,
        build: (context) => [
          pw.SizedBox(height: 10),
          GST_view(context),
          pw.SizedBox(height: 10),
          _contentTable(context),
          pw.SizedBox(height: 20),
          isGST_local ? Local_tax_table(context) : others_tax_table(context),
        ],
      ),
    );

    return doc.save();
  }

  pw.Widget header(pw.Context context) {
    return pw.Container(
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 0, left: 0),
                height: 120,
                child: pw.Image(profileImage),
              ),
              pw.Text(
                'QUOTATION',
                style: pw.TextStyle(
                  font: Helvetica_bold,
                  fontSize: 15,
                  color: PdfColors.blueGrey800,
                  // fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                  height: 120,
                  child: pw.Row(children: [
                    pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        regular('Date', 10),
                        pw.SizedBox(height: 5),
                        regular('Estimate no', 10),
                      ],
                    ),
                    pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        regular('  :  ', 10),
                        pw.SizedBox(height: 5),
                        regular('  :  ', 10),
                      ],
                    ),
                    pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          child: pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: regular(formatDate(DateTime.now()), 10),
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Container(
                          child: pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: bold(estimate, 10),
                          ),
                        ),
                      ],
                    ),
                  ])),
            ],
          ),
          pw.Container(child: to_addr(context)),
          pw.SizedBox(height: 20),
        ],
      ),
    );
  }

  pw.Widget to_addr(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                // width: 285,
                height: 20,
                decoration: pw.BoxDecoration(
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                  color: baseColor,
                  border: pw.Border.all(
                    color: baseColor,
                    width: 1,
                  ),
                ),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(
                        top: 3,
                        left: 15,
                      ),
                      child: pw.Text(
                        'CLIENT ADDRESS',
                        style: pw.TextStyle(
                          font: Helvetica_bold,
                          fontSize: 10,
                          color: PdfColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  client_addr_name,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: Helvetica_bold,
                    fontSize: 10,
                    lineSpacing: 2,
                    color: _darkColor,
                  ),
                  softWrap: true,
                ),
              ),
              pw.SizedBox(
                height: 4,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  client_addr,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: Helvetica,
                    fontSize: 8,
                    lineSpacing: 3,
                    color: _darkColor,
                  ),
                  softWrap: true, // Ensure text wraps within the container
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 10),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                // width: 285,
                height: 20,
                decoration: pw.BoxDecoration(
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                  color: baseColor,
                  border: pw.Border.all(
                    color: baseColor,
                    width: 1,
                  ),
                ),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(
                        top: 3,
                        left: 15,
                      ),
                      child: pw.Text(
                        'BILLING ADDRESS',
                        style: pw.TextStyle(
                          font: Helvetica_bold,
                          fontSize: 10,
                          color: PdfColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  bill_addr_name,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: Helvetica_bold,
                    fontSize: 10,
                    lineSpacing: 2,
                    color: _darkColor,
                  ),
                  softWrap: true,
                ),
              ),
              pw.SizedBox(
                height: 4,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  bill_addr,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: Helvetica,
                    fontSize: 8,
                    lineSpacing: 2,
                    color: _darkColor,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget GST_view(pw.Context context) {
    return pw.Center(child: bold(GSTIN, 12));
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'S.No',
      'Item Description',
      'HSN',
      'GST(%)',
      'Price',
      'Quantity',
      'Total',
    ];

    return pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 22,
      cellHeight: 30,

      // ✅ Column width added
      columnWidths: {
        0: const pw.FlexColumnWidth(2), // S.No (small)
        1: const pw.FlexColumnWidth(20), // Item Description (large)
        2: const pw.FlexColumnWidth(3), // HSN Code
        3: const pw.FlexColumnWidth(3), // GST
        4: const pw.FlexColumnWidth(4), // Price
        5: const pw.FlexColumnWidth(3), // Quantity
        6: const pw.FlexColumnWidth(4), // Total
      },

      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.center,
        6: pw.Alignment.centerRight,
      },
      headerAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.center,
        6: pw.Alignment.centerRight,
      },

      headerStyle: pw.TextStyle(
        font: Helvetica_bold,
        color: PdfColors.white,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),

      cellStyle: pw.TextStyle(
        font: Helvetica,
        color: _darkColor,
        fontSize: 10,
      ),

      cellDecoration: (int rowIndex, dynamic cellData, int colIndex) {
        return pw.BoxDecoration(
          color: colIndex % 2 == 0 ? PdfColors.green50 : PdfColors.white,
        );
      },

      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),

      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget others_tax_table(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey700)),
              // height: 200,
              // width: 300, // Ensure the container has a defined width
              child: pw.Column(
                // border: pw.TableBorder.all(color: PdfColors.grey700, width: 1),
                children: [
                  pw.Row(
                    children: [
                      pw.Container(
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(right: pw.BorderSide(color: PdfColors.grey700)),
                        ),
                        height: 38,
                        width: 80,
                        child: pw.Center(
                          child: pw.Text(
                            "Taxable\nvalue",
                            style: pw.TextStyle(
                              font: Helvetica,

                              fontSize: 10,
                              color: PdfColors.grey700,
                              // fontWeight: pw.FontWeight.bold,
                            ),
                            textAlign: pw.TextAlign.center, // Justifying the text
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 38,
                        child: pw.Column(
                          children: [
                            pw.Container(
                              width: 150,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(right: pw.BorderSide(color: PdfColors.grey700)),
                              ),
                              height: 19, // Replace Expanded with defined height
                              child: pw.Center(child: regular('IGST', 10)),
                            ),
                            pw.Container(
                              height: 19, // Define height instead of Expanded
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50, // Define width instead of Expanded
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(top: pw.BorderSide(color: PdfColors.grey700), bottom: pw.BorderSide(color: PdfColors.grey700)),
                                    ),
                                    child: pw.Center(child: regular('%', 10)),
                                  ),
                                  pw.Container(
                                    width: 100, // Define width instead of Expanded
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(color: PdfColors.grey700),
                                        top: pw.BorderSide(color: PdfColors.grey700),
                                        left: pw.BorderSide(color: PdfColors.grey700),
                                      ),
                                    ),
                                    child: pw.Center(child: regular('amount', 10)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.ListView.builder(
                    itemCount: quote_gstTotals.length, // Number of items in the list
                    itemBuilder: (context, index) {
                      return pw.Row(
                        children: [
                          pw.Container(
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                right: pw.BorderSide(color: PdfColors.grey700),
                                top: pw.BorderSide(color: PdfColors.grey700),
                              ),
                            ),
                            width: 80,
                            height: 38,
                            child: pw.Center(child: regular(formatzero(quote_gstTotals[index].total), 10)),
                          ),
                          pw.Container(
                            height: 38,
                            child: pw.Row(
                              children: [
                                pw.Container(
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      top: pw.BorderSide(color: PdfColors.grey700),
                                    ),
                                  ),
                                  width: 50, // Define width instead of Expanded
                                  child: pw.Center(
                                    child: regular((quote_gstTotals[index].gst.toInt()).toString(), 10),
                                  ),
                                ),
                                pw.Container(
                                  width: 100, // Define width instead of Expanded
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(color: PdfColors.grey700),
                                      top: pw.BorderSide(color: PdfColors.grey700),
                                      left: pw.BorderSide(color: PdfColors.grey700),
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: regular(
                                        formatzero(
                                          ((quote_gstTotals[index].total.toInt() / 100) * (quote_gstTotals[index].gst)),
                                        ),
                                        10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            others_final_amount(context),
          ],
        ),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // pw.Expanded(child: pw.Container(), flex: 1),

            notes(context),

            // 995461
            pw.SizedBox(width: 100),
            authorized_signatory(context),
          ],
        ),
      ],
    );
  }

  pw.Widget Local_tax_table(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey700)),
              // height: 200,
              // width: 300, // Ensure the container has a defined width
              child: pw.Column(
                // border: pw.TableBorder.all(color: PdfColors.grey700, width: 1),
                children: [
                  pw.Row(
                    children: [
                      pw.Container(
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(right: pw.BorderSide(color: PdfColors.grey700)),
                        ),
                        height: 38,
                        width: 80,
                        child: pw.Center(
                          child: pw.Text(
                            "Taxable\nvalue",
                            style: pw.TextStyle(
                              font: Helvetica,

                              fontSize: 10,
                              color: PdfColors.grey700,
                              // fontWeight: pw.FontWeight.bold,
                            ),
                            textAlign: pw.TextAlign.center, // Justifying the text
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 38,
                        child: pw.Column(
                          children: [
                            pw.Container(
                              width: 110,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(right: pw.BorderSide(color: PdfColors.grey700)),
                              ),
                              height: 19, // Replace Expanded with defined height
                              child: pw.Center(child: regular('CGST', 10)),
                            ),
                            pw.Container(
                              height: 19, // Define height instead of Expanded
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 40, // Define width instead of Expanded
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(top: pw.BorderSide(color: PdfColors.grey700), bottom: pw.BorderSide(color: PdfColors.grey700)),
                                    ),
                                    child: pw.Center(child: regular('%', 10)),
                                  ),
                                  pw.Container(
                                    width: 70, // Define width instead of Expanded
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(color: PdfColors.grey700),
                                        top: pw.BorderSide(color: PdfColors.grey700),
                                        left: pw.BorderSide(color: PdfColors.grey700),
                                      ),
                                    ),
                                    child: pw.Center(child: regular('amount', 10)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.Container(
                        height: 38,
                        child: pw.Column(
                          children: [
                            pw.Container(
                              height: 19, // Replace Expanded with defined height
                              child: pw.Center(child: regular('SGST', 10)),
                            ),
                            pw.Container(
                              height: 19, // Define height instead of Expanded
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 40, // Define width instead of Expanded
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(top: pw.BorderSide(color: PdfColors.grey700)),
                                    ),
                                    child: pw.Center(child: regular('%', 10)),
                                  ),
                                  pw.Container(
                                    width: 70, // Define width instead of Expanded
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(color: PdfColors.grey700),
                                        top: pw.BorderSide(color: PdfColors.grey700),
                                        left: pw.BorderSide(color: PdfColors.grey700),
                                      ),
                                    ),
                                    child: pw.Center(child: regular('amount', 10)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.ListView.builder(
                    itemCount: quote_gstTotals.length, // Number of items in the list
                    itemBuilder: (context, index) {
                      return pw.Row(
                        children: [
                          pw.Container(
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                right: pw.BorderSide(color: PdfColors.grey700),
                                top: pw.BorderSide(color: PdfColors.grey700),
                              ),
                            ),
                            width: 80,
                            height: 38,
                            child: pw.Center(child: regular(formatzero(quote_gstTotals[index].total), 10)),
                          ),
                          pw.Container(
                            height: 38,
                            child: pw.Row(
                              children: [
                                pw.Container(
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      top: pw.BorderSide(color: PdfColors.grey700),
                                    ),
                                  ),
                                  width: 40, // Define width instead of Expanded
                                  child: pw.Center(
                                    child: regular((quote_gstTotals[index].gst / 2).toInt().toString(), 10),
                                  ),
                                ),
                                pw.Container(
                                  width: 70, // Define width instead of Expanded
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(color: PdfColors.grey700),
                                      top: pw.BorderSide(color: PdfColors.grey700),
                                      left: pw.BorderSide(color: PdfColors.grey700),
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: regular(
                                        formatzero(
                                          ((quote_gstTotals[index].total.toInt() / 100) * (quote_gstTotals[index].gst / 2)),
                                        ),
                                        10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            height: 38,
                            child: pw.Row(
                              children: [
                                pw.Container(
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      top: pw.BorderSide(color: PdfColors.grey700),
                                    ),
                                  ),
                                  width: 40, // Define width instead of Expanded
                                  child: pw.Center(child: regular((quote_gstTotals[index].gst / 2).toInt().toString(), 10)),
                                ),
                                pw.Container(
                                  width: 70, // Define width instead of Expanded
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(left: pw.BorderSide(color: PdfColors.grey700), top: pw.BorderSide(color: PdfColors.grey700)),
                                  ),
                                  child: pw.Center(child: regular(formatzero(((quote_gstTotals[index].total.toInt() / 100) * (quote_gstTotals[index].gst / 2))), 10)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            Local_final_amount(context),
          ],
        ),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // pw.Expanded(child: pw.Container(), flex: 1),

            notes(context),

            // 995461
            pw.SizedBox(width: 100),
            authorized_signatory(context),
          ],
        ),
      ],
    );
  }

// Define a function to format currency to two decimal places
  String formatCurrency(double value) {
    return value.toStringAsFixed(2);
  }

// Display the result
// Text('Round off : ${formatCurrency(roundOffDifference)}', style: TextStyle(fontSize: 10)),

  pw.Widget others_final_amount(pw.Context context) {
    return pw.Container(
      width: 185, // Define width to ensure bounded constraints
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              regular('Sub total  :', 10),
              regular(formatzero(_total), 10),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              regular('IGST        :', 10),
              regular(formatzero(CGST_total * 2), 10),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              regular(
                'Round off : ${((double.parse(formatCurrencyRoundedPaisa(_grandTotal).replaceAll(',', '')) - _grandTotal) >= 0 ? '+' : '')}${(double.parse(formatCurrencyRoundedPaisa(_grandTotal).replaceAll(',', '')) - _grandTotal).toStringAsFixed(2)}',
                10,
              ),
              regular(formatCurrencyRoundedPaisa(_grandTotal), 10),
            ],
          ),
          pw.Divider(color: accentColor),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              bold('Total', 12),
              bold("Rs.${formatCurrencyRoundedPaisa(_grandTotal)}", 12),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget Local_final_amount(pw.Context context) {
    // Calculate the rounded difference
    // double roundedTotal = double.parse(formatCurrency(_grandTotal));
    // double nearestInteger = _grandTotal.roundToDouble();
    // double roundOffDifference = roundedTotal - nearestInteger;
    return pw.Container(
      width: 185, // Define width to ensure bounded constraints
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              regular('Sub total   :', 10),
              regular(formatzero(_total), 10),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              regular('CGST       :', 10),
              regular(formatzero(CGST_total), 10),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              regular('SGST       :', 10),
              regular(formatzero(CGST_total), 10),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              regular(
                'Round off : ${((double.parse(formatCurrencyRoundedPaisa(_grandTotal).replaceAll(',', '')) - _grandTotal) >= 0 ? '+' : '')}${(double.parse(formatCurrencyRoundedPaisa(_grandTotal).replaceAll(',', '')) - _grandTotal).toStringAsFixed(2)}',
                10,
              ),
              regular(formatCurrencyRoundedPaisa(_grandTotal), 10),
            ],
          ),
          pw.Divider(color: accentColor),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              bold('Total', 12),
              bold("Rs.${formatCurrencyRoundedPaisa(_grandTotal)}", 12),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget notes(pw.Context context) {
    return pw.Container(
      width: 280,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 30),
          pw.Padding(
            child: bold("Note", 12),
            padding: const pw.EdgeInsets.only(left: 0, bottom: 10),
          ),
          ...List.generate(quoteController.quoteModel.Quote_noteList.length, (index) {
            return pw.Padding(
              padding: pw.EdgeInsets.only(left: 0, top: index == 0 ? 0 : 8),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  regular("${index + 1}.", 10),
                  pw.SizedBox(width: 5),
                  pw.Expanded(
                    child: pw.Text(
                      quoteController.quoteModel.Quote_noteList[index],
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                        font: Helvetica,
                        fontSize: 10,
                        lineSpacing: 2,
                        color: PdfColors.blueGrey800,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 0, top: 5),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                regular("${quoteController.quoteModel.Quote_noteList.length + 1}.", 10),
                pw.SizedBox(width: 5),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      bold("Bank Account Details:", 10),
                      pw.SizedBox(height: 5), // Adds a small space between the lines
                      pw.Row(
                        children: [
                          regular("Current a/c:", 10),
                          pw.SizedBox(width: 5),
                          regular("257399850001", 10),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        children: [
                          regular("IFSC code:", 10),
                          pw.SizedBox(width: 5),
                          regular("INDB0000521", 10),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        children: [
                          regular("Bank name:", 10),
                          pw.SizedBox(width: 5),
                          regular("IndusInd Bank Limited", 10),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        children: [
                          regular("Branch name:", 10),
                          pw.SizedBox(width: 5),
                          regular("R.S. Puram, Coimbatore.", 10),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        children: [
                          regular("UPI Id:", 10),
                          pw.SizedBox(width: 5),
                          regular("sporadasecure@indus", 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (quoteController.quoteModel.Quote_recommendationList.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 0, top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  regular("${quoteController.quoteModel.Quote_noteList.length + 2}.", 10),
                  pw.SizedBox(width: 5),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        bold(quoteController.quoteModel.recommendationHeadingController.value.text, 10),
                        ...quoteController.quoteModel.Quote_recommendationList.map((recommendation) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 5, top: 5),
                            child: pw.Row(
                              children: [
                                pw.Container(
                                  width: 80,
                                  child: regular(recommendation.key.toString(), 10),
                                ),
                                regular(":", 10),
                                pw.SizedBox(width: 5),
                                regular(recommendation.value.toString(), 10),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  pw.Widget authorized_signatory(pw.Context context) {
    return pw.Expanded(
      flex: 1,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            height: 30,
          ),
          pw.Container(
            height: 70,
            width: 250,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(
                  color: PdfColors.grey700,
                  width: 1,
                ),
                bottom: pw.BorderSide(
                  color: PdfColors.grey700,
                  width: 1,
                ),
                left: pw.BorderSide(
                  color: PdfColors.grey700,
                  width: 1,
                ),
                right: pw.BorderSide(
                  color: PdfColors.grey700,
                  width: 1,
                ),
              ),
            ),
            child: pw.Align(
              alignment: pw.Alignment.bottomCenter,
              child: pw.Text("Authorized Signatory", style: pw.TextStyle(font: Helvetica, color: PdfColors.grey, fontSize: 10, letterSpacing: 0.5)),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget footer(pw.Context context) {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        if (context.pagesCount > 1)
          if (context.pageNumber < context.pagesCount)
            pw.Column(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 20),
                  child: regular('continue...', 12),
                )
              ],
            ),
        pw.Align(
          alignment: pw.Alignment.center,
          child: pw.Column(
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.only(top: 10, bottom: 2),
                child: bold('SPORADA SECURE INDIA PRIVATE LIMITED', 12),
              ),
              regular('687/7, 3rd Floor, Sakthivel Towers, Trichy road, Ramanathapuram, Coimbatore - 641045', 8),
              regular('Telephone: +91-422-2312363, E-mail: sales@sporadasecure.com, Website: www.sporadasecure.com', 8),
              pw.SizedBox(height: 2),
              regular('CIN: U30007TZ2020PTC03414  |  GSTIN: 33ABECS0625B1Z0', 8),
            ],
          ),
        )
      ],
    );
  }
}
