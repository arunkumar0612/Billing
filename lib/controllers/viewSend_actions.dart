import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/constants/viewSendpdf_constants.dart';

class ViewsendController extends GetxController {
  var viewSendModel = ViewSendModel();

  void updateSelectedPdf(File file) {
    viewSendModel.selectedPdf.value = file;
  }

  // Toggle loading state
  void setLoading(bool value) {
    viewSendModel.isLoading.value = value;
  }

  // Toggle WhatsApp state
  void toggleWhatsApp(bool value) {
    viewSendModel.whatsapp.value = value;
  }

  // Toggle Gmail state
  void toggleGmail(bool value) {
    viewSendModel.gmail.value = value;
  }

  // Update phone number text
  void updatePhoneNumber(String phoneNumber) {
    viewSendModel.phoneNumberController.value.text = phoneNumber;
  }

  // Update email text
  void updateEmail(String email) {
    viewSendModel.emailController.value.text = email;
  }

  // Update feedback text
  void updateFeedback(String feedback) {
    viewSendModel.feedbackController.value.text = feedback;
  }

  // Update file path text
  void updateFilePath(String filePath) {
    viewSendModel.filePathController.value.text = filePath;
  }

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
        'pdf'
      ],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        // File exceeds 2 MB size limit
        if (kDebugMode) {
          print('Selected file exceeds 2MB in size.');
        }
        // Show Alert Dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Selected file exceeds 2MB in size.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        viewSendModel.pickedFile.value = null;
        viewSendModel.selectedPdf.value = null;
      } else {
        viewSendModel.pickedFile.value = result;
        viewSendModel.selectedPdf.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  // Clear all inputs
  void clearAllInputs() {
    viewSendModel.phoneNumberController.value.clear();
    viewSendModel.emailController.value.clear();
    viewSendModel.feedbackController.value.clear();
    viewSendModel.filePathController.value.clear();
    viewSendModel.selectedPdf.value = null;
    viewSendModel.whatsapp.value = false;
    viewSendModel.gmail.value = false;
    viewSendModel.isLoading.value = false;
  }
}
