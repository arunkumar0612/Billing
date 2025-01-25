import 'package:get/get.dart';
import '../models/constants/IAM_constants.dart';

class LoginController extends GetxController {
  var loginModel = LoginModel();

  void updateUsername(String value) {
    loginModel.username.value = value;
  }

  void updatePassword(String value) {
    loginModel.password.value = value;
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
