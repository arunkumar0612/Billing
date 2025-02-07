import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import '../../../controllers/SALEScontrollers/ClientReq_actions.dart';
import '../../../models/constants/api.dart';
import '../../../models/entities/Response_entities.dart';
import '../../../models/entities/SALES/ClientReq_entities.dart';
import '../../../views/components/Basic_DialogBox.dart';
import '../../APIservices/invoker.dart';

mixin ClientreqdetailsService {
  final Invoker apiController = Get.find<Invoker>();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();

  final ClientreqController clientreqController = Get.find<ClientreqController>();
  void add_details(context) {
    // send_MOR(context);
    if (clientreqController.clientReqModel.detailsformKey.value.currentState?.validate() ?? false) {
      if (clientreqController.clientReqModel.pickedFile.value != null) {
        clientreqController.nextTab();
      } else {
        Basic_dialog(
          context: context,
          title: 'Please add a MOR referene',
          content: "",
          onOk: () {},
        );
      }
    }
  }

  void uploadMor(context, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.multiPart(file, API.Upload_MOR_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await Basic_dialog(context: context, title: 'Upload MOR', content: "MOR uploaded Successfully", onOk: () {});
          clientreqController.updateMOR_uploadedPath(value);
        } else {
          await Basic_dialog(context: context, title: 'Upload MOR', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  void postData(context) async {
    try {
      String jsonData = '''{
    "name": "JK constructiond",
    "emailid": "ganeshkumar.m@sporadasecure.com",
    "phoneno": "8248650039",
    "address": "chinnverampatti,udumallai",
    "gst": "33ABCD43wsd123",
    "billingaddressname": "JK construction",
    "customerrequirementid": "ssipl/ec250101",
    "billingaddress": "chinnverampatti,udumallai",
    "modeofrequest": "mailid",
    "MORreference": "//192.168.0.156/backup",
    "product": [
      {"productname": "camera", "productquantity": 1},
      {"productname": "dvr", "productquantity": 1}
    ],
    "notes": [{"note": "aqefrfcqf"}],
    "messagetype": 3,
    "invoiceamount": 2423,
    "date": "2025-02-06"
  }''';

      Map<String, dynamic> jsonMap = jsonDecode(jsonData);
      print(jsonMap);
      AddSales salesData = AddSales.fromJson(jsonMap);
      print(salesData.address);
      send_data(context, jsonData, clientreqController.clientReqModel.morFile.value!);
    } catch (e) {
      print(e);
    }
  }

  void send_data(context, String jsonData, File file) async {
    try {
      Map<String, dynamic>? response = await apiController.Multer(sessiontokenController.sessiontokenModel.sessiontoken.value, jsonData, file, API.sales_add_details_API);
      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          await Basic_dialog(context: context, title: 'Customer List', content: "Customer List fetched successfully", onOk: () {});
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
