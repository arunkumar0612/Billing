import 'package:get/get.dart';
import 'package:ssipl_billing/services/IAM_services/newpassword_services.dart';
import '../../controllers/IAM_actions.dart';

mixin NewpasswordValidator {
  final NewpasswordController newwordController = Get.find<NewpasswordController>();
  final ForgotpasswordController forgotpasswordController = Get.find<ForgotpasswordController>();

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
      NewpasswordServices().Newpassword(context);

      forgotpasswordController.toggleIndicator(true);
    }
  }
}
