// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/account_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/view_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ViewLedger.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ledger_PDF_template/account_ledger_pdf_template.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ledger_excel_template/account_ledger_excel_template.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/services/billing_services.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/showPDF.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
                          textAlign: TextAlign.start,
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
                          textAlign: TextAlign.end,
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
                                                  textAlign: TextAlign.start,
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
                                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                textAlign: TextAlign.end,
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
                                            try {
                                              // Generate the PDF bytes
                                              var parsedData = await widget.parsePDF_AccountLedger(
                                                widget.isSubscription_Client(),
                                                widget.isSales_Client(),
                                              );

                                              final pdfBytes = await generateAccountLedger(PdfPageFormat.a4, parsedData);

                                              // Create timestamp for filename
                                              final timestamp = DateTime.now().millisecondsSinceEpoch;
                                              final filename = 'ledger_$timestamp.pdf';

                                              // Show the share dialog
                                              account_ledgerController.clear_sharedata();
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
                                                                if (account_ledgerController.account_LedgerModel.whatsapp_selectionStatus.value) const SizedBox(height: 20),
                                                                if (account_ledgerController.account_LedgerModel.whatsapp_selectionStatus.value)
                                                                  Row(
                                                                    children: [
                                                                      const Text("whatsapp"),
                                                                      const SizedBox(width: 20),
                                                                      const Text(":"),
                                                                      const SizedBox(width: 20),
                                                                      Expanded(
                                                                        child: TextFormField(
                                                                          controller: account_ledgerController.account_LedgerModel.phoneController.value,
                                                                          style: const TextStyle(fontSize: 13, color: Colors.black),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                if (account_ledgerController.account_LedgerModel.gmail_selectionStatus.value) const SizedBox(height: 20),
                                                                if (account_ledgerController.account_LedgerModel.gmail_selectionStatus.value)
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
                                                                            controller: account_ledgerController.account_LedgerModel.emailController.value,
                                                                            decoration: InputDecoration(
                                                                              suffixIcon: MouseRegion(
                                                                                cursor: SystemMouseCursors.click,
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    account_ledgerController.toggleCCemailvisibility(!account_ledgerController.account_LedgerModel.CCemailToggle.value);
                                                                                  },
                                                                                  child: SizedBox(
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    child: Stack(
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: Alignment.center,
                                                                                          child: Icon(
                                                                                            account_ledgerController.account_LedgerModel.CCemailToggle.value
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
                                                                if (account_ledgerController.account_LedgerModel.CCemailToggle.value && account_ledgerController.account_LedgerModel.gmail_selectionStatus.value)
                                                                  const SizedBox(height: 10),
                                                                if (account_ledgerController.account_LedgerModel.CCemailToggle.value && account_ledgerController.account_LedgerModel.gmail_selectionStatus.value)
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
                                                                            controller: account_ledgerController.account_LedgerModel.CCemailController.value,
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
                                                                            account_ledgerController.account_LedgerModel.whatsapp_selectionStatus.value =
                                                                                !account_ledgerController.account_LedgerModel.whatsapp_selectionStatus.value;
                                                                          },
                                                                          icon: Image.asset('assets/images/whatsapp.png'),
                                                                        ),
                                                                        if (account_ledgerController.account_LedgerModel.whatsapp_selectionStatus.value)
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
                                                                            account_ledgerController.account_LedgerModel.gmail_selectionStatus.value =
                                                                                !account_ledgerController.account_LedgerModel.gmail_selectionStatus.value;
                                                                          },
                                                                          icon: Image.asset('assets/images/gmail.png'),
                                                                        ),
                                                                        if (account_ledgerController.account_LedgerModel.gmail_selectionStatus.value)
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
                                                                          controller: account_ledgerController.account_LedgerModel.feedbackController.value,
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
                                                                      cursor: account_ledgerController.account_LedgerModel.whatsapp_selectionStatus.value ||
                                                                              account_ledgerController.account_LedgerModel.gmail_selectionStatus.value
                                                                          ? SystemMouseCursors.click
                                                                          : SystemMouseCursors.forbidden,
                                                                      child: GestureDetector(
                                                                        onTap: () async {
                                                                          if (account_ledgerController.account_LedgerModel.whatsapp_selectionStatus.value ||
                                                                              account_ledgerController.account_LedgerModel.gmail_selectionStatus.value) {
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
                                                                            color: account_ledgerController.account_LedgerModel.whatsapp_selectionStatus.value ||
                                                                                    account_ledgerController.account_LedgerModel.gmail_selectionStatus.value
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
                                            var parsedData = await widget.parsePDF_AccountLedger(
                                              widget.isSubscription_Client(),
                                              widget.isSales_Client(),
                                            );

                                            final pdfBytes = await generateAccountLedger(PdfPageFormat.a4, parsedData);

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
                                    const SizedBox(width: 40), // Space between buttons
                                    // Download Button
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            // Start loading indicator
                                            // loader.start(context);
                                            // await Future.delayed(const Duration(milliseconds: 300));

                                            var parsedData = await widget.parsePDF_AccountLedger(
                                              widget.isSubscription_Client(),
                                              widget.isSales_Client(),
                                            );

                                            // Generate PDF bytes
                                            final pdfBytes = await generateAccountLedger(PdfPageFormat.a4, parsedData);

                                            // Generate unique filename with timestamp
                                            final timestamp = DateTime.now().millisecondsSinceEpoch;
                                            final filename = 'Account_ledger_$timestamp'; // Unique filename

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
                                    const SizedBox(width: 40), // Space between buttons
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            var parsedData = await widget.parsePDF_AccountLedger(
                                              widget.isSubscription_Client(),
                                              widget.isSales_Client(),
                                            );

                                            // Generate the PDF bytes directly from your function
                                            Uint8List pdfBytes = await generateAccountLedger(PdfPageFormat.a4, parsedData);

                                            // // Show the dialog with the same design
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
                                    const SizedBox(width: 40),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            // Start loading indicator
                                            // loader.start(context);
                                            await Future.delayed(const Duration(milliseconds: 300));
                                            var parsedData = await widget.parsePDF_AccountLedger(
                                              widget.isSubscription_Client(),
                                              widget.isSales_Client(),
                                            );

                                            bool useClientTemplate = widget.isSubscription_Client() || widget.isSales_Client();

                                            // Generate PDF bytes
                                            final excelBytes = await generateExcel(useClientTemplate, parsedData);

                                            // Generate unique filename with timestamp
                                            final timestamp = DateTime.now().millisecondsSinceEpoch;
                                            final filename = 'Account_ledger$timestamp'; // Unique filename

                                            // Let user select directory
                                            String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
                                              dialogTitle: 'Select folder to save Excel File',
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
                                            String savePath = "$selectedDirectory/$filename.xlxs";
                                            await File(savePath).writeAsBytes(excelBytes);

                                            // Show success message
                                            Success_SnackBar(context, "✅ Excel File downloaded successfully!");

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
                                              content: "An error occurred while downloading the Excel:\n$e",
                                            );
                                          }
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(height: 25, 'assets/images/excel.png'),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Excel",
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
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 5),
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
                    ),
            ),
          ],
        );
      },
    );
  }

  void showSharePDFdialog() {}
}

class Account_ledger_filter extends StatefulWidget with Account_LedgerService {
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
                          await widget.selectfilterDate(context, account_LedgerController.account_LedgerModel.startDateController.value);
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
                          await widget.selectfilterDate(context, account_LedgerController.account_LedgerModel.endDateController.value);
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
