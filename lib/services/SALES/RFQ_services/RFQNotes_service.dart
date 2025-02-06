import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/RFQ_actions.dart';
import 'package:ssipl_billing/models/entities/SALES/RFQ_entities.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_RFQ/RFQ_template.dart';

import '../../../controllers/viewSend_actions.dart';
import '../../../themes/style.dart';
import '../../../views/components/view_send_pdf.dart';
import '../../../views/screens/SALES/Generate_RFQ/RFQ_template.dart';
// import '../../../views/screens/SALES/Generate_RFQ/rfq_template.dart';

mixin RFQnotesService {
  final RFQController rfqController = Get.find<RFQController>();
  final ViewsendController viewsendController = Get.find<ViewsendController>();

  void addtable_row(context) {
    rfqController.updateTableValueControllerText(rfqController.rfqModel.recommendationHeadingController.value.text);
    bool exists = rfqController.rfqModel.RFQ_recommendationList.any((note) => note.key == rfqController.rfqModel.recommendationKeyController.value.text);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('This note Name already exists.'),
        ),
      );
      return;
    }
    rfqController.addRecommendation(key: rfqController.rfqModel.recommendationKeyController.value.text, value: rfqController.rfqModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (rfqController.rfqModel.noteformKey.value.currentState?.validate() ?? false) {
      rfqController.updateNoteList(rfqController.rfqModel.notecontentController.value.text, rfqController.rfqModel.note_editIndex.value!);
      clearnoteFields();
      rfqController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    rfqController.updateRecommendation(index: rfqController.rfqModel.recommendation_editIndex.value!, key: rfqController.rfqModel.recommendationKeyController.value.text.toString(), value: rfqController.rfqModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    rfqController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    Note note = rfqController.rfqModel.RFQ_noteList[index];
    rfqController.updateNoteContentControllerText(note.notename);
    rfqController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = rfqController.rfqModel.RFQ_recommendationList[index];
    rfqController.updateTableKeyControllerText(note.key.toString());
    rfqController.updateTableValueControllerText(note.value.toString());
    rfqController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      rfqController.updateNoteEditindex(null);
      rfqController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    rfqController.rfqModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    rfqController.rfqModel.recommendationKeyController.value.clear();
    rfqController.rfqModel.recommendationValueController.value.clear();
  }

  void addNotes(context) {
    if (rfqController.rfqModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = rfqController.rfqModel.RFQ_noteList.any((note) => note.notename == rfqController.rfqModel.notecontentController.value.text);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This note Name already exists.'),
          ),
        );
        return;
      }
      rfqController.addNote(rfqController.rfqModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  void Generate_RFQ(BuildContext context) async {
    // Start generating PDF data as a Future
    viewsendController.setLoading(false);
    final pdfGenerationFuture = generate_RFQ(
      PdfPageFormat.a4,
      rfqController.rfqModel.RFQ_products,
      rfqController.rfqModel.vendor_name_controller.value.text,
      rfqController.rfqModel.vendor_email_controller.value.text,
      rfqController.rfqModel.vendor_phone_controller.value.text,
      rfqController.rfqModel.vendor_address_controller.value.text,
      rfqController.rfqModel.RFQ_no.value,
    );

    // Show the dialog immediately (not awaited)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Primary_colors.Light,
          content: Generate_popup(
            type: 'E://RFQ.pdf', // Pass the expected file path
          ),
        );
      },
    );

    // Wait for PDF data generation to complete
    final pdfData = await pdfGenerationFuture;
    const filePath = 'E://RFQ.pdf';
    final file = File(filePath);

    // Perform file writing and any other future tasks in parallel
    await Future.wait([
      file.writeAsBytes(pdfData), // Write PDF to file asynchronously
      Future.delayed(const Duration(seconds: 2)), // Simulate any other async task if needed
    ]);

    // Continue execution while the dialog is still open
    viewsendController.setLoading(true);
  }
}
