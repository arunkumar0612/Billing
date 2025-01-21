// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/common_modules/api.dart';
import 'package:ssipl_billing/common_modules/encrypt_decrypt.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Generate_popup extends StatefulWidget {
  String type;
  Generate_popup({super.key, required this.type});
  static late dynamic Function() callback;

  @override
  State<Generate_popup> createState() => Generate_popupState();
}

class Generate_popupState extends State<Generate_popup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
// 'E://quotation.pdf'
  File? _selectedPdf;
  static bool isloading = false;

  bool whatsapp = false;
  bool gmail = false;
  // Function to pick PDF
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();
  TextEditingController file_path_Controller = TextEditingController();
  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedPdf = File(result.files.single.path!);
        if (kDebugMode) {
          print(File(result.files.single.path!));
        }
        file_path_Controller = TextEditingController(text: path.absolute(_selectedPdf.toString()));
      });
    }
  }

  // Function to show PDF in readable size
  void _showReadablePdf() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
          height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
          child: SfPdfViewer.file(_selectedPdf!),
        ),
      ),
    );
  }

  Future<void> printPdf() async {
    if (kDebugMode) {
      print('Selected PDF Path: $_selectedPdf');
    }

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdfBytes = await _selectedPdf!.readAsBytes();
          return pdfBytes;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error printing PDF: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedPdf = File(widget.type);
    file_path_Controller = TextEditingController(text: _selectedPdf!.path.toString());
    isloading = false;
    Generate_popup.callback = update;
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat the animation with reverse

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    // update();
  }

  void update() async {
    setState(
      () {
        isloading = true;
      },
    );
  }

  EncryptWithAES obj = const EncryptWithAES();
  void _addclientRequest() async {
    String? valueToToken = await obj.get_stored_token();

    final formData = {
      "phoneno": "8248650039",
      "mailto:emailid": "hariprasath.s@sporadasecure.com",
      "pdfpath": "\\\\192.168.0.198\\backup\\Hari\\BM-blueprint.pdf",
      "feedback": "Invoice for your request",
      "documenttype": "Invoice"
    };

    final dataToEncrypt = jsonEncode(formData);
    final encryptedData = obj.encryptWithAES(valueToToken.toString().substring(0, 16), dataToEncrypt);

    final requestData = {
      "STOKEN": valueToToken,
      "querystring": encryptedData,
    };

    final response = await http.post(
      Uri.parse(API.sales_add_client_requirement_API),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestData),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = obj.decryptWithAES(valueToToken.toString().substring(0, 16), encryptedResponse);
      final decodedResponse = jsonDecode(decryptedResponse);
      final Code = decodedResponse['code'];
      final Message = decodedResponse['message'];

      if (!Code) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Unable to Sent PDF'),
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
        // Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('PDF Sent.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      if (kDebugMode) {
        print('API Request Failed with Status Code: ${response.statusCode}');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    file_path_Controller.dispose(); // Dispose of the text controller
    super.dispose();
  }

  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 930,
      height: 600,
      child: Stack(
        children: [
          Row(
            children: [
              isloading
                  ? Expanded(
                      child: GestureDetector(
                        child: Stack(
                          children: [
                            SfPdfViewer.file(_selectedPdf!),
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(255, 184, 184, 184).withOpacity(0.8), // Shadow color
                                        spreadRadius: 1, // Spread radius of the shadow
                                        blurRadius: 5, // Blur radius of the shadow
                                        offset: const Offset(0, 3), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: () {
                                      printPdf();
                                    },
                                    icon: const Icon(Icons.print, color: Color.fromARGB(255, 58, 58, 58)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        onDoubleTap: () {
                          _showReadablePdf();
                        },
                      ),
                    )
                  : Expanded(
                      child: Stack(
                        children: [
                          // Add your PDF content or placeholder here
                          Center(
                              child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // Add background color if needed
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(199, 120, 250, 120).withOpacity(0.9), // Shadow color with opacity
                                  spreadRadius: 5, // How much the shadow spreads
                                  blurRadius: 7, // How blurry the shadow looks
                                  offset: const Offset(0, 3), // Shadow position (x, y)
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // Adjust blur intensity
                                child: Image.asset(
                                  'assets/images/img.png',
                                  fit: BoxFit.fill, // Scales the image
                                ),
                              ),
                            ),
                          )),

                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Positioned(
                                top: (590) * _animation.value, // Adjust top position
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: 5, // Height of the scan line
                                    color: Colors.red.withOpacity(0.5), // Adjust opacity as needed
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
              const SizedBox(width: 10),
              Expanded(
                  child: Form(
                key: formKey1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Client Requirement',
                          style: TextStyle(fontSize: 20, color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'File Name             :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          path.basename(_selectedPdf.toString()),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Phone Number   :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Textfield_1(
                              readonly: false,
                              controller: phonenumberController,
                              text: 'Enter Phone Number',
                              icon: Icons.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Phone Number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Email ID                 :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Textfield_1(
                              readonly: false,
                              controller: emailController,
                              text: 'Enter Email ID',
                              icon: Icons.email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Email ID';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Change File         :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       _pickPdf();
                        //     },
                        //     child: const Text('choose file'))
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: TextFormField(
                              // initialValue: _selectedPdf!.path,
                              showCursor: true,
                              readOnly: true,
                              style: const TextStyle(fontSize: 13, color: Primary_colors.Color1),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(13),
                                labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue),
                                    width: 80,
                                    child: TextButton(
                                      onPressed: () {
                                        _pickPdf();
                                      },
                                      child: const Text(
                                        'Choose',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.file_open, color: Colors.white),
                              ),
                              controller: file_path_Controller,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       'Custome Note    :',
                    //       style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     Expanded(
                    //       child: SizedBox(
                    //         height: 40,
                    //         child: TextFormField(
                    //           style: const TextStyle(fontSize: 13, color: Colors.white),
                    //           decoration: InputDecoration(
                    //             contentPadding: const EdgeInsets.all(1),
                    //             filled: true,
                    //             fillColor: Primary_colors.Dark,
                    //             focusedBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(5),
                    //               borderSide: const BorderSide(
                    //                 color: Colors.black,
                    //               ),
                    //             ),
                    //             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                    //             hintStyle: const TextStyle(
                    //               fontSize: 13,
                    //               color: Color.fromARGB(255, 167, 165, 165),
                    //             ),
                    //             hintText: 'Custome Notes',
                    //             border: const OutlineInputBorder(),
                    //             prefixIcon: const Icon(Icons.note_add, color: Colors.white),
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Share File              :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Stack(
                                alignment: FractionalOffset.topRight,
                                children: [
                                  IconButton(
                                    iconSize: 30,
                                    onPressed: () {
                                      setState(() {
                                        whatsapp = whatsapp == false ? true : false;
                                      });
                                    },
                                    icon: Image.asset(
                                      'assets/images/whatsapp.png',
                                    ),
                                  ),
                                  if (whatsapp)
                                    Align(
                                      // alignment: Alignment.topLeft,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Colors.blue,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(2),
                                            child: Icon(
                                              Icons.check,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                              size: 12,
                                            ),
                                          )),
                                    )
                                ],
                              ),
                              const SizedBox(width: 20),
                              Stack(
                                alignment: FractionalOffset.topRight,
                                children: [
                                  IconButton(
                                    iconSize: 35,
                                    onPressed: () {
                                      setState(() {
                                        gmail = gmail == false ? true : false;
                                      });
                                    },
                                    icon: Image.asset('assets/images/gmail.png'),
                                  ),
                                  if (gmail)
                                    Align(
                                      // alignment: Alignment.topLeft,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Colors.blue,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(2),
                                            child: Icon(
                                              Icons.check,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                              size: 12,
                                            ),
                                          )),
                                    )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 80,
                      child: TextField(
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        maxLines: 5,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                          labelText: 'Enter your feedback',
                          labelStyle: const TextStyle(color: Color.fromARGB(255, 126, 126, 125), fontSize: 13),
                          border: const OutlineInputBorder(),
                        ),
                        controller: feedbackController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                if (formKey1.currentState?.validate() ?? false) {
                  _addclientRequest();
                }
              },
              child: const Text('Send'),
            ),
          )
        ],
      ),
    );
  }
}
