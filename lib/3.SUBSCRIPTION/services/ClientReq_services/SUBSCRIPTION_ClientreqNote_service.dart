import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart' show SUBSCRIPTION_ClientreqController;
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/SUBSCRIPTION_ClientReq_entities.dart' show SUBSCRIPTION_Post_ClientRequirement;
import 'package:ssipl_billing/3.SUBSCRIPTION/views/Process/Generate_client_req/SUBSCRIPTION_clientreq_template.dart';
import 'package:ssipl_billing/API-/api.dart' show API;
import 'package:ssipl_billing/API-/invoker.dart' show Invoker;
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart' show Basic_dialog;
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart' show CMDmResponse;
import 'package:ssipl_billing/IAM-/controllers/IAM_actions.dart' show SessiontokenController;
import 'package:ssipl_billing/UTILS-/helpers/support_functions.dart' show getCurrentDate;

mixin SUBSCRIPTION_ClientreqNoteService {
  final SUBSCRIPTION_ClientreqController clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final loader = LoadingOverlay();
  void addtable_row(context) {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      clientreqController.updateRec_ValueControllerText(clientreqController.clientReqModel.Rec_HeadingController.value.text);
      bool exists = clientreqController.clientReqModel.clientReqRecommendationList.any((note) => note.key == clientreqController.clientReqModel.Rec_KeyController.value.text);
      if (exists) {
        Get.snackbar("Note", 'This note Name already exists.');

        return;
      }
      clientreqController.addRecommendation(key: clientreqController.clientReqModel.Rec_KeyController.value.text, value: clientreqController.clientReqModel.Rec_ValueController.value.text);
      cleartable_Fields();
    }
  }

  void updatenote() {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      clientreqController.updateNoteList(clientreqController.clientReqModel.noteContentController.value.text, clientreqController.clientReqModel.noteEditIndex.value!);
      clearnoteFields();
      clientreqController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    clientreqController.updateRecommendation(
        index: clientreqController.clientReqModel.Rec_EditIndex.value!,
        key: clientreqController.clientReqModel.Rec_KeyController.value.text.toString(),
        value: clientreqController.clientReqModel.Rec_ValueController.value.text.toString());
    cleartable_Fields();
    clientreqController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    clientreqController.updateNoteContentControllerText(clientreqController.clientReqModel.clientReqNoteList[index]);
    clientreqController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = clientreqController.clientReqModel.clientReqRecommendationList[index];
    clientreqController.updateRec_KeyControllerText(note.key.toString());
    clientreqController.updateRec_ValueControllerText(note.value.toString());
    clientreqController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      clientreqController.updateNoteEditindex(null);
      clientreqController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    clientreqController.clientReqModel.noteContentController.value.clear();
  }

  void cleartable_Fields() {
    clientreqController.clientReqModel.Rec_KeyController.value.clear();
    clientreqController.clientReqModel.Rec_ValueController.value.clear();
  }

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

  dynamic postData(context, customer_type) async {
    try {
      if (clientreqController.postDatavalidation()) {
        await Basic_dialog(context: context, showCancel: false, title: "POST", content: "All fields must be filled", onOk: () {});
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
        // clientreqController.clientReqModel.customer_id.value,
        // clientreqController.clientReqModel.selected_branchList,
        // customer_type == "Enquiry" ? 1 : 2
      );

      await send_data(context, jsonEncode(salesData.toJson()), cachedPdf);
    } catch (e) {
      await Basic_dialog(context: context, showCancel: false, title: "POST", content: "$e", onOk: () {});
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, file, API.subscription_add_details_API);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          loader.stop();
          await Basic_dialog(context: context, showCancel: false, title: "CLIENT REQUIREMENT", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
          clientreqController.resetData();
        } else {
          loader.stop();
          await Basic_dialog(context: context, showCancel: false, title: 'Processing client requirement', content: value.message ?? "", onOk: () {});
        }
      } else {
        loader.stop();
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
      //await Refresher().refreshAll(context);
    } catch (e) {
      loader.stop();
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }
}
