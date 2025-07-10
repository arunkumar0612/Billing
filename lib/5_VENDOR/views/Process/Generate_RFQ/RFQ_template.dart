import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ssipl_billing/5_VENDOR/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/product_entities.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

Future<Uint8List> generate_RFQ(
  PdfPageFormat pageFormat,
  products,
  to_addr_name,
  to_email,
  to_phone,
  to_addr,
  RFQ_num,
) async {
  final RFQ = Request_for_quote(
    products: products,
    baseColor: PdfColors.green500,
    accentColor: PdfColors.blueGrey900,
    company_addr_name: "SPORADA SECURE INDIA PRIVATE LIMITED",
    company_email: 'Email : sales@sporadasecure.com',
    company_phone: "Phone : +91-422-2312363",
    company_addr: "Address : 687/7, 3rd Floor, Sakthivel Towers, Trichy road, Ramanathapuram, Coimbatore - 641045",
    RFQ_no: RFQ_num,
    to_addr_name: "PREMIER ELEKTRICALS",
    to_email: 'Email : premierelektricals@gmail.com',
    to_phone: "Phone : 04252-2311229842214563",
    to_addr: "Address : 171, Palani Road,Udumalpet, 642154",
  );

  return await RFQ.buildPdf(pageFormat);
}

class Request_for_quote {
  Request_for_quote(
      {required this.RFQ_no,
      required this.baseColor,
      required this.accentColor,
      required this.company_addr_name,
      required this.company_email,
      required this.company_phone,
      required this.company_addr,
      required this.to_addr_name,
      required this.to_email,
      required this.to_phone,
      required this.to_addr,
      required this.products
      // required this.items,
      });
  final vendor_RfqController rfqController = Get.find<vendor_RfqController>();

