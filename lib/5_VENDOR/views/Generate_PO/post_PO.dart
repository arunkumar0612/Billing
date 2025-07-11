// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:ssipl_billing/5_VENDOR/controllers/PO_actions.dart';
import 'package:ssipl_billing/5_VENDOR/services/PO_services/PO_Post_services.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/PDFviewonly.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

// ignore: must_be_immutable
class PostPo extends StatefulWidget with PostServices {
  String type;
  PostPo({super.key, required this.type});

  @override
  State<PostPo> createState() => PostPoState();
}

class PostPoState extends State<PostPo> with SingleTickerProviderStateMixin {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final vendor_PoController poController = Get.find<vendor_PoController>();

  @override
  void initState() {
    super.initState();

    // poController.poModel.selected
    // Pdf.value = File(widget.type);
    poController.poModel.filePathController.value = TextEditingController(text: poController.poModel.selectedPdf.value?.path.toString());

    poController.poModel.animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    poController.poModel.animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: poController.poModel.animationController,
        curve: Curves.linear,
      ),
    );
    widget.animation_control();
    // update();
  }

  // void _addclientRequest() async {
  //   String? valueToToken = sessiontokenController.sessiontokenModel.sessiontoken.value;

  //   final formData = {
  //     "phoneno": "8248650039",
  //     "mailto:emailid": "hariprasath.s@sporadasecure.com",
  //     "pdfpath": "\\\\192.168.0.198\\backup\\Hari\\BM-blueprint.pdf",
  //     "feedback": "Po for your request",
  //     "documenttype": "Po"
  //   };

  //   final dataToEncrypt = jsonEncode(formData);
  //   final encryptedData = AES.encryptWithAES(valueToToken.toString().substring(0, 16), dataToEncrypt);

  //   final requestData = {
  //     "STOKEN": valueToToken,
  //     "querystring": encryptedData,
  //   };

  //   final response = await http.post(
  //     Uri.parse(API.sales_add_client_requirement_API),
  //     headers: {
  //       "Content-Type": "application/json"
  //     },
  //     body: jsonEncode(requestData),
  //   );
  //   if (response.statusCode == 200) {
  //     final responseData = jsonDecode(response.body);
  //     final encryptedResponse = responseData['encryptedResponse'];
  //     final decryptedResponse = AES.decryptWithAES(valueToToken.toString().substring(0, 16), encryptedResponse);
  //     final decodedResponse = jsonDecode(decryptedResponse);
  //     final Code = decodedResponse['code'];
  //     final Message = decodedResponse['message'];

  //     if (!Code) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('Unable to Sent PDF'),
  //             content: Text(Message),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else {
  //       // Navigator.of(context).pop();
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text('Success'),
  //           content: const Text('PDF Sent.'),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print('API Request Failed with Status Code: ${response.statusCode}');
  //     }
  //   }
  // }

  @override
  void dispose() {
    poController.poModel.animationController.dispose(); // Dispose of the animation controller
    poController.poModel.filePathController.value.dispose(); // Dispose of the text controller
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
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              poController.poModel.ispdfLoading.value
                  ? Expanded(
                      child: GestureDetector(
                        child: Stack(
                          children: [
                            poController.poModel.selectedPdf.value != null
                                ? PDFviewonly.dialogWidget(poController.poModel.selectedPdf.value!)
                                : Container(
                                    color: Colors.white,
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [Text("No data available, please refresh the page!")],
                                        ),
                                      ],
                                    ),
                                  ),
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
                                      widget.printPdf();
                                    },
                                    icon: const Icon(Icons.print, color: Color.fromARGB(255, 58, 58, 58)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        onDoubleTap: () {
                          if (poController.poModel.selectedPdf.value != null) {
                            PDFviewonly.show(context, poController.poModel.selectedPdf.value!);
                            // PDFviewonly. (context, poController.poModel.selectedPdf.value!);
                            // widget.showReadablePdf(context);
                          } else {
                            Get.snackbar("No data", "Maximizing is restricted!");
                            Get.smartManagement;
                          }
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
                                  color: const Color.fromARGB(198, 30, 31, 30).withOpacity(0.9), // Shadow color with opacity
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
                            animation: poController.poModel.animation,
                            builder: (context, child) {
                              return Positioned(
                                top: (590) * poController.poModel.animation.value, // Adjust top position
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
                          'PO',
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
                          path.basename(poController.poModel.selectedPdf.value?.path ?? ""),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (poController.poModel.whatsapp_selectionStatus.value)
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
                                digitsOnly: false,
                                width: 400,
                                readonly: false,
                                controller: poController.poModel.phoneController.value,
                                // text: 'Enter Phone Number',
                                // icon: Icons.phone,
                                validator: (value) {
                                  Validators.phnNo_validator(value);
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (poController.poModel.gmail_selectionStatus.value)
                      Column(
                        children: [
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
                                  width: 400,
                                  child: TextFormField(
                                    readOnly: false,
                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                                    controller: poController.poModel.emailController.value,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Primary_colors.Dark,
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),

                                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                      // labelText: text,
                                      // label: Text(text ?? ''),
                                      labelStyle: const TextStyle(
                                        fontSize: Primary_font_size.Text7,
                                        color: Color.fromARGB(255, 167, 165, 165),
                                      ),
                                      border: const OutlineInputBorder(),

                                      suffixIcon: MouseRegion(
                                        cursor: SystemMouseCursors.click, // Change cursor to hand
                                        child: GestureDetector(
                                          onTap: () {
                                            poController.toggleCCemailvisibility(!poController.poModel.CCemailToggle.value);
                                          },
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    poController.poModel.CCemailToggle.value ? Icons.closed_caption_outlined : Icons.closed_caption_disabled_outlined,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                const Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: Icon(
                                                    size: 15,
                                                    Icons.add,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      Validators.email_validator(value);

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (poController.poModel.CCemailToggle.value)
                            const SizedBox(
                              height: 10,
                            ),
                          if (poController.poModel.CCemailToggle.value)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  '                                      Cc :',
                                  style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 94, 162, 250), fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),

                                Expanded(
                                  child: SizedBox(
                                    height: 30,
                                    width: 400,
                                    child: TextFormField(
                                      readOnly: false,
                                      style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 204, 204, 204)),
                                      controller: poController.poModel.CCemailController.value,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color.fromARGB(255, 38, 39, 44),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),

                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                        // labelText: text,
                                        // label: Text(text ?? ''),
                                        labelStyle: TextStyle(
                                          fontSize: Primary_font_size.Text7,
                                          color: Color.fromARGB(255, 167, 165, 165),
                                        ),
                                        border: OutlineInputBorder(),

                                        // suffixIcon: GestureDetector(
                                        //   onTap: () {
                                        //     poController.toggleCCemailvisibility(!poController.poModel.CCemailToggle.value);
                                        //   },
                                        //   child: Icon(
                                        //     poController.poModel.CCemailToggle.value ? Icons.closed_caption_outlined : Icons.closed_caption_disabled_outlined,
                                        //     color: Colors.blue,
                                        //   ),
                                        // ),
                                      ),
                                      validator: (value) {
                                        Validators.email_validator(value);

                                        return null;
                                      },
                                    ),
                                  ),
                                ),

                                // Expanded(
                                //   child: SizedBox(
                                //     child: BasicTextfield(
                                //       digitsOnly: false,
                                //       width: 400,

                                //       readonly: false,
                                //       controller: poController.poModel.CCemailController.value,
                                //       validator: (value) {
                                //         Validators.email_validator(value);

                                //         return null;
                                //       },
                                //     ),
                                //   ),
                                // ),
                              ],
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
                                        poController.pickFile(context);
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
                              controller: poController.poModel.filePathController.value,
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
                                      poController.poModel.whatsapp_selectionStatus.value = poController.poModel.whatsapp_selectionStatus.value == false ? true : false;
                                    },
                                    icon: Image.asset(
                                      'assets/images/whatsapp.png',
                                    ),
                                  ),
                                  if (poController.poModel.whatsapp_selectionStatus.value)
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
                                      poController.poModel.gmail_selectionStatus.value = poController.poModel.gmail_selectionStatus.value == false ? true : false;
                                    },
                                    icon: Image.asset('assets/images/gmail.png'),
                                  ),
                                  if (poController.poModel.gmail_selectionStatus.value)
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
                        controller: poController.poModel.feedbackController.value,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: BasicButton(
                                  text: "Back",
                                  colors: Colors.red,
                                  onPressed: () {
                                    poController.backTab();
                                  })),
                        ),
                        if (poController.poModel.whatsapp_selectionStatus.value || poController.poModel.gmail_selectionStatus.value)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: BasicButton(
                                    text: "Send",
                                    colors: Colors.blue,
                                    onPressed: () {
                                      widget.postData(context, poController.fetch_messageType());
                                    })),
                          )
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       if (formKey1.currentState?.validate() ?? false) {
          //         _addclientRequest();
          //       }
          //     },
          //     child: const Text('Send'),
          //   ),
          // )
          //   ],
          // ),
        );
      },
    );
  }
}
