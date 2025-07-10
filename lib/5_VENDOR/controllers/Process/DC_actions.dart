import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/constants/Process/DC_constants.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

class Vendor_DCController extends GetxController {
  var dcModel = DCModel();

  void updateSelectedPdf(File file) {
    dcModel.selectedPdf.value = file;
  }

  // Update feedback text
  void updateFeedback(String feedback) {
    dcModel.feedbackController.value.text = feedback;
  }

  // Update file path text
  void updateFilePath(String filePath) {
    dcModel.filePathController.value.text = filePath;
  }

  Future<bool> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], lockParentWindow: true);

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');

        dcModel.pickedFile.value = null;
        dcModel.selectedPdf.value = null;
      } else {
        dcModel.pickedFile.value = result;
        dcModel.selectedPdf.value = file;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  void resetData() {
    dcModel.pickedFile.value = null;
    dcModel.selectedPdf.value = null;
    dcModel.feedbackController.value.clear();
  }
}
