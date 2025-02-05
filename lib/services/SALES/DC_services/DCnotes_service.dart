import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/DC_actions.dart';
import 'package:ssipl_billing/models/entities/SALES/DC_entities.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_DC/DC_template.dart';

import '../../../themes/style.dart';
import '../../../views/components/view_send_pdf.dart';

mixin DcnotesService {
  final DCController dcController = Get.find<DCController>();

  void addtable_row(context) {
    dcController.updateTableValueControllerText(dcController.dcModel.recommendationHeadingController.value.text);
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
    dcController.updateTableKeyControllerText(note.key.toString());
    dcController.updateTableValueControllerText(note.value.toString());
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

  void generate_DC(context) async {
    final pdfData = await generate_Delivery_challan(
      PdfPageFormat.a4,
      dcController.dcModel.Delivery_challan_products,
      dcController.dcModel.clientAddressNameController.value.text,
      dcController.dcModel.clientAddressController.value.text,
      dcController.dcModel.billingAddressNameController.value.text,
      dcController.dcModel.billingAddressController.value.text,
      dcController.dcModel.Delivery_challan_no.value,
      dcController.dcModel.TitleController.value.text,
    );

    const filePath = 'E://Delivery_challan.pdf';
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
              type: 'E://Delivery_challan.pdf',
            ));
      },
    );
    // Sales_Client.Delivery_challan_Callback();
  }
}
