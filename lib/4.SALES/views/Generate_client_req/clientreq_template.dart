import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ssipl_billing/4.SALES/models/entities/product_entities.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

import '../../controllers/ClientReq_actions.dart';

Future<Uint8List> generateClientReq({
  required PdfPageFormat pageFormat,
  required List<ClientreqProduct> products,
  required String clientAddrName,
  required String clientAddr,
  required String billAddrName,
  required String billAddr,
  required String chosenFilepath,
}) async {
  final clientreq = Client_requirement(
      products: products,
      baseColor: PdfColors.green500,
      accentColor: PdfColors.blueGrey900,
      client_addr_name: clientAddrName,
      client_addr: clientAddr,
      bill_addr_name: billAddrName,
      bill_addr: billAddr,
      imagePath: chosenFilepath);
  return await clientreq.buildPdf(pageFormat);
}

class Client_requirement {
  Client_requirement(
      {required this.products,
      required this.baseColor,
      required this.accentColor,
      required this.client_addr_name,
      required this.client_addr,
      required this.bill_addr_name,
      required this.bill_addr,
      required this.imagePath});
  final ClientreqController clientreqController = Get.find<ClientreqController>();

  String client_addr_name = "";
  String client_addr = "";
  String bill_addr_name = "";
  String bill_addr = "";
  final List<ClientreqProduct> products;
  final PdfColor baseColor;
  final PdfColor accentColor;
  static const _darkColor = PdfColors.blueGrey800;
  dynamic profileImage;
  dynamic mode_of_req;
  dynamic width;
  dynamic height;
  String imagePath = "";

  Future<void> getImageResolution() async {
    var file = File(imagePath);

    if (await file.exists()) {
      List<int> imageBytes = await file.readAsBytes();
      Uint8List uint8List = Uint8List.fromList(imageBytes);
      img.Image? image = img.decodeImage(uint8List);

      if (image != null) {
        {
          width = image.width;
          height = image.height;
        }
        if (kDebugMode) {
          print("h:$height , w:$width");
        }
      } else {
        if (kDebugMode) {
          print('File does not exist at path: $imagePath');
        }
      }
    }
  }

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    await getImageResolution();
    Helvetica = await loadFont_regular();
    Helvetica_bold = await loadFont_bold();
    final doc = pw.Document();
    profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/sporada.jpeg')).buffer.asUint8List(),
    );
    final imageBytes = File(imagePath).readAsBytesSync();

    mode_of_req = pw.MemoryImage(imageBytes);
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
          to_adddr(context),
          pw.SizedBox(height: 10),
          _contentTable(context),
          pw.SizedBox(height: 20),
          notes(context),
        ],
      ),
    );

    return doc.save();
  }

  //
  pw.Widget header(pw.Context context) {
    return pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
      pw.Padding(padding: const pw.EdgeInsets.all(20), child: bold("CLIENT REQUEST", 15)),
    ]);
  }

  pw.Widget to_adddr(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: 0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // pw.Container(
          //   height: 90,
          //   child: pw.Image(profileImage),
          // ),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 20, bottom: 6), child: bold(clientreqController.clientReqModel.clientNameController.value.text, 12)),
          // bold("SPORADA SECURE PVT LTD", 13),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // pw.SizedBox(height: 5),
              pw.SizedBox(height: 5),
              pw.Row(
                children: [
                  pw.Container(
                    width: 75,
                    child: regular("Date", 10),
                  ),
                  regular(":", 10),
                  pw.SizedBox(width: 5),
                  pw.Container(width: 400, child: regular(formatDate(DateTime.now()), 10)),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                children: [
                  pw.Container(
                    width: 75,
                    child: regular("Telephone", 10),
                  ),
                  regular(":", 10),
                  pw.SizedBox(width: 5),
                  regular(clientreqController.clientReqModel.phoneController.value.text, 10),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                children: [
                  pw.Container(
                    width: 75,
                    child: regular("E-mail", 10),
                  ),
                  regular(":", 10),
                  pw.SizedBox(width: 5),
                  regular(clientreqController.clientReqModel.emailController.value.text, 10),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                children: [
                  pw.Container(
                    width: 75,
                    child: regular("Address", 10),
                  ),
                  regular(":", 10),
                  pw.SizedBox(width: 5),
                  pw.Container(width: 400, child: regular(clientreqController.clientReqModel.clientAddressController.value.text, 10)),
                ],
              ),
              pw.SizedBox(height: 5),

              pw.Row(
                children: [
                  pw.Container(
                    width: 75,
                    child: regular("GST", 10),
                  ),
                  regular(":", 10),
                  pw.SizedBox(width: 5),
                  pw.Container(width: 400, child: regular(clientreqController.clientReqModel.gstController.value.text, 10)),
                ],
              ),
              pw.SizedBox(height: 5),

              pw.Row(
                children: [
                  pw.Container(
                    width: 75,
                    child: regular("Mode of request", 10),
                  ),
                  regular(":", 10),
                  pw.SizedBox(width: 5),
                  pw.Container(width: 400, child: regular(clientreqController.clientReqModel.morController.value.text, 10)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'S.No',
      'Item Description',
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

      // ✅ Added Flex Widths
      columnWidths: {
        0: const pw.FlexColumnWidth(1), // S.No (small)
        1: const pw.FlexColumnWidth(5), // Item Description (wide)
        2: const pw.FlexColumnWidth(2), // Quantity (medium)
      },

      cellAlignments: {
        0: pw.Alignment.center, // S.No center
        1: pw.Alignment.centerLeft, // Item Description left
        2: pw.Alignment.center, // Quantity center
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
        (row) => [
          (row + 1).toString(), // Generate row number (S.No)
          products[row].productName.toString(), // Item Description
          products[row].quantity.toString(), // Quantity
        ],
      ),
    );
  }

  pw.Widget notes(pw.Context context) {
    return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Container(
        width: 600,
        // width: width > height ? 250 : 300,
        // height: 500,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // pw.SizedBox(height: 30),
            pw.Padding(
              child: bold("Note", 12),
              padding: const pw.EdgeInsets.only(left: 0, bottom: 10),
            ),
            ...List.generate(clientreqController.clientReqModel.clientReqNoteList.length, (index) {
              return pw.Padding(
                padding: pw.EdgeInsets.only(left: 0, top: index == 0 ? 0 : 8),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    regular("${index + 1}.", 10),
                    pw.SizedBox(width: 5),
                    pw.Expanded(
                      child: pw.Text(
                        clientreqController.clientReqModel.clientReqNoteList[index],
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
          ],
        ),
      ),
      pw.SizedBox(height: 10),
      modeOf_request(context),
      pw.SizedBox(width: 10),
    ]);
  }

  pw.Widget modeOf_request(pw.Context context) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(right: 10),
        child: pw.Container(
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(10),
              color: PdfColors.grey,
            ),
            child: pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Container(
                  height: height > width ? 320 : 200,
                  width: width > height ? 300 : 200,
                  child: pw.ClipRRect(horizontalRadius: 10, verticalRadius: 10, child: pw.Image(mode_of_req, fit: pw.BoxFit.fill)),
                ))));
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
        ),
      ],
    );
  }
}
