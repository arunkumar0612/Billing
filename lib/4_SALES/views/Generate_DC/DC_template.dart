import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ssipl_billing/4_SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

Future<Uint8List> generate_Dc(PdfPageFormat pageFormat, products, client_addr_name, client_addr, bill_addr_name, bill_addr, dc_num, invoice_num, GSTIN) async {
  final dc = Delivery_challan(
    products: products,
    baseColor: PdfColors.green500,
    accentColor: PdfColors.blueGrey900,
    client_addr_name: client_addr_name,
    client_addr: client_addr,
    bill_addr_name: bill_addr_name,
    bill_addr: bill_addr,
    dc_num: dc_num ?? "",
    invoice_num: invoice_num ?? "",
    GSTIN: GSTIN,
    type: '',
  );

  return await dc.buildPdf(pageFormat);
}

class Delivery_challan {
  Delivery_challan(
      {required this.products,
      required this.baseColor,
      required this.accentColor,
      required this.client_addr_name,
      required this.client_addr,
      required this.bill_addr_name,
      required this.bill_addr,
      required this.dc_num,
      required this.invoice_num,
      required this.type,
      required this.GSTIN

      // required this.items,
      });
  final DcController dcController = Get.find<DcController>();

  String client_addr_name = "";
  String client_addr = "";
  String bill_addr_name = "";
  String bill_addr = "";
  String dc_num = "";
  String invoice_num = '';
  String type = "";
  String GSTIN = "";

  final List<DcProduct> products;

  final PdfColor baseColor;
  final PdfColor accentColor;
  static const _darkColor = PdfColors.blueGrey800;

  // double get _total => products.map<double>((p) => p.total).reduce((a, b) => a + b);
  // double get _grandTotal => _total + CGST_total + SGST_total;
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
          title(context),
          pw.SizedBox(height: 10),
          _contentTable(context),
          pw.SizedBox(height: 10),
          notes(context),
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
                'DELIVERY CHALLAN',
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
                        regular('Invoice ref', 10),
                        pw.SizedBox(height: 5),
                        regular('DC no', 10),
                      ],
                    ),
                    pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        regular('  :  ', 10),
                        pw.SizedBox(height: 5),
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
                            child: bold(invoice_num, 10),
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Container(
                          child: pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: bold(dc_num, 10),
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
    return pw.Center(child: bold(GSTIN, 12));
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'S.No',
      'Item Description',
      'HSN',
      'Quantity',
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

      // ✅ FlexColumnWidth added
      columnWidths: {
        0: const pw.FlexColumnWidth(1), // S.No (small)
        1: const pw.FlexColumnWidth(5), // Item Description (big)
        2: const pw.FlexColumnWidth(2), // HSN (medium)
        3: const pw.FlexColumnWidth(2), // Quantity (medium)
      },

      cellAlignments: {
        0: pw.Alignment.center, // S.No center
        1: pw.Alignment.centerLeft, // Item Description left
        2: pw.Alignment.center, // HSN center
        3: pw.Alignment.center, // Quantity center
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

      // Optional Row Border (uncomment if needed)
      /*
    rowDecoration: pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: accentColor,
          width: 0.5,
        ),
      ),
    ),
    */

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

  pw.Widget notes(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: 280,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 30),
                  pw.Padding(
                    child: bold("Note", 12),
                    padding: const pw.EdgeInsets.only(left: 0, bottom: 10),
                  ),
                  ...List.generate(dcController.dcModel.Dc_noteList.length, (index) {
                    return pw.Padding(
                      padding: pw.EdgeInsets.only(left: 0, top: index == 0 ? 0 : 8),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          regular("${index + 1}.", 10),
                          pw.SizedBox(width: 5),
                          pw.Expanded(
                            child: pw.Text(
                              dcController.dcModel.Dc_noteList[index],
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
                    padding: const pw.EdgeInsets.only(left: 0, top: 5, bottom: 5),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        regular("${dcController.dcModel.Dc_noteList.length + 1}.", 10),
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
                                  regular(": IndusInd Bank Limited", 10),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // pw.Padding(
                  //   padding: const pw.EdgeInsets.only(left: 0, top: 15),
                  //   child: pw.Row(
                  //     crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //     children: [
                  //       // regular("${Delivery_challan_noteList.length + 2}.", 10),
                  //       pw.SizedBox(width: 5),
                  //       pw.Expanded(
                  //         child: pw.Column(
                  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //           children: [
                  //             bold(
                  //                 dcController.dcModel
                  //                     .recommendationHeadingController.value.text,
                  //                 10),
                  //             ...dcController.dcModel.Dc_recommendationList
                  //                 .map((recommendation) {
                  //               return pw.Padding(
                  //                 padding: const pw.EdgeInsets.only(top: 5),
                  //                 child: pw.Row(
                  //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //                   children: [
                  //                     pw.SizedBox(
                  //                       width: 50, // Fixed width to align keys
                  //                       child: regular(
                  //                           recommendation.key.toString(), 10),
                  //                     ),
                  //                     pw.Text(":",
                  //                         style: pw.TextStyle(fontSize: 10)),
                  //                     pw.SizedBox(width: 5),
                  //                     pw.Expanded(
                  //                       child: regular(
                  //                           recommendation.value.toString(), 10),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             }),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            pw.Container(width: 230, child: pw.Divider(thickness: 0.1, color: PdfColors.grey)),
            pw.Container(
              width: 280,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 0, top: 5),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // regular("${Delivery_challan_noteList.length + 2}.", 10),
                        // pw.SizedBox(width: 5),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Padding(
                                child: bold(dcController.dcModel.recommendationHeadingController.value.text, 10),
                                padding: const pw.EdgeInsets.only(left: 0, bottom: 5),
                              ),
                              ...dcController.dcModel.Dc_recommendationList.asMap().entries.map((entry) {
                                final index = entry.key;
                                final recommendation = entry.value;
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(top: 5),
                                  child: pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    children: [
                                      regular("${index + 1}.", 10),
                                      pw.SizedBox(width: 5),
                                      pw.Padding(
                                        child: bold(recommendation.key.toString(), 10),
                                        padding: const pw.EdgeInsets.only(left: 0, right: 5),
                                      ),
                                      pw.Text(":", style: const pw.TextStyle(fontSize: 10)),
                                      pw.SizedBox(width: 5),
                                      pw.Expanded(
                                        child: regular(recommendation.value.toString(), 10),
                                      ),
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
            ),
          ],
        ),
        pw.SizedBox(
          width: 110,
        ),
        authorized_signatory(context)
      ],
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
