// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/IAM/views/forgot_password.dart';
import 'package:ssipl_billing/IAM/views/login_page.dart';
import 'package:ssipl_billing/IAM/views/newpassword.dart';
import 'package:ssipl_billing/IAM/views/register_page.dart';
import 'package:ssipl_billing/IAM/views/verifyOTP.dart';

import '../../THEMES/style.dart';
import '../controllers/IAM_actions.dart';

class IAM extends StatefulWidget {
  const IAM({super.key});
  // static late Function() update;
  // static String Page_name = '';
  // static String email = '';
  @override
  State<IAM> createState() => _IAMState();
}

class _IAMState extends State<IAM> {
  final IAMController IamController = Get.find<IAMController>();
  // String Page_name = 'Login';
  // String email = 'no';
  @override
  void initState() {
    super.initState();
    // IAM.update = updateData;
  }

  // void updateData() {
  //   setState(() {
  //     Page_name = IAM.Page_name;
  //     email = IAM.email;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Get the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 50;

    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Obx(
        () {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
                child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/geo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Primary_colors.Light.withOpacity(0.85),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/logo.svg',
                                // ignore: deprecated_member_use
                                // color: const Color.fromARGB(255, 168, 167, 167),
                                width: screenWidth > 1000 ? screenWidth / 7 : screenWidth / 3,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Stack(
                                children: [
                                  // Bottom shadow for the recessed effect
                                  Text(
                                    'Billing Management System',
                                    style: TextStyle(
                                      fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 3500) : baseFontSize * (screenWidth / 2700),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      color: Colors.white.withOpacity(0.2),
                                      shadows: const [
                                        Shadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 2,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Top layer to give the 3D embossed effect
                                  Text(
                                    'Billing Management System',
                                    style: TextStyle(
                                      fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 3500) : baseFontSize * (screenWidth / 2700),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.8),
                                            const Color.fromARGB(255, 255, 255, 255),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(const Rect.fromLTWH(0, 0, 200, 100)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      IamController.IAMModel.pagename.value == 'Login'
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Loginpage(),
                            )
                          : IamController.IAMModel.pagename.value == 'Register'
                              ? Expanded(child: RegisterPage())
                              : IamController.IAMModel.pagename.value == 'Forgotpassword'
                                  ? Forgot_password()
                                  : IamController.IAMModel.pagename.value == 'OTPverification'
                                      ? Verify_OTP()
                                      : IamController.IAMModel.pagename.value == 'Setnewpassword'
                                          ? Newpassword()
                                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            )),
          );
        },
      );
    }));
  }
}
