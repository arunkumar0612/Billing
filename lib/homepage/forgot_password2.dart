import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssipl_billing/common_modules/api.dart';
import 'package:ssipl_billing/common_modules/encrypt_decrypt.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/homepage/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:glowy_borders/glowy_borders.dart';

class Forgot_password2 extends StatefulWidget {
  final String email;

  const Forgot_password2({super.key, required this.email});

  @override
  State<Forgot_password2> createState() => _Forgot_password2State();
}

class _Forgot_password2State extends State<Forgot_password2> {
  // Create controllers for each TextField
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  bool indicator = false;
  EncryptWithAES obj = const EncryptWithAES();
  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please complete all fields to continue.'),
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
  }

  Future<Map<String, dynamic>> loadConfigFile(String path) async {
    final configString = await rootBundle.loadString(path);
    return jsonDecode(configString);
  }

  void Forgot_password2() async {
    try {
      final configData = await loadConfigFile('assets/key.config');
      final apiKey = configData['APIkey'];
      final secret = configData['Secret'];
      final formData = {
        "username": widget.email,
        "OTP": _otpControllers.map((controller) => controller.text).join(),
      };

      final dataToEncrypt = jsonEncode(formData);
      final encryptedData = obj.encryptWithAES(secret, dataToEncrypt);

      final requestData = {
        "APIkey": apiKey,
        "Secret": secret,
        "querystring": encryptedData,
      };

      final response = await http.post(
        Uri.parse(API.forgotpassword2_API),
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
                title: const Text('OTP verify Failed'),
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
            home_page.Page_name = 'Setnewpassword';
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
              title: const Text('OTP verify Failed', style: TextStyle(color: Colors.white)),
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
            content: Text('$e', style: const TextStyle(color: Color.fromARGB(255, 175, 174, 174))),
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 50;

    return AnimatedGradientBorder(
      animationTime: 2,
      glowSize: indicator ? 5 : 5,
      gradientColors: indicator ? [const Color.fromARGB(255, 157, 98, 253), Colors.black] : [Primary_colors.Light],
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
                              controller: _otpControllers[index],
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                // Handle input changes
                                if (value.length == 1) {
                                  // Automatically move to the next field if available
                                  if (index < _otpControllers.length - 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                } else if (value.length > 1) {
                                  // Handle paste functionality
                                  for (int i = 0; i < value.length; i++) {
                                    if (i < _otpControllers.length) {
                                      _otpControllers[i].text = value[i];
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
                        bool allCompleted = _otpControllers.every((controller) => controller.text.isNotEmpty);

                        if (allCompleted) {
                          setState(() {
                            indicator = true;
                          });
                          String otpCode = _otpControllers.map((controller) => controller.text).join();
                          if (kDebugMode) {
                            print("Entered OTP: $otpCode");
                          }

                          Forgot_password2();
                        } else {
                          _showErrorDialog(context);
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
                          setState(() {
                            home_page.Page_name = 'Forgotpassword';
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
        ),
      ),
    );
  }
}
