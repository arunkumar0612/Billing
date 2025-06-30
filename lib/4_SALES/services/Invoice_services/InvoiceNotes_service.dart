import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4_SALES/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_Invoice/invoice_template.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

mixin InvoicenotesService {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  /// Adds a new recommendation row to the invoice recommendation table.
  ///
  /// This method checks whether a recommendation key (note name) already exists in the list.
  /// If it does, it displays an error message and prevents duplicate entries.
  /// Otherwise, it adds a new key-value pair to the `Invoice_recommendationList` and
  /// clears the input fields.
  ///
  /// **Functionality:**
  /// - Validates uniqueness of the `recommendationKeyController` text.
  /// - Adds the key-value pair to the recommendation list via `addRecommendation()`.
  /// - Clears both key and value input fields using `cleartable_Fields()`.
  ///
  /// **Parameters:**
  /// - `context`: Build context used to display a snackbar if the key already exists.
  ///
  /// **Use Case:**
  /// - Used when a user dynamically adds custom recommendation entries to an invoice.
  ///
  /// **Error Handling:**
  /// - Shows an error snackbar (`Error_SnackBar`) if the key already exists in the list.
  void addtable_row(context) {
    // invoiceController.updateRec_ValueControllerText(invoiceController.invoiceModel.recommendationHeadingController.value.text);
    bool exists = invoiceController.invoiceModel.Invoice_recommendationList.any((note) => note.key == invoiceController.invoiceModel.recommendationKeyController.value.text);
    if (exists) {
      Error_SnackBar(context, 'This note Name already exists.');

      return;
    }
    invoiceController.addRecommendation(key: invoiceController.invoiceModel.recommendationKeyController.value.text, value: invoiceController.invoiceModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  /// Updates an existing note in the invoice note list.
  ///
  /// This function performs validation on the note form using `noteformKey`.
  /// If the form is valid, it updates the note at the specified index with the
  /// content from `notecontentController`. After updating, it clears the input
  /// field and resets the editing index to null.
  ///
  /// **Functionality:**
  /// - Validates the note input form.
  /// - Updates the note at `note_editIndex` with new content.
  /// - Clears the note input field using `clearnoteFields()`.
  /// - Resets the editing index via `updateNoteEditindex(null)`.
  ///
  /// **Use Case:**
  /// - Used when a user edits an existing note in an invoice or quote.
  ///
  /// **Validation:**
  /// - Ensures the form is valid before applying changes.
  void updatenote() {
    if (invoiceController.invoiceModel.noteformKey.value.currentState?.validate() ?? false) {
      invoiceController.updateNoteList(invoiceController.invoiceModel.notecontentController.value.text, invoiceController.invoiceModel.note_editIndex.value!);
      clearnoteFields();
      invoiceController.updateNoteEditindex(null);
    }
  }

  /// Updates a recommendation entry in the invoice recommendation table.
  ///
  /// This function updates an existing recommendation row using the provided
  /// key-value pair at the specified index (`recommendation_editIndex`). Once updated,
  /// it clears the input fields and resets the editing index.
  ///
  /// **Functionality:**
  /// - Retrieves the current index to be edited from `recommendation_editIndex`.
  /// - Updates the recommendation list with the new key and value from their respective controllers.
  /// - Clears the recommendation input fields using `cleartable_Fields()`.
  /// - Resets the editing index via `updateRecommendationEditindex(null)`.
  ///
  /// **Use Case:**
  /// - Used when editing a row in the "Recommendation Table" section of an invoice or quote.
  ///
  /// **Note:**
  /// - Assumes the index is always valid (non-null). Caller must ensure this before invoking.
  void updatetable() {
    invoiceController.updateRecommendation(
        index: invoiceController.invoiceModel.recommendation_editIndex.value!,
        key: invoiceController.invoiceModel.recommendationKeyController.value.text.toString(),
        value: invoiceController.invoiceModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    invoiceController.updateRecommendationEditindex(null);
  }

  /// Loads an existing note into the form for editing.
  ///
  /// This function is called when a user wants to edit a note from the invoice's
  /// note list. It updates the `notecontentController` with the content of the selected
  /// note and sets the current editing index to the selected index.
  ///
  /// **Functionality:**
  /// - Fetches the note at the given `index` from `Invoice_noteList`.
  /// - Updates the text controller with the selected note's content.
  /// - Sets the editing index to the selected note using `updateNoteEditindex(index)`.
  ///
  /// **Parameters:**
  /// - `index` → The index of the note to be edited.
  ///
  /// **Use Case:**
  /// - Called when a user taps the "edit" icon/button for a note entry.
  void editnote(int index) {
    invoiceController.updateNoteContentControllerText(invoiceController.invoiceModel.Invoice_noteList[index]);
    invoiceController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = invoiceController.invoiceModel.Invoice_recommendationList[index];
    invoiceController.updateRec_KeyControllerText(note.key.toString());
    invoiceController.updateRec_ValueControllerText(note.value.toString());
    invoiceController.updateRecommendationEditindex(index);
  }

  /// Resets the editing state for both the note and recommendation table sections.
  ///
  /// This function performs the following:
  /// - Clears all note-related input fields.
  /// - Clears all recommendation table input fields.
  /// - Resets the note editing index to `null`.
  /// - Resets the recommendation editing index to `null`.
  ///
  /// Useful when cancelling or finalizing edits to ensure the form returns to a clean state.
  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      invoiceController.updateNoteEditindex(null);
      invoiceController.updateRecommendationEditindex(null);
    };
  }

  /// Clears the content of the note input field.
  ///
  /// This is typically used after submitting or canceling a note entry
  /// to reset the note input for the next entry.
  void clearnoteFields() {
    invoiceController.invoiceModel.notecontentController.value.clear();
  }

  /// Clears the input fields used for adding or editing a recommendation table entry.
  ///
  /// Specifically:
  /// - Clears the key field for the recommendation.
  /// - Clears the value field for the recommendation.
  ///
  /// This is typically called after submitting or canceling a recommendation entry.
  void cleartable_Fields() {
    invoiceController.invoiceModel.recommendationKeyController.value.clear();
    invoiceController.invoiceModel.recommendationValueController.value.clear();
  }

  /// Adds a new note to the invoice note list if it passes validation and is not a duplicate.
  ///
  /// - Validates the note input form.
  /// - Checks if the note already exists in the `Invoice_noteList`.
  /// - If valid and unique, adds the note to the list and clears the input field.
  /// - Shows a snackbar warning if the note already exists.
  void addNotes(context) {
    if (invoiceController.invoiceModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = invoiceController.invoiceModel.Invoice_noteList.any((note) => note == invoiceController.invoiceModel.notecontentController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');
        return;
      }
      invoiceController.addNote(invoiceController.invoiceModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  // void Generate_Invoice(BuildContext context) async {
  //   // viewsendController.setLoading(false);
  //   invoiceController.nextTab();
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   sub();
  //   // Start generating PDF data as a Future
  // }

  // void sub() async {
  //   final pdfData = await generate_Invoice(
  //     PdfPageFormat.a4,
  //     invoiceController.invoiceModel.Invoice_products,
  //     invoiceController.invoiceModel.clientAddressNameController.value.text,
  //     invoiceController.invoiceModel.clientAddressController.value.text,
  //     invoiceController.invoiceModel.billingAddressNameController.value.text,
  //     invoiceController.invoiceModel.billingAddressController.value.text,
  //     invoiceController.invoiceModel.Invoice_no.value,
  //     invoiceController.invoiceModel.TitleController.value.text,
  //     9,
  //     invoiceController.invoiceModel.Invoice_gstTotals,
  //   );

  //   // Show the dialog immediately (not awaited)
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Primary_colors.Light,
  //         content: Generate_popup(
  //           type: 'E://Invoice.pdf', // Pass the expected file path
  //         ),
  //       );
  //     },
  //   );

  //   // Wait for PDF data generation to complete

  //   const filePath = 'E://Invoice.pdf';
  //   final file = File(filePath);

  //   // Perform file writing and any other future tasks in parallel

  //   file.writeAsBytes(pdfData); // Write PDF to file asynchronously
  //   // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed

  //   // Continue execution while the dialog is still open
  //   viewsendController.setLoading(true);
  // }

  /// Generates an invoice PDF and saves it to the device's temporary cache directory.
  ///
  /// - Uses invoice data such as product list, addresses, invoice number, and GST details.
  /// - Formats the invoice as an A4 PDF using `generate_Invoice`.
  /// - Replaces slashes or hyphens in the invoice number to create a valid filename.
  /// - Writes the PDF bytes to a file in the temporary directory.
  /// - Stores the file reference in `invoiceModel.selectedPdf`.
  /// - Logs the file path if in debug mode.
  Future<void> savePdfToCache() async {
    Uint8List pdfData = await generate_Invoice(
        PdfPageFormat.a4,
        invoiceController.invoiceModel.Invoice_products,
        invoiceController.invoiceModel.clientAddressNameController.value.text,
        invoiceController.invoiceModel.clientAddressController.value.text,
        invoiceController.invoiceModel.billingAddressNameController.value.text,
        invoiceController.invoiceModel.billingAddressController.value.text,
        invoiceController.invoiceModel.Invoice_no.value,
        invoiceController.invoiceModel.gstNumController.value.text,
        invoiceController.invoiceModel.Invoice_gstTotals,
        isGST_Local(invoiceController.invoiceModel.gstNumController.value.text));

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedInvoiceNo = Returns.replace_Slash_hypen(invoiceController.invoiceModel.Invoice_no.value!);
    String filePath = '${tempDir.path}/$sanitizedInvoiceNo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    invoiceController.invoiceModel.selectedPdf.value = file;
    // return file;
  }
}
