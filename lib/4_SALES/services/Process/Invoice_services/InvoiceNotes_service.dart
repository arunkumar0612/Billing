import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4_SALES/controllers/Process/Invoice_actions.dart';
import 'package:ssipl_billing/4_SALES/views/Process/Generate_Invoice/invoice_template.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

mixin InvoicenotesService {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  void addtable_row(context) {
    // invoiceController.updateRec_ValueControllerText(invoiceController.invoiceModel.recommendationHeadingController.value.text);
    bool exists = invoiceController.invoiceModel.Invoice_recommendationList.any((note) => note.key == invoiceController.invoiceModel.recommendationKeyController.value.text);
    if (exists) {
      Error_SnackBar(context, 'This note Name already exists.');

      return;
    }
    invoiceController.addRecommendation(key: invoiceController.invoiceModel.recommendationKeyController.value.text, value: invoiceController.invoiceModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (invoiceController.invoiceModel.noteformKey.value.currentState?.validate() ?? false) {
      invoiceController.updateNoteList(invoiceController.invoiceModel.notecontentController.value.text, invoiceController.invoiceModel.note_editIndex.value!);
      clearnoteFields();
      invoiceController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    invoiceController.updateRecommendation(
        index: invoiceController.invoiceModel.recommendation_editIndex.value!,
        key: invoiceController.invoiceModel.recommendationKeyController.value.text.toString(),
        value: invoiceController.invoiceModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    invoiceController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    invoiceController.updateNoteContentControllerText(invoiceController.invoiceModel.Invoice_noteList[index]);
    invoiceController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = invoiceController.invoiceModel.Invoice_recommendationList[index];
    invoiceController.updateRec_KeyControllerText(note.key.toString());
    invoiceController.updateRec_ValueControllerText(note.value.toString());
    invoiceController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      invoiceController.updateNoteEditindex(null);
      invoiceController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    invoiceController.invoiceModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    invoiceController.invoiceModel.recommendationKeyController.value.clear();
    invoiceController.invoiceModel.recommendationValueController.value.clear();
  }

  void addNotes(context) {
    if (invoiceController.invoiceModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = invoiceController.invoiceModel.Invoice_noteList.any((note) => note == invoiceController.invoiceModel.notecontentController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');
        return;
      }
      invoiceController.addNote(invoiceController.invoiceModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  // void Generate_Invoice(BuildContext context) async {
  //   // viewsendController.setLoading(false);
  //   invoiceController.nextTab();
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   sub();
  //   // Start generating PDF data as a Future
  // }

  // void sub() async {
  //   final pdfData = await generate_Invoice(
  //     PdfPageFormat.a4,
  //     invoiceController.invoiceModel.Invoice_products,
  //     invoiceController.invoiceModel.clientAddressNameController.value.text,
  //     invoiceController.invoiceModel.clientAddressController.value.text,
  //     invoiceController.invoiceModel.billingAddressNameController.value.text,
  //     invoiceController.invoiceModel.billingAddressController.value.text,
  //     invoiceController.invoiceModel.Invoice_no.value,
  //     invoiceController.invoiceModel.TitleController.value.text,
  //     9,
  //     invoiceController.invoiceModel.Invoice_gstTotals,
  //   );

  //   // Show the dialog immediately (not awaited)
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Primary_colors.Light,
  //         content: Generate_popup(
  //           type: 'E://Invoice.pdf', // Pass the expected file path
  //         ),
  //       );
  //     },
  //   );

  //   // Wait for PDF data generation to complete

  //   const filePath = 'E://Invoice.pdf';
  //   final file = File(filePath);

  //   // Perform file writing and any other future tasks in parallel

  //   file.writeAsBytes(pdfData); // Write PDF to file asynchronously
  //   // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed

  //   // Continue execution while the dialog is still open
  //   viewsendController.setLoading(true);
  // }

  Future<void> savePdfToCache() async {
    Uint8List pdfData = await generate_Invoice(
        PdfPageFormat.a4,
        invoiceController.invoiceModel.Invoice_products,
        invoiceController.invoiceModel.clientAddressNameController.value.text,
        invoiceController.invoiceModel.clientAddressController.value.text,
        invoiceController.invoiceModel.billingAddressNameController.value.text,
        invoiceController.invoiceModel.billingAddressController.value.text,
        invoiceController.invoiceModel.Invoice_no.value,
        invoiceController.invoiceModel.gstNumController.value.text,
        invoiceController.invoiceModel.Invoice_gstTotals,
        isGST_Local(invoiceController.invoiceModel.gstNumController.value.text));

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedInvoiceNo = Returns.replace_Slash_hypen(invoiceController.invoiceModel.Invoice_no.value!);
    String filePath = '${tempDir.path}/$sanitizedInvoiceNo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    invoiceController.invoiceModel.selectedPdf.value = file;
    // return file;
  }
}
