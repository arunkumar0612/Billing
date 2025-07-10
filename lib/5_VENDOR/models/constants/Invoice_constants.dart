import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceModel extends GetxController with GetSingleTickerProviderStateMixin {
  var pickedFile = Rxn<FilePickerResult>();
  var selectedPdf = Rxn<File>();
  var ispdfLoading = false.obs;

  var feedbackController = TextEditingController().obs;
  var filePathController = TextEditingController().obs;
}
