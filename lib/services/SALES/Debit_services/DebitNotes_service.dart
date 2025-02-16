import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Debit_actions.dart';
import 'package:ssipl_billing/models/entities/SALES/Debit_entities.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_Debit/Debit_template.dart';

import '../../../controllers/viewSend_actions.dart';
import '../../../themes/style.dart';
import '../../../views/components/view_send_pdf.dart';
import '../../../views/screens/SALES/Generate_DebitNote/Debit_template.dart';
// import '../../../views/screens/SALES/Generate_Debit/debit_template.dart';

mixin DebitnotesService {
  final DebitController debitController = Get.find<DebitController>();
  final ViewsendController viewsendController = Get.find<ViewsendController>();

  void addtable_row(context) {
    debitController.updateRec_ValueControllerText(debitController.debitModel.recommendationHeadingController.value.text);
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
    debitController.updateRecommendation(index: debitController.debitModel.recommendation_editIndex.value!, key: debitController.debitModel.recommendationKeyController.value.text.toString(), value: debitController.debitModel.recommendationValueController.value.text.toString());
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
    debitController.updateRec_KeyControllerText(note.key.toString());
    debitController.updateRec_ValueControllerText(note.value.toString());
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

  void Generate_Debit(BuildContext context) async {
    // Start generating PDF data as a Future
    viewsendController.setLoading(false);
    final pdfGenerationFuture = generate_Debit(PdfPageFormat.a4, debitController.debitModel.Debit_products, debitController.debitModel.clientAddressNameController.value.text, debitController.debitModel.clientAddressController.value.text, debitController.debitModel.billingAddressNameController.value.text, debitController.debitModel.billingAddressController.value.text, debitController.debitModel.Debit_no.value, 9, debitController.debitModel.Debit_gstTotals);

    // Show the dialog immediately (not awaited)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Primary_colors.Light,
          content: Generate_popup(
            type: 'E://Debit.pdf', // Pass the expected file path
          ),
        );
      },
    );

    // Wait for PDF data generation to complete
    final pdfData = await pdfGenerationFuture;
    const filePath = 'E://Debit.pdf';
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
