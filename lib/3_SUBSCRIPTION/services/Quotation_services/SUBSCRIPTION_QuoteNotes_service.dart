import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart' show SUBSCRIPTION_QuoteController;
import 'package:ssipl_billing/3_SUBSCRIPTION/models/entities/SUBSCRIPTION_Quote_entities.dart' show Package, SUBSCRIPTION_Quote, Site;
import 'package:ssipl_billing/3_SUBSCRIPTION/views/Process/Generate_Quote/SUBSCRIPTION_quote_template.dart' show SUBSCRIPTION_generate_Quote;
import 'package:ssipl_billing/API/invoker.dart' show Invoker;
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart' show SessiontokenController;
import 'package:ssipl_billing/UTILS/helpers/returns.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

mixin SUBSCRIPTION_QuotenotesService {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
// Function to handle the next tab action
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

// Function to handle the next tab action
  void updatenote() {
    if (quoteController.quoteModel.noteformKey.value.currentState?.validate() ?? false) {
      quoteController.updateNoteList(quoteController.quoteModel.notecontentController.value.text, quoteController.quoteModel.note_editIndex.value!);
      clearnoteFields();
      quoteController.updateNoteEditindex(null);
    }
  }

// Function to update a table row
  /// This function updates a table row in the quote model.
  void updatetable() {
    quoteController.updateRecommendation(
        index: quoteController.quoteModel.recommendation_editIndex.value!,
        key: quoteController.quoteModel.recommendationKeyController.value.text.toString(),
        value: quoteController.quoteModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    quoteController.updateRecommendationEditindex(null);
  }

// Function to edit a note
  /// This function updates the note content and sets the edit index for the note.
  void editnote(int index) {
    quoteController.updateNoteContentControllerText(quoteController.quoteModel.Quote_noteList[index]);
    quoteController.updateNoteEditindex(index);
  }

// Function to edit a table row
  /// This function updates the key and value controllers with the data from the selected recommendation.
  void editnotetable(int index) {
    final note = quoteController.quoteModel.Quote_recommendationList[index];
    quoteController.updateRec_KeyControllerText(note.key.toString());
    quoteController.updateRec_ValueControllerText(note.value.toString());
    quoteController.updateRecommendationEditindex(index);
  }

// Function to delete a note
  /// This function removes a note from the quote model's note list.
  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      quoteController.updateNoteEditindex(null);
      quoteController.updateRecommendationEditindex(null);
    };
  }

// Function to clear the note fields
  /// This function clears the note content controller's text.
  /// It is used to reset the note input field after adding or updating a note.
  void clearnoteFields() {
    quoteController.quoteModel.notecontentController.value.clear();
  }

// Function to clear the table fields
  /// This function clears the recommendation key and value controllers' text.
  void cleartable_Fields() {
    quoteController.quoteModel.recommendationKeyController.value.clear();
    quoteController.quoteModel.recommendationValueController.value.clear();
  }

// Function to add a note
  /// This function validates the note form, checks for duplicate notes,
  /// and adds a new note to the quote model's note list if it passes validation.
  void addNotes(context) {
    if (quoteController.quoteModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = quoteController.quoteModel.Quote_noteList.any((note) => note == quoteController.quoteModel.notecontentController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.', backgroundColor: const Color.fromARGB(97, 255, 193, 7));
        return;
      }
      quoteController.addNote(quoteController.quoteModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

// Function to save the PDF to cache
  /// This function generates a PDF from the quote data and saves it to the cache directory.
  /// It constructs the quote data as a map, including details like date, quote number, GSTIN, address details, package mapped sites, and notes.
  /// It then generates the PDF using the `SUBSCRIPTION_generate_Quote` function and saves it to a temporary directory.
  Future<void> savePdfToCache(context) async {
    // Constructing the data as a map
    List<Package> package_details = [];
    List<Site> siteData = [];
    List<int> amounts = [];
    for (int i = 0; i < quoteController.quoteModel.selectedPackagesList.length; i++) {
      for (int j = 0; j < quoteController.quoteModel.selectedPackagesList[i].sites.length; j++) {
        Site data = quoteController.quoteModel.selectedPackagesList[i].sites[j];
        Package sub = quoteController.quoteModel.selectedPackagesList[i];
        amounts.add(
          int.parse(sub.amount),
        );
        siteData.add(data);
        package_details.add(sub);
      }
    }
    Map<String, dynamic> quoteData = {
      "date": getCurrentDate(),
      "quoteNo": quoteController.quoteModel.Quote_no.value!.toString(),
      "gstPercent": 18,
      "GSTIN": quoteController.quoteModel.gstNumController.value.text,
      'pendingAmount': 0.0,
      "addressDetails": {
        "clientName": quoteController.quoteModel.clientAddressNameController.value.text,
        "clientAddress": quoteController.quoteModel.clientAddressController.value.text,
        "billingName": quoteController.quoteModel.billingAddressNameController.value.text,
        "billingAddress": quoteController.quoteModel.billingAddressController.value.text,
      },
      "packageMappedSites": quoteController.quoteModel.selectedPackagesList,
      "siteData": siteData,
      "notes": quoteController.quoteModel.notecontent,
    };

    SUBSCRIPTION_Quote quote = SUBSCRIPTION_Quote.fromJson(quoteData, siteData, amounts);

    Uint8List pdfData = await SUBSCRIPTION_generate_Quote(
      PdfPageFormat.a4,
      quote,
    );
    Directory tempDir = await getTemporaryDirectory();
    String sanitizedInvoiceNo = Returns.replace_Slash_hypen(quoteController.quoteModel.Quote_no.value!.toString());
    String filePath = '${tempDir.path}/$sanitizedInvoiceNo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    quoteController.updateSelectedPdf(file);
  }
}
