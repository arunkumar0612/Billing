import 'package:get/get.dart';

import 'package:ssipl_billing/models/entities/IAM_entities.dart';
import 'package:ssipl_billing/views/screens/IAM/IAM.dart';
import '../../controllers/IAM_actions.dart';
import '../../models/constants/api.dart';
import '../../views/components/Basic_DialogBox.dart';
import '../APIservices/invoker.dart';

mixin NewpasswordServices {
  final NewpasswordController newwordController = Get.put(NewpasswordController());
  final ForgotpasswordController forgotpasswordController = Get.put(ForgotpasswordController());
  final Invoker apiController = Get.put(Invoker());
  void validateForm(context) {
    newwordController.newpasswordModel.errors.clear();
    // Regular expression to check password criteria
    bool hasUppercase = newwordController.newpasswordModel.passwordController.value.text.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = newwordController.newpasswordModel.passwordController.value.text.contains(RegExp(r'[a-z]'));
    bool hasDigits = newwordController.newpasswordModel.passwordController.value.text.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = newwordController.newpasswordModel.passwordController.value.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool isLengthValid = newwordController.newpasswordModel.passwordController.value.text.length >= 8;

    if (newwordController.newpasswordModel.passwordController.value.text.isEmpty) {
      newwordController.newpasswordModel.errors['password'] = 'Please enter your password';
    } else if (!isLengthValid) {
      newwordController.newpasswordModel.errors['password'] = 'Password must be at least 8 characters';
    } else if (!hasUppercase) {
      newwordController.newpasswordModel.errors['password'] = 'Password must contain at least one uppercase letter';
    } else if (!hasLowercase) {
      newwordController.newpasswordModel.errors['password'] = 'Password must contain at least one lowercase letter';
    } else if (!hasDigits) {
      newwordController.newpasswordModel.errors['password'] = 'Password must contain at least one digit';
    } else if (!hasSpecialCharacters) {
      newwordController.newpasswordModel.errors['password'] = 'Password must contain at least one special character';
    }

    if (newwordController.newpasswordModel.confirmController.value.text.isEmpty) {
      newwordController.newpasswordModel.errors['confirmPassword'] = 'Please confirm your password';
    } else if (newwordController.newpasswordModel.confirmController.value.text != newwordController.newpasswordModel.passwordController.value.text) {
      newwordController.newpasswordModel.errors['confirmPassword'] = 'Passwords do not match';
    }

    if (newwordController.newpasswordModel.errors.isEmpty) {
      Newpassword(context);
      forgotpasswordController.toggleIndicator(true);
    }
  }

  void Newpassword(context) async {
    try {
      Map<String, dynamic>? response = await apiController
          .IAM({"username": forgotpasswordController.forgotpasswordModel.emailController.value.text, "password": newwordController.newpasswordModel.confirmController.value.text}, API.newpassword_API);

      if (response?['statusCode'] == 200) {
        Newpassword_Response data = Newpassword_Response.fromJson(response!);
        if (data.code) {
          forgotpasswordController.toggleIndicator(false);
          IAM.Page_name = 'Login';
          IAM.update();
        } else {
          forgotpasswordController.toggleIndicator(false);
          await Basic_dialog(context: context, title: 'Newpassword Failed', content: data.message ?? "", onOk: () {});
        }
      } else {
        forgotpasswordController.toggleIndicator(false);
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      forgotpasswordController.toggleIndicator(false);
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
