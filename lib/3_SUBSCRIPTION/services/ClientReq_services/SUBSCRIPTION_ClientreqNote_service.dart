import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart' show SUBSCRIPTION_ClientreqController;
import 'package:ssipl_billing/3_SUBSCRIPTION/models/entities/SUBSCRIPTION_ClientReq_entities.dart' show SUBSCRIPTION_Post_ClientRequirement;
import 'package:ssipl_billing/3_SUBSCRIPTION/views/Process/Generate_client_req/SUBSCRIPTION_clientreq_template.dart';
import 'package:ssipl_billing/API/api.dart' show API;
import 'package:ssipl_billing/API/invoker.dart' show Invoker;
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart' show CMDmResponse;
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart' show SessiontokenController;
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart' show getCurrentDate;

mixin SUBSCRIPTION_ClientreqNoteService {
  final SUBSCRIPTION_ClientreqController clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final loader = LoadingOverlay();

  /// Adds a new recommendation row to the table if the form is valid.
  /// Checks for duplicate note keys to avoid redundancy.
  /// Shows a warning snackbar if the note key already exists.
  /// Adds the key-value pair to the recommendation list on success.
  /// Clears the input fields after adding the recommendation.
  void addtable_row(context) {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      // clientreqController.updateRe(clientreqController.clientReqModel.Rec_HeadingController.value.text);
      bool exists = clientreqController.clientReqModel.clientReqRecommendationList.any((note) => note.key == clientreqController.clientReqModel.Rec_KeyController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');

        return;
      }
      clientreqController.addRecommendation(key: clientreqController.clientReqModel.Rec_KeyController.value.text, value: clientreqController.clientReqModel.Rec_ValueController.value.text);
      cleartable_Fields();
    }
  }

  /// Updates an existing note in the list if the note form is valid.
  /// Uses the current content and index to update the specific note entry.
  /// Clears the note input fields after the update.
  /// Resets the note edit index to null after completion.
  /// Ensures clean state management for editing notes.
  void updatenote() {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      clientreqController.updateNoteList(clientreqController.clientReqModel.noteContentController.value.text, clientreqController.clientReqModel.noteEditIndex.value!);
      clearnoteFields();
      clientreqController.updateNoteEditindex(null);
    }
  }

  /// Updates an existing recommendation in the table using the current edit index.
  /// Applies updated key and value from the respective text controllers.
  /// Clears the recommendation input fields after updating.
  /// Resets the recommendation edit index to null.
  /// Ensures the edited table row reflects the new data correctly.
  void updatetable() {
    clientreqController.updateRecommendation(
        index: clientreqController.clientReqModel.Rec_EditIndex.value!,
        key: clientreqController.clientReqModel.Rec_KeyController.value.text.toString(),
        value: clientreqController.clientReqModel.Rec_ValueController.value.text.toString());
    cleartable_Fields();
    clientreqController.updateRecommendationEditindex(null);
  }

  /// Loads the selected note content into the note input field for editing.
  /// Retrieves the note at the given [index] from the note list.
  /// Updates the note content controller with the selected note's text.
  /// Sets the current edit index in the controller for tracking.
  /// Prepares the UI for updating an existing note entry.
  void editnote(int index) {
    clientreqController.updateNoteContentControllerText(clientreqController.clientReqModel.clientReqNoteList[index]);
    clientreqController.updateNoteEditindex(index);
  }

  /// Loads the selected recommendation row into the input fields for editing.
  /// Retrieves the recommendation at the specified [index] from the list.
  /// Updates the key and value text controllers with the selected data.
  /// Sets the current recommendation edit index in the controller.
  /// Prepares the table UI for editing the selected recommendation entry.
  void editnotetable(int index) {
    final note = clientreqController.clientReqModel.clientReqRecommendationList[index];
    clientreqController.updateRec_KeyControllerText(note.key.toString());
    clientreqController.updateRec_ValueControllerText(note.value.toString());
    clientreqController.updateRecommendationEditindex(index);
  }

  /// Resets all editing states related to notes and recommendations.
  /// Clears both note and table input fields.
  /// Resets the note editing index to `null`.
  /// Resets the recommendation editing index to `null`.
  /// Ensures a clean slate for creating new entries after editing.
  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      clientreqController.updateNoteEditindex(null);
      clientreqController.updateRecommendationEditindex(null);
    };
  }

// Function to delete a note from the list
  /// Clears the text in the note content input field.
  /// Resets the [noteContentController] to an empty state.
  void clearnoteFields() {
    clientreqController.clientReqModel.noteContentController.value.clear();
  }

