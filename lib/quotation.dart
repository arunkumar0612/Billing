// import 'dart:io';
// // import 'dart:typed_data';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart' show Uint8List, rootBundle;
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// // import 'package:printing/printing.dart';
// import 'package:intl/intl.dart';

// Future<void> quotationmain() async {
//   final pdfData = await generateInvoice(PdfPageFormat.a4);
//   await savePdfToNetwork(pdfData);
//   // await Printing.sharePdf(bytes: pdfData, filename: 'invoice.pdf');
// }

// // Future<void> savePdfToNetwork(Uint8List pdfData) async {
// //   try {
// //     const networkPath = '\\\\192.168.0.198\\backup\\Hari\\invoice.pdf';

// //     final file = File(networkPath);

// //     await file.writeAsBytes(pdfData);

// //     if (kDebugMode) {
// //       print('PDF saved to $networkPath');
// //     }
// //   } catch (e) {
// //     if (kDebugMode) {
// //       print('Error saving PDF: $e');
// //     }
// //   }
// // }

// Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
//   final products = <Product>[
//     const Product('19874', "Two way communication", 17500, 2),
//     const Product('98452', "40 W - VoIP / IP Based Horn Loud speaker", 18500, 4),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//     const Product('28375', "Installation charges", 1500, 6),
//   ];

//   final invoice = Invoice(
//     invoiceNumber: '982347',
//     products: products,
//     customerName: 'ANAMALLAIS AGENCIES',
//     customerAddress: '166/5, Chennai Main Road, Koranattu Karuppur, 166/5, Chennai Main Road, Koranattu Karuppur,Kumbakonam - 612501 ',
//     paymentInfo: 'Pre-paid',
//     tax: .09,
//     CGST: .09,
//     SGST: .09,
//     baseColor: PdfColors.green500,
//     accentColor: PdfColors.blueGrey900,
//   );

//   return await invoice.buildPdf(pageFormat);
// }

// class Invoice {
//   Invoice({
//     required this.products,
//     required this.customerName,
//     required this.customerAddress,
//     required this.invoiceNumber,
//     required this.tax,
//     required this.CGST,
//     required this.SGST,
//     required this.paymentInfo,
//     required this.baseColor,
//     required this.accentColor,
//   });

//   final List<Product> products;
//   final String customerName;
//   final String customerAddress;
//   final String invoiceNumber;
//   final double CGST;
//   final double SGST;
//   final double tax;
//   final String paymentInfo;
//   final PdfColor baseColor;
//   final PdfColor accentColor;

//   static const _darkColor = PdfColors.blueGrey800;
//   static const _lightColor = PdfColors.white;
//   PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;
//   double get _total => products.map<double>((p) => p.total).reduce((a, b) => a + b);
//   double get _grandTotal => _total * (1 + tax);
//   dynamic profileImage;

//   Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
//     final doc = pw.Document();
//     profileImage = pw.MemoryImage(
//       (await rootBundle.load('assets/images/sporada.jpeg')).buffer.asUint8List(),
//     );

//     doc.addPage(
//       pw.MultiPage(
//         pageTheme: pw.PageTheme(
//           pageFormat: pageFormat.copyWith(
//             marginLeft: 15, // Set the desired margin
//             marginRight: 15,
//             marginTop: 0,
//             marginBottom: 15,
//           ),
//         ),
//         footer: _address,
//         header: _buildHeader,
//         build: (context) => [
//           _contentTable(context),
//           pw.SizedBox(height: 20),
//           _termsAndConditions(context),
//         ],
//       ),
//     );

//     return doc.save();
//   }

