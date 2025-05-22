import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssipl_billing/IAM/models/entities/IAM_entities.dart';

import '../../API/api.dart';
import '../../API/invoker.dart';
import '../../COMPONENTS-/Basic_DialogBox.dart';
import '../../COMPONENTS-/Response_entities.dart';
import '../../ROUTES/route_names.dart';
import '../controllers/IAM_actions.dart';

mixin LoginServices {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final LoginController loginController = Get.find<LoginController>();
  final Invoker apiController = Get.find<Invoker>();

  void Login(context) async {
    try {
      Login_Request requestBody = Login_Request(
        username: loginController.loginModel.userController.value.text,
        password: loginController.loginModel.passwordController.value.text,
      );

      Map<String, dynamic>? response = await apiController.IAM(requestBody.toJson(), API.Login_API);

      if (response?['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response!);
        if (value.code) {
          sessiontokenController.loginApiData(value);

          loginController.toggleIndicator(false);
          Get.toNamed(RouteNames.home);
        } else {
          loginController.toggleIndicator(false);
          await Error_dialog(context: context, title: 'Login Failed', content: value.message ?? "", onOk: () {});
        }
      } else {
        loginController.toggleIndicator(false);
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      loginController.toggleIndicator(false);
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }

  void actionRememberMe(bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("remember_me", value);
      await prefs.setString('username', loginController.loginModel.userController.value.text);
      if (value == true) {
        await prefs.setString('password', loginController.loginModel.passwordController.value.text);
      } else {
        await prefs.remove('password');
      }
      loginController.toggleRememberMe(value);
    } catch (e) {
      if (kDebugMode) {
        print(' actionRememberMe ==> $e');
      }
    }
  }

  void load_login_details() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');
    bool? rememberMe = prefs.getBool('remember_me');

    if (username != null && password != null && rememberMe != null) {
      loginController.updatePasswordController(password);
      loginController.updateUsernameController(username);
      loginController.toggleRememberMe(rememberMe);
    }
  }
}
