import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/IAM_actions.dart';

mixin LoginServices {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void actionRememberMe(bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("remember_me", value);
      await prefs.setString('username', loginController.loginModel.value.username);
      if (value == true) {
        await prefs.setString('password', loginController.loginModel.value.password);
      } else {
        await prefs.remove('passwords'); // Remove password from SharedPreferences
      }
      // setState(
      //   () {

      loginController.toggleRememberMe(value);
      // controller.isCheckedRememberMe = value;
      //   },
      // );
    } catch (e) {
      if (kDebugMode) {
        // final error = home_page.error;
        print(' actionRememberMe ==> $e');
        // print('ERROR====>$error');
      }
    }
  }

  void load_login_details() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');
    bool? rememberMe = prefs.getBool('remember_me');

    if (username != null && password != null && rememberMe != null) {
      // setState(() {
      userController.text = username;
      passwordController.text = password;
      loginController.updatePassword(password);
      loginController.updateUsername(username);
      loginController.toggleRememberMe(rememberMe);
      //  isCheckedRememberMe = rememberMe;
      // });
    }
  }
}
