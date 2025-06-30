import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4_SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_DC/DC_template.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';

// import 'package:ssipl_billing/utils/helpers/returns.dart';

mixin DcnotesService {
  final DcController dcController = Get.find<DcController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  /// Adds a new recommendation to the table if it doesn’t already exist.
  ///
  /// This checks if the entered key already exists in the recommendation list.
  /// If it does, it shows an error message and stops. If not, it adds the new
  /// key-value pair to the list and clears the input fields afterwards.
  ///
  /// [context] – Used to show the error snackbar if a duplicate is found.
  void addtable_row(context) {
    // dcController.updateRec_ValueControllerText(dcController.dcModel.recommendationHeadingController.value.text);
    bool exists = dcController.dcModel.Dc_recommendationList.any((note) => note.key == dcController.dcModel.recommendationKeyController.value.text);
    if (exists) {
      Error_SnackBar(context, 'This note Name already exists.');

      return;
    }
    dcController.addRecommendation(key: dcController.dcModel.recommendationKeyController.value.text, value: dcController.dcModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  /// Updates an existing note if the form input is valid.
  ///
  /// This checks the note form for validation. If it passes, it updates the note
  /// at the current edit index with the new text, clears the input field, and
  /// resets the edit index so editing mode ends.
  void updatenote() {
    if (dcController.dcModel.noteformKey.value.currentState?.validate() ?? false) {
      dcController.updateNoteList(dcController.dcModel.notecontentController.value.text, dcController.dcModel.note_editIndex.value!);
      clearnoteFields();
      dcController.updateNoteEditindex(null);
    }
  }

  /// Updates a recommendation entry in the list with new key and value.
  ///
  /// This takes the current edit index and updates that item with the latest
  /// key and value from the input fields. After updating, it clears the fields
  /// and resets the edit index to exit editing mode.
  void updatetable() {
    dcController.updateRecommendation(
        index: dcController.dcModel.recommendation_editIndex.value!,
        key: dcController.dcModel.recommendationKeyController.value.text.toString(),
        value: dcController.dcModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    dcController.updateRecommendationEditindex(null);
  }

  /// Loads an existing note into the input field for editing.
  ///
  /// This grabs the note at the given [index], fills it into the input box,
  /// and stores the index so we know which note is being edited.
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

  /// Resets the editing state for both notes and recommendations.
  ///
  /// This clears out the note and recommendation input fields,
  /// and sets both edit indexes to null — basically exits any ongoing edits.
  void resetEditingStateNote() {
    clearnoteFields();
    cleartable_Fields();
    dcController.updateNoteEditindex(null);
    dcController.updateRecommendationEditindex(null);
  }

  void clearnoteFields() {
    dcController.dcModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    dcController.dcModel.recommendationKeyController.value.clear();
    dcController.dcModel.recommendationValueController.value.clear();
  }

  /// Adds a new note if the form input is valid and it’s not a duplicate.
  ///
  /// First, this checks if the note form is filled out properly. Then it looks
  /// through the existing notes to make sure the same content hasn’t already
  /// been added. If it’s a duplicate, it shows a snackbar and exits early.
  /// Otherwise, it adds the new note and clears the input field.
  ///
  /// [context] – Used for form validation and showing the snackbar.
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

  /// Generates a Delivery Challan (DC) PDF and saves it to the device's temporary cache directory.
  ///
  /// This method performs the following:
  /// - Generates the PDF data using `generate_Dc()` with the current DC form values (e.g., address, DC number, invoice reference).
  /// - Replaces slashes or hyphens in the DC number using `Returns.replace_Slash_hypen()` to make a valid filename.
  /// - Writes the PDF to a temporary file path under the device's cache directory.
  /// - Stores the generated `File` object in `dcController.dcModel.selectedPdf`.
  ///
  /// Debug logs the file path where the PDF is stored.
  ///
  /// **Note:** This function does not return the file directly but updates the model with the cached file reference.
  ///
  /// Example file path:
  /// `cache/1234_DC_5678.pdf`
  Future<void> savePdfToCache() async {
    Uint8List pdfData = await generate_Dc(
      PdfPageFormat.a4,
      dcController.dcModel.selected_dcProducts,
      dcController.dcModel.clientAddressNameController.value.text,
      dcController.dcModel.clientAddressController.value.text,
      dcController.dcModel.billingAddressNameController.value.text,
      dcController.dcModel.billingAddressController.value.text,
      dcController.dcModel.Dc_no.value,
      dcController.dcModel.invRef_no.value,
      dcController.dcModel.gstNumController.value.text,
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
