import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_client_req/clientreq_template.dart';
import '../../../controllers/ClientReq_actions.dart';
import '../../../models/entities/ClientReq_entities.dart';
import '../../../themes/style.dart';
import '../../../views/components/view_send_pdf.dart';

mixin ClientreqNoteService {
  final ClientreqController clientreqController = Get.find<ClientreqController>();

  void addtable_row(context) {
    clientreqController.updateTableValueControllerText(clientreqController.clientReqModel.tableHeadingController.value.text);
    bool exists = clientreqController.clientReqModel.clientReqRecommendationList.any((note) => note.key == clientreqController.clientReqModel.tableKeyController.value.text);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('This note Name already exists.'),
        ),
      );
      return;
    }
    clientreqController.addRecommendation(key: clientreqController.clientReqModel.tableKeyController.value.text, value: clientreqController.clientReqModel.tableValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      clientreqController.updateNoteList(clientreqController.clientReqModel.noteContentController.value.text, clientreqController.clientReqModel.noteEditIndex.value!);
      clearnoteFields();
      clientreqController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    clientreqController.updateRecommendation(index: clientreqController.clientReqModel.noteTableEditIndex.value!, key: clientreqController.clientReqModel.tableKeyController.value.text.toString(), value: clientreqController.clientReqModel.tableValueController.value.text.toString());
    cleartable_Fields();
    clientreqController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    Note note = clientreqController.clientReqModel.clientReqNoteList[index];
    clientreqController.updateNoteContentControllerText(note.notename);
    clientreqController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = clientreqController.clientReqModel.clientReqRecommendationList[index];
    clientreqController.updateTableKeyControllerText(note.key.toString());
    clientreqController.updateTableValueControllerText(note.value.toString());
    clientreqController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      clientreqController.updateNoteEditindex(null);
      clientreqController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    clientreqController.clientReqModel.noteContentController.value.clear();
  }

  void cleartable_Fields() {
    clientreqController.clientReqModel.tableKeyController.value.clear();
    clientreqController.clientReqModel.tableValueController.value.clear();
  }

  void addNotes(context) {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      bool exists = clientreqController.clientReqModel.clientReqNoteList.any((note) => note.notename == clientreqController.clientReqModel.noteContentController.value.text);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This note Name already exists.'),
          ),
        );
        return;
      }
      clientreqController.addNote(clientreqController.clientReqModel.noteContentController.value.text);
      clearnoteFields();
    }
  }

  void Generate_clientReq(context) async {
    final pdfData = await generate_clientreq(PdfPageFormat.a4, clientreqController.clientReqModel.clientReqProductDetails, clientreqController.clientReqModel.billingAddressNameController.value.text, clientreqController.clientReqModel.clientAddressController.value.text, clientreqController.clientReqModel.billingAddressNameController.value.text, clientreqController.clientReqModel.billingAddressController.value.text, clientreqController.clientReqModel.clientReqNo.value, clientreqController.clientReqModel.pickedFile.value?.files.single.path);

    const filePath = 'E://clientReq.pdf';
    final file = File(filePath);
    await file.writeAsBytes(pdfData);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Primary_colors.Light,
            content: Generate_popup(
              type: 'E://clientReq.pdf',
            ));
      },
    );
    // Sales_Client.clientReq_Callback();
  }
}
