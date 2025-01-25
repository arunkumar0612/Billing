import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginModel {
  final userController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final username = Rxn<String>();
  final password = Rxn<String>();
  final userid = Rxn<String>();
  final indicator = false.obs;
  final isCheckedRememberMe = false.obs;
  final passwordVisibility = false.obs;
}
