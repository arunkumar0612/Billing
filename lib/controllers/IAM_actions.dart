import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/constants/IAM_constants.dart';

class LoginController extends GetxController {
  var loginModel = LoginModel();

  void updateUsernameController(String value) {
    loginModel.userController.value.text = value;
  }

  void updatePasswordController(String value) {
    loginModel.passwordController.value.text = value;
  }

  void toggleRememberMe(bool value) {
    loginModel.isCheckedRememberMe.value = value;
  }

  void togglePasswordVisibility(bool value) {
    loginModel.passwordVisibility.value = value;
  }

  void toggleIndicator(bool value) {
    loginModel.indicator.value = value;
  }
}

class RegisterController extends GetxController {
  var registerModel = RegisterModel();

  void updatenameController(String value) {
    registerModel.nameController.value.text = value;
  }

  void updateemailController(String value) {
    registerModel.emailController.value.text = value;
  }

  void updatephoneController(String value) {
    registerModel.phoneController.value.text = value;
  }

  void updatepasswordController(String value) {
    registerModel.passwordController.value.text = value;
  }

  void updateconfirmController(String value) {
    registerModel.confirmController.value.text = value;
  }

  void togglePasswordVisibility(bool value) {
    registerModel.passwordVisibility.value = value;
  }

  void toggleIndicator(bool value) {
    registerModel.indicator.value = value;
  }

  void updateError(Map<String, String> value) {
    registerModel.errors.value = value;
  }
}

class ForgotpasswordController extends GetxController {
  var forgotpasswordModel = ForgotpasswordModel();

  void updateemailController(String value) {
    forgotpasswordModel.emailController.value.text = value;
  }

  void toggleIndicator(bool value) {
    forgotpasswordModel.indicator.value = value;
  }
}

class VerifyOTPControllers extends GetxController {
  var verifyOTPModel = VerifyOTPModel();

  void updateOTPController(List<TextEditingController> value) {
    verifyOTPModel.otpControllers.value = value;
  }

  void toggleIndicator(bool value) {
    verifyOTPModel.indicator.value = value;
  }
}

class NewpasswordController extends GetxController {
  var newpasswordModel = NewpasswordModel();

  void updatepasswordController(String value) {
    newpasswordModel.passwordController.value.text = value;
  }

  void updateconfirmController(String value) {
    newpasswordModel.confirmController.value.text = value;
  }

  void togglePasswordVisibility(bool value) {
    newpasswordModel.passwordVisibility.value = value;
  }

  void toggleIndicator(bool value) {
    newpasswordModel.indicator.value = value;
  }

  void updateError(Map<String, String> value) {
    newpasswordModel.errors.value = value;
  }
}
