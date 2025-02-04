import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/Debit_actions.dart';
import 'package:ssipl_billing/models/entities/Debit_entities.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_Debit/Debit_template.dart';

import '../../../themes/style.dart';
import '../../../views/components/view_send_pdf.dart';
import '../../../views/screens/SALES/Generate_DebitNote/Debit_template.dart';
// import '../../../views/screens/SALES/Generate_Debit/debit_template.dart';

mixin DebitnotesService {
  final DebitController debitController = Get.find<DebitController>();

  void addtable_row(context) {
    debitController.updateTableValueControllerText(debitController.debitModel.recommendationHeadingController.value.text);
    bool exists = debitController.debitModel.Debit_recommendationList.any((note) => note.key == debitController.debitModel.recommendationKeyController.value.text);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('This note Name already exists.'),
        ),
      );
      return;
    }
    debitController.addRecommendation(key: debitController.debitModel.recommendationKeyController.value.text, value: debitController.debitModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (debitController.debitModel.noteformKey.value.currentState?.validate() ?? false) {
      debitController.updateNoteList(debitController.debitModel.notecontentController.value.text, debitController.debitModel.note_editIndex.value!);
      clearnoteFields();
      debitController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    debitController.updateRecommendation(
        index: debitController.debitModel.recommendation_editIndex.value!,
        key: debitController.debitModel.recommendationKeyController.value.text.toString(),
        value: debitController.debitModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    debitController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    Note note = debitController.debitModel.Debit_noteList[index];
    debitController.updateNoteContentControllerText(note.notename);
    debitController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = debitController.debitModel.Debit_recommendationList[index];
    debitController.updateTableKeyControllerText(note.key.toString());
    debitController.updateTableValueControllerText(note.value.toString());
    debitController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      debitController.updateNoteEditindex(null);
      debitController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    debitController.debitModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    debitController.debitModel.recommendationKeyController.value.clear();
    debitController.debitModel.recommendationValueController.value.clear();
  }

  void addNotes(context) {
    if (debitController.debitModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = debitController.debitModel.Debit_noteList.any((note) => note.notename == debitController.debitModel.notecontentController.value.text);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This note Name already exists.'),
          ),
        );
        return;
      }
      debitController.addNote(debitController.debitModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  void Generate_Debit(context) async {
    final pdfData = await generate_Debit(
        PdfPageFormat.a4,
        debitController.debitModel.Debit_products,
        debitController.debitModel.clientAddressNameController.value.text,
        debitController.debitModel.clientAddressController.value.text,
        debitController.debitModel.billingAddressNameController.value.text,
        debitController.debitModel.billingAddressController.value.text,
        debitController.debitModel.Debit_no.value,
        9,
        debitController.debitModel.Debit_gstTotals);

    const filePath = 'E://Debit.pdf';
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
              type: 'E://Debit.pdf',
            ));
      },
    );
    // Sales_Client.Debit_Callback();
  }
}
