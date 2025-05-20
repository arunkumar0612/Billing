// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/account_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ViewLedger.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ledger_PDF_template/account_ledger_pdf_template.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/UTILS-/helpers/support_functions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../THEMES-/style.dart';

class AccountLedger extends StatefulWidget with Account_LedgerService {
  AccountLedger({super.key});

  @override
  State<AccountLedger> createState() => _accountLedgerState();
}

class _accountLedgerState extends State<AccountLedger> {
  final Account_LedgerController account_ledgerController = Get.find<Account_LedgerController>();
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
    // loader.start(context); // Now safe to use
    await widget.get_Account_LedgerList();
    await Future.delayed(const Duration(seconds: 2));
    // loader.stop();
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
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].voucherNumber,
                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
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
                                      Text(
                                        textAlign: TextAlign.center,
                                        account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].invoiceNumber,
                                        style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                      ),
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
                                              'Net : ${account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].billDetails.subtotal.toString()}',
                                              style: const TextStyle(color: Primary_colors.Color6, fontSize: Primary_font_size.Text5),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              textAlign: TextAlign.start,
                                              'GST : ${account_ledgerController.account_LedgerModel.account_Ledger_list.value.ledgerList[index].billDetails.totalGST.toString()}',
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
                                  final pdfBytes = await generateAccountLedger(PdfPageFormat.a4);

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
                                final pdfBytes = await generateAccountLedger(PdfPageFormat.a4);

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
                                await Future.delayed(const Duration(milliseconds: 300));

                                // Generate PDF bytes
                                final pdfBytes = await generateAccountLedger(PdfPageFormat.a4);

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
                                // Generate the PDF bytes directly from your function
                                Uint8List pdfBytes = await generateAccountLedger(PdfPageFormat.a4);

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
        );
      },
    );
  }
}
