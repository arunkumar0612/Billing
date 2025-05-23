// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/GST_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/GST_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/view_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ViewLedger.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ledger_PDF_template/GST_ledger_pdf_template.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../THEMES/style.dart';

class GSTLedger extends StatefulWidget with GST_LedgerService, View_LedgerService {
  GSTLedger({super.key});

  @override
  State<GSTLedger> createState() => _GSTLedgerState();
}

class _GSTLedgerState extends State<GSTLedger> {
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final GST_LedgerController gst_ledgerController = Get.find<GST_LedgerController>();

  List<String> gst_ledger_type_list = ['Consolidated GST', 'Input GST', 'Output GST'];
  String? Selected_ledger_type = 'Consolidated GST';

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
    await widget.get_GST_LedgerList();
    await widget.Get_SUBcustomerList();
    await widget.Get_SALEScustomerList();
    await Future.delayed(const Duration(seconds: 2));
    loader.stop();
  }

  @override
  Widget build(BuildContext context) {
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
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'GST No',
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
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
                          'GST Type',
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Taxable Value(\u20B9)',
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Gross Amount(\u20B9)',
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'CGST(\u20B9)',
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'SGST(\u20B9)',
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'IGST(\u20B9)',
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Total GST(\u20B9)',
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
                child: gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) => Container(
                                height: 1,
                                color: const Color.fromARGB(94, 125, 125, 125),
                              ),
                              itemCount: gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList.length,
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
                                                  formatDate(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].date),
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ),
                                            // Vertical line after 'Date' column

                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].voucherNumber,
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ),
                                            // Vertical line after 'Reference No' column

                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].voucherNumber,
                                                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].gstNumber,
                                                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            // Vertical line after 'clientname' column
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].description ?? "-",
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].gstType,
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
                                                  formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].subTotal),
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].totalAmount),
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].cgst),
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].sgst),
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].igst),
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ),

                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.gstList[index].totalGst),
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(255, 166, 255, 93),
                                                    fontSize: Primary_font_size.Text8,
                                                  ),
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
                          view_LedgerController.view_LedgerModel.showGSTsummary.value
                              ? Column(
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        const Text(
                                          'GST SUMMARY',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Table(
                                          border: TableBorder.all(color: const Color.fromARGB(255, 112, 112, 112)),
                                          children: [
                                            const TableRow(
                                              decoration: BoxDecoration(color: Color.fromARGB(122, 100, 110, 255)),
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('CGST (₹)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('SGST (₹)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('IGST (₹)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Total GST (₹)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              decoration: const BoxDecoration(),
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Output GST', style: TextStyle(color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child:
                                                      Text(formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.outputCgst ?? 0.0), style: const TextStyle(color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child:
                                                      Text(formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.outputSgst ?? 0.0), style: const TextStyle(color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child:
                                                      Text(formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.outputIgst ?? 0.0), style: const TextStyle(color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.outputGst), style: const TextStyle(color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              decoration: const BoxDecoration(),
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Input GST', style: TextStyle(color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.inputCgst ?? 0.0), style: const TextStyle(color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.inputSgst ?? 0.0), style: const TextStyle(color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.inputIgst ?? 0.0), style: const TextStyle(color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.inputGst), style: const TextStyle(color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              // decoration: BoxDecoration(color: Color.fromARGB(73, 144, 146, 165)),
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('GST Payable/ refundable', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Stack(
                                                    children: [
                                                      // Bottom shadow for the recessed effect
                                                      Text(
                                                        formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.totalCgst ?? 0.0),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          letterSpacing: 2,
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
                                                        formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.totalCgst ?? 0.0),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          letterSpacing: 2,
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
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Stack(
                                                    children: [
                                                      // Bottom shadow for the recessed effect
                                                      Text(
                                                        formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.totalSgst ?? 0.0),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          letterSpacing: 2,
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
                                                        formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.totalSgst ?? 0.0),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          letterSpacing: 2,
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
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Stack(
                                                    children: [
                                                      // Bottom shadow for the recessed effect
                                                      Text(
                                                        formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.totalIgst ?? 0.0),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          letterSpacing: 2,
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
                                                        formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.totalIgst ?? 0.0),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          letterSpacing: 2,
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
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Stack(
                                                    children: [
                                                      // Bottom shadow for the recessed effect
                                                      Text(
                                                        formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.totalGst),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          letterSpacing: 2,
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
                                                        formatCurrency(gst_ledgerController.gst_LedgerModel.gst_Ledger_list.value.totalGst),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          letterSpacing: 2,
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
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          if (view_LedgerController.view_LedgerModel.showGSTsummary.value == false)
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
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
                              ],
                            ),
                          SizedBox(
                            // height: 80,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 11,
                                  child: Row(
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
                                              try {
                                                // Generate the PDF bytes
                                                final pdfBytes = await generateGSTledger(PdfPageFormat.a4);

                                                // Create timestamp for filename
                                                final timestamp = DateTime.now().millisecondsSinceEpoch;
                                                final filename = 'ledger_$timestamp.pdf';

                                                // Show the share dialog
                                                gst_ledgerController.clear_sharedata();
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Obx(
                                                      () {
                                                        return AlertDialog(
                                                          titlePadding: const EdgeInsets.all(5),
                                                          backgroundColor: const Color.fromARGB(255, 194, 198, 253),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          title: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(7),
                                                              color: Primary_colors.Color3,
                                                            ),
                                                            child: const Padding(
                                                              padding: EdgeInsets.all(7),
                                                              child: Text(
                                                                "Share",
                                                                style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                                                              ),
                                                            ),
                                                          ),
                                                          content: IntrinsicHeight(
                                                            child: SizedBox(
                                                              width: 500,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      const Text("File name"),
                                                                      const SizedBox(width: 20),
                                                                      const Text(":"),
                                                                      const SizedBox(width: 20),
                                                                      Expanded(
                                                                        child: Text(filename), // Using generated filename
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  if (gst_ledgerController.gst_LedgerModel.whatsapp_selectionStatus.value) const SizedBox(height: 20),
                                                                  if (gst_ledgerController.gst_LedgerModel.whatsapp_selectionStatus.value)
                                                                    Row(
                                                                      children: [
                                                                        const Text("whatsapp"),
                                                                        const SizedBox(width: 20),
                                                                        const Text(":"),
                                                                        const SizedBox(width: 20),
                                                                        Expanded(
                                                                          child: TextFormField(
                                                                            controller: gst_ledgerController.gst_LedgerModel.phoneController.value,
                                                                            style: const TextStyle(fontSize: 13, color: Colors.black),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  if (gst_ledgerController.gst_LedgerModel.gmail_selectionStatus.value) const SizedBox(height: 20),
                                                                  if (gst_ledgerController.gst_LedgerModel.gmail_selectionStatus.value)
                                                                    Row(
                                                                      children: [
                                                                        const Text("E-mail"),
                                                                        const SizedBox(width: 50),
                                                                        const Text(":"),
                                                                        const SizedBox(width: 20),
                                                                        Expanded(
                                                                          child: SizedBox(
                                                                            child: TextFormField(
                                                                              readOnly: false,
                                                                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                                                                              controller: gst_ledgerController.gst_LedgerModel.emailController.value,
                                                                              decoration: InputDecoration(
                                                                                suffixIcon: MouseRegion(
                                                                                  cursor: SystemMouseCursors.click,
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      gst_ledgerController.toggleCCemailvisibility(!gst_ledgerController.gst_LedgerModel.CCemailToggle.value);
                                                                                    },
                                                                                    child: SizedBox(
                                                                                      height: 20,
                                                                                      width: 20,
                                                                                      child: Stack(
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: Alignment.center,
                                                                                            child: Icon(
                                                                                              gst_ledgerController.gst_LedgerModel.CCemailToggle.value
                                                                                                  ? Icons.closed_caption_outlined
                                                                                                  : Icons.closed_caption_disabled_outlined,
                                                                                              color: Primary_colors.Dark,
                                                                                            ),
                                                                                          ),
                                                                                          const Align(
                                                                                            alignment: Alignment.bottomRight,
                                                                                            child: Icon(
                                                                                              size: 15,
                                                                                              Icons.add,
                                                                                              color: Primary_colors.Dark,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  if (gst_ledgerController.gst_LedgerModel.CCemailToggle.value && gst_ledgerController.gst_LedgerModel.gmail_selectionStatus.value)
                                                                    const SizedBox(height: 10),
                                                                  if (gst_ledgerController.gst_LedgerModel.CCemailToggle.value && gst_ledgerController.gst_LedgerModel.gmail_selectionStatus.value)
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                      children: [
                                                                        const Text(
                                                                          '                                      Cc :',
                                                                          style: TextStyle(fontSize: 13, color: Primary_colors.Dark, fontWeight: FontWeight.bold),
                                                                        ),
                                                                        const SizedBox(width: 10),
                                                                        Expanded(
                                                                          child: SizedBox(
                                                                            child: TextFormField(
                                                                              scrollPadding: const EdgeInsets.only(top: 10),
                                                                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                                                                              controller: gst_ledgerController.gst_LedgerModel.CCemailController.value,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  const SizedBox(height: 20),
                                                                  Row(
                                                                    children: [
                                                                      const Text("Select"),
                                                                      const SizedBox(width: 50),
                                                                      const Text(":"),
                                                                      const SizedBox(width: 20),
                                                                      Stack(
                                                                        alignment: FractionalOffset.topRight,
                                                                        children: [
                                                                          IconButton(
                                                                            iconSize: 30,
                                                                            onPressed: () {
                                                                              gst_ledgerController.gst_LedgerModel.whatsapp_selectionStatus.value =
                                                                                  !gst_ledgerController.gst_LedgerModel.whatsapp_selectionStatus.value;
                                                                            },
                                                                            icon: Image.asset('assets/images/whatsapp.png'),
                                                                          ),
                                                                          if (gst_ledgerController.gst_LedgerModel.whatsapp_selectionStatus.value)
                                                                            Align(
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(50),
                                                                                  color: Colors.blue,
                                                                                ),
                                                                                child: const Padding(
                                                                                  padding: EdgeInsets.all(2),
                                                                                  child: Icon(
                                                                                    Icons.check,
                                                                                    color: Colors.white,
                                                                                    size: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                        ],
                                                                      ),
                                                                      const SizedBox(width: 20),
                                                                      Stack(
                                                                        alignment: FractionalOffset.topRight,
                                                                        children: [
                                                                          IconButton(
                                                                            iconSize: 35,
                                                                            onPressed: () {
                                                                              gst_ledgerController.gst_LedgerModel.gmail_selectionStatus.value =
                                                                                  !gst_ledgerController.gst_LedgerModel.gmail_selectionStatus.value;
                                                                            },
                                                                            icon: Image.asset('assets/images/gmail.png'),
                                                                          ),
                                                                          if (gst_ledgerController.gst_LedgerModel.gmail_selectionStatus.value)
                                                                            Align(
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(50),
                                                                                  color: Colors.blue,
                                                                                ),
                                                                                child: const Padding(
                                                                                  padding: EdgeInsets.all(2),
                                                                                  child: Icon(
                                                                                    Icons.check,
                                                                                    color: Colors.white,
                                                                                    size: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      Align(
                                                                        alignment: Alignment.bottomLeft,
                                                                        child: SizedBox(
                                                                          width: 380,
                                                                          child: TextFormField(
                                                                            maxLines: 5,
                                                                            controller: gst_ledgerController.gst_LedgerModel.feedbackController.value,
                                                                            style: const TextStyle(fontSize: 13, color: Colors.white),
                                                                            decoration: InputDecoration(
                                                                              contentPadding: const EdgeInsets.all(10),
                                                                              filled: true,
                                                                              fillColor: Primary_colors.Dark,
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                borderSide: const BorderSide(color: Colors.transparent),
                                                                              ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                borderSide: const BorderSide(color: Colors.transparent),
                                                                              ),
                                                                              hintStyle: const TextStyle(
                                                                                fontSize: Primary_font_size.Text7,
                                                                                color: Color.fromARGB(255, 167, 165, 165),
                                                                              ),
                                                                              hintText: 'Enter Feedback...',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      MouseRegion(
                                                                        cursor: gst_ledgerController.gst_LedgerModel.whatsapp_selectionStatus.value ||
                                                                                gst_ledgerController.gst_LedgerModel.gmail_selectionStatus.value
                                                                            ? SystemMouseCursors.click
                                                                            : SystemMouseCursors.forbidden,
                                                                        child: GestureDetector(
                                                                          onTap: () async {
                                                                            if (gst_ledgerController.gst_LedgerModel.whatsapp_selectionStatus.value ||
                                                                                gst_ledgerController.gst_LedgerModel.gmail_selectionStatus.value) {
                                                                              // Create temporary file
                                                                              final tempDir = await getTemporaryDirectory();
                                                                              final file = File('${tempDir.path}/$filename');
                                                                              await file.writeAsBytes(pdfBytes);

                                                                              // Share the file
                                                                              // You'll need to implement your sharing logic here
                                                                              // For example using share_plus package:
                                                                              // await Share.shareXFiles([XFile(file.path)], ...);

                                                                              // Or call your existing sharing method:
                                                                              // widget.postData_sendPDF(context, widget.fetch_messageType(), file);

                                                                              Navigator.pop(context); // Close dialog after sharing
                                                                            }
                                                                          },
                                                                          child: Container(
                                                                            width: 105,
                                                                            decoration: BoxDecoration(
                                                                              color: gst_ledgerController.gst_LedgerModel.whatsapp_selectionStatus.value ||
                                                                                      gst_ledgerController.gst_LedgerModel.gmail_selectionStatus.value
                                                                                  ? const Color.fromARGB(255, 81, 89, 212)
                                                                                  : const Color.fromARGB(255, 39, 41, 73),
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                            child: const Padding(
                                                                              padding: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "Send",
                                                                                  style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              } catch (e) {
                                                Error_dialog(
                                                  context: context,
                                                  title: "Error",
                                                  content: "Failed to generate PDF for sharing:\n$e",
                                                );
                                              }
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
                                            try {
                                              // Generate the PDF bytes first
                                              final pdfBytes = await generateGSTledger(PdfPageFormat.a4);

                                              // Print the generated PDF
                                              await Printing.layoutPdf(
                                                onLayout: (PdfPageFormat format) async => pdfBytes,
                                              );

                                              if (kDebugMode) {
                                                print('PDF printed successfully');
                                              }
                                            } catch (e) {
                                              if (kDebugMode) {
                                                print('Error printing PDF: $e');
                                              }
                                              // Show error dialog if needed
                                              Error_dialog(
                                                context: context,
                                                title: "Print Error",
                                                content: "An error occurred while printing:\n$e",
                                              );
                                            }
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

                                      const SizedBox(width: 40), // Space between buttons
                                      // Download Button
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () async {
                                            try {
                                              // Start loading indicator
                                              // loader.start(context);
                                              await Future.delayed(const Duration(milliseconds: 300));

                                              // Generate PDF bytes
                                              final pdfBytes = await generateGSTledger(PdfPageFormat.a4);

                                              // Generate unique filename with timestamp
                                              final timestamp = DateTime.now().millisecondsSinceEpoch;
                                              final filename = 'GST_ledger$timestamp'; // Unique filename

                                              // Let user select directory
                                              String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
                                                dialogTitle: 'Select folder to save PDF',
                                                lockParentWindow: true,
                                              );

                                              // Always stop loader after native call
                                              // loader.stop();

                                              if (selectedDirectory == null) {
                                                if (kDebugMode) {
                                                  print("User cancelled the folder selection.");
                                                }
                                                Error_dialog(
                                                  context: context,
                                                  title: "Cancelled",
                                                  content: "Download cancelled. No folder was selected.",
                                                );
                                                return;
                                              }

                                              // Save the file with unique name
                                              String savePath = "$selectedDirectory/$filename.pdf";
                                              await File(savePath).writeAsBytes(pdfBytes);

                                              // Show success message
                                              Success_SnackBar(context, "✅ PDF downloaded successfully!");

                                              // Optional: open the file
                                              await OpenFilex.open(savePath);
                                            } catch (e) {
                                              // loader.stop();
                                              if (kDebugMode) {
                                                print("❌ Error while downloading PDF: $e");
                                              }
                                              Error_dialog(
                                                context: context,
                                                title: "Error",
                                                content: "An error occurred while downloading the PDF:\n$e",
                                              );
                                            }
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(height: 25, 'assets/images/download.png'),
                                              const SizedBox(
                                                height: 10,
                                              ),
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
                                      const SizedBox(width: 40), // Space between buttons

                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () async {
                                            try {
                                              // Generate the PDF bytes directly from your function
                                              Uint8List pdfBytes = await generateGSTledger(PdfPageFormat.a4);

                                              // Show the dialog with the same design
                                              showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                  insetPadding: const EdgeInsets.all(20), // Same padding
                                                  child: SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.35, // Same width (35%)
                                                    height: MediaQuery.of(context).size.height * 0.95, // Same height (95%)
                                                    child: SfPdfViewer.memory(
                                                      pdfBytes, // Using the generated PDF bytes
                                                      canShowPaginationDialog: true,
                                                      scrollDirection: PdfScrollDirection.vertical,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } catch (e) {
                                              Error_dialog(
                                                context: context,
                                                title: "Error",
                                                content: "Failed to generate PDF:\n$e",
                                              );
                                            }
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
                                      ),
                                    ],
                                  ),
                                ),
                                if (view_LedgerController.view_LedgerModel.showGSTsummary.value == false)
                                  Expanded(
                                    flex: 3,
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex: 2,
                                            child: Stack(
                                              children: [
                                                // Bottom shadow for the recessed effect
                                                Text(
                                                  'Rs. 2389',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
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
                                                  'Rs. 2389',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
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
                                            child: Stack(
                                              children: [
                                                // Bottom shadow for the recessed effect
                                                Text(
                                                  'Rs. 2389',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
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
                                                  'Rs. 2389',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
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
                                            child: Stack(
                                              children: [
                                                // Bottom shadow for the recessed effect
                                                Text(
                                                  'Rs. 2389',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
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
                                                  'Rs. 2389',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
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
                                            child: Stack(
                                              children: [
                                                // Bottom shadow for the recessed effect
                                                Text(
                                                  '- Rs.2389',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
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
                                                  '- Rs.2389',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
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
                          ),
                          if (view_LedgerController.view_LedgerModel.showGSTsummary.value == false)
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
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
                              ],
                            ),
                        ],
                      )
                    : Center(
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
                                'No GST Ledger Found',
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
                                'generate a Ledger to see it listed here.',
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
                      ))
          ],
        );
      },
    );
  }
}
