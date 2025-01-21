// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/common_modules/api.dart';
import 'package:ssipl_billing/common_modules/encrypt_decrypt.dart';

import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/home.dart';
// import 'package:showroom_entrance_count/Add_camera.dart';
// import 'package:showroom_entrance_count/capture_image.dart';
// import 'package:showroom_entrance_count/capture_image.dart';
// import 'package:showroom_entrance_count/Add_camera.dart';
// import 'package:showroom_entrance_count/capture_image.dart';
// import 'package:showroom_entrance_count/report_page.dart';
// import 'package:showroom_entrance_count/report_page.dart';
import 'package:ssipl_billing/homepage/home_page.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:flutter/services.dart' show rootBundle;

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});
  static String userid = '';
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool check = false;
  bool isCheckedRememberMe = false;
  bool password_view = true;
  bool indicator = false;
  EncryptWithAES obj = const EncryptWithAES();

  @override
  void initState() {
    super.initState();
    load_login_details();
  }

  void load_login_details() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('usernames');
    String? password = prefs.getString('passwords');
    bool? rememberMe = prefs.getBool('remember_me');

    if (username != null && password != null && rememberMe != null) {
      setState(() {
        _userController.text = username;
        _passwordController.text = password;
        isCheckedRememberMe = rememberMe;
      });
    }
  }

  Future<Map<String, dynamic>> loadConfigFile(String path) async {
    final configString = await rootBundle.loadString(path);
    return jsonDecode(configString);
  }

  void Login() async {
    try {
      final configData = await loadConfigFile('assets/key.config');
      final apiKey = configData['APIkey'];
      final secret = configData['Secret'];
      final formData = {"username": _userController.text, "password": _passwordController.text};

      final dataToEncrypt = jsonEncode(formData);
      final encryptedData = obj.encryptWithAES(secret, dataToEncrypt);

      final requestData = {
        "APIkey": apiKey,
        "Secret": secret,
        "querystring": encryptedData,
      };

      final response = await http.post(
        Uri.parse(API.Login_API),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String encryptedResponse = responseData['encryptedResponse'];
        // print(encryptedResponse);
        final decryptedResponse = obj.decryptWithAES(secret.substring(0, 16), encryptedResponse);

        final decodedResponse = jsonDecode(decryptedResponse);
        final Code = decodedResponse['code'];
        final Message = decodedResponse['message'];
        final userid = decodedResponse['userid'];
        final SToken = decodedResponse['SESSIONTOKEN'];

        if (!Code) {
          setState(() {
            indicator = false;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Login Failed'),
                content: Text(Message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            EncryptWithAES.SESSIONTOKEN = SToken;
          });
          setState(() {
            indicator = false;
            Loginpage.userid = userid.toString();
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        }
      } else {
        setState(() {
          indicator = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Primary_colors.Light,
              title: Text('Login  Failed', style: TextStyle(color: Colors.white)),
              content: Text((response.statusCode).toString(), style: const TextStyle(color: Color.fromARGB(255, 169, 162, 162))),
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

  void actionRememberMe(bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("remember_me", value);
      await prefs.setString('usernames', _userController.text);
      if (value == true) {
        await prefs.setString('passwords', _passwordController.text);
      } else {
        await prefs.remove('passwords'); // Remove password from SharedPreferences
      }
      setState(
        () {
          isCheckedRememberMe = value;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        // final error = home_page.error;
        print(' actionRememberMe ==> $e');
        // print('ERROR====>$error');
      }
    }
  }

  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 50;
    return AnimatedGradientBorder(
      animationTime: 2,
      glowSize: indicator ? 5 : 5,
      gradientColors: indicator ? [Color.fromARGB(255, 157, 98, 253), Colors.black] : [Primary_colors.Light],
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: SizedBox(
        width: 500,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: indicator ? Colors.transparent : const Color.fromARGB(255, 121, 121, 135).withOpacity(0.5),
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
                      controller: _userController,
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
                              setState(() {
                                password_view = password_view == true ? false : true;
                              });
                            },
                            child: Icon(
                              password_view == true ? Icons.remove_red_eye : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          )),
                      controller: _passwordController,
                      obscureText: password_view,
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
                              value: isCheckedRememberMe,
                              onChanged: (value) {
                                actionRememberMe(value!);
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
                            actionRememberMe(prefs.getBool('remember_me')!);
                            setState(() {
                              indicator = true;
                            });
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
  }
}
