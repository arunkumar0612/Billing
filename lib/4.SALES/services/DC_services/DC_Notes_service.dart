import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4.SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4.SALES/views/Generate_DC/DC_template.dart';
import 'package:ssipl_billing/API-/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS-/helpers/returns.dart';

// import 'package:ssipl_billing/utils/helpers/returns.dart';

mixin DcnotesService {
  final DcController dcController = Get.find<DcController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  void addtable_row(context) {
    dcController.updateRec_ValueControllerText(dcController.dcModel.recommendationHeadingController.value.text);
    bool exists = dcController.dcModel.Dc_recommendationList.any((note) => note.key == dcController.dcModel.recommendationKeyController.value.text);
    if (exists) {
      Error_SnackBar(context, 'This note Name already exists.');

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
    dcController.updateRecommendation(
        index: dcController.dcModel.recommendation_editIndex.value!,
        key: dcController.dcModel.recommendationKeyController.value.text.toString(),
        value: dcController.dcModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    dcController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    dcController.updateNoteContentControllerText(dcController.dcModel.Dc_noteList[index]);
    dcController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = dcController.dcModel.Dc_recommendationList[index];
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
      bool exists = dcController.dcModel.Dc_noteList.any((note) => note == dcController.dcModel.notecontentController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');
        return;
      }
      dcController.addNote(dcController.dcModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  // void Generate_Dc(BuildContext context) async {
  //   // viewsendController.setLoading(false);
  //   dcController.nextTab();
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   sub();
  //   // Start generating PDF data as a Future
  // }

  // void sub() async {
  //   final pdfData = await generate_Dc(
  //     PdfPageFormat.a4,
  //     dcController.dcModel.Dc_products,
  //     dcController.dcModel.clientAddressNameController.value.text,
  //     dcController.dcModel.clientAddressController.value.text,
  //     dcController.dcModel.billingAddressNameController.value.text,
  //     dcController.dcModel.billingAddressController.value.text,
  //     dcController.dcModel.Dc_no.value,
  //     dcController.dcModel.TitleController.value.text,
  //     9,
  //     dcController.dcModel.Dc_gstTotals,
  //   );

  //   // Show the dialog immediately (not awaited)
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Primary_colors.Light,
  //         content: Generate_popup(
  //           type: 'E://Dc.pdf', // Pass the expected file path
  //         ),
  //       );
  //     },
  //   );

  //   // Wait for PDF data generation to complete

  //   const filePath = 'E://Dc.pdf';
  //   final file = File(filePath);

  //   // Perform file writing and any other future tasks in parallel

  //   file.writeAsBytes(pdfData); // Write PDF to file asynchronously
  //   // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed

  //   // Continue execution while the dialog is still open
  //   viewsendController.setLoading(true);
  // }

  Future<void> savePdfToCache() async {
    Uint8List pdfData = await generate_Dc(
      PdfPageFormat.a4,
      dcController.dcModel.selected_dcProducts,
      dcController.dcModel.clientAddressNameController.value.text,
      dcController.dcModel.clientAddressController.value.text,
      dcController.dcModel.billingAddressNameController.value.text,
      dcController.dcModel.billingAddressController.value.text,
      dcController.dcModel.Dc_no.value,
      dcController.dcModel.TitleController.value.text,
      9,
    );

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedDcNo = Returns.replace_Slash_hypen(dcController.dcModel.Dc_no.value!);
    String filePath = '${tempDir.path}/$sanitizedDcNo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    dcController.dcModel.selectedPdf.value = file;
    // return file;
  }
}
