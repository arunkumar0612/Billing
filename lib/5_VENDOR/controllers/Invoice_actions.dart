import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/constants/Invoice_constants.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

class Vendor_InvoiceController extends GetxController {
  var invoiceModel = InvoiceModel();

  void updateSelectedPdf(File file) {
    invoiceModel.selectedPdf.value = file;
  }

  // Update feedback text
  void updateFeedback(String feedback) {
    invoiceModel.feedbackController.value.text = feedback;
  }

  // Update file path text
  void updateFilePath(String filePath) {
    invoiceModel.filePathController.value.text = filePath;
  }

  Future<bool> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], lockParentWindow: true);

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');

        invoiceModel.pickedFile.value = null;
        invoiceModel.selectedPdf.value = null;
      } else {
        invoiceModel.pickedFile.value = result;
        invoiceModel.selectedPdf.value = file;
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  void resetData() {
    invoiceModel.pickedFile.value = null;
    invoiceModel.selectedPdf.value = null;
    invoiceModel.feedbackController.value.clear();
  }
}
