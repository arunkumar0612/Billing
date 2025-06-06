// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/account_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/view_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ViewLedger.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ledger_PDF_template/account_ledger_pdf_template.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ledger_excel_template/account_ledger_excel_template.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/services/billing_services.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/downloadPDF.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/printPDF.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/sharePDF.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/showPDF.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';
import '../../../THEMES/style.dart';

class AccountLedger extends StatefulWidget with Account_LedgerService, main_BillingService, View_LedgerService {
  AccountLedger({super.key});

  @override
  State<AccountLedger> createState() => _accountLedgerState();
}

class _accountLedgerState extends State<AccountLedger> {
  final Account_LedgerController account_ledgerController = Get.find<Account_LedgerController>();
  final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.resetaccount_LedgerFilters();
    });
    await widget.get_Account_LedgerList();
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
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'S.No',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Primary_colors.Color1,
                            fontWeight: FontWeight.bold,
                            fontSize: Primary_font_size.Text7,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Date',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Voucher No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Invoice No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'GST No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Type',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Description',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Transaction Details',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Debit',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Credit',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Balance',
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
            Expanded(
              child: account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Container(
                              height: 1,
                              color: const Color.fromARGB(94, 125, 125, 125),
                            ),
                            itemCount: account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList.length,
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
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: const BoxDecoration(),
                                              child: Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  (index + 1).toString(),
                                                  style: const TextStyle(
                                                    color: Primary_colors.Color1,
                                                    fontSize: Primary_font_size.Text7,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                formatDate(account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].updatedDate),
                                                // account_ledgerController.account_LedgerModel.account_Ledger_list[index]['date'],
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                          ),
                                          // Vertical line after 'Date' column
                                          const SizedBox(width: 3),
                                          // Expanded(
                                          //   flex: 2,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.all(10),
                                          //     child: Text(
                                          //       textAlign: TextAlign.center,
                                          //       account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].voucherNumber,
                                          //       style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                          //     ),
                                          //   ),
                                          // ),
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
                                                        widget.get_VoucherDetails(context, account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].voucherId);
                                                      },
                                                      child: Text(
                                                        account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].voucherNumber,
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
                                          // Vertical line after 'Reference No' column
                                          const SizedBox(width: 3),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        if (account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].invoiceType == 'subscription') {
                                                          bool success = await widget.GetSubscriptionPDFfile(
                                                              context: context, invoiceNo: account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].invoiceNumber);
                                                          if (success) {
                                                            showPDF(context, account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].invoiceNumber,
                                                                mainBilling_Controller.billingModel.pdfFile.value);
                                                          }
                                                        }
                                                      },
                                                      child: Text(
                                                        account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].invoiceNumber,
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
                                          const SizedBox(width: 3),
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].gstNumber,
                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          // Vertical line after 'clientname' column
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Text(
                                                textAlign: TextAlign.start,
                                                account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].clientName,
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].ledgerType,
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                          ),
                                          // Vertical line after 'Debit' column
                                          const SizedBox(width: 3),
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      textAlign: TextAlign.start,
                                                      account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].description,
                                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                    ),
                                                    // const SizedBox(height: 2),
                                                    // const Text(
                                                    //   textAlign: TextAlign.start,
                                                    //   'GST : Paid',
                                                    //   style: TextStyle(color: Primary_colors.Color7, fontSize: Primary_font_size.Text5),
                                                    // ),
                                                    // const SizedBox(height: 2),
                                                    // const Text(
                                                    //   textAlign: TextAlign.start,
                                                    //   'TDS : Deducted',
                                                    //   style: TextStyle(color: Primary_colors.Color7, fontSize: Primary_font_size.Text5),
                                                    // ),
                                                  ],
                                                )),
                                          ),
                                          const SizedBox(width: 3),
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Text(
                                                textAlign: account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].Payment_details?.transactionDetails == null
                                                    ? TextAlign.center
                                                    : TextAlign.start,
                                                account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].Payment_details?.transactionDetails ?? '-',
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    textAlign: TextAlign.start,
                                                    formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].debitAmount),
                                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                  ),
                                                  if (account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].debitAmount != 0.0)
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const SizedBox(height: 2),
                                                        Text(
                                                          textAlign: TextAlign.start,
                                                          'Net : ${formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].billDetails.subtotal)}',
                                                          style: const TextStyle(color: Primary_colors.Color6, fontSize: Primary_font_size.Text5),
                                                        ),
                                                        const SizedBox(height: 2),
                                                        Text(
                                                          textAlign: TextAlign.start,
                                                          'GST : ${formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].billDetails.totalGST)}',
                                                          style: const TextStyle(color: Primary_colors.Color6, fontSize: Primary_font_size.Text5),
                                                        ),
                                                        // const SizedBox(height: 2),
                                                        // Text(
                                                        //   textAlign: TextAlign.start,
                                                        //   'TDS :${account_ledgerController.account_LedgerModel.account_Ledger_list[index].billDetails.tds.toString()}',
                                                        //   style: const TextStyle(color: Primary_colors.Color6, fontSize: Primary_font_size.Text5),
                                                        // ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    textAlign: TextAlign.start,
                                                    formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].creditAmount),
                                                    style: const TextStyle(
                                                      color: Primary_colors.Color1,
                                                      fontSize: Primary_font_size.Text7,
                                                    ),
                                                  ),
                                                  if (account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].creditAmount != 0.0)
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const SizedBox(height: 2),
                                                        Text(
                                                          textAlign: TextAlign.start,
                                                          'Net : ${account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].billDetails.subtotal.toString()}',
                                                          style: const TextStyle(color: Color.fromARGB(179, 129, 244, 133), fontSize: Primary_font_size.Text5),
                                                        ),
                                                        const SizedBox(height: 2),
                                                        Tooltip(
                                                          message: "KHV/INGST/241215",
                                                          child: Text(
                                                            'GST : ${account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].billDetails.totalGST.toString()}',
                                                            style: const TextStyle(color: Color.fromARGB(181, 129, 244, 133), fontSize: Primary_font_size.Text5),
                                                          ),
                                                        ),
                                                        // const SizedBox(height: 2),
                                                        // Tooltip(
                                                        //   message: "KHV/INTDS/948484",
                                                        //   child: Text(
                                                        //     'TDS :${account_ledgerController.account_LedgerModel.account_Ledger_list[index].billDetails.subtotal.toString()}',
                                                        //     style: const TextStyle(color: Color.fromARGB(255, 248, 110, 94), fontSize: Primary_font_size.Text5),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                convertAmountWithDrCr(formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].balance)),
                                                style: const TextStyle(
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontSize: Primary_font_size.Text7,
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
                        const SizedBox(height: 15),
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
                          // height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 11,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Share Button
                                    const SizedBox(
                                      width: 38,
                                    ),
                                    MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () async {
                                            var parsedData = await widget.parsePDF_AccountLedger(
                                              widget.isSubscription_Client(),
                                              widget.isSales_Client(),
                                            );

                                            final pdfBytes = await generateAccountLedger(PdfPageFormat.a4, parsedData);

                                            Directory tempDir = await getTemporaryDirectory();
                                            String fileName =
                                                ('LEDGER(${account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value != "" ? formatDate(DateTime.parse(account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value)) : formatDate(DateTime.now())} - ${account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value != "" ? formatDate(DateTime.parse(account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value)) : formatDate(DateTime.now())})');
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
                                          var parsedData = await widget.parsePDF_AccountLedger(
                                            widget.isSubscription_Client(),
                                            widget.isSales_Client(),
                                          );

                                          final pdfBytes = await generateAccountLedger(PdfPageFormat.a4, parsedData);
                                          printPDF(context, pdfBytes);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(height: 30, 'assets/images/printer.png'),
                                            const SizedBox(height: 5),
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
                                          var parsedData = await widget.parsePDF_AccountLedger(
                                            widget.isSubscription_Client(),
                                            widget.isSales_Client(),
                                          );

                                          final pdfBytes = await generateAccountLedger(PdfPageFormat.a4, parsedData);

                                          String fileName =
                                              ('LEDGER(${account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value != "" ? formatDate(DateTime.parse(account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value)) : formatDate(DateTime.now())} - ${account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value != "" ? formatDate(DateTime.parse(account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value)) : formatDate(DateTime.now())})');
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
                                    const SizedBox(width: 40),
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
                                            var parsedData = await widget.parsePDF_AccountLedger(
                                              widget.isSubscription_Client(),
                                              widget.isSales_Client(),
                                            );
                                            if (value == 'pdf') {
                                              final pdfBytes = await generateAccountLedger(PdfPageFormat.a4, parsedData);
                                              Directory tempDir = await getTemporaryDirectory();
                                              String fileName =
                                                  ('LEDGER(${account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value != "" ? formatDate(DateTime.parse(account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value)) : formatDate(DateTime.now())} - ${account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value != "" ? formatDate(DateTime.parse(account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value)) : formatDate(DateTime.now())})');
                                              String filePath = '${tempDir.path}/$fileName.pdf';
                                              File file = File(filePath);
                                              await file.writeAsBytes(pdfBytes);
                                              downloadPdf(context, fileName, file);
                                            } else if (value == 'excel') {
                                              bool useClientTemplate = widget.isSubscription_Client() || widget.isSales_Client();
                                              final excelBytes = await accountLedger_generateExcel(useClientTemplate, parsedData);
                                              Directory tempDir = await getTemporaryDirectory();
                                              String fileName =
                                                  ('LEDGER(${account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value != "" ? formatDate(DateTime.parse(account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.fromdate.value)) : formatDate(DateTime.now())} - ${account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value != "" ? formatDate(DateTime.parse(account_ledgerController.account_LedgerModel.account_LedgerSelectedFilter.value.todate.value)) : formatDate(DateTime.now())})');
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
                              ),
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 25),
                                      Expanded(
                                        flex: 2,
                                        child: Stack(
                                          children: [
                                            // Bottom shadow for the recessed effect
                                            Text(
                                              formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.debitAmount),
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
                                              formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.debitAmount),
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
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Stack(
                                          children: [
                                            // Bottom shadow for the recessed effect
                                            Text(
                                              formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.creditAmount),
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
                                              formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.creditAmount),
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
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 0),
                                          child: Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              // Bottom shadow for the recessed effect
                                              Text(
                                                textAlign: TextAlign.end,
                                                convertAmountWithDrCr(formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.balanceAmount)),
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
                                                textAlign: TextAlign.end,
                                                convertAmountWithDrCr(formatCurrency(account_ledgerController.account_LedgerModel.account_Ledger_list.value.balanceAmount)),
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            // ignore: prefer_const_constructors
                            SizedBox(
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
                              'No Account Ledger Found',
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

  void showSharePDFdialog() {}
}

class Account_ledger_filter extends StatefulWidget with Account_LedgerService, main_BillingService {
  Account_ledger_filter({super.key});

  @override
  State<Account_ledger_filter> createState() => _Account_ledger_filterState();
}

class _Account_ledger_filterState extends State<Account_ledger_filter> {
  final Account_LedgerController account_LedgerController = Get.find<Account_LedgerController>();
  final View_LedgerController view_ledgerController = Get.find<View_LedgerController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter Account Ledgers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Primary_colors.Color3),
        ),
        const Divider(height: 30, thickness: 1, color: Color.fromARGB(255, 97, 97, 97)),
        const SizedBox(height: 35),
        // Quick Date Filters
        const Text(
          'Transaction type',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [Obx(() => _buildAccount_LedgertypeFilterChip('Show All')), Obx(() => _buildAccount_LedgertypeFilterChip('Payable')), Obx(() => _buildAccount_LedgertypeFilterChip('Receivable'))],
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
                selected: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Show All',
                onSelected: (_) {
                  account_LedgerController.account_LedgerModel.selectedInvoiceType.value = 'Show All';
                  account_LedgerController.account_LedgerModel.selectedsalescustomer.value = 'None';
                  account_LedgerController.account_LedgerModel.selectedsubcustomer.value = 'None';
                  // widget.get_Account_LedgerList();
                },
                backgroundColor: Primary_colors.Dark,
                selectedColor: Primary_colors.Dark,
                labelStyle: TextStyle(
                  fontSize: Primary_font_size.Text7,
                  color: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
                ),
              ),
              FilterChip(
                label: const Text('Sales'),
                selected: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Sales',
                onSelected: (_) {
                  account_LedgerController.account_LedgerModel.selectedInvoiceType.value = 'Sales';
                  account_LedgerController.account_LedgerModel.selectedsalescustomer.value = 'None';
                  account_LedgerController.account_LedgerModel.selectedsubcustomer.value = 'None';
                  // widget.get_Account_LedgerList();
                },
                backgroundColor: Primary_colors.Dark,
                showCheckmark: false,
                selectedColor: Primary_colors.Dark,
                labelStyle: TextStyle(
                  fontSize: Primary_font_size.Text7,
                  color: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Sales' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Sales' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
                ),
              ),
              FilterChip(
                label: const Text('Subscription'),
                selected: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Subscription',
                onSelected: (_) {
                  account_LedgerController.account_LedgerModel.selectedInvoiceType.value = 'Subscription';
                  account_LedgerController.account_LedgerModel.selectedsalescustomer.value = 'None';
                  account_LedgerController.account_LedgerModel.selectedsubcustomer.value = 'None';
                  // widget.get_Account_LedgerList();
                },
                backgroundColor: Primary_colors.Dark,
                showCheckmark: false,
                selectedColor: Primary_colors.Dark,
                labelStyle: TextStyle(
                  fontSize: Primary_font_size.Text7,
                  color: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Subscription' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Subscription' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => SizedBox(
            child: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Sales'
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
                                    selectedItem: account_LedgerController.account_LedgerModel.selectedsalescustomer.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        account_LedgerController.account_LedgerModel.selectedsalescustomer.value = value;
                                        final customerList = view_ledgerController.view_LedgerModel.salesCustomerList;

                                        // Find the index of the selected customer
                                        final index = customerList.indexWhere((customer) => customer.customerName == value);
                                        account_LedgerController.account_LedgerModel.selectedcustomerID.value = view_ledgerController.view_LedgerModel.salesCustomerList[index].customerId;
                                        if (kDebugMode) {
                                          print('Selected customer ID: ${account_LedgerController.account_LedgerModel.selectedcustomerID.value}');
                                        }
                                      }
                                    },
                                  ),
                                ),
                                Obx(
                                  () => SizedBox(
                                    child: account_LedgerController.account_LedgerModel.selectedsalescustomer.value != 'None'
                                        ? IconButton(
                                            onPressed: () {
                                              account_LedgerController.account_LedgerModel.selectedsalescustomer.value = 'None';
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
            child: account_LedgerController.account_LedgerModel.selectedInvoiceType.value == 'Subscription'
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
                                    selectedItem: account_LedgerController.account_LedgerModel.selectedsubcustomer.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        account_LedgerController.account_LedgerModel.selectedsubcustomer.value = value;
                                        final customerList = view_ledgerController.view_LedgerModel.subCustomerList;

                                        // Find the index of the selected customer
                                        final index = customerList.indexWhere((customer) => customer.customerName == value);
                                        account_LedgerController.account_LedgerModel.selectedcustomerID.value = view_ledgerController.view_LedgerModel.subCustomerList[index].customerId;

                                        // print('Selected customer ID: ${view_LedgerController.view_LedgerModel.selectedsubcustomerID.value}');
                                        // widget.get_Account_LedgerList();
                                      }
                                    },
                                  ),
                                ),
                                Obx(
                                  () => SizedBox(
                                    child: account_LedgerController.account_LedgerModel.selectedsubcustomer.value != 'None'
                                        ? IconButton(
                                            onPressed: () {
                                              account_LedgerController.account_LedgerModel.selectedsubcustomer.value = 'None';
                                              account_LedgerController.account_LedgerModel.selectedcustomerID.value = 'None';
                                              widget.get_Account_LedgerList();
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

        // Status Filter
        const Text(
          'Payment type',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 85, 84, 84)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<String>(
              value: account_LedgerController.account_LedgerModel.selectedpaymenttype.value,
              isDense: true, // Reduces the vertical height
              items: account_LedgerController.account_LedgerModel.paymenttypeList.map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                account_LedgerController.account_LedgerModel.selectedpaymenttype.value = value!;
                // widget.get_Account_LedgerList();
              },
              decoration: const InputDecoration(
                isDense: true, // Makes the field more compact
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Smaller padding
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 154, 152, 152)),
              dropdownColor: Primary_colors.Dark,
            ),
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
                    child: account_LedgerController.account_LedgerModel.startDateController.value.text.isNotEmpty || account_LedgerController.account_LedgerModel.endDateController.value.text.isNotEmpty
                        ? TextButton(
                            onPressed: () {
                              account_LedgerController.account_LedgerModel.selectedMonth.value = 'None';
                              account_LedgerController.account_LedgerModel.startDateController.value.clear();
                              account_LedgerController.account_LedgerModel.endDateController.value.clear();
                              account_LedgerController.account_LedgerModel.selectedMonth.refresh();
                              account_LedgerController.account_LedgerModel.startDateController.refresh();
                              account_LedgerController.account_LedgerModel.endDateController.refresh();
                              // widget.get_Account_LedgerList();
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
                        value: account_LedgerController.account_LedgerModel.selectedMonth.value,
                        items: ['None', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].map((String value) {
                          return DropdownMenuItem<String>(value: value, child: Text(value));
                        }).toList(),
                        onChanged: (value) {
                          account_LedgerController.account_LedgerModel.selectedMonth.value = value!;
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

                            account_LedgerController.account_LedgerModel.startDateController.value.text = formatDate(firstDay);
                            account_LedgerController.account_LedgerModel.endDateController.value.text = formatDate(lastDay);
                            account_LedgerController.account_LedgerModel.startDateController.refresh();
                            account_LedgerController.account_LedgerModel.endDateController.refresh();
                            // widget.get_Account_LedgerList();
                          } else {
                            account_LedgerController.account_LedgerModel.startDateController.value.clear();
                            account_LedgerController.account_LedgerModel.endDateController.value.clear();
                            account_LedgerController.account_LedgerModel.startDateController.refresh();
                            account_LedgerController.account_LedgerModel.endDateController.refresh();
                            // widget.get_Account_LedgerList();
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
                        controller: account_LedgerController.account_LedgerModel.startDateController.value,
                        readOnly: true,
                        onTap: () async {
                          widget.select_previousDates(context, account_LedgerController.account_LedgerModel.startDateController.value);
                          // await widget.get_Account_LedgerList();
                          account_LedgerController.account_LedgerModel.startDateController.refresh();
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
                        controller: account_LedgerController.account_LedgerModel.endDateController.value,
                        readOnly: true,
                        onTap: () async {
                          await widget.select_previousDates(context, account_LedgerController.account_LedgerModel.endDateController.value);
                          account_LedgerController.account_LedgerModel.endDateController.refresh();
                          // await widget.get_Account_LedgerList();
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
                widget.resetaccount_LedgerFilters();
                widget.get_Account_LedgerList();
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
                widget.assignaccount_LedgerFilters();
                await widget.get_Account_LedgerList();
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

  Widget _buildAccount_LedgertypeFilterChip(String label) {
    final isSelected = account_LedgerController.account_LedgerModel.selectedtransactiontype.value == label;

    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
      ),
      selected: isSelected,
      onSelected: (_) {
        account_LedgerController.account_LedgerModel.selectedtransactiontype.value = label;
        // widget.get_Account_LedgerList();
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
