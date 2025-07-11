// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/TDS_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/services/TDS_ledger_service.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/services/view_ledger_service.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/views/ViewLedger.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/views/ledger_PDF_template/TDS_ledger_pdf_template.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/views/ledger_excel_template/TDS_ledger_excel_template.dart';
import 'package:ssipl_billing/2_BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2_BILLING/_main_BILLING/services/billing_services.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/downloadPDF.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/printPDF.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/sharePDF.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/showPDF.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

class TDSLedger extends StatefulWidget with TDS_LedgerService, View_LedgerService, main_BillingService {
  TDSLedger({super.key});

  @override
  State<TDSLedger> createState() => _TDSLedgerState();
}

class _TDSLedgerState extends State<TDSLedger> {
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final TDS_LedgerController tds_ledgerController = Get.find<TDS_LedgerController>();
  final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();

  List<String> tds_ledger_type_list = ['Consolidated TDS', 'Input TDS', 'Output TDS'];
  String? Selected_ledger_type = 'Consolidated TDS';

  final loader = LoadingOverlay();
  @override
  void initState() {
    super.initState();
    // Avoid using context here for inherited widgets.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startInitialization();
  }

  bool _initialized = false;

  void _startInitialization() async {
    if (_initialized) return;
    _initialized = true;
    await Future.delayed(const Duration(milliseconds: 100));
    loader.start(context); // Now safe to use
    await widget.Get_SUBcustomerList();
    await widget.Get_SALEScustomerList(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.resettds_LedgerFilters();
    });
    await widget.get_TDS_LedgerList();
    await Future.delayed(const Duration(seconds: 0));
    loader.stop();
  }

  @override
  Widget build(BuildContext context) {
    loader.stop();
    return Obx(
      () {
        return Column(
          children: [
            Container(
              // height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Primary_colors.Color3, Primary_colors.Color3], // Example gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10), // Ensure border radius for smooth corners
              ),
              child: const Padding(
                padding: EdgeInsets.all(0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'S.No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Date',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Voucher No',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Invoice No',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'PAN No',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Particulars',
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'TDS Type',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Invoice Amount(\u20B9)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Debit(\u20B9)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Credit(\u20B9)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList.isNotEmpty
                ? Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          // flex: 3,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Container(
                              height: 1,
                              color: const Color.fromARGB(94, 125, 125, 125),
                            ),
                            itemCount: tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Primary_colors.Light,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: const BoxDecoration(),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  (index + 1).toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Primary_colors.Color1,
                                                    fontSize: Primary_font_size.Text7,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                formatDate(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].rowUpdatedDate),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                          ),
                                          // Vertical line after 'Date' column

                                          // Vertical line after 'Reference No' column
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        widget.get_VoucherDetails(context, tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].voucherId);
                                                      },
                                                      child: Text(
                                                        tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].voucherNumber,
                                                        textAlign: TextAlign.end,
                                                        style: const TextStyle(color: Colors.blue, fontSize: Primary_font_size.Text7),
                                                      ),
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   textAlign: TextAlign.center,
                                                  //   account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].invoiceNumber,
                                                  //   style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          if (tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].invoiceType == 'subscription') {
                                                            bool success = await widget.GetSubscriptionPDFfile(
                                                                context: context, invoiceNo: tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].invoice_number);
                                                            if (success) {
                                                              showPDF(context, tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].invoice_number,
                                                                  mainBilling_Controller.billingModel.pdfFile.value);
                                                            }
                                                          }
                                                        },
                                                        child: Text(
                                                          tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].invoice_number,
                                                          style: const TextStyle(color: Colors.blue, fontSize: Primary_font_size.Text7),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      extractPanFromGst(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].gstNumber),
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          // Vertical line after 'clientname' column
                                          Expanded(
                                            flex: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                textAlign: TextAlign.start,
                                                tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].description ?? "-",
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].tdsType,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                          ),
                                          // Vertical line after 'Debit' column
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                formatCurrency(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].totalAmount),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                formatCurrency(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].debitAmount),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                formatCurrency(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.tdsList[index].creditAmount),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Row(children: [
                         Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Share Button
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () async {
                                            final pdfBytes = await generateTDSledger(PdfPageFormat.a4, tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value);
                                            Directory tempDir = await getTemporaryDirectory();
                                            String fileName =
                                                ('TDS_LEDGER(${tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value != "" ? formatDate(DateTime.parse(tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value)) : formatDate(DateTime.now())} - ${tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value != "" ? formatDate(DateTime.parse(tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value)) : formatDate(DateTime.now())})');
                                            String filePath = '${tempDir.path}/$fileName.pdf';
                                            File file = File(filePath);
                                            await file.writeAsBytes(pdfBytes);
                                            shareAnyPDF(context, filePath, file);
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(height: 25, 'assets/images/share.png'),
                                              const SizedBox(height: 6),
                                              const Text(
                                                "Share",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(255, 143, 143, 143),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                    const SizedBox(width: 40), // Space between buttons

                                    // Download Button
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () async {
                                          final pdfBytes = await generateTDSledger(PdfPageFormat.a4, tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value);
                                          printPDF(context, pdfBytes);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(height: 30, 'assets/images/printer.png'),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              "Print",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(255, 143, 143, 143),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 40),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () async {
                                          final pdfBytes = await generateTDSledger(PdfPageFormat.a4, tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value);
                                          String fileName =
                                              ('TDS_LEDGER(${tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value != "" ? formatDate(DateTime.parse(tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value)) : formatDate(DateTime.now())} - ${tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value != "" ? formatDate(DateTime.parse(tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value)) : formatDate(DateTime.now())})');
                                          final directory = await getTemporaryDirectory();
                                          final filePath = '${directory.path}/$fileName.pdf';
                                          final pdfFile = await File(filePath).writeAsBytes(pdfBytes);
                                          showPDF(context, fileName, pdfFile);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(height: 30, 'assets/images/pdfdownload.png'),
                                            const SizedBox(height: 5),
                                            const Text(
                                              "View",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(255, 143, 143, 143),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ), // Space between buttons
                                    // Download Button
                                    const SizedBox(width: 40), // Space between buttons

                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          popupMenuTheme: PopupMenuThemeData(
                                            color: Primary_colors.Light, // Dropdown background color
                                            textStyle: const TextStyle(
                                              color: Colors.white, // Default text color
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        child: PopupMenuButton<String>(
                                          tooltip: '',
                                          onSelected: (value) async {
                                            if (value == 'pdf') {
                                              final pdfBytes = await generateTDSledger(PdfPageFormat.a4, tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value);
                                              Directory tempDir = await getTemporaryDirectory();
                                              String fileName =
                                                  ('TDS_LEDGER(${tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value != "" ? formatDate(DateTime.parse(tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value)) : formatDate(DateTime.now())} - ${tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value != "" ? formatDate(DateTime.parse(tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value)) : formatDate(DateTime.now())})');
                                              String filePath = '${tempDir.path}/$fileName.pdf';
                                              File file = File(filePath);
                                              await file.writeAsBytes(pdfBytes);
                                              downloadPdf(context, fileName, file);
                                            } else if (value == 'excel') {
                                              final excelBytes = await TDSledger_excelTemplate(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value);
                                              Directory tempDir = await getTemporaryDirectory();
                                              String fileName =
                                                  ('TDS_LEDGER(${tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value != "" ? formatDate(DateTime.parse(tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.fromdate.value)) : formatDate(DateTime.now())} - ${tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value != "" ? formatDate(DateTime.parse(tds_ledgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.todate.value)) : formatDate(DateTime.now())})');
                                              String filePath = '${tempDir.path}/$fileName.xlsx';
                                              File file = File(filePath);
                                              await file.writeAsBytes(excelBytes);
                                              downloadExcel(context, fileName, file);
                                            }
                                          },
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 'pdf',
                                              child: Row(
                                                children: [
                                                  Image.asset('assets/images/pdfdownload.png', width: 20, height: 20),
                                                  const SizedBox(width: 10),
                                                  const Text('Download PDF'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'excel',
                                              child: Row(
                                                children: [
                                                  Image.asset('assets/images/excel.png', width: 20, height: 20),
                                                  const SizedBox(width: 10),
                                                  const Text('Download Excel'),
                                                ],
                                              ),
                                            ),
                                          ],
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/download.png',
                                                    height: 25,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 20,
                                                    color: Color.fromARGB(255, 143, 143, 143),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                "Download",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(255, 143, 143, 143),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    flex: 11,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: SizedBox(
                                      height: 5,
                                      child: CustomPaint(
                                        painter: DottedLinePainter(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 100,),
                                  Expanded(
                                    flex: 16,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Expanded(
                                            flex: 2,
                                            child: Stack(
                                              children: [
                                                // Bottom shadow for the recessed effect
                                                Text(
                                                  formatCurrency(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.totalPayables),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0,
                                                    color: Colors.white.withOpacity(0.2),
                                                    shadows: const [
                                                      Shadow(
                                                        offset: Offset(2, 2),
                                                        blurRadius: 2,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Top layer to give the 3D embossed effect
                                                Text(
                                                  formatCurrency(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.totalPayables),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0,
                                                    foreground: Paint()
                                                      ..shader = LinearGradient(
                                                        colors: [
                                                          Colors.black.withOpacity(0.8),
                                                          const Color.fromARGB(255, 255, 223, 0),
                                                        ],
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                      ).createShader(const Rect.fromLTWH(0, 0, 200, 100)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Stack(alignment: AlignmentDirectional.center,
                                              children: [
                                                // Bottom shadow for the recessed effect
                                                Text(
                                                  formatCurrency(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.totalReceivables),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0,
                                                    color: Colors.white.withOpacity(0.2),
                                                    shadows: const [
                                                      Shadow(
                                                        offset: Offset(2, 2),
                                                        blurRadius: 2,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Top layer to give the 3D embossed effect
                                                Text(
                                                  formatCurrency(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.totalReceivables),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0,
                                                    foreground: Paint()
                                                      ..shader = LinearGradient(
                                                        colors: [
                                                          Colors.black.withOpacity(0.8),
                                                          const Color.fromARGB(255, 255, 223, 0),
                                                        ],
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                      ).createShader(const Rect.fromLTWH(0, 0, 200, 100)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    flex: 11,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: SizedBox(
                                      height: 5,
                                      child: CustomPaint(
                                        painter: DottedLinePainter(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 80,
                                  ),
                                  Expanded(
                                    flex: 16,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Claimable(ITR)",
                                      style: TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Stack(alignment: AlignmentDirectional.center,
                                      children: [
                                        // Bottom shadow for the recessed effect
                                        Text(
                                          formatCurrency(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.totalTds),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0,
                                            color: Colors.white.withOpacity(0.2),
                                            shadows: const [
                                              Shadow(
                                                offset: Offset(2, 2),
                                                blurRadius: 2,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Top layer to give the 3D embossed effect
                                        Text(
                                          formatCurrency(tds_ledgerController.tds_LedgerModel.tds_Ledger_list.value.totalTds),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0,
                                            foreground: Paint()
                                              ..shader = LinearGradient(
                                                colors: [
                                                  Colors.black.withOpacity(0.8),
                                                  const Color.fromARGB(255, 255, 223, 0),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ).createShader(const Rect.fromLTWH(0, 0, 200, 100)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),)
                        ],),
                        
                        
                      ],
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Lottie.asset(
                              'assets/animations/JSON/emptyprocesslist.json',
                              // width: 264,
                              height: 150,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 164),
                            child: Text(
                              'No TDS Ledger Found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey[800],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 204),
                            child: Text(
                              'Generate a Voucher to see it listed here.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey[400],
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class TDS_ledger_filter extends StatefulWidget with TDS_LedgerService {
  TDS_ledger_filter({super.key});

  @override
  State<TDS_ledger_filter> createState() => _TDS_ledger_filterState();
}

class _TDS_ledger_filterState extends State<TDS_ledger_filter> {
  final TDS_LedgerController TDS_ledgerController = Get.find<TDS_LedgerController>();
  final View_LedgerController view_ledgerController = Get.find<View_LedgerController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter TDS Ledgers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Primary_colors.Color3),
        ),
        const Divider(height: 30, thickness: 1, color: Color.fromARGB(255, 97, 97, 97)),
        const SizedBox(height: 35),
        // Quick Date Filters
        const Text(
          'TDS type',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [Obx(() => _buildTDS_ledgertypeFilterChip('Show All')), Obx(() => _buildTDS_ledgertypeFilterChip('Payable')), Obx(() => _buildTDS_ledgertypeFilterChip('Receivable'))],
        ),
        const SizedBox(height: 35),

        // Product Type Filter
        const Text(
          'Invoice Type',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Wrap(
            spacing: 8,
            children: [
              FilterChip(
                showCheckmark: false,
                label: const Text('Show All'),
                selected: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Show All',
                onSelected: (_) {
                  TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value = 'Show All';
                  TDS_ledgerController.tds_LedgerModel.selectedsalescustomer.value = 'None';
                  TDS_ledgerController.tds_LedgerModel.selectedsubcustomer.value = 'None';
                  // widget.get_TDS_ledgerList();
                },
                backgroundColor: Primary_colors.Dark,
                selectedColor: Primary_colors.Dark,
                labelStyle: TextStyle(
                  fontSize: Primary_font_size.Text7,
                  color: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
                ),
              ),
              FilterChip(
                label: const Text('Sales'),
                selected: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Sales',
                onSelected: (_) {
                  TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value = 'Sales';
                  TDS_ledgerController.tds_LedgerModel.selectedsalescustomer.value = 'None';
                  TDS_ledgerController.tds_LedgerModel.selectedsubcustomer.value = 'None';
                  // widget.get_TDS_ledgerList();
                },
                backgroundColor: Primary_colors.Dark,
                showCheckmark: false,
                selectedColor: Primary_colors.Dark,
                labelStyle: TextStyle(
                  fontSize: Primary_font_size.Text7,
                  color: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Sales' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Sales' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
                ),
              ),
              FilterChip(
                label: const Text('Subscription'),
                selected: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Subscription',
                onSelected: (_) {
                  TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value = 'Subscription';
                  TDS_ledgerController.tds_LedgerModel.selectedsalescustomer.value = 'None';
                  TDS_ledgerController.tds_LedgerModel.selectedsubcustomer.value = 'None';
                  // widget.get_TDS_ledgerList();
                },
                backgroundColor: Primary_colors.Dark,
                showCheckmark: false,
                selectedColor: Primary_colors.Dark,
                labelStyle: TextStyle(
                  fontSize: Primary_font_size.Text7,
                  color: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Subscription' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Subscription' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => SizedBox(
            child: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Sales'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 35),
                      const Text(
                        'Select sales client',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        return SizedBox(
                          height: 35,
                          // width: 250,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color.fromARGB(255, 91, 90, 90), width: 1.0),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownSearch<String>(
                                    popupProps: PopupProps.menu(
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                          hintText: 'Search...',
                                          hintStyle: const TextStyle(fontSize: 12),
                                          prefixIcon: const Icon(Icons.search, size: 18),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                            borderSide: BorderSide(color: Colors.grey.shade300),
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                      menuProps: MenuProps(borderRadius: BorderRadius.circular(6.0), elevation: 3),
                                      constraints: const BoxConstraints.tightFor(height: 250), // Reduced popup height
                                    ),
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        iconColor: const Color.fromARGB(252, 162, 158, 158),
                                        // labelText: "Client",
                                        // labelStyle: TextStyle(
                                        //   color: Colors.grey.shade600,
                                        //   fontSize: 12,
                                        // ),
                                        floatingLabelStyle: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                      baseStyle: const TextStyle(
                                        fontSize: 12, // Smaller font size
                                        color: Color.fromARGB(255, 138, 137, 137),
                                      ),
                                    ),
                                    items: view_ledgerController.view_LedgerModel.salesCustomerList.map((customer) {
                                      return customer.customerName;
                                    }).toList(),
                                    selectedItem: TDS_ledgerController.tds_LedgerModel.selectedsalescustomer.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        TDS_ledgerController.tds_LedgerModel.selectedsalescustomer.value = value;
                                        final customerList = view_ledgerController.view_LedgerModel.salesCustomerList;

                                        // Find the index of the selected customer
                                        final index = customerList.indexWhere((customer) => customer.customerName == value);
                                        TDS_ledgerController.tds_LedgerModel.selectedcustomerID.value = view_ledgerController.view_LedgerModel.salesCustomerList[index].customerId;
                                        if (kDebugMode) {
                                          print('Selected customer ID: ${TDS_ledgerController.tds_LedgerModel.selectedcustomerID.value}');
                                        }
                                      }
                                    },
                                  ),
                                ),
                                Obx(
                                  () => SizedBox(
                                    child: TDS_ledgerController.tds_LedgerModel.selectedsalescustomer.value != 'None'
                                        ? IconButton(
                                            onPressed: () {
                                              TDS_ledgerController.tds_LedgerModel.selectedsalescustomer.value = 'None';
                                            },
                                            icon: const Icon(Icons.close, color: Colors.red, size: 18),
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  )
                : const SizedBox(),
          ),
        ),
        Obx(
          () => SizedBox(
            child: TDS_ledgerController.tds_LedgerModel.selectedInvoiceType.value == 'Subscription'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 35),
                      const Text(
                        'Select subscription customer',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        return SizedBox(
                          height: 35,
                          // width: 250,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color.fromARGB(255, 91, 90, 90), width: 1.0),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownSearch<String>(
                                    popupProps: PopupProps.menu(
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                          hintText: 'Search...',
                                          hintStyle: const TextStyle(fontSize: 12),
                                          prefixIcon: const Icon(Icons.search, size: 18),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                            borderSide: BorderSide(color: Colors.grey.shade300),
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                      menuProps: MenuProps(borderRadius: BorderRadius.circular(6.0), elevation: 3),
                                      constraints: const BoxConstraints.tightFor(height: 250), // Reduced popup height
                                    ),
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        iconColor: const Color.fromARGB(252, 162, 158, 158),
                                        // labelText: "Client",
                                        // labelStyle: TextStyle(
                                        //   color: Colors.grey.shade600,
                                        //   fontSize: 12,
                                        // ),
                                        floatingLabelStyle: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                      baseStyle: const TextStyle(
                                        fontSize: 12, // Smaller font size
                                        color: Color.fromARGB(255, 138, 137, 137),
                                      ),
                                    ),
                                    items: view_ledgerController.view_LedgerModel.subCustomerList.map((customer) {
                                      return customer.customerName;
                                    }).toList(),
                                    selectedItem: TDS_ledgerController.tds_LedgerModel.selectedsubcustomer.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        TDS_ledgerController.tds_LedgerModel.selectedsubcustomer.value = value;
                                        final customerList = view_ledgerController.view_LedgerModel.subCustomerList;

                                        // Find the index of the selected customer
                                        final index = customerList.indexWhere((customer) => customer.customerName == value);
                                        TDS_ledgerController.tds_LedgerModel.selectedcustomerID.value = view_ledgerController.view_LedgerModel.subCustomerList[index].customerId;

                                        // print('Selected customer ID: ${view_LedgerController.view_LedgerModel.selectedsubcustomerID.value}');
                                        // widget.get_TDS_ledgerList();
                                      }
                                    },
                                  ),
                                ),
                                Obx(
                                  () => SizedBox(
                                    child: TDS_ledgerController.tds_LedgerModel.selectedsubcustomer.value != 'None'
                                        ? IconButton(
                                            onPressed: () {
                                              TDS_ledgerController.tds_LedgerModel.selectedsubcustomer.value = 'None';
                                              TDS_ledgerController.tds_LedgerModel.selectedcustomerID.value = 'None';
                                              widget.get_TDS_LedgerList();
                                            },
                                            icon: const Icon(Icons.close, color: Colors.red, size: 18),
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  )
                : const SizedBox(),
          ),
        ),

        const SizedBox(height: 35),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Select date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                ),
                // const SizedBox(width: 8),
                Obx(
                  () => SizedBox(
                    child: TDS_ledgerController.tds_LedgerModel.startDateController.value.text.isNotEmpty || TDS_ledgerController.tds_LedgerModel.endDateController.value.text.isNotEmpty
                        ? TextButton(
                            onPressed: () {
                              TDS_ledgerController.tds_LedgerModel.selectedMonth.value = 'None';
                              TDS_ledgerController.tds_LedgerModel.startDateController.value.clear();
                              TDS_ledgerController.tds_LedgerModel.endDateController.value.clear();
                              TDS_ledgerController.tds_LedgerModel.selectedMonth.refresh();
                              TDS_ledgerController.tds_LedgerModel.startDateController.refresh();
                              TDS_ledgerController.tds_LedgerModel.endDateController.refresh();
                              // widget.get_TDS_ledgerList();
                            },
                            child: const Text('Clear', style: TextStyle(fontSize: Primary_font_size.Text7)),
                          )
                        : const SizedBox(),
                  ),
                ),
                const Spacer(),
                Obx(
                  () {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      width: 100, // Adjust width as needed
                      height: 30, // Adjust height as needed
                      child: DropdownButtonFormField<String>(
                        menuMaxHeight: 300,
                        value: TDS_ledgerController.tds_LedgerModel.selectedMonth.value,
                        items: ['None', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].map((String value) {
                          return DropdownMenuItem<String>(value: value, child: Text(value));
                        }).toList(),
                        onChanged: (value) {
                          TDS_ledgerController.tds_LedgerModel.selectedMonth.value = value!;
                          if (value != 'None') {
                            final monthIndex = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].indexOf(value) + 1;

                            final now = DateTime.now();
                            final year = now.year;
                            final firstDay = DateTime(year, monthIndex, 1);
                            final lastDay = monthIndex < 12 ? DateTime(year, monthIndex + 1, 0) : DateTime(year + 1, 1, 0);

                            String formatDate(DateTime date) {
                              return "${date.year.toString().padLeft(4, '0')}-"
                                  "${date.month.toString().padLeft(2, '0')}-"
                                  "${date.day.toString().padLeft(2, '0')}";
                            }

                            TDS_ledgerController.tds_LedgerModel.startDateController.value.text = formatDate(firstDay);
                            TDS_ledgerController.tds_LedgerModel.endDateController.value.text = formatDate(lastDay);
                            TDS_ledgerController.tds_LedgerModel.startDateController.refresh();
                            TDS_ledgerController.tds_LedgerModel.endDateController.refresh();
                            // widget.get_TDS_ledgerList();
                          } else {
                            TDS_ledgerController.tds_LedgerModel.startDateController.value.clear();
                            TDS_ledgerController.tds_LedgerModel.endDateController.value.clear();
                            TDS_ledgerController.tds_LedgerModel.startDateController.refresh();
                            TDS_ledgerController.tds_LedgerModel.endDateController.refresh();
                            // widget.get_TDS_ledgerList();
                          }
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                        ),
                        style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 154, 152, 152)),
                        dropdownColor: Primary_colors.Dark,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormField(
                        style: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                        controller: TDS_ledgerController.tds_LedgerModel.startDateController.value,
                        readOnly: true,
                        onTap: () async {
                          await widget.selectfilterDate(context, TDS_ledgerController.tds_LedgerModel.startDateController.value);
                          // await widget.get_TDS_ledgerList();
                          TDS_ledgerController.tds_LedgerModel.startDateController.refresh();
                        },
                        decoration: InputDecoration(
                          labelText: 'From',
                          labelStyle: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                          suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Color.fromARGB(255, 85, 84, 84)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormField(
                        style: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                        controller: TDS_ledgerController.tds_LedgerModel.endDateController.value,
                        readOnly: true,
                        onTap: () async {
                          await widget.selectfilterDate(context, TDS_ledgerController.tds_LedgerModel.endDateController.value);
                          TDS_ledgerController.tds_LedgerModel.endDateController.refresh();
                          // await widget.get_TDS_ledgerList();
                        },
                        decoration: InputDecoration(
                          labelText: 'To',
                          labelStyle: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                          suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Color.fromARGB(255, 85, 84, 84)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                widget.resettds_LedgerFilters();
                widget.get_TDS_LedgerList();
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Primary_colors.Color3),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('RESET', style: TextStyle(color: Primary_colors.Color3)),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                widget.assigntds_LedgerFilters();
                await widget.get_TDS_LedgerList();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Primary_colors.Color3,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'APPLY',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTDS_ledgertypeFilterChip(String label) {
    final isSelected = TDS_ledgerController.tds_LedgerModel.selectedTDStype.value == label;

    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
      ),
      selected: isSelected,
      onSelected: (_) {
        TDS_ledgerController.tds_LedgerModel.selectedTDStype.value = label;
        // widget.get_TDS_ledgerList();
      },
      backgroundColor: Primary_colors.Dark,
      selectedColor: Primary_colors.Dark,
      labelStyle: TextStyle(color: isSelected ? Primary_colors.Color3 : Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
      ),
    );
  }
}
