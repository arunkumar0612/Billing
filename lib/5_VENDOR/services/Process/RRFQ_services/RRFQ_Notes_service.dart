import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Process/RRFQ_actions.dart';
import 'package:ssipl_billing/5_VENDOR/views/Process/Generate_RRFQ/RRFQ_template.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';

mixin RrfqnotesService {
  final vendor_RrfqController rrfqController = Get.find<vendor_RrfqController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  void addtable_row(context) {
    // rrfqController.updateRec_HeadingControllerText(rrfqController.rrfqModel.recommendationHeadingController.value.text);
    bool exists = rrfqController.rrfqModel.Rrfq_recommendationList.any((note) => note.key == rrfqController.rrfqModel.recommendationKeyController.value.text);
    if (exists) {
      Error_SnackBar(context, 'This note Name already exists.');

      return;
    }
    rrfqController.addRecommendation(key: rrfqController.rrfqModel.recommendationKeyController.value.text, value: rrfqController.rrfqModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (rrfqController.rrfqModel.noteformKey.value.currentState?.validate() ?? false) {
      rrfqController.updateNoteList(rrfqController.rrfqModel.notecontentController.value.text, rrfqController.rrfqModel.note_editIndex.value!);
      clearnoteFields();
      rrfqController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    rrfqController.updateRecommendation(
        index: rrfqController.rrfqModel.recommendation_editIndex.value!,
        key: rrfqController.rrfqModel.recommendationKeyController.value.text.toString(),
        value: rrfqController.rrfqModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    rrfqController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    rrfqController.updateNoteContentControllerText(rrfqController.rrfqModel.Rrfq_noteList[index]);
    rrfqController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = rrfqController.rrfqModel.Rrfq_recommendationList[index];
    rrfqController.updateRec_KeyControllerText(note.key.toString());
    rrfqController.updateRec_ValueControllerText(note.value.toString());
    rrfqController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      rrfqController.updateNoteEditindex(null);
      rrfqController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    rrfqController.rrfqModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    rrfqController.rrfqModel.recommendationKeyController.value.clear();
    rrfqController.rrfqModel.recommendationValueController.value.clear();
  }

  void addNotes(context) {
    if (rrfqController.rrfqModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = rrfqController.rrfqModel.Rrfq_noteList.any((note) => note == rrfqController.rrfqModel.notecontentController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');
        return;
      }
      rrfqController.addNote(rrfqController.rrfqModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  // void Generate_Rrfq(BuildContext context) async {
  //   // viewsendController.setLoading(false);
  //   rrfqController.nextTab();
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   sub();
  //   // Start generating PDF data as a Future
  // }

  // void sub() async {
  //   final pdfData = await generate_Rrfq(
  //     PdfPageFormat.a4,
  //     rrfqController.rrfqModel.Rrfq_products,
  //     rrfqController.rrfqModel.clientAddressNameController.value.text,
  //     rrfqController.rrfqModel.clientAddressController.value.text,
  //     rrfqController.rrfqModel.billingAddressNameController.value.text,
  //     rrfqController.rrfqModel.billingAddressController.value.text,
  //     rrfqController.rrfqModel.Rrfq_no.value,
  //     rrfqController.rrfqModel.TitleController.value.text,
  //     9,
  //     rrfqController.rrfqModel.Rrfq_gstTotals,
  //   );

  //   // Show the dialog immediately (not awaited)
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Primary_colors.Light,
  //         content: Generate_popup(
  //           type: 'E://Rrfq.pdf', // Pass the expected file path
  //         ),
  //       );
  //     },
  //   );

  //   // Wait for PDF data generation to complete

  //   const filePath = 'E://Rrfq.pdf';
  //   final file = File(filePath);

  //   // Perform file writing and any other future tasks in parallel

  //   file.writeAsBytes(pdfData); // Write PDF to file asynchronously
  //   // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed

  //   // Continue execution while the dialog is still open
  //   viewsendController.setLoading(true);
  // }

  Future<void> savePdfToCache() async {
    Uint8List pdfData = await generate_RRFQ(PdfPageFormat.a4, rrfqController.rrfqModel.Rrfq_products, "", "", "", "", rrfqController.rrfqModel.Rrfq_no.value);

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedRrfqNo = Returns.replace_Slash_hypen(rrfqController.rrfqModel.Rrfq_no.value ?? "1234");
    String filePath = '${tempDir.path}/$sanitizedRrfqNo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    rrfqController.rrfqModel.selectedPdf.value = file;
    // return file;
  }
}
