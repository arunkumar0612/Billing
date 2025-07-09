import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/VendorList_actions.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/manual_onboard_actions.dart';
import 'package:ssipl_billing/API/invoker.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';

mixin VendorListService {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final VendorListController vendorListController = Get.find<VendorListController>();
  final ManualOnboardController manualOnboardController = Get.find<ManualOnboardController>();
  final Invoker apiController = Get.find<Invoker>();
  final loader = LoadingOverlay();

  Future<bool> pickFile(BuildContext context, String logoType, int id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg'], lockParentWindow: true);
    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();
      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');
        return false;
      } else {
        // uploadImage(context, file, logoType, id);
        return true;
      }
    }
    return false;
  }

  // dynamic uploadImage(context, File file, String logoType, int id) async {
  //   try {
  //     Uint8List fileBytes = await file.readAsBytes();
  //     VendorLogoUpload logoUpload = VendorLogoUpload(
  //       logotype: logoType,
  //       id: id,
  //       image: fileBytes,
  //     );
  //     String encodedData = json.encode(logoUpload.toJson());
  //     Map<String, dynamic>? response = await apiController.SendByQuerystring(encodedData, API.vendorList_UploadImage);
  //     if (response['statusCode'] == 200) {
  //       CMDmResponse value = CMDmResponse.fromJson(response);
  //       if (value.code) {
  //         await Success_dialog(context: context, title: "LOGO", content: value.message!, onOk: () {});

  //         if (logoType == 'organization') {
  //           get_OrganizationList(context);
  //         } else if (logoType == 'company') {
  //           get_CompanyList(context);
  //         } else if (logoType == 'vendor') {
  //           get_VendorList(context);
  //         }
  //       } else {
  //         await Error_dialog(context: context, title: 'Uploading Logo', content: value.message ?? "", onOk: () {});
  //       }
  //     } else {
  //       Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
  //     }
  //   } catch (e) {
  //     Error_dialog(context: context, title: "ERROR", content: "$e");
  //   }
  // }
}
