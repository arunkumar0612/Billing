import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4_SALES/models/entities/ClientReq_entities.dart';
import 'package:ssipl_billing/4_SALES/views/Generate_client_req/clientreq_template.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

import '../../controllers/ClientReq_actions.dart';

mixin ClientreqNoteService {
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final loader = LoadingOverlay();

  /// Adds a new recommendation entry to the client request table if the form is valid.
  ///
  /// This method:
  /// - Validates the recommendation form using its `FormKey`.
  /// - Checks if a recommendation with the same key already exists in the list.
  ///   - If it exists, shows a snackbar notification and stops further execution.
  /// - If not, it adds the recommendation using the provided key-value pair.
  /// - Clears the input fields after successfully adding the entry.
  ///
  /// Parameters:
  /// - [context]: The current BuildContext used to show snackbars and access form state.
  void addtable_row(context) {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      // clientreqController.updateRec_ValueControllerText(clientreqController.clientReqModel.Rec_HeadingController.value.text);
      bool exists = clientreqController.clientReqModel.clientReqRecommendationList.any((note) => note.key == clientreqController.clientReqModel.Rec_KeyController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');

        return;
      }
      clientreqController.addRecommendation(key: clientreqController.clientReqModel.Rec_KeyController.value.text, value: clientreqController.clientReqModel.Rec_ValueController.value.text);
      cleartable_Fields();
    }
  }

  /// Updates an existing note in the note list if the form is valid.
  ///
  /// This method:
  /// - Validates the note form using its `FormKey`.
  /// - If valid, updates the note at the specified edit index with the current text content.
  /// - Clears the note input fields after the update.
  /// - Resets the edit index to `null` to indicate no active edit.
  ///
  /// No parameters.
  /// This function operates on state managed within `clientreqController`.
  void updatenote() {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      clientreqController.updateNoteList(clientreqController.clientReqModel.noteContentController.value.text, clientreqController.clientReqModel.noteEditIndex.value!);
      clearnoteFields();
      clientreqController.updateNoteEditindex(null);
    }
  }

  /// Updates an existing recommendation entry in the table.
  ///
  /// This method:
  /// - Retrieves the current edit index and key-value pair from the respective controllers.
  /// - Calls `updateRecommendation` to update the entry at the specified index.
  /// - Clears the recommendation input fields using `cleartable_Fields()`.
  /// - Resets the edit index to `null` to indicate that editing has ended.
  ///
  /// No parameters.
  /// This function operates on the recommendation state within `clientreqController`.
  void updatetable() {
    clientreqController.updateRecommendation(
        index: clientreqController.clientReqModel.Rec_EditIndex.value!,
        key: clientreqController.clientReqModel.Rec_KeyController.value.text.toString(),
        value: clientreqController.clientReqModel.Rec_ValueController.value.text.toString());
    cleartable_Fields();
    clientreqController.updateRecommendationEditindex(null);
  }

  /// Prepares a note entry for editing by loading its content and index.
  ///
  /// This method:
  /// - Retrieves the note at the specified [index] from the note list.
  /// - Sets the text of the note input controller with the selected note's content.
  /// - Updates the edit index to indicate which note is being edited.
  ///
  /// Parameters:
  /// - [index]: The index of the note to be edited.
  void editnote(int index) {
    clientreqController.updateNoteContentControllerText(clientreqController.clientReqModel.clientReqNoteList[index]);
    clientreqController.updateNoteEditindex(index);
  }

  /// Loads a selected recommendation entry into the text fields for editing.
  ///
  /// This just takes the item at the given index, fills the key and value input boxes
  /// so the user can update them, and marks which item is being edited.
  ///
  /// [index] – The index of the item the user wants to modify.
  void editnotetable(int index) {
    final note = clientreqController.clientReqModel.clientReqRecommendationList[index];
    clientreqController.updateRec_KeyControllerText(note.key.toString());
    clientreqController.updateRec_ValueControllerText(note.value.toString());
    clientreqController.updateRecommendationEditindex(index);
  }

  /// Clears all editing states for notes and recommendations.
  ///
  /// This resets both the note and table input fields, and also clears any
  /// active edit index. Basically brings the form back to a clean slate.
  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      clientreqController.updateNoteEditindex(null);
      clientreqController.updateRecommendationEditindex(null);
    };
  }

  /// Clears the note input field.
  ///
  /// Just resets the note text box so it’s empty — useful after adding or updating a note.
  void clearnoteFields() {
    clientreqController.clientReqModel.noteContentController.value.clear();
  }

  /// Clears the recommendation key and value input fields.
  ///
  /// This just empties both the key and value text boxes — typically called
  /// after adding or updating a recommendation.
  void cleartable_Fields() {
    clientreqController.clientReqModel.Rec_KeyController.value.clear();
    clientreqController.clientReqModel.Rec_ValueController.value.clear();
  }

  /// Adds a new note to the list if it passes validation and isn’t a duplicate.
  ///
  /// First checks if the form is valid. If the exact same note already exists,
  /// it shows a snackbar and exits. Otherwise, it adds the note and clears the input field.
  ///
  /// [context] – Needed for form validation and showing the snackbar.
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

  /// Generates a client request PDF and saves it to the device’s temporary cache folder.
  ///
  /// This function:
  /// - Builds the PDF using current form data from `clientreqController`.
  /// - Writes the PDF bytes to a temporary file named `client_request.pdf`.
  /// - Returns the saved file so it can be used later (like for sharing or previewing).
  ///
  /// Returns:
  /// - A [Future<File>] pointing to the newly saved PDF in the temp directory.
  Future<File> savePdfToCache() async {
    Uint8List pdfData = await generateClientReq(
      pageFormat: PdfPageFormat.a4,
      products: clientreqController.clientReqModel.clientReqProductDetails,
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

  /// Gathers all client request data, generates a PDF, and sends it to the backend.
  ///
  /// This function:
  /// - First checks if the required fields are valid. If not, it shows an error dialog and stops.
  /// - If valid, it shows a loader, generates a temporary PDF file using `savePdfToCache()`,
  ///   and builds a `Post_ClientRequirement` object with the form data.
  /// - Based on the `customer_type`, it sets whether the request is an Enquiry (1) or Client Request (2).
  /// - Converts the data to JSON and sends it along with the PDF using `send_data()`.
  ///
  /// [context] – Used for UI actions like dialogs and loader.
  /// [customer_type] – A string that decides whether the request is an "Enquiry" or not.
  dynamic postData(context, customer_type) async {
    try {
      if (clientreqController.postDatavalidation()) {
        await Error_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      loader.start(context);
      File cachedPdf = await savePdfToCache();
      Post_ClientRequirement salesData = Post_ClientRequirement.fromJson(
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
          clientreqController.clientReqModel.clientReqProductDetails,
          clientreqController.clientReqModel.clientReqNoteList,
          getCurrentDate(),
          clientreqController.clientReqModel.customer_id.value,
          clientreqController.clientReqModel.selected_branchList,
          customer_type == "Enquiry" ? 1 : 2);

      await send_data(context, jsonEncode(salesData.toJson()), cachedPdf);
    } catch (e) {
      await Error_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  /// Sends the client request data along with a PDF file to the backend using a multipart API call.
  ///
  /// This function:
  /// - Uses the session token and the provided JSON + file to make an API request.
  /// - If the response is successful and the server returns a success code, it:
  ///   - Stops the loader,
  ///   - Shows a success dialog,
  ///   - Pops the current screen with a `true` result,
  ///   - And resets the form data.
  /// - If there's an error or the server responds with failure, it shows the appropriate error dialog.
  ///
  /// [context] – Needed for showing dialogs and navigation.
  /// [jsonData] – The request payload in JSON string format.
  /// [file] – The generated PDF file that needs to be sent with the request.
  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, [file], API.sales_add_details_API);
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
    } catch (e) {
      loader.stop();
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
