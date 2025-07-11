import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/7_HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7_HIERARCHY/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

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
          hierarchyController.search(hierarchyController.hierarchyModel.searchQuery.value);
          // print(hierarchyController.hierarchyModel.OrganizationList.value.Live [0].)
        } else {
          loader.stop();
          await Error_dialog(context: context, title: 'Fetch Organization List', content: value.message ?? "", onOk: () {});
        }
        loader.stop();
        return;
      } else {
        loader.stop();
        await Error_dialog(
          context: context,
          title: "SERVER DOWN",
          content: "Please contact administration!",
        );
        loader.stop();
        return;
      }
    } catch (e) {
      loader.stop();
      Error_dialog(context: context, title: "ERROR", content: "$e");
      return;
    }
  }

  void get_CompanyList(context) async {
    try {
      loader.start(context);
      await Future.delayed(const Duration(milliseconds: 1000));
      Map<String, dynamic>? response;
      if (hierarchyController.hierarchyModel.OrgID.value == null) {
        response = await apiController.GetbyToken(API.hierarchy_CompanyData);
      } else {
        final Map<String, dynamic> requestBody = {"organizationid": hierarchyController.hierarchyModel.OrgID.value};
        response = await apiController.GetbyQueryString(requestBody, API.hierarchy_CompanyData);
      }

      // Map<String, dynamic>? response = await apiController.GetbyToken(API.hierarchy_CompanyData);

      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          hierarchyController.add_Comp(value);
          hierarchyController.search(hierarchyController.hierarchyModel.searchQuery.value);
        } else {
          loader.stop();
          await Error_dialog(
            context: context,
            title: 'Fetch Company List',
            content: value.message ?? "",
            onOk: () {},
          );
        }
      } else {
        loader.stop();
        await Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      loader.stop();
      return;
    } catch (e) {
      loader.stop();
      Error_dialog(context: context, title: "ERROR", content: "$e");

      return;
    }
  }

  void get_BranchList(context) async {
    try {
      loader.start(context);
      await Future.delayed(const Duration(milliseconds: 1000));

      Map<String, dynamic>? response;
      if (hierarchyController.hierarchyModel.CompID.value == null) {
        response = await apiController.GetbyToken(API.hierarchy_BranchData);
      } else {
        final Map<String, dynamic> requestBody = {"customerid": hierarchyController.hierarchyModel.CompID.value};
        response = await apiController.GetbyQueryString(requestBody, API.hierarchy_BranchData);
      }

      // Map<String, dynamic>? response = await apiController.GetbyToken(API.hierarchy_BranchData);

      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response ?? {});
        if (value.code) {
          hierarchyController.add_Branch(value);
          hierarchyController.search(hierarchyController.hierarchyModel.searchQuery.value);
        } else {
          await Error_dialog(context: context, title: 'Fetch Branch List', content: value.message ?? "", onOk: () {});
        }
      } else {
        loader.stop();
        await Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
      loader.stop();
      return;
    } catch (e) {
      loader.stop();
      Error_dialog(context: context, title: "ERROR", content: "$e");
      return;
    }
  }

  Future<bool> pickFile(BuildContext context, String logoType, int id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg'], lockParentWindow: true);
    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();
      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');
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
          await Success_dialog(context: context, title: "LOGO", content: value.message!, onOk: () {});

          if (logoType == 'organization') {
            get_OrganizationList(context);
          } else if (logoType == 'company') {
            get_CompanyList(context);
          } else if (logoType == 'branch') {
            get_BranchList(context);
          }
        } else {
          await Error_dialog(context: context, title: 'Uploading Logo', content: value.message ?? "", onOk: () {});
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
