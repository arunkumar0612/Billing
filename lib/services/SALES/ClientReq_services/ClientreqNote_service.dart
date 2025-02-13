import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/services/APIservices/invoker.dart';
import 'package:ssipl_billing/utils/helpers/support_functions.dart';
import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';
import '../../../controllers/SALEScontrollers/ClientReq_actions.dart';
import '../../../controllers/viewSend_actions.dart';
import '../../../models/constants/api.dart';
import '../../../models/entities/SALES/ClientReq_entities.dart';

mixin ClientreqNoteService {
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  final ViewsendController viewsendController = Get.find<ViewsendController>();
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  void addtable_row(context) {
    clientreqController.updateTableValueControllerText(clientreqController.clientReqModel.tableHeadingController.value.text);
    bool exists = clientreqController.clientReqModel.clientReqRecommendationList.any((note) => note.key == clientreqController.clientReqModel.tableKeyController.value.text);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('This note Name already exists.'),
        ),
      );
      return;
    }
    clientreqController.addRecommendation(key: clientreqController.clientReqModel.tableKeyController.value.text, value: clientreqController.clientReqModel.tableValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (clientreqController.clientReqModel.noteFormKey.value.currentState?.validate() ?? false) {
      clientreqController.updateNoteList(clientreqController.clientReqModel.noteContentController.value.text, clientreqController.clientReqModel.noteEditIndex.value!);
      clearnoteFields();
      clientreqController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    clientreqController.updateRecommendation(index: clientreqController.clientReqModel.noteTableEditIndex.value!, key: clientreqController.clientReqModel.tableKeyController.value.text.toString(), value: clientreqController.clientReqModel.tableValueController.value.text.toString());
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
    clientreqController.updateTableKeyControllerText(note.key.toString());
    clientreqController.updateTableValueControllerText(note.value.toString());
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
    clientreqController.clientReqModel.tableKeyController.value.clear();
    clientreqController.clientReqModel.tableValueController.value.clear();
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

  // void Generate_clientReq(BuildContext context) async {
  //   // Start generating PDF data as a Future
  //   viewsendController.setLoading(false);
  //   final pdfGenerationFuture = generate_clientreq(
  //     PdfPageFormat.a4,
  //     clientreqController.clientReqModel.clientReqProductDetails,
  //     clientreqController.clientReqModel.billingAddressNameController.value.text,
  //     clientreqController.clientReqModel.clientAddressController.value.text,
  //     clientreqController.clientReqModel.billingAddressNameController.value.text,
  //     clientreqController.clientReqModel.billingAddressController.value.text,
  //     clientreqController.clientReqModel.clientReqNo.value,
  //     clientreqController.clientReqModel.pickedFile.value?.files.single.path,
  //   );

  //   // Show the dialog immediately (not awaited)
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Primary_colors.Light,
  //         content: Generate_popup(
  //           type: 'E://clientReq.pdf', // Pass the expected file path
  //         ),
  //       );
  //     },
  //   );

  //   // Wait for PDF data generation to complete
  //   final pdfData = await pdfGenerationFuture;

  //   const filePath = 'E://clientReq.pdf';
  //   final file = File(filePath);

  //   // Perform file writing and any other future tasks in parallel
  //   await Future.wait([
  //     file.writeAsBytes(pdfData), // Write PDF to file asynchronously
  //     // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed
  //   ]);

  //   // Continue execution while the dialog is still open
  //   viewsendController.setLoading(true);
  // }

  dynamic postData(context) async {
    try {
      AddSales salesData = AddSales.fromJson(clientreqController.clientReqModel.clientNameController.value.text, clientreqController.clientReqModel.emailController.value.text, clientreqController.clientReqModel.phoneController.value.text, clientreqController.clientReqModel.clientAddressController.value.text, clientreqController.clientReqModel.gstController.value.text, clientreqController.clientReqModel.billingAddressNameController.value.text, "ssipl/ec250101", clientreqController.clientReqModel.billingAddressController.value.text, clientreqController.clientReqModel.morController.value.text, clientreqController.clientReqModel.MOR_uploadedPath.value!, clientreqController.clientReqModel.clientReqProductDetails, clientreqController.clientReqModel.clientReqNoteList, getCurrentDate());
      await send_data(context, jsonEncode(salesData.toJson()), clientreqController.clientReqModel.morFile.value!);
    } catch (e) {
      print(e);
    }
  }

  dynamic send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, file, API.sales_add_details_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await Basic_dialog(context: context, title: "CLIENT REQUIREMENT", content: value.message!, onOk: () {});
          // salesController.addToCustomerList(value);
          // print("*****************${salesController.salesModel.customerList[1].customerId}");
        } else {
          await Basic_dialog(context: context, title: 'Customer List Error', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      print(response);
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
