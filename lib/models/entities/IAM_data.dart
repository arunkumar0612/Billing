import 'package:flutter/widgets.dart';

class LoginModel {
  TextEditingController userController;
  TextEditingController passwordController;
  String username;
  String password;
  String userid;
  bool indicator;
  bool isCheckedRememberMe;
  bool password_visibility;

  LoginModel({
    TextEditingController? userController,
    TextEditingController? passwordController,
    required this.username,
    required this.password,
    required this.userid,
    this.indicator = false,
    this.isCheckedRememberMe = false,
    this.password_visibility = true,
  })  : userController = userController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();
}
