import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/DC_actions.dart';

mixin DcnotesService {
  final DCController dcController = Get.find<DCController>();

  void addtable_row(context) {
    dcController.updateTableValueControllerText(dcController.dcModel.tableHeadingController.value.text);
    bool exists = dcController.dcModel.Delivery_challan_recommendationList.any((note) => note['key'] == dcController.dcModel.tableKeyController.value.text);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('This note Name already exists.'),
        ),
      );
      return;
    }
    dcController.addRecommendation(key: dcController.dcModel.tableKeyController.value.text, value: dcController.dcModel.tableValueController.value.text);
    dcController.updateNoteLength(dcController.dcModel.Delivery_challan_recommendationList.length);
  }

  void updatenote() {
    if (dcController.dcModel.noteformKey.value.currentState?.validate() ?? false) {
      dcController.dcModel.Delivery_challan_noteList[dcController.dcModel.noteeditIndex.value!] = {
        'notecontent': dcController.dcModel.notecontentController.value.text,
      };
      clearnoteFields();
      dcController.updateNoteEditindex(null);
      dcController.updateNoteLength(dcController.dcModel.Delivery_challan_noteList.length);
    }
  }

  void updatetable() {
    dcController.updateRecommendation(index: dcController.dcModel.notetable_editIndex.value!, key: dcController.dcModel.tableKeyController.value.text.toString(), value: dcController.dcModel.tableValueController.value.text.toString());
    cleartable_Fields();
    dcController.updateNoteTableEditindex(null);
    dcController.updateNoteTableLength(dcController.dcModel.Delivery_challan_recommendationList.length);
  }

  void editnote(int index) {
    Map<String, dynamic> note = dcController.dcModel.Delivery_challan_noteList[index];
    dcController.updateNoteContentControllerText(note['notecontent'] ?? "");
    dcController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    Map<String, dynamic> note = dcController.dcModel.Delivery_challan_recommendationList[index];
    dcController.updateTableKeyControllerText(note['key'].toString());
    dcController.updateTableValueControllerText(note['value'].toString());
    dcController.updateNoteTableEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      dcController.updateNoteEditindex(null);
      dcController.updateNoteTableEditindex(null);
    };
  }

  void clearnoteFields() {
    dcController.dcModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    dcController.dcModel.tableKeyController.value.clear();
    dcController.dcModel.tableValueController.value.clear();
  }

  void addNotes(context) {
    if (dcController.dcModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = dcController.dcModel.Delivery_challan_noteList.any((note) => note['notename'] == dcController.dcModel.notecontentController.value.text);
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
      dcController.updateNoteLength(dcController.dcModel.Delivery_challan_noteList.length);
      clearnoteFields();
    }
  }
}
