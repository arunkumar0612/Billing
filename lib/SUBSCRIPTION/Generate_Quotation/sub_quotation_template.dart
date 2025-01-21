import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ssipl_billing/common_modules/support_functions.dart';

List<sub_Product> sub_quote_products = [];
List<Map<String, dynamic>> sub_quote_gstTotals = [];
//main
String sub_quote_client_addr_name = "";
String sub_quote_client_addr = "";
String sub_quote_bill_addr_name = "";
String sub_quote_bill_addr = "";
String sub_quote_estimate_no = "";
String sub_quote_title = "";
String sub_quote_table_heading = "";
List<Map<String, dynamic>> sub_quote_noteList = [];
List<Map<String, dynamic>> sub_quote_recommendationList = [];
// List<Map<String, dynamic>> sub_quote_productDetails = [];

Future<Uint8List> generate_sub_Quotation(PdfPageFormat pageFormat, products, client_addr_name, client_addr, bill_addr_name, bill_addr, estimate_num, title, gst) async {
  final quotation = sub_Quotation(
      products: products,
      GST: gst.toDouble(),
      baseColor: PdfColors.green500,
      accentColor: PdfColors.blueGrey900,
      client_addr_name: client_addr_name,
      client_addr: client_addr,
      bill_addr_name: bill_addr_name,
      bill_addr: bill_addr,
      estimate: estimate_num ?? "",
      title_text: title,
      type: '',
      special_price: 5000);

  return await quotation.buildPdf(pageFormat);
}

class sub_Quotation {
  sub_Quotation({
    required this.products,
    required this.GST,
    required this.baseColor,
    required this.accentColor,
    required this.client_addr_name,
    required this.client_addr,
    required this.bill_addr_name,
    required this.bill_addr,
    required this.estimate,
    required this.title_text,
    required this.type,
    required this.special_price,
    // required this.items,
  });
  String client_addr_name = "";
  String client_addr = "";
  String bill_addr_name = "";
  String bill_addr = "";
  String estimate = "";
  String title_text = "";
  String type = "";
  double special_price;

