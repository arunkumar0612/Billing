import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssipl_billing/models/entities/IAM_entities.dart';
import '../../controllers/IAM_actions.dart';
import '../../models/constants/api.dart';
import '../../routes/route_names.dart';
import '../../utils/helpers/encrypt_decrypt.dart';
import '../../views/components/Basic_DialogBox.dart';
import '../APIservices/invoker.dart';

mixin LoginServices {
  final LoginController loginController = Get.put(LoginController());
  final Invoker apiController = Get.put(Invoker());
  void Login(context) async {
    try {
      Map<String, dynamic>? response = await apiController.IAM({
        "username": loginController.loginModel.userController.value.text,
        "password": loginController.loginModel.passwordController.value.text,
      }, API.Login_API);

      if (response?['statusCode'] == 200) {
        Login_Response data = Login_Response.fromJson(response!);
        if (data.code) {
          AES.SESSIONTOKEN = data.sessionToken ?? "null";
          loginController.toggleIndicator(false);
          Get.toNamed(RouteNames.home);
        } else {
          loginController.toggleIndicator(false);
          await Basic_dialog(context: context, title: 'Login Failed', content: data.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e");
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
