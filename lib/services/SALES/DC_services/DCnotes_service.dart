import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/DC_actions.dart';
import 'package:ssipl_billing/models/entities/SALES/DC_entities.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_DC/DC_template.dart';

// import '../../../controllers/viewSend_actions.dart';
import '../../../themes/style.dart';
import '../../../views/components/view_send_pdf.dart';

mixin DcnotesService {
  final DCController dcController = Get.find<DCController>();
  // final ViewsendController viewsendController = Get.find<ViewsendController>();

  void addtable_row(context) {
    dcController.updateRec_ValueControllerText(dcController.dcModel.recommendationHeadingController.value.text);
    bool exists = dcController.dcModel.Delivery_challan_recommendationList.any((note) => note.key == dcController.dcModel.recommendationKeyController.value.text);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('This note Name already exists.'),
        ),
      );
      return;
    }
    dcController.addRecommendation(key: dcController.dcModel.recommendationKeyController.value.text, value: dcController.dcModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (dcController.dcModel.noteformKey.value.currentState?.validate() ?? false) {
      dcController.updateNoteList(dcController.dcModel.notecontentController.value.text, dcController.dcModel.note_editIndex.value!);
      clearnoteFields();
      dcController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    dcController.updateRecommendation(index: dcController.dcModel.recommendation_editIndex.value!, key: dcController.dcModel.recommendationKeyController.value.text.toString(), value: dcController.dcModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    dcController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    Note note = dcController.dcModel.Delivery_challan_noteList[index];
    dcController.updateNoteContentControllerText(note.notename);
    dcController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = dcController.dcModel.Delivery_challan_recommendationList[index];
    dcController.updateRec_KeyControllerText(note.key.toString());
    dcController.updateRec_ValueControllerText(note.value.toString());
    dcController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      dcController.updateNoteEditindex(null);
      dcController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    dcController.dcModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    dcController.dcModel.recommendationKeyController.value.clear();
    dcController.dcModel.recommendationValueController.value.clear();
  }

  void addNotes(context) {
    if (dcController.dcModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = dcController.dcModel.Delivery_challan_noteList.any((note) => note.notename == dcController.dcModel.notecontentController.value.text);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This note Name already exists.'),
          ),
        );
        return;
      }
      dcController.addNote(dcController.dcModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  void generate_DC(BuildContext context) async {
    // Start generating PDF data as a Future
    // viewsendController.setLoading(false);
    final pdfGenerationFuture = generate_Delivery_challan(
      PdfPageFormat.a4,
      dcController.dcModel.Delivery_challan_products,
      dcController.dcModel.clientAddressNameController.value.text,
      dcController.dcModel.clientAddressController.value.text,
      dcController.dcModel.billingAddressNameController.value.text,
      dcController.dcModel.billingAddressController.value.text,
      dcController.dcModel.Delivery_challan_no.value,
      dcController.dcModel.TitleController.value.text,
    );

    // Show the dialog immediately (not awaited)
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       backgroundColor: Primary_colors.Light,
    //       content: Generate_popup(
    //         type: 'E://Delivery_challan.pdf', // Pass the expected file path
    //       ),
    //     );
    //   },
    // );

    // Wait for PDF data generation to complete
    final pdfData = await pdfGenerationFuture;
    const filePath = 'E://Delivery_challan.pdf';
    final file = File(filePath);

    // Perform file writing and any other future tasks in parallel
    await Future.wait([
      file.writeAsBytes(pdfData), // Write PDF to file asynchronously
      Future.delayed(const Duration(seconds: 2)), // Simulate any other async task if needed
    ]);

    // Continue execution while the dialog is still open
    // viewsendController.setLoading(true);
  }
}
