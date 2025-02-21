// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';

import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/utils/validators/newpassword_validator.dart';
// import 'package:ssipl_billing/views/screens/IAM/IAM.dart';

import 'package:glowy_borders/glowy_borders.dart';

class Newpassword extends StatefulWidget with NewpasswordValidator {
  Newpassword({super.key});

  @override
  State<Newpassword> createState() => _NewpasswordState();
}

class _NewpasswordState extends State<Newpassword> {
  final IAMController IamController = Get.find<IAMController>();
  final NewpasswordController newpasswordController = Get.find<NewpasswordController>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 50;
    return Obx(() {
      return AnimatedGradientBorder(
        animationTime: 2,
        glowSize: newpasswordController.newpasswordModel.indicator.value ? 5 : 5,
        gradientColors: newpasswordController.newpasswordModel.indicator.value ? [Color.fromARGB(255, 157, 98, 253), Colors.black] : [Primary_colors.Light],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: SizedBox(
          width: 500,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: newpasswordController.newpasswordModel.indicator.value ? Colors.transparent : Primary_colors.Color3.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 1), // Shadow offset
              ),
            ], borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Set New Password',
                    style: TextStyle(color: Colors.white, fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 4000) : baseFontSize * (screenWidth / 1500), fontWeight: FontWeight.bold),
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
                            color: newpasswordController.newpasswordModel.errors['password'] == null ? Colors.black : Colors.red,
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                          color: newpasswordController.newpasswordModel.errors['password'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: newpasswordController.newpasswordModel.errors['password'] == null ? Colors.black : Colors.red),
                        ),
                        labelText: newpasswordController.newpasswordModel.errors['password'] ?? 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              newpasswordController.newpasswordModel.passwordVisibility.value = newpasswordController.newpasswordModel.passwordVisibility.value == true ? false : true;
                            });
                          },
                          child: Icon(
                            newpasswordController.newpasswordModel.passwordVisibility.value == true ? Icons.remove_red_eye : Icons.visibility_off,
                            color: newpasswordController.newpasswordModel.errors['password'] == null ? Colors.white : Colors.red,
                          ),
                        ),
                      ),
                      controller: newpasswordController.newpasswordModel.passwordController.value,
                      obscureText: newpasswordController.newpasswordModel.passwordVisibility.value,
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
                            color: newpasswordController.newpasswordModel.errors['confirmPassword'] == null ? Colors.black : Colors.red,
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                          color: newpasswordController.newpasswordModel.errors['confirmPassword'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: newpasswordController.newpasswordModel.errors['confirmPassword'] == null ? Colors.black : Colors.red),
                        ),
                        labelText: newpasswordController.newpasswordModel.errors['confirmPassword'] ?? 'Confirm Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock, color: newpasswordController.newpasswordModel.errors['confirmPassword'] == null ? Colors.white : Colors.red),
                      ),
                      controller: newpasswordController.newpasswordModel.confirmController.value,
                      obscureText: newpasswordController.newpasswordModel.passwordVisibility.value,
                    ),
                  ),
                  const SizedBox(height: 30),
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
                        },
                        child: Text(
                          'Submit',
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
                          "Don't want to continue ?",
                          style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10, color: Color.fromARGB(255, 201, 201, 201), fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            // IAM.Page_name = 'Forgotpassword';
                            IamController.IAMModel.pagename.value = 'Forgotpassword';
                            // IAM.update();
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10, color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
