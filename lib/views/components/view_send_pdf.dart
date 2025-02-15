// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/models/constants/api.dart';
import 'package:ssipl_billing/utils/helpers/encrypt_decrypt.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import '../../controllers/viewSend_actions.dart';

import '../../controllers/IAM_actions.dart';
import '../../utils/validators/minimal_validators.dart';

// ignore: must_be_immutable
class Generate_popup extends StatefulWidget {
  String type;
  Generate_popup({super.key, required this.type});

  @override
  State<Generate_popup> createState() => Generate_popupState();
}

class Generate_popupState extends State<Generate_popup> with SingleTickerProviderStateMixin {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final ViewsendController viewsendController = Get.find<ViewsendController>();

  // Future<void> _pickPdf() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null) {
  //     setState(() {
  //       _selectedPdf = File(result.files.single.path!);
  //       if (kDebugMode) {
  //         print(File(result.files.single.path!));
  //       }
  //       file_path_Controller = TextEditingController(text: path.absolute(_selectedPdf.toString()));
  //     });
  //   }
  // }

  // Function to show PDF in readable size
  void _showReadablePdf() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
          height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
          child: SfPdfViewer.file(viewsendController.viewSendModel.selectedPdf.value!),
        ),
      ),
    );
  }

  Future<void> printPdf() async {
    if (kDebugMode) {
      print('Selected PDF Path: ${viewsendController.viewSendModel.selectedPdf.value}');
    }

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdfBytes = await viewsendController.viewSendModel.selectedPdf.value!.readAsBytes();
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
    viewsendController.viewSendModel.selectedPdf.value = File(widget.type);
    viewsendController.viewSendModel.filePathController.value = TextEditingController(text: viewsendController.viewSendModel.selectedPdf.value!.path.toString());
    // viewsendController.viewSendModel.isLoading.value = false;

    viewsendController.viewSendModel.animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat the animation with reverse

    viewsendController.viewSendModel.animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: viewsendController.viewSendModel.animationController,
        curve: Curves.linear,
      ),
    );
    // update();
  }

  void _addclientRequest() async {
    String? valueToToken = sessiontokenController.sessiontokenModel.sessiontoken.value;

    final formData = {
      "phoneno": "8248650039",
      "mailto:emailid": "hariprasath.s@sporadasecure.com",
      "pdfpath": "\\\\192.168.0.198\\backup\\Hari\\BM-blueprint.pdf",
      "feedback": "Invoice for your request",
      "documenttype": "Invoice"
    };

    final dataToEncrypt = jsonEncode(formData);
    final encryptedData = AES.encryptWithAES(valueToToken.toString().substring(0, 16), dataToEncrypt);

    final requestData = {
      "STOKEN": valueToToken,
      "querystring": encryptedData,
    };

    final response = await http.post(
      Uri.parse(API.sales_add_client_requirement_API),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode(requestData),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(valueToToken.toString().substring(0, 16), encryptedResponse);
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
    viewsendController.viewSendModel.animationController.dispose(); // Dispose of the animation controller
    viewsendController.viewSendModel.filePathController.value.dispose(); // Dispose of the text controller
    super.dispose();
  }

  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SizedBox(
          width: 930,
          height: 610,
          child: Stack(
            children: [
              Row(
                children: [
                  viewsendController.viewSendModel.isLoading.value
                      ? Expanded(
                          child: GestureDetector(
                            child: Stack(
                              children: [
                                SfPdfViewer.file(viewsendController.viewSendModel.selectedPdf.value!),
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
                                animation: viewsendController.viewSendModel.animation,
                                builder: (context, child) {
                                  return Positioned(
                                    top: (590) * viewsendController.viewSendModel.animation.value, // Adjust top position
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
                              path.basename(viewsendController.viewSendModel.selectedPdf.value.toString()),
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
                                child: BasicTextfield(
                                  readonly: false,
                                  controller: viewsendController.viewSendModel.phoneNumberController.value,
                                  text: 'Enter Phone Number',
                                  icon: Icons.phone,
                                  validator: (value) {
                                    Validators.phnNo_validator(value);
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
                                child: BasicTextfield(
                                  readonly: false,
                                  controller: viewsendController.viewSendModel.emailController.value,
                                  text: 'Enter Email ID',
                                  icon: Icons.email,
                                  validator: (value) {
                                    Validators.email_validator(value);

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
                                            viewsendController.pickFile(context);
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
                                  controller: viewsendController.viewSendModel.filePathController.value,
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
                                          viewsendController.viewSendModel.whatsapp.value = viewsendController.viewSendModel.whatsapp.value == false ? true : false;
                                        },
                                        icon: Image.asset(
                                          'assets/images/whatsapp.png',
                                        ),
                                      ),
                                      if (viewsendController.viewSendModel.whatsapp.value)
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
                                          viewsendController.viewSendModel.gmail.value = viewsendController.viewSendModel.gmail.value == false ? true : false;
                                        },
                                        icon: Image.asset('assets/images/gmail.png'),
                                      ),
                                      if (viewsendController.viewSendModel.gmail.value)
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
                            controller: viewsendController.viewSendModel.feedbackController.value,
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
      },
    );
  }
}
