import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/models/entities/SALES/Credit_entities.dart';
import '../../../controllers/Credit_actions.dart';
import '../../../themes/style.dart';
import '../../../views/components/view_send_pdf.dart';
import '../../../views/screens/SALES/Generate_creditNote/Credit_template.dart';

mixin CreditnotesService {
  final CreditController creditController = Get.find<CreditController>();

  void addtable_row(context) {
    creditController.updateTableHeadingControllerText(creditController.creditModel.recommendationHeadingController.value.text);
    bool exists = creditController.creditModel.Credit_recommendationList.any((note) => note.key == creditController.creditModel.recommendationKeyController.value.text);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('This note Name already exists.'),
        ),
      );
      return;
    }
    creditController.addRecommendation(key: creditController.creditModel.recommendationKeyController.value.text, value: creditController.creditModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (creditController.creditModel.noteformKey.value.currentState?.validate() ?? false) {
      creditController.updateNoteList(creditController.creditModel.notecontentController.value.text, creditController.creditModel.note_editIndex.value!);
      clearnoteFields();
      creditController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    creditController.updateRecommendation(index: creditController.creditModel.recommendation_editIndex.value!, key: creditController.creditModel.recommendationKeyController.value.text.toString(), value: creditController.creditModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    creditController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    Note note = creditController.creditModel.Credit_noteList[index];
    creditController.updateNoteContentControllerText(note.notename);
    creditController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = creditController.creditModel.Credit_recommendationList[index];
    creditController.updateTableKeyControllerText(note.key.toString());
    creditController.updateTableValueControllerText(note.value.toString());
    creditController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      creditController.updateNoteEditindex(null);
      creditController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    creditController.creditModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    creditController.creditModel.recommendationKeyController.value.clear();
    creditController.creditModel.recommendationValueController.value.clear();
  }

  void addNotes(context) {
    if (creditController.creditModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = creditController.creditModel.Credit_noteList.any((note) => note.notename == creditController.creditModel.notecontentController.value.text);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This note Name already exists.'),
          ),
        );
        return;
      }
      creditController.addNote(creditController.creditModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  void Generate_Credit(context) async {
    final pdfData = await generate_Credit(PdfPageFormat.a4, creditController.creditModel.Credit_products, creditController.creditModel.clientAddressNameController.value.text, creditController.creditModel.clientAddressController.value.text, creditController.creditModel.billingAddressNameController.value.text, creditController.creditModel.billingAddressController.value.text, creditController.creditModel.Credit_no.value, 9, creditController.creditModel.Credit_gstTotals);

    const filePath = 'E://Credit.pdf';
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
              type: 'E://Credit.pdf',
            ));
      },
    );
    // Sales_Client.Credit_Callback();
  }
}
