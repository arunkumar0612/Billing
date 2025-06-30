import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4_SALES/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_RFQ/RFQ_template.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';

mixin RfqnotesService {
  final RfqController rfqController = Get.find<RfqController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  /// Adds a new recommendation row to the RFQ table if the key is unique.
  ///
  /// Checks if a recommendation with the same key already exists in `Rfq_recommendationList`.
  /// - If it exists, shows an error snackbar and exits.
  /// - If not, adds the new key-value pair to the recommendation list and clears the input fields.
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

  /// Updates an existing note in the note list if the form is valid.
  ///
  /// Validates the note form using `noteformKey`.
  /// - If valid, updates the note content at the specified edit index.
  /// - Clears the note input fields and resets the edit index to null.
  void updatenote() {
    if (rfqController.rfqModel.noteformKey.value.currentState?.validate() ?? false) {
      rfqController.updateNoteList(rfqController.rfqModel.notecontentController.value.text, rfqController.rfqModel.note_editIndex.value!);
      clearnoteFields();
      rfqController.updateNoteEditindex(null);
    }
  }

  /// Updates an existing recommendation entry in the table using the current input values.
  ///
  /// Uses the `recommendation_editIndex` to locate the entry, then updates it
  /// with the key and value from their respective controllers.
  /// Clears the input fields and resets the edit index to null after updating.
  void updatetable() {
    rfqController.updateRecommendation(
        index: rfqController.rfqModel.recommendation_editIndex.value!,
        key: rfqController.rfqModel.recommendationKeyController.value.text.toString(),
        value: rfqController.rfqModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    rfqController.updateRecommendationEditindex(null);
  }

  /// Loads the selected note into the input field for editing.
  ///
  /// Sets the note content from the note list at the given [index] into the controller,
  /// and updates the edit index to enable editing mode.
  void editnote(int index) {
    rfqController.updateNoteContentControllerText(rfqController.rfqModel.Rfq_noteList[index]);
    rfqController.updateNoteEditindex(index);
  }

  /// Loads the selected recommendation into the input fields for editing.
  ///
  /// Retrieves the key and value from the recommendation list at the given [index],
  /// sets them into their respective controllers, and updates the edit index to enable editing mode.
  void editnotetable(int index) {
    final note = rfqController.rfqModel.Rfq_recommendationList[index];
    rfqController.updateRec_KeyControllerText(note.key.toString());
    rfqController.updateRec_ValueControllerText(note.value.toString());
    rfqController.updateRecommendationEditindex(index);
  }

  /// Resets the editing state for both notes and recommendations.
  ///
  /// Clears all related input fields and resets both the note and recommendation
  /// edit indices to null, exiting editing mode.
  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      rfqController.updateNoteEditindex(null);
      rfqController.updateRecommendationEditindex(null);
    };
  }

  /// Clears the note input field by resetting the `notecontentController` text.
  void clearnoteFields() {
    rfqController.rfqModel.notecontentController.value.clear();
  }

  /// Clears the recommendation input fields by resetting both
  /// the key and value text controllers.
  void cleartable_Fields() {
    rfqController.rfqModel.recommendationKeyController.value.clear();
    rfqController.rfqModel.recommendationValueController.value.clear();
  }

  /// Adds a new note to the note list if it passes validation and is unique.
  ///
  /// Validates the note form using `noteformKey`.
  /// - If the note already exists, shows a snackbar message and exits.
  /// - If valid and unique, adds the note to the list and clears the input field.
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

  /// Generates the RFQ PDF and saves it to the device's temporary cache directory.
  ///
  /// - Uses `generate_RFQ` to create the PDF with current RFQ data.
  /// - Constructs a sanitized file name from the RFQ number to avoid invalid characters.
  /// - Saves the PDF as a `.pdf` file in the system's temporary directory.
  /// - Updates the `selectedPdf` in the RFQ model with the cached file reference.
  /// - Prints the file path in debug mode for verification.
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
