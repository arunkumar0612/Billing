// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/homepage/forgot_password1.dart';
import 'package:ssipl_billing/homepage/forgot_password2.dart';
import 'package:ssipl_billing/homepage/forgot_password3.dart';
import 'package:ssipl_billing/homepage/login_page.dart';
import 'package:ssipl_billing/homepage/register_page.dart';
// import 'package:showroom_entrance_count/homepage/login_page.dart';
// import 'package:showroom_entrance_count/homepage/register_page.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});
  static late Function() update;
  static String Page_name = '';
  static String email = '';
  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  String Page_name = 'Login';
  String email = 'no';
  @override
  void initState() {
    super.initState();
    home_page.update = updateData;
  }

  void updateData() {
    setState(() {
      Page_name = home_page.Page_name;
      email = home_page.email;
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
                      // const SizedBox(height: 50),
                      // screenWidth > 1000
                      //     ? Center(
                      //         child: Padding(
                      //           padding: EdgeInsets.all(10),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Image.asset(
                      //                 'assets/images/whitefull.png',
                      //                 width: screenWidth / 7,
                      //               ),
                      //               Column(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     'Smart Facial Recognition System',
                      //                     style: TextStyle(fontSize: baseFontSize * (screenWidth / 1900), color: Color.fromARGB(255, 33, 195, 114)),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   'assets/images/whitefull.png',
                              //   width: screenWidth / 3,
                              // ),
                              SvgPicture.asset(
                                'assets/images/logo.svg',
                                // ignore: deprecated_member_use
                                // color: const Color.fromARGB(255, 168, 167, 167),
                                width: screenWidth > 1000 ? screenWidth / 7 : screenWidth / 3,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
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
                        padding: EdgeInsets.all(20),
                        child: Page_name == 'Login'
                            ? Loginpage()
                            : Page_name == 'Register'
                                ? RegisterPage()
                                : Page_name == 'Forgotpassword'
                                    ? Forgot_password1()
                                    : Page_name == 'OTPverification'
                                        ? Forgot_password2(
                                            email: email,
                                          )
                                        : Page_name == 'Setnewpassword'
                                            ? Forgot_password3(
                                                email: email,
                                              )
                                            : Container(),
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
