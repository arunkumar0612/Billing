import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';

import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/services/APIservices/invoker.dart';
import 'package:ssipl_billing/utils/helpers/returns.dart';
import 'package:ssipl_billing/views/screens/SUBSCRIPTION/Generate_Quote/SUBSCRIPTION_quote_template.dart';

mixin SUBSCRIPTION_QuotenotesService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  void addtable_row(context) {
    quoteController.updateRec_ValueControllerText(quoteController.quoteModel.recommendationHeadingController.value.text);
    bool exists = quoteController.quoteModel.Quote_recommendationList.any((note) => note.key == quoteController.quoteModel.recommendationKeyController.value.text);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('This note Name already exists.'),
        ),
      );
      return;
    }
    quoteController.addRecommendation(key: quoteController.quoteModel.recommendationKeyController.value.text, value: quoteController.quoteModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (quoteController.quoteModel.noteformKey.value.currentState?.validate() ?? false) {
      quoteController.updateNoteList(quoteController.quoteModel.notecontentController.value.text, quoteController.quoteModel.note_editIndex.value!);
      clearnoteFields();
      quoteController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    quoteController.updateRecommendation(
        index: quoteController.quoteModel.recommendation_editIndex.value!,
        key: quoteController.quoteModel.recommendationKeyController.value.text.toString(),
        value: quoteController.quoteModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    quoteController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    quoteController.updateNoteContentControllerText(quoteController.quoteModel.Quote_noteList[index]);
    quoteController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = quoteController.quoteModel.Quote_recommendationList[index];
    quoteController.updateRec_KeyControllerText(note.key.toString());
    quoteController.updateRec_ValueControllerText(note.value.toString());
    quoteController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      quoteController.updateNoteEditindex(null);
      quoteController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    quoteController.quoteModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    quoteController.quoteModel.recommendationKeyController.value.clear();
    quoteController.quoteModel.recommendationValueController.value.clear();
  }

  void addNotes(context) {
    if (quoteController.quoteModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = quoteController.quoteModel.Quote_noteList.any((note) => note == quoteController.quoteModel.notecontentController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');
        return;
      }
      quoteController.addNote(quoteController.quoteModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  // void Generate_Quote(BuildContext context) async {
  //   // viewsendController.setLoading(false);
  //   quoteController.nextTab();
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   sub();
  //   // Start generating PDF data as a Future
  // }

  // void sub() async {
  //   final pdfData = await generate_Quote(
  //     PdfPageFormat.a4,
  //     quoteController.quoteModel.Quote_products,
  //     quoteController.quoteModel.clientAddressNameController.value.text,
  //     quoteController.quoteModel.clientAddressController.value.text,
  //     quoteController.quoteModel.billingAddressNameController.value.text,
  //     quoteController.quoteModel.billingAddressController.value.text,
  //     quoteController.quoteModel.Quote_no.value,
  //     quoteController.quoteModel.TitleController.value.text,
  //     9,
  //     quoteController.quoteModel.Quote_gstTotals,
  //   );

  //   // Show the dialog immediately (not awaited)
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Primary_colors.Light,
  //         content: Generate_popup(
  //           type: 'E://Quote.pdf', // Pass the expected file path
  //         ),
  //       );
  //     },
  //   );

  //   // Wait for PDF data generation to complete

  //   const filePath = 'E://Quote.pdf';
  //   final file = File(filePath);

  //   // Perform file writing and any other future tasks in parallel

  //   file.writeAsBytes(pdfData); // Write PDF to file asynchronously
  //   // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed

  //   // Continue execution while the dialog is still open
  //   viewsendController.setLoading(true);
  // }

  Future<void> savePdfToCache() async {
    Uint8List pdfData = await SUBSCRIPTION_generate_Quote(
      PdfPageFormat.a4,
      quoteController.quoteModel.Quote_sites,
      quoteController.quoteModel.clientAddressNameController.value.text,
      quoteController.quoteModel.clientAddressController.value.text,
      quoteController.quoteModel.billingAddressNameController.value.text,
      quoteController.quoteModel.billingAddressController.value.text,
      quoteController.quoteModel.Quote_no.value,
      quoteController.quoteModel.TitleController.value.text,
      9,
      quoteController.quoteModel.Quote_gstTotals,
    );

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedQuoteNo = Returns.replace_Slash_hypen(quoteController.quoteModel.Quote_no.value!);
    String filePath = '${tempDir.path}/$sanitizedQuoteNo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    quoteController.quoteModel.selectedPdf.value = file;
    // return file;
  }
}