//   pw.Widget _buildHeader(pw.Context context) {
//     return pw.Column(
//       children: [
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.start,
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Container(
//               // alignment: pw.Alignment.topLeft,
//               padding: const pw.EdgeInsets.only(bottom: 0, left: 0),
//               height: 120,
//               width: 200,

//               child: pw.Image(profileImage),
//             ),
//             pw.Expanded(
//               child: pw.Column(
//                 children: [
//                   pw.SizedBox(height: 45),
//                   pw.Container(
//                     padding: const pw.EdgeInsets.only(left: 170, top: 0, bottom: 0, right: 0),
//                     alignment: pw.Alignment.centerRight,
//                     height: 50,
//                     child: pw.GridView(
//                       crossAxisCount: 2,
//                       children: [
//                         pw.Text('Invoice :'),
//                         pw.Text(invoiceNumber),
//                         pw.Text('Date :'),
//                         pw.Text(_formatDate(DateTime.now())),
//                         pw.Text('POF :'),
//                         pw.Text('AT/PO/CBE/0032'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         pw.Container(child: to_adddr(context)),
//         pw.SizedBox(height: 20)
//       ],
//     );
//   }

//   pw.Widget notes(pw.Context context) {
//     return pw.Row(
//       mainAxisAlignment: pw.MainAxisAlignment.start, // Align the container to the right
//       children: [
//         pw.SizedBox(width: 20),
//         pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//           pw.Container(
//             height: 30,
//             width: 225,
//             child: pw.BarcodeWidget(
//               barcode: pw.Barcode.pdf417(),
//               data: 'Invoice# $invoiceNumber',
//               drawText: false,
//             ),
//           ),
//           // pw.SizedBox(height: 10),
//           // pw.Text("Scan for payment", style: const pw.TextStyle(fontSize: 13)),
//         ])
//       ],
//     );
//   }

//   pw.Widget _termsAndConditions(pw.Context context) {
//     return pw.Row(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         // pw.Expanded(child: pw.Container(), flex: 1),

//         pw.Container(
//           width: 290,
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Padding(
//                 child: pw.Text(
//                   'Note',
//                   style: pw.TextStyle(
//                     fontSize: 12,
//                     color: baseColor,
//                     // fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//                 padding: const pw.EdgeInsets.only(left: 10, bottom: 10),
//               ),
//               // First note item
//               pw.Padding(
//                 padding: const pw.EdgeInsets.only(left: 10),
//                 child: pw.Row(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       "1.",
//                       style: const pw.TextStyle(
//                         fontSize: 10,
//                         color: _darkColor,
//                       ),
//                     ),
//                     pw.SizedBox(width: 5), // Space between number and text
//                     pw.Expanded(
//                       child: pw.Text(
//                         "Materials will be installed within 14 working days from the date of purchase order receipt.",
//                         textAlign: pw.TextAlign.justify,
//                         style: const pw.TextStyle(
//                           fontSize: 10,
//                           color: _darkColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Second note item
//               pw.Padding(
//                 padding: const pw.EdgeInsets.only(left: 10, top: 5),
//                 child: pw.Row(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       "2.",
//                       style: const pw.TextStyle(
//                         fontSize: 10,
//                         color: _darkColor,
//                       ),
//                     ),
//                     pw.SizedBox(width: 5),
//                     pw.Expanded(
//                       child: pw.Text(
//                         "The client needs to provide the UPS power supply and LAN cable at the point where the device is proposed to install.",
//                         textAlign: pw.TextAlign.justify,
//                         style: const pw.TextStyle(
//                           fontSize: 10,
//                           color: _darkColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Third note item (Bank Details)
//               pw.Padding(
//                 padding: const pw.EdgeInsets.only(left: 10, top: 5),
//                 child: pw.Row(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       "3.",
//                       style: const pw.TextStyle(
//                         fontSize: 10,
//                         color: _darkColor,
//                       ),
//                     ),
//                     pw.SizedBox(width: 5),
//                     pw.Expanded(
//                       child: pw.Text(
//                         "Bank Account Details :\n     Current a/c : 5924757234723\n     IFSC code : \n     Bank name : IndusInd bank\n     Branch name : R.S. Puram, Coimbatore.",
//                         textAlign: pw.TextAlign.justify,
//                         style: const pw.TextStyle(
//                           fontSize: 10,
//                           color: _darkColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // pw.Padding(
//               //   padding: const pw.EdgeInsets.only(top: 10, left: 40),
//               //   child: pw.Container(
//               //     height: 30,
//               //     width: 125,
//               //     child: pw.BarcodeWidget(
//               //       barcode: pw.Barcode.pdf417(),
//               //       data: 'Invoice# $invoiceNumber',
//               //       drawText: false,
//               //     ),
//               //   ),
//               // )
//             ],
//           ),
//         ),
//         pw.SizedBox(width: 50),
//         pw.Expanded(
//           flex: 1,
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text('Sub Total:'),
//                   pw.Text(_formatCurrency(_total)),
//                 ],
//               ),
//               pw.SizedBox(height: 5),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text('CGST: 9%'),
//                   pw.Text(_formatCurrency(_total * CGST)),
//                 ],
//               ),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text('SGST: 9%'),
//                   pw.Text(_formatCurrency(_total * SGST)),
//                 ],
//               ),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text('Round off'),
//                   pw.Text(_formatCurrency(_total * SGST)),
//                 ],
//               ),
//               pw.Divider(color: accentColor),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text('Total:'),
//                   pw.Text(_formatCurrency(_grandTotal)),
//                 ],
//               ),
//               pw.SizedBox(
//                 height: 30,
//               ),
//               pw.Container(
//                 height: 70,
//                 width: 250, // You can adjust the width as needed
//                 decoration: const pw.BoxDecoration(
//                   border: pw.Border(
//                     top: pw.BorderSide(
//                       color: PdfColors.black,
//                       width: 1,
//                     ),
//                     bottom: pw.BorderSide(
//                       color: PdfColors.black,
//                       width: 1,
//                     ),
//                     left: pw.BorderSide(
//                       color: PdfColors.black,
//                       width: 1,
//                     ),
//                     right: pw.BorderSide(
//                       color: PdfColors.black,
//                       width: 1,
//                     ),
//                   ),
//                 ),
//                 child: pw.Align(
//                   alignment: pw.Alignment.bottomCenter,
//                   child: pw.Text(
//                     'Authorized Signatory',
//                     style: const pw.TextStyle(
//                       fontSize: 10,
//                       color: PdfColors.grey, // Set the text color to grey
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   pw.Widget to_adddr(pw.Context context) {
//     return pw.Row(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Expanded(
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Container(
//                 width: 275,
//                 height: 20,
//                 decoration: pw.BoxDecoration(
//                   borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
//                   color: baseColor,
//                   border: pw.Border.all(
//                     color: baseColor,
//                     width: 1,
//                   ),
//                 ),
//                 child: pw.Padding(
//                   padding: const pw.EdgeInsets.only(left: 15, top: 4),
//                   child: pw.Text(
//                     'CLIENT ADDRESS',
//                     style: const pw.TextStyle(
//                       fontSize: 10,
//                       color: PdfColors.white,
//                       // fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               pw.SizedBox(
//                 height: 10,
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.symmetric(horizontal: 10),
//                 child: pw.Text(
//                   'TRICHY ANAMALLAIS PVT LTD',
//                   textAlign: pw.TextAlign.start,
//                   style: const pw.TextStyle(
//                     fontSize: 10,
//                     lineSpacing: 2,
//                     color: _darkColor,
//                   ),
//                   softWrap: true, // Ensure text wraps within the container
//                 ),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.symmetric(horizontal: 10),
//                 child: pw.Text(
//                   "166/5, Chennai main road, Koranattu Karuppur, Kumbakonam - 612501",
//                   textAlign: pw.TextAlign.start,
//                   style: const pw.TextStyle(
//                     fontSize: 10,
//                     lineSpacing: 2,
//                     color: _darkColor,
//                   ),
//                   softWrap: true, // Ensure text wraps within the container
//                 ),
//               ),
//               pw.SizedBox(height: 4),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.symmetric(horizontal: 10),
//                 child: pw.Text(
//                   "GST : 33AACCT2782R1ZS",
//                   textAlign: pw.TextAlign.start,
//                   style: const pw.TextStyle(
//                     // font: pw.Font.courierBold(),
//                     fontSize: 10,
//                     lineSpacing: 2,
//                     color: _darkColor,
//                   ),
//                   softWrap: true, // Ensure text wraps within the container
//                 ),
//               ),
//             ],
//           ),
//         ),
//         pw.Expanded(
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Container(
//                 width: 275,
//                 height: 20,
//                 decoration: pw.BoxDecoration(
//                   borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
//                   color: baseColor,
//                   border: pw.Border.all(
//                     color: baseColor,
//                     width: 1,
//                   ),
//                 ),
//                 child: pw.Padding(
//                   padding: const pw.EdgeInsets.only(left: 15, top: 4),
//                   child: pw.Text(
//                     'BILLING ADDRESS',
//                     style: const pw.TextStyle(
//                       fontSize: 10,
//                       color: PdfColors.white,
//                       // fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               pw.SizedBox(
//                 height: 10,
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.symmetric(horizontal: 10),
//                 child: pw.Text(
//                   'TRICHY ANAMALLAIS PVT LTD',
//                   textAlign: pw.TextAlign.start,
//                   style: const pw.TextStyle(
//                     fontSize: 10,
//                     lineSpacing: 2,
//                     color: _darkColor,
//                   ),
//                   softWrap: true, // Ensure text wraps within the container
//                 ),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.symmetric(horizontal: 10),
//                 child: pw.Text(
//                   "166/5, Chennai main road, Koranattu Karuppur, Kumbakonam - 612501",
//                   textAlign: pw.TextAlign.start,
//                   style: const pw.TextStyle(
//                     fontSize: 10,
//                     lineSpacing: 2,
//                     color: _darkColor,
//                   ),
//                   softWrap: true, // Ensure text wraps within the container
//                 ),
//               ),
//               pw.SizedBox(height: 4),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.symmetric(horizontal: 10),
//                 child: pw.Text(
//                   "GST : 33AACCT2782R1ZS",
//                   textAlign: pw.TextAlign.start,
//                   style: const pw.TextStyle(
//                     // font: pw.Font.courierBold(),
//                     fontSize: 10,
//                     lineSpacing: 2,
//                     color: _darkColor,
//                   ),
//                   softWrap: true, // Ensure text wraps within the container
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   pw.Widget _address(pw.Context context) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.SizedBox(height: 20),
//         if (context.pagesCount > 1)
//           if (context.pageNumber < context.pagesCount)
//             pw.Column(
//               children: [
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.only(top: 20),
//                   child: pw.Text(
//                     'continue...',
//                     // textAlign: pw.TextAlign.justify,
//                     style: const pw.TextStyle(
//                       fontSize: 10,
//                       // lineSpacing: 2,
//                       color: _darkColor,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//         pw.Align(
//             alignment: pw.Alignment.center,
//             child: pw.Column(children: [
//               pw.Container(
//                 padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
//                 child: pw.Text(
//                   'SPORADA SECURE INDIA PRIVATE LIMITED',
//                   style: const pw.TextStyle(
//                     fontSize: 12,
//                     color: _darkColor,
//                     // fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//               ),
//               pw.Text(
//                 '687/7, 3rd Floor, Sakthivel Towers, Trichy road, Ramanathapuram, Coimbatore - 641045',
//                 // textAlign: pw.TextAlign.justify,
//                 style: const pw.TextStyle(
//                   fontSize: 10,
//                   // lineSpacing: 2,
//                   color: _darkColor,
//                 ),
//               ),
//               pw.Text(
//                 'Telephone: +91-422-2312363, E-mail: sales @ sporadasecure.com, Website: www.sporadasecure.com',
//                 // textAlign: pw.TextAlign.justify,
//                 style: const pw.TextStyle(
//                   fontSize: 10,
//                   // lineSpacing: 2,
//                   color: _darkColor,
//                 ),
//               ),
//               pw.SizedBox(height: 2),
//               pw.Text(
//                 'CIN: U30007TZ2020PTC03414 | GSTIN: 33ABECS0625B1Z0',
//                 // textAlign: pw.TextAlign.justify,
//                 style: const pw.TextStyle(
//                   fontSize: 9,
//                   // lineSpacing: 2,
//                   color: _darkColor,
//                 ),
//               ),
//               // pw.Align(
//               //   alignment: pw.Alignment.bottomCenter,
//               //   child: pw.Column(
//               //     crossAxisAlignment: pw.CrossAxisAlignment.start,
//               //     children: [
//               //       pw.Text(
//               //         'CIN-Number: U30007TZ2020PTC03414',
//               //         // textAlign: pw.TextAlign.justify,
//               //         style: const pw.TextStyle(
//               //           fontSize: 10,
//               //           // lineSpacing: 2,
//               //           color: _darkColor,
//               //         ),
//               //       ),
//               //       pw.Text(
//               //         'GSTIN: 33ABECS0625B1Z0',
//               //         // textAlign: pw.TextAlign.justify,
//               //         style: const pw.TextStyle(
//               //           fontSize: 10,
//               //           // lineSpacing: 2,
//               //           color: _darkColor,
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ]))
//       ],
//     );
//   }

//   pw.Widget _contentTable(pw.Context context) {
//     const tableHeaders = ['SKU#', 'Item Description', 'Price', 'Quantity', 'Total'];

//     return pw.TableHelper.fromTextArray(
//       border: null,
//       cellAlignment: pw.Alignment.centerLeft,
//       headerDecoration: pw.BoxDecoration(
//         borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
//         color: baseColor,
//       ),
//       headerHeight: 25,
//       cellHeight: 30,
//       cellAlignments: {
//         0: pw.Alignment.centerLeft,
//         1: pw.Alignment.centerLeft,
//         2: pw.Alignment.center,
//         3: pw.Alignment.center,
//         4: pw.Alignment.centerRight,
//       },
//       headerStyle: pw.TextStyle(
//         color: _baseTextColor,
//         fontSize: 10,
//         // fontWeight: pw.FontWeight.bold,
//       ),
//       cellStyle: const pw.TextStyle(
//         color: _darkColor,
//         fontSize: 10,
//       ),
//       rowDecoration: pw.BoxDecoration(
//         border: pw.Border(
//           bottom: pw.BorderSide(
//             color: accentColor,
//             width: .5,
//           ),
//         ),
//       ),
//       headers: List<String>.generate(
//         tableHeaders.length,
//         (col) => tableHeaders[col],
//       ),
//       data: List<List<String>>.generate(
//         products.length,
//         (row) => List<String>.generate(
//           tableHeaders.length,
//           (col) => products[row].getIndex(col),
//         ),
//       ),
//     );
//   }
// }

// String _formatCurrency(double amount) {
//   return 'Rs.${amount.toStringAsFixed(2)}';
// }

// String _formatDate(DateTime date) {
//   final format = DateFormat.yMMMd('en_US');
//   return format.format(date);
// }

// class Product {
//   const Product(
//     this.sku,
//     this.productName,
//     this.price,
//     this.quantity,
//   );

//   final String sku;
//   final String productName;
//   final double price;
//   final int quantity;
//   double get total => price * quantity;

//   String getIndex(int index) {
//     switch (index) {
//       case 0:
//         return sku;
//       case 1:
//         return productName;
//       case 2:
//         return _formatCurrency(price);
//       case 3:
//         return quantity.toString();
//       case 4:
//         return _formatCurrency(total);
//     }
//     return '';
//   }
// }
