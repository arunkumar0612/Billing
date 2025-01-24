import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../models/entities/IAM_data.dart';

class LoginController extends GetxController {
  var loginModel = LoginModel(username: '', password: '', userid: '').obs;
  var option = "fdd".obs;
  final Rx<TextEditingController> userController = TextEditingController().obs;

  void updateUsername(String value) {
    loginModel.update((model) {
      model?.username = value;
      // option.update(fn)
    });
  }

  void updatePassword(String value) {
    loginModel.update((model) {
      model?.password = value;
    });
  }

  void toggleRememberMe(bool value) {
    loginModel.update((model) {
      model?.isCheckedRememberMe = value;
    });
  }

  void togglePasswordVisibility(bool value) {
    loginModel.update((model) {
      model?.password_visibility = value;
    });
  }

  void toggleIndicator(bool value) {
    loginModel.update((model) {
      model?.indicator = value;
    });
  }

  bool get indicatorStatus => loginModel.value.indicator;
  bool get rememberMeStatus => loginModel.value.isCheckedRememberMe;
  bool get passwordVisibleStatus => loginModel.value.password_visibility;
}