// Function to clear the fields in the recommendation table
  /// Clears the key and value input fields used for recommendations.
  /// Resets both [Rec_KeyController] and [Rec_ValueController] to empty.
  void cleartable_Fields() {
    clientreqController.clientReqModel.Rec_KeyController.value.clear();
    clientreqController.clientReqModel.Rec_ValueController.value.clear();
  }

  /// Adds a new note to the note list if the input is valid and not duplicated.
  /// Validates the note form using [noteFormKey].
  /// Checks for existing notes with the same content to prevent duplicates.
  /// Adds the note to the list and clears the input field upon success.
  /// Shows a warning snackbar if a duplicate note is found.
  void addNotes(context) {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      bool exists = clientreqController.clientReqModel.clientReqNoteList.any((note) => note == clientreqController.clientReqModel.noteContentController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');
        return;
      }
      clientreqController.addNote(clientreqController.clientReqModel.noteContentController.value.text);
      clearnoteFields();
    }
  }

  /// Generates a client request PDF and saves it to the device's temporary cache directory.
  /// Uses form data and site details to create the PDF via [generateClientReq].
  /// Writes the PDF as bytes to a file named `client_request.pdf`.
  /// Logs the file path in debug mode for reference.
  /// Returns the saved [File] object for further use (e.g., sharing or uploading).
  Future<File> savePdfToCache() async {
    Uint8List pdfData = await generateClientReq(
      pageFormat: PdfPageFormat.a4,
      sites: clientreqController.clientReqModel.clientReqSiteDetails,
      clientAddrName: clientreqController.clientReqModel.clientAddressController.value.text,
      clientAddr: clientreqController.clientReqModel.clientAddressController.value.text,
      billAddrName: clientreqController.clientReqModel.billingAddressNameController.value.text,
      billAddr: clientreqController.clientReqModel.billingAddressController.value.text,
      chosenFilepath: clientreqController.clientReqModel.pickedFile.value?.files.single.path ?? '',
    );

    Directory tempDir = await getTemporaryDirectory();
    String filePath = '${tempDir.path}/client_request.pdf';

    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    return file;
  }

  /// Validates input fields and prepares client requirement data for submission.
  /// Generates a PDF using [savePdfToCache] and encodes form data into JSON.
  /// Constructs a [SUBSCRIPTION_Post_ClientRequirement] model from controller values.
  /// Sends the data and PDF to the backend using [send_data].
  /// Displays error dialogs on validation failure or exceptions during the process.
  dynamic postData(context, customer_type) async {
    try {
      if (clientreqController.postDatavalidation()) {
        await Error_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
      File cachedPdf = await savePdfToCache();
      SUBSCRIPTION_Post_ClientRequirement salesData = SUBSCRIPTION_Post_ClientRequirement.fromJson(
        clientreqController.clientReqModel.titleController.value.text,
        clientreqController.clientReqModel.clientNameController.value.text,
        clientreqController.clientReqModel.emailController.value.text,
        clientreqController.clientReqModel.phoneController.value.text,
        clientreqController.clientReqModel.clientAddressController.value.text,
        clientreqController.clientReqModel.gstController.value.text,
        clientreqController.clientReqModel.billingAddressNameController.value.text,
        clientreqController.clientReqModel.billingAddressController.value.text,
        clientreqController.clientReqModel.morController.value.text,
        clientreqController.clientReqModel.MOR_uploadedPath.value!,
        clientreqController.clientReqModel.clientReqSiteDetails,
        clientreqController.clientReqModel.clientReqNoteList,
        getCurrentDate(),
        clientreqController.clientReqModel.CompanyID_Controller.value,
        // clientreqController.clientReqModel.customer_id.value,
        // clientreqController.clientReqModel.selected_branchList,
        // customer_type == "Enquiry" ? 1 : 2
      );

      await send_data(context, jsonEncode(salesData.toJson()), cachedPdf);
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  /// Sends client requirement data and the generated PDF file to the backend API.
  /// Uses the [Multer] method with session token and multipart form submission.
  /// Handles response status and shows success or error dialogs accordingly.
  /// Stops the loader upon completion or failure of the request.
  /// Resets form data and navigates back on successful submission.
  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.subscription_add_details_API);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Success_dialog(context: context, title: "SUCCESS", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
          clientreqController.resetData();
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Processing client requirement', content: value.message ?? "", onOk: () {});
        }
      } else {
        loader.stop();
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      //await Refresher().refreshAll(context);
    } catch (e) {
      loader.stop();
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
