import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/services/APIservices/invoker.dart';
import 'package:ssipl_billing/utils/helpers/support_functions.dart';
import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_client_req/clientreq_template.dart';
import '../../../controllers/SALEScontrollers/ClientReq_actions.dart';
import '../../../models/constants/api.dart';
import '../../../models/entities/SALES/ClientReq_entities.dart';

mixin ClientreqNoteService {
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  void addtable_row(context) {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      clientreqController.updateRec_ValueControllerText(clientreqController.clientReqModel.Rec_HeadingController.value.text);
      bool exists = clientreqController.clientReqModel.clientReqRecommendationList.any((note) => note.key == clientreqController.clientReqModel.Rec_KeyController.value.text);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This note Name already exists.'),
          ),
        );
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
    clientreqController.updateRecommendation(index: clientreqController.clientReqModel.Rec_EditIndex.value!, key: clientreqController.clientReqModel.Rec_KeyController.value.text.toString(), value: clientreqController.clientReqModel.Rec_ValueController.value.text.toString());
    cleartable_Fields();
    clientreqController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    Note note = clientreqController.clientReqModel.clientReqNoteList[index];
    clientreqController.updateNoteContentControllerText(note.notename);
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
      bool exists = clientreqController.clientReqModel.clientReqNoteList.any((note) => note.notename == clientreqController.clientReqModel.noteContentController.value.text);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This note Name already exists.'),
          ),
        );
        return;
      }
      clientreqController.addNote(clientreqController.clientReqModel.noteContentController.value.text);
      clearnoteFields();
    }
  }

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

  dynamic postData(context, customer_type) async {
    try {
      if (clientreqController.postDatavalidation()) {
        await Basic_dialog(context: context, title: "POST", content: "All fields must be filled", onOk: () {});
        return;
      }
      File cachedPdf = await savePdfToCache();
      Post_ClientRequirement salesData = Post_ClientRequirement.fromJson(clientreqController.clientReqModel.titleController.value.text, clientreqController.clientReqModel.clientNameController.value.text, clientreqController.clientReqModel.emailController.value.text, clientreqController.clientReqModel.phoneController.value.text, clientreqController.clientReqModel.clientAddressController.value.text, clientreqController.clientReqModel.gstController.value.text, clientreqController.clientReqModel.billingAddressNameController.value.text, clientreqController.clientReqModel.billingAddressController.value.text, clientreqController.clientReqModel.morController.value.text, clientreqController.clientReqModel.MOR_uploadedPath.value!, clientreqController.clientReqModel.clientReqProductDetails, clientreqController.clientReqModel.clientReqNoteList, getCurrentDate(), clientreqController.clientReqModel.customer_id.value, clientreqController.clientReqModel.selected_branchList, customer_type == "Enquiry" ? 1 : 2);

      await send_data(context, jsonEncode(salesData.toJson()), cachedPdf);
    } catch (e) {
      await Basic_dialog(context: context, title: "POST", content: "$e", onOk: () {});
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, file, API.sales_add_details_API);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Basic_dialog(context: context, title: "CLIENT REQUIREMENT", content: value.message!, onOk: () {});
          Navigator.of(context).pop(true);
          clientreqController.resetData();
        } else {
          await Basic_dialog(context: context, title: 'Processing client requirement', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
