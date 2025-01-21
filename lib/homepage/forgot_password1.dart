// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssipl_billing/common_modules/api.dart';
import 'package:ssipl_billing/common_modules/encrypt_decrypt.dart';
import 'package:ssipl_billing/homepage/home_page.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:glowy_borders/glowy_borders.dart';

class Forgot_password1 extends StatefulWidget {
  const Forgot_password1({super.key});

  @override
  State<Forgot_password1> createState() => _Forgot_password1State();
}

class _Forgot_password1State extends State<Forgot_password1> {
  final TextEditingController _emailController = TextEditingController();
  bool indicator = false;

  EncryptWithAES obj = const EncryptWithAES();
  Future<Map<String, dynamic>> loadConfigFile(String path) async {
    final configString = await rootBundle.loadString(path);
    return jsonDecode(configString);
  }

  void Forgot_password1() async {
    try {
      final configData = await loadConfigFile('assets/key.config');
      final apiKey = configData['APIkey'];
      final secret = configData['Secret'];
      final formData = {
        "username": _emailController.text,
      };

      final dataToEncrypt = jsonEncode(formData);
      final encryptedData = obj.encryptWithAES(secret, dataToEncrypt);

      final requestData = {
        "APIkey": apiKey,
        "Secret": secret,
        "querystring": encryptedData,
      };

      final response = await http.post(
        Uri.parse(API.forgotpassword1_API),
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

        if (!Code) {
          setState(() {
            indicator = false;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Email verify Failed'),
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
            home_page.Page_name = 'OTPverification';
            home_page.email = _emailController.text;
            home_page.update();
          });
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
              title: Text('Email verify Failed', style: TextStyle(color: Colors.white)),
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
              child: Form(
                key: formKey1,
                child: Column(
                  children: [
                    Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.white, fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 4000) : baseFontSize * (screenWidth / 1500), fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: screenWidth > 1000 ? 55 : 50,
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
                            labelText: 'Email',
                            border: const OutlineInputBorder(),
                            prefixIcon: Icon(Icons.mail, color: Colors.white)),
                        controller: _emailController,
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
                            if (formKey1.currentState?.validate() ?? false) {
                              setState(() {
                                indicator = true;
                              });
                              Forgot_password1();
                            }

                            // if (_emailController.text != '') {
                            //   setState(() {
                            //     indicator = true;
                            //   });
                            //   Forgotpassword1_api();
                            // } else {
                            //   showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //         backgroundColor: Primary_colors.Light,
                            //         title: const Text('Input Error', style: TextStyle(color: Colors.white)),
                            //         content: Text('Please give input for all the fields', style: TextStyle(color: const Color.fromARGB(255, 175, 174, 174))),
                            //         actions: [
                            //           TextButton(
                            //             onPressed: () {
                            //               Navigator.of(context).pop();

                            //               // _isLoading = false;
                            //             },
                            //             child: const Text(
                            //               'OK',
                            //               style: TextStyle(color: Colors.white, fontSize: 15),
                            //             ),
                            //           ),
                            //         ],
                            //       );
                            //     },
                            //   );
                            // }
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
                            "Don't want to continue ?",
                            style: TextStyle(fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10, color: Color.fromARGB(255, 201, 201, 201), fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                home_page.Page_name = 'Login';
                                home_page.update();
                              });
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
            )),
      ),
    );
  }
}