  String company_addr_name = "";
  String company_email = "";
  String company_phone = "";
  String company_addr = "";
  String to_addr_name = "";
  String to_email = "";
  String to_phone = "";
  String to_addr = "";
  final List<RFQProduct> products;
  final String RFQ_no;
  final PdfColor baseColor;
  final PdfColor accentColor;
  static const _darkColor = PdfColors.blueGrey800;
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
            marginLeft: 15, // Set the desired margin
            marginRight: 15,
            marginTop: 0,
            marginBottom: 15,
          ),
        ),
        header: header,
        build: (context) => [
          pw.SizedBox(height: 5),
          pw.Container(child: adddr(context)),
          pw.SizedBox(height: 20),
          pw.SizedBox(height: 10),
          title(context),
          pw.SizedBox(height: 10),
          _contentTable(context),
          // pw.Divider(
          //   color: PdfColors.grey500,
          //   thickness: 0.2,
          // ),
          pw.SizedBox(height: 10),
          tax_tabl(context),
        ],
      ),
    );

    return doc.save();
  }

  pw.Widget header(pw.Context context) {
    return pw.Container(
      // height: 220,
      child: pw.Column(
        children: [
          pw.SizedBox(height: 5),
          pw.Padding(
            padding: const pw.EdgeInsets.only(right: 5),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 0, left: 0),
                  height: 100,
                  child: pw.Image(profileImage),
                ),
                pw.Text(
                  'REQUEST FOR QUOTATION',
                  style: pw.TextStyle(
                    font: Helvetica_bold,
                    fontSize: 15,
                    color: PdfColors.blueGrey800,
                    // fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Container(
                    height: 100,
                    child: pw.Row(children: [
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          regular('Date', 10),
                          pw.SizedBox(height: 5),
                          regular('RFQ no', 10),
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
                            // width: 100,
                            child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: bold(RFQ_no, 10),
                            ),
                          ),
                        ],
                      ),
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget adddr(pw.Context context) {
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
                        'FROM ADDRESS',
                        style: pw.TextStyle(
                          font: Helvetica_bold,
                          // fontWeight: pw.FontWeight.bold,
                          fontSize: 10,

                          color: PdfColors.white,
                        ),
                        // softWrap: true, // Ensure text wraps within the container
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
                  company_addr_name,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: Helvetica_bold,
                    fontSize: 10,
                    lineSpacing: 2,
                    color: _darkColor,
                  ),
                  softWrap: true, // Ensure text wraps within the container
                ),
              ),
              pw.SizedBox(
                height: 4,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  company_email,
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
              pw.SizedBox(
                height: 4,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  company_phone,
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
              pw.SizedBox(
                height: 4,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  company_addr,
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
              // pw.SizedBox(height: 4),
              // pw.Padding(
              //   padding: const pw.EdgeInsets.symmetric(horizontal: 10),
              //   child: pw.Text(
              //     "GSTIN : ",
              //     textAlign: pw.TextAlign.start,
              //     style: pw.TextStyle(
              //       font: Helvetica,
              //       // font: pw.Font.courierBold(),
              //       fontSize: 10,
              //       lineSpacing: 2,
              //       color: _darkColor,
              //     ),
              //     softWrap: true, // Ensure text wraps within the container
              //   ),
              // ),
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
                        'VENDOR ADDRESS',

                        style: pw.TextStyle(
                          font: Helvetica_bold,
                          // fontWeight: pw.FontWeight.bold,
                          fontSize: 10,

                          color: PdfColors.white,
                        ),
                        // softWrap: true, // Ensure text wraps within the container
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
                  to_addr_name,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: Helvetica_bold,
                    fontSize: 10,
                    lineSpacing: 2,
                    color: _darkColor,
                  ),
                  softWrap: true, // Ensure text wraps within the container
                ),
              ),
              pw.SizedBox(
                height: 4,
              ),

              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  to_email,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: Helvetica,
                    fontSize: 8,
                    lineSpacing: 2,
                    color: _darkColor,
                  ),
                  softWrap: true, // Ensure text wraps within the container
                ),
              ),
              pw.SizedBox(
                height: 4,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  to_phone,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: Helvetica,
                    fontSize: 8,
                    lineSpacing: 2,
                    color: _darkColor,
                  ),
                  softWrap: true, // Ensure text wraps within the container
                ),
              ),
              pw.SizedBox(
                height: 4,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  to_addr,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: Helvetica,
                    fontSize: 8,
                    lineSpacing: 2,
                    color: _darkColor,
                  ),
                  softWrap: true, // Ensure text wraps within the container
                ),
              ),
              // pw.SizedBox(height: 4),
              // pw.Padding(
              //   padding: const pw.EdgeInsets.symmetric(horizontal: 10),
              //   child: pw.Text(
              //     "GSTIN : ",
              //     textAlign: pw.TextAlign.start,
              //     style: pw.TextStyle(
              //       font: Helvetica,
              //       // font: pw.Font.courierBold(),
              //       fontSize: 10,
              //       lineSpacing: 2,
              //       color: _darkColor,
              //     ),
              //     softWrap: true, // Ensure text wraps within the container
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget title(pw.Context context) {
    return pw.Center(child: bold('PRODUCT LIST', 12));
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = ['S.No', 'Item Description', 'Quantity'];

    return pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 30,
      columnWidths: {
        0: const pw.FlexColumnWidth(1), // S.No
        1: const pw.FlexColumnWidth(5), // Item Description
        2: const pw.FlexColumnWidth(2), // Quantity
      },
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
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
      headers: List<String>.from(tableHeaders),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget tax_tabl(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // pw.Expanded(child: pw.Container(), flex: 1),

            notes(context),

            // 995461
          ],
        ),
      ],
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
            child: bold("INSTRUCTIONS", 12),
            padding: const pw.EdgeInsets.only(left: 0, bottom: 10),
          ),
          // First note item
          ...List.generate(rfqController.rfqModel.Rfq_noteList.length, (index) {
            return pw.Padding(
              padding: pw.EdgeInsets.only(left: 0, top: index == 0 ? 0 : 8),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  regular("${index + 1}.", 10),
                  pw.SizedBox(width: 5),
                  pw.Expanded(
                    child: pw.Text(
                      rfqController.rfqModel.Rfq_noteList[index],
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
          if (rfqController.rfqModel.Rfq_recommendationList.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 0, top: 8),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  regular("${rfqController.rfqModel.Rfq_noteList.length + 1}.", 10),
                  pw.SizedBox(width: 5),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        bold(rfqController.rfqModel.recommendationHeadingController.value.text, 10),
                        ...rfqController.rfqModel.Rfq_recommendationList.map((recommendation) {
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
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 0, top: 8),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                regular("${rfqController.rfqModel.Rfq_noteList.length + (rfqController.rfqModel.Rfq_recommendationList.isEmpty ? 1 : 2)}.", 10),
                pw.SizedBox(width: 5),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      bold("Send Quotation to", 10),
                      // pw.SizedBox(height: 8), // Adds a small space between the lines

                      pw.Padding(
                        padding: const pw.EdgeInsets.only(
                          left: 5,
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 5),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 50,
                                  child: regular("Email", 10),
                                ),
                                regular(":", 10),
                                pw.SizedBox(width: 5),
                                regular("sales@sporadasecure.com", 10),
                              ],
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 50,
                                  child: regular("Address", 10),
                                ),
                                regular(":", 10),
                                pw.SizedBox(width: 5),
                                regular("687/7, 3rd Floor, Sakthivel Towers, Trichy road, Ramanathapuram, Coimbatore - 641045", 10),
                              ],
                            ),
                          ],
                        ),
                      )
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
}
