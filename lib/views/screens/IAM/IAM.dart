import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/screens/IAM/forgot_password1.dart';
import 'package:ssipl_billing/views/screens/IAM/forgot_password2.dart';
import 'package:ssipl_billing/views/screens/IAM/forgot_password3.dart';
import 'package:ssipl_billing/views/screens/IAM/login_page.dart';
import 'package:ssipl_billing/views/screens/IAM/register_page.dart';

class IAM extends StatefulWidget {
  const IAM({super.key});
  static late Function() update;
  static String Page_name = '';
  static String email = '';
  @override
  State<IAM> createState() => _IAMState();
}

class _IAMState extends State<IAM> {
  String Page_name = 'Login';
  String email = 'no';
  @override
  void initState() {
    super.initState();
    IAM.update = updateData;
  }

  void updateData() {
    setState(() {
      Page_name = IAM.Page_name;
      email = IAM.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 50;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Primary_colors.Dark,
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
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Page_name == 'Login'
                            ? Loginpage()
                            : Page_name == 'Register'
                                ? const RegisterPage()
                                : Page_name == 'Forgotpassword'
                                    ? const Forgot_password1()
                                    : Page_name == 'OTPverification'
                                        ? Forgot_password2(
                                            email: email,
                                          )
                                        : Page_name == 'Setnewpassword'
                                            ? Forgot_password3(
                                                email: email,
                                              )
                                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
