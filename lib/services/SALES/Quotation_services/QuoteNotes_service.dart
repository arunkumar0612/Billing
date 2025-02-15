import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Quote_actions.dart';
import 'package:ssipl_billing/models/entities/SALES/Quote_entities.dart';
import '../../../controllers/viewSend_actions.dart';
import '../../../themes/style.dart';
import '../../../views/components/view_send_pdf.dart';
import '../../../views/screens/SALES/Generate_Quote/quote_template.dart';

mixin QuotenotesService {
  final QuoteController quoteController = Get.find<QuoteController>();
  final ViewsendController viewsendController = Get.find<ViewsendController>();

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
    quoteController.updateRecommendation(index: quoteController.quoteModel.recommendation_editIndex.value!, key: quoteController.quoteModel.recommendationKeyController.value.text.toString(), value: quoteController.quoteModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    quoteController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    Note note = quoteController.quoteModel.Quote_noteList[index];
    quoteController.updateNoteContentControllerText(note.notename);
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
      bool exists = quoteController.quoteModel.Quote_noteList.any((note) => note.notename == quoteController.quoteModel.notecontentController.value.text);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This note Name already exists.'),
          ),
        );
        return;
      }
      quoteController.addNote(quoteController.quoteModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  void Generate_Quote(BuildContext context) async {
    // Start generating PDF data as a Future
    viewsendController.setLoading(false);
    final pdfGenerationFuture = generate_Quote(
      PdfPageFormat.a4,
      quoteController.quoteModel.Quote_products,
      quoteController.quoteModel.clientAddressNameController.value.text,
      quoteController.quoteModel.clientAddressController.value.text,
      quoteController.quoteModel.billingAddressNameController.value.text,
      quoteController.quoteModel.billingAddressController.value.text,
      quoteController.quoteModel.Quote_no.value,
      quoteController.quoteModel.TitleController.value.text,
      9,
      quoteController.quoteModel.Quote_gstTotals,
    );

    // Show the dialog immediately (not awaited)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Primary_colors.Light,
          content: Generate_popup(
            type: 'E://Quote.pdf', // Pass the expected file path
          ),
        );
      },
    );

    // Wait for PDF data generation to complete
    final pdfData = await pdfGenerationFuture;

    const filePath = 'E://Quote.pdf';
    final file = File(filePath);

    // Perform file writing and any other future tasks in parallel
    await Future.wait([
      file.writeAsBytes(pdfData), // Write PDF to file asynchronously
      // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed
    ]);

    // Continue execution while the dialog is still open
    viewsendController.setLoading(true);
  }
}
