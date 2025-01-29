import 'package:get/get.dart';

import 'package:ssipl_billing/models/entities/IAM_entities.dart';
import '../../controllers/IAM_actions.dart';
import '../../models/constants/api.dart';
import '../../routes/route_names.dart';
import '../../views/components/Basic_DialogBox.dart';
import '../APIservices/invoker.dart';

mixin RegisterServices {
  final RegisterController registerController = Get.put(RegisterController());
  final Invoker apiController = Get.put(Invoker());
  void validateForm(context) {
    registerController.registerModel.errors.clear();

    bool hasUppercase = registerController.registerModel.passwordController.value.text.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = registerController.registerModel.passwordController.value.text.contains(RegExp(r'[a-z]'));
    bool hasDigits = registerController.registerModel.passwordController.value.text.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = registerController.registerModel.passwordController.value.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool isLengthValid = registerController.registerModel.passwordController.value.text.length >= 8;

    if (registerController.registerModel.nameController.value.text.isEmpty) {
      registerController.registerModel.errors['name'] = 'Please enter your name';
    }

    if (registerController.registerModel.emailController.value.text.isEmpty) {
      registerController.registerModel.errors['email'] = 'Please enter your email';
    } else if (!RegExp(
      r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',
      caseSensitive: true,
    ).hasMatch(registerController.registerModel.emailController.value.text)) {
      registerController.registerModel.errors['email'] = 'Please enter a valid email';
    }

    if (registerController.registerModel.phoneController.value.text.isEmpty) {
      registerController.registerModel.errors['phone'] = 'Please enter your phone number';
    } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(registerController.registerModel.phoneController.value.text)) {
      registerController.registerModel.errors['phone'] = 'Please enter a valid phone number';
    }
    if (registerController.registerModel.passwordController.value.text.isEmpty) {
      registerController.registerModel.errors['password'] = 'Please enter your password';
    } else if (!isLengthValid) {
      registerController.registerModel.errors['password'] = 'Password must be at least 8 characters';
    } else if (!hasUppercase) {
      registerController.registerModel.errors['password'] = 'Password must contain at least one uppercase letter';
    } else if (!hasLowercase) {
      registerController.registerModel.errors['password'] = 'Password must contain at least one lowercase letter';
    } else if (!hasDigits) {
      registerController.registerModel.errors['password'] = 'Password must contain at least one digit';
    } else if (!hasSpecialCharacters) {
      registerController.registerModel.errors['password'] = 'Password must contain at least one special character';
    }

    if (registerController.registerModel.confirmController.value.text.isEmpty) {
      registerController.registerModel.errors['confirmPassword'] = 'Please confirm your password';
    } else if (registerController.registerModel.confirmController.value.text != registerController.registerModel.passwordController.value.text) {
      registerController.registerModel.errors['confirmPassword'] = 'Passwords do not match';
    }

    if (registerController.registerModel.errors.isEmpty) {
      // If there are no errors, show the success dialog
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: const Text('Registration Successful'),
      //       content: const Text('You have registered successfully.'),
      //       actions: <Widget>[
      //         TextButton(
      //           child: const Text('OK'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //             // Optionally navigate to another page
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
      Register(context);
      registerController.toggleIndicator(true);
      // setState(() {
      //   indicator = true;
      // });
    }
  }

  void Register(context) async {
    try {
      Map<String, dynamic>? response = await apiController.IAM({
        "name": registerController.registerModel.nameController.value.text,
        "emailid": registerController.registerModel.emailController.value.text,
        "phoneno": registerController.registerModel.phoneController.value.text,
        "password": registerController.registerModel.passwordController.value.text,
      }, API.Register_API);

      if (response?['statusCode'] == 200) {
        Register_Response data = Register_Response.fromJson(response!);
        if (data.code) {
          // AES.SESSIONTOKEN = data.sessionToken ?? "null";
          registerController.toggleIndicator(false);
          await Basic_dialog(
            context: context,
            title: 'Please click the link to verify on your Mail',
            content: data.message ?? "",
            onOk: () {
              registerController.registerModel.nameController.value.clear();
              registerController.registerModel.emailController.value.clear();
              registerController.registerModel.phoneController.value.clear();
              registerController.registerModel.passwordController.value.clear();
              registerController.registerModel.confirmController.value.clear();
            },
          );
          registerController.toggleIndicator(true);
          Get.toNamed(RouteNames.login);
        } else {
          registerController.toggleIndicator(false);
          await Basic_dialog(context: context, title: 'Register Failed', content: data.message ?? "", onOk: () {});
        }
      } else {
        registerController.toggleIndicator(false);
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      registerController.toggleIndicator(false);
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
