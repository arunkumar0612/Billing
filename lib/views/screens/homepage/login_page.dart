// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/models/constants/api.dart';
import 'package:ssipl_billing/services/APIservices/MyController.dart';
import 'package:ssipl_billing/utils/helpers/encrypt_decrypt.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/home.dart';
import 'package:ssipl_billing/views/screens/homepage/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:ssipl_billing/views/components/Basic_DialogBox.dart';
import '../../../services/IAM_services/login_services.dart';

class Loginpage extends StatefulWidget with LoginServices {
  Loginpage({super.key});
  // static String userid = '';
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final MyController apiController = Get.put(MyController());
  final LoginController loginController = Get.put(LoginController());

  // bool check = false;
  // bool isCheckedRememberMe = false;
  // bool password_view = true;
  // bool indicator = false;

  @override
  void initState() {
    super.initState();
    widget.load_login_details();
  }

  void Login() async {
    try {
      Map<String, dynamic>? response = await apiController.login({
        "username": widget.userController.text,
        "password": widget.passwordController.text,
      }, API.Login_API);
      final Code = response?['code'];
      final Message = response?['message'];
      final userid = response?['userid'];
      final SToken = response?['SESSIONTOKEN'];

      if (!Code && response?['statusCode'] != 200) {
        loginController.toggleIndicator(false);
        // setState(() {
        //   indicator = false;
        // });
        await Basic_dialog(context: context, title: 'Login Failed', content: Message, onOk: () {});
      } else {
        EncryptWithAES.SESSIONTOKEN = SToken;
        loginController.toggleIndicator(false);

        // setState(() {
        //   indicator = false;
        //   // Loginpage.userid = userid.toString();
        // });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Primary_colors.Light,
            title: const Text('Server Down!', style: TextStyle(color: Colors.white)),
            content: Text('$e', style: TextStyle(color: const Color.fromARGB(255, 175, 174, 174))),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  // _isLoading = false;
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 50;
    return Obx(() {
      return AnimatedGradientBorder(
        animationTime: 2,
        glowSize: loginController.indicatorStatus ? 5 : 5,
        gradientColors: loginController.indicatorStatus
            ? [
                Color.fromARGB(255, 157, 98, 253),
                Colors.black
              ]
            : [
                Primary_colors.Light
              ],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: SizedBox(
          width: 500,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: loginController.indicatorStatus ? Colors.transparent : const Color.fromARGB(255, 121, 121, 135).withOpacity(0.5),
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
              child: Form(
                key: formKey1,
                child: Column(
                  children: [
                    Text(
                      'LogIn',
                      style: TextStyle(color: Colors.white, fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 4000) : baseFontSize * (screenWidth / 1500), fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      // height: screenWidth > 1000 ? 55 : 50,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(1),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 75, 75, 96),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelStyle: TextStyle(
                              fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                              color: Color.fromARGB(255, 167, 165, 165),
                            ),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                            labelText: 'User Name',
                            border: const OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person, color: Colors.white)),
                        controller: widget.userController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter user name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 400,
                      // height: screenWidth > 1000 ? 55 : 50,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(1),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 75, 75, 96),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelStyle: TextStyle(
                              fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                              color: Color.fromARGB(255, 167, 165, 165),
                            ),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                            labelText: "Password",
                            border: const OutlineInputBorder(),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                // setState(() {
                                loginController.togglePasswordVisibility(loginController.passwordVisibleStatus ? false : true);

                                // password_view = password_view == true ? false : true;
                                // });
                              },
                              child: Icon(
                                loginController.passwordVisibleStatus == true ? Icons.remove_red_eye : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            )),
                        controller: widget.passwordController,
                        obscureText: loginController.passwordVisibleStatus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                side: BorderSide(color: const Color.fromARGB(255, 192, 191, 191)),
                                activeColor: Color.fromARGB(255, 118, 219, 222),
                                checkColor: Colors.white,
                                focusColor: Color.fromARGB(255, 19, 151, 135),
                                value: loginController.rememberMeStatus,
                                onChanged: (value) {
                                  widget.actionRememberMe(value!);
                                  // setState(
                                  //   () {
                                  //     isCheckedRememberMe = value ?? false; // Update isCheckedRememberMe with the new value
                                  //   },
                                  // );
                                },
                              ),
                              Text(
                                'Remember Me',
                                style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 9, color: Color.fromARGB(255, 201, 201, 201), fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              setState(
                                () {
                                  home_page.Page_name = 'Forgotpassword';
                                  home_page.update();
                                },
                              );
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 9, color: Color.fromARGB(255, 201, 201, 201), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      height: 45,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 239, 237, 237),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => MyHomePage()),
                            // );
                            if (formKey1.currentState?.validate() ?? false) {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              Login();

                              // setState(() {
                              //   indicator = false;
                              //   // Loginpage.userid = decodedResponse['userid'].toString();
                              // });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Dashboard()),
                              // );
                              widget.actionRememberMe(prefs.getBool('remember_me')!);
                              loginController.toggleIndicator(true);

                              // setState(() {
                              //   indicator = true;
                              // });
                            }
                          },
                          child: Text(
                            'LogIn',
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
                            'New User ?',
                            style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10, color: Color.fromARGB(255, 201, 201, 201), fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                home_page.Page_name = 'Register';
                                home_page.update();
                              });
                            },
                            child: Text(
                              'Register',
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
        ),
      );
    });
  }
}
