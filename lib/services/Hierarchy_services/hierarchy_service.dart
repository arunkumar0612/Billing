import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/models/constants/api.dart';
import 'package:ssipl_billing/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/services/APIservices/invoker.dart';
import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';
import 'package:ssipl_billing/views/components/Loading.dart';

mixin HierarchyService {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final HierarchyController hierarchyController = Get.find<HierarchyController>();
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();

  void get_OrganizationList(context) async {
    try {
      loader.start(context);
      await Future.delayed(const Duration(milliseconds: 1000));
      Map<String, dynamic>? response = await apiController.GetbyToken(API.hierarchy_OrganizationData);

      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          hierarchyController.add_Org(value);
        } else {
          await Basic_dialog(context: context, title: 'Fetch Organization List', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
        loader.stop();
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
    }
  }

  void get_CompanyList(context) async {
    try {
      loader.start(context);
      await Future.delayed(const Duration(milliseconds: 1000));
      Map<String, dynamic>? response = await apiController.GetbyToken(API.hierarchy_CompanyData);

      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          hierarchyController.add_Comp(value);
        } else {
          await Basic_dialog(context: context, title: 'Fetch Company List', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      loader.stop();
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
    }
  }

  void get_BranchList(context) async {
    try {
      loader.start(context);
      await Future.delayed(const Duration(milliseconds: 1000));
      Map<String, dynamic>? response = await apiController.GetbyToken(API.hierarchy_BranchData);

      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          hierarchyController.add_Branch(value);
        } else {
          await Basic_dialog(context: context, title: 'Fetch Branch List', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
      loader.stop();
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
    }
  }

  Future<bool> pickFile(BuildContext context, String logoType, int id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);
    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();
      if (fileLength > 2 * 1024 * 1024) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Selected file exceeds 2MB in size.'),
            actions: [ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          ),
        );
        return false;
      } else {
        uploadImage(context, file, logoType, id);
        return true;
      }
    }
    return false;
  }

  dynamic uploadImage(context, File file, String logoType, int id) async {
    try {
      Uint8List fileBytes = await file.readAsBytes();
      BranchLogoUpload logoUpload = BranchLogoUpload(
        logotype: logoType,
        id: id,
        image: fileBytes,
      );
      String encodedData = json.encode(logoUpload.toJson());
      Map<String, dynamic>? response = await apiController.SendByQuerystring(encodedData, API.hierarchy_UploadImage);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          await Basic_dialog(context: context, title: "LOGO", content: value.message!, onOk: () {}, showCancel: false);

          if (logoType == 'organization') {
            get_OrganizationList(context);
          } else if (logoType == 'company') {
            get_CompanyList(context);
          } else if (logoType == 'branch') {
            get_BranchList(context);
          }
        } else {
          await Basic_dialog(context: context, title: 'Uploading Logo', content: value.message ?? "", onOk: () {}, showCancel: false);
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!", showCancel: false);
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e", showCancel: false);
    }
  }
}
