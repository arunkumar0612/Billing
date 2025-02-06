import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class IAMmodel {
  final pagename = "Login".obs;
}

class LoginModel {
  final userController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final userid = Rxn<String>().obs;
  final indicator = false.obs;
  final isCheckedRememberMe = false.obs;
  final passwordVisibility = false.obs;
}

class RegisterModel {
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmController = TextEditingController().obs;
  final indicator = false.obs;
  final passwordVisibility = true.obs;
  final errors = <String, String>{}.obs;
}

class ForgotpasswordModel {
  final emailController = TextEditingController().obs;
  final indicator = false.obs;
}

class VerifyOTPModel {
  final otpControllers = List.generate(6, (_) => TextEditingController()).obs;
  final indicator = false.obs;
}

class NewpasswordModel {
  final passwordController = TextEditingController().obs;
  final confirmController = TextEditingController().obs;
  final indicator = false.obs;
  final passwordVisibility = true.obs;
  final errors = <String, String>{}.obs;
}

class SessiontokenModel {
  final sessiontokenController = "15b97917-b296-11ed-997a-b42e9923".obs;
}