  final List<sub_Product> products;
  final double GST;
  final PdfColor baseColor;
  final PdfColor accentColor;
  static const _darkColor = PdfColors.blueGrey800;
  double get CGST_total => (special_price / 100) * (GST / 2);
  double get SGST_total => (special_price / 100) * (GST / 2);
  // double get _total => products.map<double>((p) => p.total).reduce((a, b) => a + b);
  double get _grandTotal => special_price + CGST_total + SGST_total;
  dynamic profileImage;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    Helvetica = await loadFont_regular();
    Helvetica_bold = await loadFont_bold();
    final Uint8List discountImage = await loadAssetImage('assets/images/discount.png');
    final pw.Widget contentTable = await buildContentTable(discountImage);
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
          title(context),
          pw.SizedBox(height: 10),
          contentTable,
          pw.SizedBox(height: 20),
          tax_table(context),
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
                'ESTIMATE',
                style: pw.TextStyle(
                  letterSpacing: 2,
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
                            child: regular("AA/234L/KK", 10),
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

  pw.Widget title(pw.Context context) {
    return pw.Center(child: bold(title_text, 12));
  }

  Future<Uint8List> loadAssetImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  Future<pw.Widget> buildContentTable(Uint8List discountImageData) async {
    return pw.Table(
      columnWidths: {
        0: const pw.FlexColumnWidth(1),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(3),
        4: const pw.FlexColumnWidth(1),
      },
      children: [
        // Header Row
        pw.TableRow(
          decoration: pw.BoxDecoration(
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)), // Rounded
            color: baseColor, // Header background color
          ),
          children: [
            _buildTableCell('S.No', isHeader: true),
            _buildTableCell('Package', isHeader: true),
            _buildTableCell('Regular price', isHeader: true),
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              padding: const pw.EdgeInsets.all(7),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    'Special price ',
                    style: pw.TextStyle(
                      font: Helvetica_bold,
                      fontSize: 10,
                      color: PdfColors.white,
                    ),
                  ),
                  pw.SizedBox(width: 4), // Space between text and image
                  pw.Image(
                    pw.MemoryImage(discountImageData),
                    height: 12,
                    width: 12,
                  ),
                ],
              ),
            ),
            _buildTableCell('GST', isHeader: true),
          ],
        ),
        // Data Rows
        for (var i = 0; i < products.length; i++)
          pw.TableRow(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(color: PdfColors.grey, width: 0.5), // Bottom border for rows
              ),
            ),
            children: [
              _buildTableCell('${i + 1}'),
              _buildTableCell(products[i].package),
              _buildTableCell(products[i].regular_price.toString()),
              _buildTableCell(products[i].special_price.toString()),
              _buildTableCell(products[i].gst.toString()),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildTableCell(String content, {bool isHeader = false}) {
    return pw.Container(
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.all(7),
      child: pw.Text(
        content,
        style: pw.TextStyle(
          font: isHeader ? Helvetica_bold : Helvetica,
          fontSize: isHeader ? 10 : 9,
          color: isHeader ? PdfColors.white : _darkColor,
        ),
      ),
    );
  }

  // ignore: unused_element
  pw.TextStyle _headerTextStyle() {
    return pw.TextStyle(
      font: Helvetica_bold,
      color: _darkColor,
      fontSize: 10,
    );
  }

  // ignore: unused_element
  pw.TextStyle _cellTextStyle() {
    return pw.TextStyle(
      font: Helvetica,
      color: _darkColor,
      fontSize: 10,
    );
  }

  // pw.TextStyle _headerTextStyle() {
  //   return pw.TextStyle(
  //     font: Helvetica_bold,
  //     color: PdfColors.white,
  //     fontSize: 10,
  //   );
  // }

  // pw.TextStyle _cellTextStyle() {
  //   return pw.TextStyle(
  //     font: Helvetica,
  //     color: _darkColor,
  //     fontSize: 10,
  //   );
  // }

  pw.Widget tax_table(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            notes(context),

            pw.Container(
              height: 400,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  final_amount(context),
                  pw.SizedBox(height: 10),
                  authorized_signatory(context),
                ],
              ),
            ),

            // final_amount(context),
          ],
        ),
        // pw.Row(
        //   mainAxisAlignment: pw.MainAxisAlignment.end,
        //   crossAxisAlignment: pw.CrossAxisAlignment.start,
        //   children: [
        //     pw.Expanded(child: pw.Container(), flex: 1),

        //     // 995461
        //     pw.SizedBox(width: 100),
        //     authorized_signatory(context),
        //   ],
        // ),
      ],
    );
  }

// Define a function to format currency to two decimal places
  String formatCurrency(double value) {
    return value.toStringAsFixed(2);
  }

// Display the result
// Text('Round off : ${formatCurrency(roundOffDifference)}', style: TextStyle(fontSize: 10)),

  pw.Widget final_amount(pw.Context context) {
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
              regular(formatzero(special_price), 10),
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
          // pw.SizedBox(height: 30),
          pw.Padding(
            child: bold("Note", 12),
            padding: const pw.EdgeInsets.only(left: 0, bottom: 10),
          ),
          ...List.generate(sub_quote_noteList.length, (index) {
            return pw.Padding(
              padding: pw.EdgeInsets.only(left: 0, top: index == 0 ? 0 : 8),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  regular("${index + 1}.", 10),
                  pw.SizedBox(width: 5),
                  pw.Expanded(
                    child: pw.Text(
                      sub_quote_noteList[index]["notecontent"],
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
            padding: const pw.EdgeInsets.only(left: 0, top: 8),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                regular("${sub_quote_noteList.length + 1}.", 10),
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
          if (sub_quote_recommendationList.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 0, top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  regular("${sub_quote_noteList.length + 2}.", 10),
                  pw.SizedBox(width: 5),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        bold(sub_quote_table_heading, 10),
                        ...sub_quote_recommendationList.map((recommendation) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 5, top: 5),
                            child: pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  child: regular(recommendation["key"].toString(), 10),
                                ),
                                regular(":", 10),
                                pw.SizedBox(width: 5),
                                regular(recommendation["value"].toString(), 10),
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
            height: 90,
            width: 185,
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

class sub_Product {
  const sub_Product(
    this.sno,
    this.package,
    this.regular_price,
    this.special_price,
    this.gst,
  );

  final String sno;
  final String package;
  final double regular_price;
  final double special_price;
  final double gst;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno;
      case 1:
        return package;
      case 2:
        return regular_price.toString();
      case 3:
        return special_price.toString();
      case 4:
        return gst.toString();
    }
    return '';
  }
}
