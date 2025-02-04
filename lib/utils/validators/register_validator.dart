import 'package:get/get.dart';
import 'package:ssipl_billing/services/IAM_services/register_services.dart';
import '../../controllers/IAM_actions.dart';

mixin RegisterValidator {
  final RegisterController registerController = Get.put(RegisterController());

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
      RegisterServices().Register(context);

      registerController.toggleIndicator(true);
      // setState(() {
      //   indicator = true;
      // });
    }
  }
}
