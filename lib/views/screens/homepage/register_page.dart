import 'package:flutter/material.dart';
import 'package:ssipl_billing/models/constants/api.dart';
import 'package:ssipl_billing/utils/helpers/encrypt_decrypt.dart';
import 'package:ssipl_billing/views/screens/homepage/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:ssipl_billing/themes/style.dart';

import 'package:flutter/services.dart' show rootBundle;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool indicator = false;
  bool password_view = true;
  final Map<String, String> _errors = {};
  // ignore: unused_element
  void _validateForm() {
    setState(() {
      _errors.clear();
      String password = _passwordController.text;
      String confirmPassword = _confirmController.text;

      bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
      bool hasLowercase = password.contains(RegExp(r'[a-z]'));
      bool hasDigits = password.contains(RegExp(r'[0-9]'));
      bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      bool isLengthValid = password.length >= 8;

      if (_nameController.text.isEmpty) {
        _errors['name'] = 'Please enter your name';
      }

      if (_emailController.text.isEmpty) {
        _errors['email'] = 'Please enter your email';
      } else if (!RegExp(
        r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',
        caseSensitive: true,
      ).hasMatch(_emailController.text)) {
        _errors['email'] = 'Please enter a valid email';
      }

      if (_phoneController.text.isEmpty) {
        _errors['phone'] = 'Please enter your phone number';
      } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(_phoneController.text)) {
        _errors['phone'] = 'Please enter a valid phone number';
      }
      if (password.isEmpty) {
        _errors['password'] = 'Please enter your password';
      } else if (!isLengthValid) {
        _errors['password'] = 'Password must be at least 8 characters';
      } else if (!hasUppercase) {
        _errors['password'] = 'Password must contain at least one uppercase letter';
      } else if (!hasLowercase) {
        _errors['password'] = 'Password must contain at least one lowercase letter';
      } else if (!hasDigits) {
        _errors['password'] = 'Password must contain at least one digit';
      } else if (!hasSpecialCharacters) {
        _errors['password'] = 'Password must contain at least one special character';
      }

      if (confirmPassword.isEmpty) {
        _errors['confirmPassword'] = 'Please confirm your password';
      } else if (confirmPassword != password) {
        _errors['confirmPassword'] = 'Passwords do not match';
      }

      if (_errors.isEmpty) {
        // If there are no errors, show the success dialog
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: const Text('Registration Successful'),
        //       content: const Text('You have registered successfully.'),
        //       actions: <Widget>[
        //         TextButton(
        //           child: const Text('OK'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //             // Optionally navigate to another page
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
        Register();
        setState(() {
          indicator = true;
        });
      }
    });
  }

  Future<Map<String, dynamic>> loadConfigFile(String path) async {
    final configString = await rootBundle.loadString(path);
    return jsonDecode(configString);
  }

  void Register() async {
    try {
      final configData = await loadConfigFile('assets/key.config');
      final apiKey = configData['APIkey'];
      final secret = configData['Secret'];
      final formData = {
        "name": _nameController.text,
        "emailid": _emailController.text,
        "phoneno": _phoneController.text,
        "password": _passwordController.text,
      };

      final dataToEncrypt = jsonEncode(formData);
      final encryptedData = EncryptWithAES.encryptWithAES(secret, dataToEncrypt);

      final requestData = {
        "APIkey": apiKey,
        "Secret": secret,
        "querystring": encryptedData,
      };

      final response = await http.post(
        Uri.parse(API.Register_API),
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode(requestData),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String encryptedResponse = responseData['encryptedResponse'];
        // print(encryptedResponse);
        final decryptedResponse = EncryptWithAES.decryptWithAES(secret.substring(0, 16), encryptedResponse);

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
            indicator = false;
          });
          setState(() {
            home_page.Page_name = 'Login';
            home_page.update();
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Primary_colors.Light,
                contentPadding: const EdgeInsets.all(0),
                content: Container(
                  decoration: BoxDecoration(color: Primary_colors.Light, borderRadius: BorderRadius.circular(30)),
                  height: 250,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 80, child: Image.asset('assets/images/tik.gif')),
                      const Text(
                        'Registered Successfully',
                        style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.SubHeading),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Please click the link to verify on your Mail',
                        style: TextStyle(color: Color.fromARGB(255, 158, 155, 155), fontSize: Primary_font_size.Text8),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
                              height: 30,
                              width: 80,
                              child: TextButton(
                                onPressed: () {
                                  _nameController.clear();
                                  _emailController.clear();
                                  _phoneController.clear();
                                  _passwordController.clear();
                                  _confirmController.clear();
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
              title: const Text('Register  Failed', style: TextStyle(color: Colors.white)),
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

  // void Register() async {
  //   try {
  //     final requestBody = {};

  //     final response = await http.post(
  //       Uri.parse(Register_apiKey),
  //       headers: {"Content-Type": "application/json"},
  //       body: json.encode(requestBody),
  //     );

  //     if (!mounted) return;
  //     if (response.statusCode == 200) {
  //       final decodedResponse = json.decode(response.body);

  //       final successCode = decodedResponse['code'];

  //       if (successCode == true) {
  //       } else {}
  //     } else {
  //       setState(() {
  //         indicator = false;
  //       });
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             backgroundColor: Primary_colors.Light,
  //             title: const Text('ERROR'),
  //             content: const Text('Server Down!'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();

  //                   // _isLoading = false;
  //                 },
  //                 child: const Text(
  //                   'OK',
  //                   style: TextStyle(color: Colors.white, fontSize: 15),
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     setState(() {
  //       indicator = false;
  //     });
  //     if (kDebugMode) {
  //       print(' call_Register_Api ==> $e');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 50;
    return AnimatedGradientBorder(
      animationTime: 2,
      glowSize: indicator ? 5 : 5,
      gradientColors: indicator
          ? [
              const Color.fromARGB(255, 157, 98, 253),
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
                          color: _errors['name'] == null ? Colors.black : Colors.red,
                        ),
                      ),
                      labelStyle: TextStyle(
                        fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                        color: _errors['name'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: _errors['name'] == null ? Colors.black : Colors.red),
                      ),
                      labelText: _errors['name'] ?? 'Name',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person, color: _errors['name'] == null ? Colors.white : Colors.red),
                      // errorText: _errors['name'],
                    ),
                    controller: _nameController,
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
                        borderSide: BorderSide(color: _errors['email'] == null ? Colors.black : Colors.red),
                      ),
                      labelStyle: TextStyle(
                        fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                        color: _errors['email'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: _errors['email'] == null ? Colors.black : Colors.red),
                      ),
                      labelText: _errors['email'] ?? 'Email',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail, color: _errors['email'] == null ? Colors.white : Colors.red),
                    ),
                    controller: _emailController,
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
                          color: _errors['phone'] == null ? Colors.black : Colors.red,
                        ),
                      ),
                      labelStyle: TextStyle(
                        fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                        color: _errors['phone'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: _errors['phone'] == null ? Colors.black : Colors.red),
                      ),
                      labelText: _errors['phone'] ?? 'Phone Number',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone, color: _errors['phone'] == null ? Colors.white : Colors.red),
                    ),
                    controller: _phoneController,
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
                          color: _errors['password'] == null ? Colors.black : Colors.red,
                        ),
                      ),
                      labelStyle: TextStyle(
                        fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                        color: _errors['password'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: _errors['password'] == null ? Colors.black : Colors.red),
                      ),
                      labelText: _errors['password'] ?? 'Password',
                      border: const OutlineInputBorder(),
                      prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            password_view = password_view == true ? false : true;
                          });
                        },
                        child: Icon(
                          password_view == true ? Icons.remove_red_eye : Icons.visibility_off,
                          color: _errors['password'] == null ? Colors.white : Colors.red,
                        ),
                      ),
                    ),
                    controller: _passwordController,
                    obscureText: password_view,
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
                          color: _errors['confirmPassword'] == null ? Colors.black : Colors.red,
                        ),
                      ),
                      labelStyle: TextStyle(
                        fontSize: screenWidth > 1000 ? baseFontSize * (screenWidth / 7500) : 10,
                        color: _errors['confirmPassword'] == null ? const Color.fromARGB(255, 167, 165, 165) : Colors.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: _errors['confirmPassword'] == null ? Colors.black : Colors.red),
                      ),
                      labelText: _errors['confirmPassword'] ?? 'Confirm Password',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock, color: _errors['confirmPassword'] == null ? Colors.white : Colors.red),
                    ),
                    controller: _confirmController,
                    obscureText: password_view,
                  ),
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
                        _validateForm();
                        // setState(() {
                        //   home_page.Page_name = 'Login';
                        //   home_page.update();
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
                            home_page.Page_name = 'Login';
                            home_page.update();
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
  }
}
