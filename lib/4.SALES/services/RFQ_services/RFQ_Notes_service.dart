import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4.SALES/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/4.SALES/views/Generate_RFQ/RFQ_template.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';

mixin RfqnotesService {
  final RfqController rfqController = Get.find<RfqController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  void addtable_row(context) {
    // rfqController.updateRec_HeadingControllerText(rfqController.rfqModel.recommendationHeadingController.value.text);
    bool exists = rfqController.rfqModel.Rfq_recommendationList.any((note) => note.key == rfqController.rfqModel.recommendationKeyController.value.text);
    if (exists) {
      Error_SnackBar(context, 'This note Name already exists.');

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
    rfqController.updateRecommendation(
        index: rfqController.rfqModel.recommendation_editIndex.value!,
        key: rfqController.rfqModel.recommendationKeyController.value.text.toString(),
        value: rfqController.rfqModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    rfqController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    rfqController.updateNoteContentControllerText(rfqController.rfqModel.Rfq_noteList[index]);
    rfqController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = rfqController.rfqModel.Rfq_recommendationList[index];
    rfqController.updateRec_KeyControllerText(note.key.toString());
    rfqController.updateRec_ValueControllerText(note.value.toString());
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
      bool exists = rfqController.rfqModel.Rfq_noteList.any((note) => note == rfqController.rfqModel.notecontentController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');
        return;
      }
      rfqController.addNote(rfqController.rfqModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  // void Generate_Rfq(BuildContext context) async {
  //   // viewsendController.setLoading(false);
  //   rfqController.nextTab();
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   sub();
  //   // Start generating PDF data as a Future
  // }

  // void sub() async {
  //   final pdfData = await generate_Rfq(
  //     PdfPageFormat.a4,
  //     rfqController.rfqModel.Rfq_products,
  //     rfqController.rfqModel.clientAddressNameController.value.text,
  //     rfqController.rfqModel.clientAddressController.value.text,
  //     rfqController.rfqModel.billingAddressNameController.value.text,
  //     rfqController.rfqModel.billingAddressController.value.text,
  //     rfqController.rfqModel.Rfq_no.value,
  //     rfqController.rfqModel.TitleController.value.text,
  //     9,
  //     rfqController.rfqModel.Rfq_gstTotals,
  //   );

  //   // Show the dialog immediately (not awaited)
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Primary_colors.Light,
  //         content: Generate_popup(
  //           type: 'E://Rfq.pdf', // Pass the expected file path
  //         ),
  //       );
  //     },
  //   );

  //   // Wait for PDF data generation to complete

  //   const filePath = 'E://Rfq.pdf';
  //   final file = File(filePath);

  //   // Perform file writing and any other future tasks in parallel

  //   file.writeAsBytes(pdfData); // Write PDF to file asynchronously
  //   // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed

  //   // Continue execution while the dialog is still open
  //   viewsendController.setLoading(true);
  // }

  Future<void> savePdfToCache() async {
    Uint8List pdfData = await generate_RFQ(PdfPageFormat.a4, rfqController.rfqModel.Rfq_products, "", "", "", "", rfqController.rfqModel.Rfq_no.value);

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedRfqNo = Returns.replace_Slash_hypen(rfqController.rfqModel.Rfq_no.value ?? "1234");
    String filePath = '${tempDir.path}/$sanitizedRfqNo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    rfqController.rfqModel.selectedPdf.value = file;
    // return file;
  }
}
