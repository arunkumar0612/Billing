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
