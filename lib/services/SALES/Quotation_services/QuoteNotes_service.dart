import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/Quote_actions.dart';
import 'package:ssipl_billing/models/entities/Quote_entities.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_Quote/Quote_template.dart';

import '../../../themes/style.dart';
import '../../../views/components/view_send_pdf.dart';
import '../../../views/screens/SALES/Generate_Quote/quote_template.dart';
// import '../../../views/screens/SALES/Generate_Quote/quote_template.dart';

mixin QuotenotesService {
  final QuoteController quoteController = Get.find<QuoteController>();

  void addtable_row(context) {
    quoteController.updateTableValueControllerText(quoteController.quoteModel.recommendationHeadingController.value.text);
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
    Note note = quoteController.quoteModel.Quote_noteList[index];
    quoteController.updateNoteContentControllerText(note.notename);
    quoteController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = quoteController.quoteModel.Quote_recommendationList[index];
    quoteController.updateTableKeyControllerText(note.key.toString());
    quoteController.updateTableValueControllerText(note.value.toString());
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

  void Generate_Quote(context) async {
    final pdfData = await generate_Quote(
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

    const filePath = 'E://Quote.pdf';
    final file = File(filePath);
    await file.writeAsBytes(pdfData);

    // Future.delayed(const Duration(seconds: 4), () {
    //   Generate_popup.callback();
    // });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://Quote.pdf',
            ));
      },
    );
    // Sales_Client.Quote_Callback();
  }
}
