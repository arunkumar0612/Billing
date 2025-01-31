import 'package:flutter/material.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';

import 'package:ssipl_billing/utils/validators/register_validator.dart';

import 'package:ssipl_billing/views/screens/IAM/IAM.dart';

import 'package:glowy_borders/glowy_borders.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget with RegisterValidator {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 50;
    return Obx(() {
      return AnimatedGradientBorder(
        animationTime: 2,
        glowSize: registerController.registerModel.indicator.value ? 5 : 5,
        gradientColors: registerController.registerModel.indicator.value ? [const Color.fromARGB(255, 157, 98, 253), Colors.black] : [Primary_colors.Light],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: SizedBox(
          width: 500,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 121, 121, 135).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 1), // Shadow offset
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 33, 33, 48),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 4000) : baseFontSize * (screenWidth / 1500),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    height: screenWidth > 1000 ? 55 : 50,
                    child: TextFormField(
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 75, 75, 96),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: registerController.registerModel.errors['name'] == null ? Colors.black : Colors.red,
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                          color: registerController.registerModel.errors['name'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: registerController.registerModel.errors['name'] == null ? Colors.black : Colors.red),
                        ),
                        labelText: registerController.registerModel.errors['name'] ?? 'Name',
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person, color: registerController.registerModel.errors['name'] == null ? Colors.white : Colors.red),
                        // errorText: _errors['name'],
                      ),
                      controller: registerController.registerModel.nameController.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    height: screenWidth > 1000 ? 55 : 50,
                    child: TextFormField(
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 75, 75, 96),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: registerController.registerModel.errors['email'] == null ? Colors.black : Colors.red),
                        ),
                        labelStyle: TextStyle(
                          fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                          color: registerController.registerModel.errors['email'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: registerController.registerModel.errors['email'] == null ? Colors.black : Colors.red),
                        ),
                        labelText: registerController.registerModel.errors['email'] ?? 'Email',
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.mail, color: registerController.registerModel.errors['email'] == null ? Colors.white : Colors.red),
                      ),
                      controller: registerController.registerModel.emailController.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    height: screenWidth > 1000 ? 55 : 50,
                    child: TextFormField(
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 75, 75, 96),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: registerController.registerModel.errors['phone'] == null ? Colors.black : Colors.red,
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                          color: registerController.registerModel.errors['phone'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: registerController.registerModel.errors['phone'] == null ? Colors.black : Colors.red),
                        ),
                        labelText: registerController.registerModel.errors['phone'] ?? 'Phone Number',
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone, color: registerController.registerModel.errors['phone'] == null ? Colors.white : Colors.red),
                      ),
                      controller: registerController.registerModel.phoneController.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    height: screenWidth > 1000 ? 55 : 50,
                    child: TextFormField(
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(1),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 75, 75, 96),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: registerController.registerModel.errors['password'] == null ? Colors.black : Colors.red,
                            ),
                          ),
                          labelStyle: TextStyle(
                            fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                            color: registerController.registerModel.errors['password'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: registerController.registerModel.errors['password'] == null ? Colors.black : Colors.red),
                          ),
                          labelText: registerController.registerModel.errors['password'] ?? 'Password',
                          border: const OutlineInputBorder(),
                          prefixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                registerController.registerModel.passwordVisibility.value = registerController.registerModel.passwordVisibility.value == true ? false : true;
                              });
                            },
                            child: Icon(
                              registerController.registerModel.passwordVisibility.value == true ? Icons.remove_red_eye : Icons.visibility_off,
                              color: registerController.registerModel.errors['password'] == null ? Colors.white : Colors.red,
                            ),
                          ),
                        ),
                        controller: registerController.registerModel.passwordController.value,
                        obscureText: registerController.registerModel.passwordVisibility.value),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    height: screenWidth > 1000 ? 55 : 50,
                    child: TextFormField(
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(1),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 75, 75, 96),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: registerController.registerModel.errors['confirmPassword'] == null ? Colors.black : Colors.red,
                            ),
                          ),
                          labelStyle: TextStyle(
                            fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                            color: registerController.registerModel.errors['confirmPassword'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: registerController.registerModel.errors['confirmPassword'] == null ? Colors.black : Colors.red),
                          ),
                          labelText: registerController.registerModel.errors['confirmPassword'] ?? 'Confirm Password',
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock, color: registerController.registerModel.errors['confirmPassword'] == null ? Colors.white : Colors.red),
                        ),
                        controller: registerController.registerModel.confirmController.value,
                        obscureText: registerController.registerModel.passwordVisibility.value),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 239, 237, 237),
                      ),
                      child: TextButton(
                        onPressed: () {
                          widget.validateForm(context);
                          // setState(() {
                          //   IAM.Page_name = 'Login';
                          //   IAM.update();
                          // });
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7000) : 11, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ?',
                          style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10, color: const Color.fromARGB(255, 201, 201, 201), fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              IAM.Page_name = 'Login';
                              IAM.update();
                            });
                          },
                          child: Text(
                            'LogIn',
                            style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10, color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
