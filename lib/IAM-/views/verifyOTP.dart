// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:ssipl_billing/IAM-/services/verifyOTP_services.dart';

import '../../COMPONENTS-/Basic_DialogBox.dart';
import '../../THEMES-/style.dart';
import '../controllers/IAM_actions.dart';

class Verify_OTP extends StatefulWidget with VerifyotpServices {
  Verify_OTP({super.key});

  @override
  State<Verify_OTP> createState() => _Verify_OTPState();
}

class _Verify_OTPState extends State<Verify_OTP> {
  // Create controllers for each TextField
  final IAMController IamController = Get.find<IAMController>();
  final VerifyOTPControllers VerifyOTPController = Get.find<VerifyOTPControllers>();

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    for (var controller in VerifyOTPController.verifyOTPModel.otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 50;
    return Obx(() {
      return AnimatedGradientBorder(
        animationTime: 2,
        glowSize: VerifyOTPController.verifyOTPModel.indicator.value ? 5 : 5,
        gradientColors: VerifyOTPController.verifyOTPModel.indicator.value ? [const Color.fromARGB(255, 157, 98, 253), Colors.black] : [Primary_colors.Light],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: SizedBox(
          width: 500,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: VerifyOTPController.verifyOTPModel.indicator.value ? Colors.transparent : Primary_colors.Color3.withOpacity(0.5),
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
                    'OTP Verification',
                    style: TextStyle(color: Colors.white, fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 4000) : baseFontSize * (screenWidth / 1500), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: screenWidth > 450 ? 10 : baseFontSize * (screenWidth / 4000),
                            ),
                            Container(
                              width: screenWidth > 500 ? 45 : 35,
                              height: screenWidth > 500 ? 45 : 35,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 75, 75, 96),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller: VerifyOTPController.verifyOTPModel.otpControllers[index],
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  // Handle input changes
                                  if (value.length == 1) {
                                    // Automatically move to the next field if available
                                    if (index < VerifyOTPController.verifyOTPModel.otpControllers.length - 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  } else if (value.length > 1) {
                                    // Handle paste functionality
                                    for (int i = 0; i < value.length; i++) {
                                      if (i < VerifyOTPController.verifyOTPModel.otpControllers.length) {
                                        VerifyOTPController.verifyOTPModel.otpControllers[i].text = value[i];
                                      }
                                    }
                                    // Move focus to the last box
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [LengthLimitingTextInputFormatter(6)],
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth > 400 ? 10 : baseFontSize * (screenWidth / 4000),
                            ),
                          ],
                        );
                      }),
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
                          // Check if all fields are completed
                          bool allCompleted = VerifyOTPController.verifyOTPModel.otpControllers.every((controller) => controller.text.isNotEmpty);

                          if (allCompleted) {
                            VerifyOTPController.toggleIndicator(true);
                            widget.Verify_OTP(context);
                          } else {
                            Basic_dialog(context: context, showCancel: false, title: "Error", content: "Please enter OTP Correctly!");
                          }
                        },
                        child: Text(
                          'Continue',
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
                          "Don't want to continue?",
                          style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10, color: const Color.fromARGB(255, 201, 201, 201), fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            IamController.IAMModel.pagename.value = 'Forgotpassword';
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10, color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
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
