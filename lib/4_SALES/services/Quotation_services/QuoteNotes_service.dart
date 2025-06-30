import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4_SALES/controllers/Quote_actions.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_Quote/quote_template.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

mixin QuotenotesService {
  final QuoteController quoteController = Get.find<QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  /// Adds a new recommendation entry to the quote's recommendation list.
  ///
  /// - Checks if a recommendation with the same key already exists to prevent duplicates.
  /// - If the key exists, displays an error snackbar and exits.
  /// - If the key is unique, it adds the recommendation using the provided key and value from the respective controllers.
  /// - Clears the input fields after successfully adding the entry.
  ///
  /// This function helps in managing dynamic key-value rows under quote recommendations.
  void addtable_row(context) {
    // quoteController.updateRec_ValueControllerText(quoteController.quoteModel.recommendationHeadingController.value.text);
    bool exists = quoteController.quoteModel.Quote_recommendationList.any((note) => note.key == quoteController.quoteModel.recommendationKeyController.value.text);
    if (exists) {
      Error_SnackBar(context, 'This note Name already exists.');

      return;
    }
    quoteController.addRecommendation(key: quoteController.quoteModel.recommendationKeyController.value.text, value: quoteController.quoteModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  /// Updates an existing note in the quote's note list.
  ///
  /// - Validates the note form using `noteformKey`.
  /// - If valid, updates the note at the specified index (`note_editIndex`) with the new content from `notecontentController`.
  /// - Clears the note input fields after the update.
  /// - Resets the note edit index to null to indicate no note is currently being edited.
  ///
  /// This function is used when editing an existing note entry in the quote.
  void updatenote() {
    if (quoteController.quoteModel.noteformKey.value.currentState?.validate() ?? false) {
      quoteController.updateNoteList(quoteController.quoteModel.notecontentController.value.text, quoteController.quoteModel.note_editIndex.value!);
      clearnoteFields();
      quoteController.updateNoteEditindex(null);
    }
  }

  /// Updates an existing recommendation entry in the quote's recommendation list.
  ///
  /// - Uses the current edit index (`recommendation_editIndex`) to locate the recommendation to update.
  /// - Replaces the key and value of the recommendation with the updated text from `recommendationKeyController` and `recommendationValueController`.
  /// - Clears the input fields after updating the recommendation.
  /// - Resets the recommendation edit index to null, indicating no item is being edited.
  void updatetable() {
    quoteController.updateRecommendation(
        index: quoteController.quoteModel.recommendation_editIndex.value!,
        key: quoteController.quoteModel.recommendationKeyController.value.text.toString(),
        value: quoteController.quoteModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    quoteController.updateRecommendationEditindex(null);
  }

  /// Loads the selected note into the input field for editing.
  ///
  /// - Retrieves the note at the given `index` from `Quote_noteList`.
  /// - Sets the note content in `notecontentController` for user editing.
  /// - Updates the `note_editIndex` to track which note is being edited.
  void editnote(int index) {
    quoteController.updateNoteContentControllerText(quoteController.quoteModel.Quote_noteList[index]);
    quoteController.updateNoteEditindex(index);
  }

  /// Loads the selected recommendation (note table entry) into the input fields for editing.
  ///
  /// - Fetches the recommendation at the given `index` from `Quote_recommendationList`.
  /// - Sets the `recommendationKeyController` and `recommendationValueController`
  ///   with the existing key and value for user modification.
  /// - Updates `recommendation_editIndex` to track which entry is being edited.
  void editnotetable(int index) {
    final note = quoteController.quoteModel.Quote_recommendationList[index];
    quoteController.updateRec_KeyControllerText(note.key.toString());
    quoteController.updateRec_ValueControllerText(note.value.toString());
    quoteController.updateRecommendationEditindex(index);
  }

  /// Resets the editing state of both notes and recommendations in the quote form.
  ///
  /// - Clears all note and table input fields.
  /// - Sets both `note_editIndex` and `recommendation_editIndex` to null
  ///   to indicate that no item is currently being edited.
  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      quoteController.updateNoteEditindex(null);
      quoteController.updateRecommendationEditindex(null);
    };
  }

  /// Clears the text field used for entering or editing a note in the quote form.
  ///
  /// Specifically resets the `notecontentController` to an empty state.
  void clearnoteFields() {
    quoteController.quoteModel.notecontentController.value.clear();
  }

  /// Clears the input fields used for adding or editing a recommendation entry in the quote form.
  ///
  /// Resets both the key and value text controllers to empty strings.
  void cleartable_Fields() {
    quoteController.quoteModel.recommendationKeyController.value.clear();
    quoteController.quoteModel.recommendationValueController.value.clear();
  }

  /// Adds a new note to the quote if it passes validation and does not already exist.
  ///
  /// - Validates the note input form.
  /// - Checks for duplicates in the existing note list.
  /// - If unique, adds the note and clears the input field.
  /// - Shows a snackbar if the note already exists.
  void addNotes(context) {
    if (quoteController.quoteModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = quoteController.quoteModel.Quote_noteList.any((note) => note == quoteController.quoteModel.notecontentController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');
        return;
      }
      quoteController.addNote(quoteController.quoteModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  // void Generate_Quote(BuildContext context) async {
  //   // viewsendController.setLoading(false);
  //   quoteController.nextTab();
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   sub();
  //   // Start generating PDF data as a Future
  // }

  // void sub() async {
  //   final pdfData = await generate_Quote(
  //     PdfPageFormat.a4,
  //     quoteController.quoteModel.Quote_products,
  //     quoteController.quoteModel.clientAddressNameController.value.text,
  //     quoteController.quoteModel.clientAddressController.value.text,
  //     quoteController.quoteModel.billingAddressNameController.value.text,
  //     quoteController.quoteModel.billingAddressController.value.text,
  //     quoteController.quoteModel.Quote_no.value,
  //     quoteController.quoteModel.TitleController.value.text,
  //     9,
  //     quoteController.quoteModel.Quote_gstTotals,
  //   );

  //   // Show the dialog immediately (not awaited)
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Primary_colors.Light,
  //         content: Generate_popup(
  //           type: 'E://Quote.pdf', // Pass the expected file path
  //         ),
  //       );
  //     },
  //   );

  //   // Wait for PDF data generation to complete

  //   const filePath = 'E://Quote.pdf';
  //   final file = File(filePath);

  //   // Perform file writing and any other future tasks in parallel

  //   file.writeAsBytes(pdfData); // Write PDF to file asynchronously
  //   // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed

  //   // Continue execution while the dialog is still open
  //   viewsendController.setLoading(true);
  // }

  /// Generates a quote PDF and saves it to the temporary cache directory.
  ///
  /// - Uses `generate_Quote()` to create the PDF content from quote details.
  /// - Sanitizes the quote number to form a valid filename.
  /// - Writes the PDF as a file in the system's temporary directory.
  /// - Updates the `selectedPdf` in the quote model with the saved file reference.
  /// - Prints the cached file path in debug mode for verification.
  Future<void> savePdfToCache() async {
    Uint8List pdfData = await generate_Quote(
      PdfPageFormat.a4,
      quoteController.quoteModel.Quote_products,
      quoteController.quoteModel.clientAddressNameController.value.text,
      quoteController.quoteModel.clientAddressController.value.text,
      quoteController.quoteModel.billingAddressNameController.value.text,
      quoteController.quoteModel.billingAddressController.value.text,
      quoteController.quoteModel.Quote_no.value,
      quoteController.quoteModel.gstNumController.value.text,
      // 9,
      quoteController.quoteModel.Quote_gstTotals,
      isGST_Local(quoteController.quoteModel.gstNumController.value.text),
    );

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedQuoteNo = Returns.replace_Slash_hypen(quoteController.quoteModel.Quote_no.value!);
    String filePath = '${tempDir.path}/$sanitizedQuoteNo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    quoteController.quoteModel.selectedPdf.value = file;
    // return file;
  }
}
