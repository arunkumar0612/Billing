import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewSendModel {
  late AnimationController animationController;
  late Animation<double> animation;
  var pickedFile = Rxn<FilePickerResult>();
  var selectedPdf = Rxn<File>();
  var isLoading = false.obs;
  var whatsapp = false.obs;
  var gmail = false.obs;
  var phoneNumberController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var feedbackController = TextEditingController().obs;
  var filePathController = TextEditingController().obs;
}
