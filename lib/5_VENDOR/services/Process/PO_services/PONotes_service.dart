import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Process/PO_actions.dart';
import 'package:ssipl_billing/5_VENDOR/views/Process/Generate_PO/po_template.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

mixin POnotesService {
  final POController poController = Get.find<POController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  void addtable_row(context) {
    // poController.updateRec_ValueControllerText(poController.poModel.recommendationHeadingController.value.text);
    bool exists = poController.poModel.PO_recommendationList.any((note) => note.key == poController.poModel.recommendationKeyController.value.text);
    if (exists) {
      Error_SnackBar(context, 'This note Name already exists.');

      return;
    }
    poController.addRecommendation(key: poController.poModel.recommendationKeyController.value.text, value: poController.poModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (poController.poModel.noteformKey.value.currentState?.validate() ?? false) {
      poController.updateNoteList(poController.poModel.notecontentController.value.text, poController.poModel.note_editIndex.value!);
      clearnoteFields();
      poController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    poController.updateRecommendation(
        index: poController.poModel.recommendation_editIndex.value!,
        key: poController.poModel.recommendationKeyController.value.text.toString(),
        value: poController.poModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    poController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    poController.updateNoteContentControllerText(poController.poModel.PO_noteList[index]);
    poController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = poController.poModel.PO_recommendationList[index];
    poController.updateRec_KeyControllerText(note.key.toString());
    poController.updateRec_ValueControllerText(note.value.toString());
    poController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      poController.updateNoteEditindex(null);
      poController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    poController.poModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    poController.poModel.recommendationKeyController.value.clear();
    poController.poModel.recommendationValueController.value.clear();
  }

  void addNotes(context) {
    if (poController.poModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = poController.poModel.PO_noteList.any((note) => note == poController.poModel.notecontentController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');
        return;
      }
      poController.addNote(poController.poModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  // void Generate_PO(BuildContext context) async {
  //   // viewsendController.setLoading(false);
  //   poController.nextTab();
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   sub();
  //   // Start generating PDF data as a Future
  // }

  // void sub() async {
  //   final pdfData = await generate_PO(
  //     PdfPageFormat.a4,
  //     poController.poModel.PO_products,
  //     poController.poModel.clientAddressNameController.value.text,
  //     poController.poModel.clientAddressController.value.text,
  //     poController.poModel.billingAddressNameController.value.text,
  //     poController.poModel.billingAddressController.value.text,
  //     poController.poModel.PO_no.value,
  //     poController.poModel.TitleController.value.text,
  //     9,
  //     poController.poModel.PO_gstTotals,
  //   );

  //   // Show the dialog immediately (not awaited)
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Primary_colors.Light,
  //         content: Generate_popup(
  //           type: 'E://PO.pdf', // Pass the expected file path
  //         ),
  //       );
  //     },
  //   );

  //   // Wait for PDF data generation to complete

  //   const filePath = 'E://PO.pdf';
  //   final file = File(filePath);

  //   // Perform file writing and any other future tasks in parallel

  //   file.writeAsBytes(pdfData); // Write PDF to file asynchronously
  //   // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed

  //   // Continue execution while the dialog is still open
  //   viewsendController.setLoading(true);
  // }

  Future<void> savePdfToCache() async {
    Uint8List pdfData = await generate_PO(
        PdfPageFormat.a4,
        poController.poModel.PO_products,
        "18",
        poController.poModel.PAN_Controller.value.text,
        poController.poModel.contactPerson_Controller.value.text,
        poController.poModel.AddressController.value.text,
        poController.poModel.PO_no.value,
        poController.poModel.gstNumController.value.text,
        poController.poModel.PO_gstTotals,
        isGST_Local(poController.poModel.gstNumController.value.text));

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedPONo = Returns.replace_Slash_hypen(poController.poModel.PO_no.value!);
    String filePath = '${tempDir.path}/$sanitizedPONo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    poController.poModel.selectedPdf.value = file;
    // return file;
  }
}
