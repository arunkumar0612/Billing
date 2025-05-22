// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:ssipl_billing/4.SALES/controllers/CustomPDF_Controllers/CustomPDF_Quote_actions.dart';
import 'package:ssipl_billing/4.SALES/services/CustomPDF_services/Quote/PostAll_Quote_services.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PostQuote extends StatefulWidget with salesCustom_PostServices {
  PostQuote({super.key});

  @override
  State<PostQuote> createState() => PostQuoteState();
}

class PostQuoteState extends State<PostQuote> with SingleTickerProviderStateMixin {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final CustomPDF_QuoteController pdfpopup_controller = Get.find<CustomPDF_QuoteController>();

  @override
  void initState() {
    super.initState();
    pdfpopup_controller.pdfModel.value.filePathController.value = TextEditingController(text: pdfpopup_controller.pdfModel.value.genearatedPDF.value?.path.toString());
    pdfpopup_controller.pdfModel.value.animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    pdfpopup_controller.pdfModel.value.animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: pdfpopup_controller.pdfModel.value.animationController,
        curve: Curves.linear,
      ),
    );
    widget.animation_control();
  }

  @override
  void dispose() {
    pdfpopup_controller.pdfModel.value.animationController.dispose(); // Dispose of the animation controller
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
              pdfpopup_controller.pdfModel.value.ispdfLoading.value
                  ? Expanded(
                      child: GestureDetector(
                        child: Stack(
                          children: [
                            pdfpopup_controller.pdfModel.value.genearatedPDF.value != null
                                ? SfPdfViewer.file(pdfpopup_controller.pdfModel.value.genearatedPDF.value!)
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
                            // Align(
                            //   alignment: AlignmentDirectional.bottomEnd,
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(5),
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         // Container(
                            //         //   decoration: BoxDecoration(
                            //         //     borderRadius: BorderRadius.circular(50),
                            //         //     // boxShadow: [
                            //         //     //   BoxShadow(
                            //         //     //     color: const Color.fromARGB(255, 184, 184, 184).withOpacity(0.8),
                            //         //     //     spreadRadius: 1,
                            //         //     //     blurRadius: 5,
                            //         //     //     offset: const Offset(0, 3),
                            //         //     //   ),
                            //         //     // ],
                            //         //   ),
                            //         //   child: IconButton(
                            //         //     splashColor: Colors.transparent,
                            //         //     highlightColor: Colors.transparent,
                            //         //     onPressed: () {
                            //         //       widget.downloadPdf(path.basename(pdfpopup_controller.pdfModel.value.genearatedPDF.value?.path ?? ""));
                            //         //     },
                            //         //     icon: const Icon(
                            //         //       Icons.download_outlined,
                            //         //       color: Colors.blue,
                            //         //     ),
                            //         //   ),
                            //         // ),
                            //         // const SizedBox(
                            //         //   height: 10,
                            //         // ),
                            //         // Container(
                            //         //   decoration: BoxDecoration(
                            //         //     borderRadius: BorderRadius.circular(50),
                            //         //     // boxShadow: [
                            //         //     //   BoxShadow(
                            //         //     //     color: const Color.fromARGB(255, 184, 184, 184).withOpacity(0.8),
                            //         //     //     spreadRadius: 1,
                            //         //     //     blurRadius: 5,
                            //         //     //     offset: const Offset(0, 3),
                            //         //     //   ),
                            //         //     // ],
                            //         //   ),
                            //         //   child: IconButton(
                            //         //     // splashColor: Colors.transparent,
                            //         //     // highlightColor: Colors.transparent,
                            //         //     onPressed: () {
                            //         //       widget.printPdf();
                            //         //     },
                            //         //     icon: const Icon(
                            //         //       Icons.print,
                            //         //       color: Colors.redAccent,
                            //         //     ),
                            //         //   ),
                            //         // ),

                            //         GestureDetector(
                            //           onTap: () {
                            //             widget.printPdf();
                            //           },
                            //           child: Column(
                            //             mainAxisSize: MainAxisSize.min,
                            //             children: [
                            //               Image.asset(height: 40, 'assets/images/printer.png'),
                            //               const SizedBox(
                            //                 height: 5,
                            //               ),
                            //               const Text(
                            //                 "Print",
                            //                 style: TextStyle(
                            //                   fontSize: 14,
                            //                   fontWeight: FontWeight.w500,
                            //                   color: Color.fromARGB(255, 143, 143, 143),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         const SizedBox(height: 20), // Space between buttons
                            //         // Download Button
                            //         GestureDetector(
                            //           onTap: () {
                            //             widget.downloadPdf(path.basename(pdfpopup_controller.pdfModel.value.genearatedPDF.value?.path ?? ""));
                            //           },
                            //           child: Column(
                            //             mainAxisSize: MainAxisSize.min,
                            //             children: [
                            //               Image.asset(height: 40, 'assets/images/pdfdownload.png'),
                            //               const SizedBox(
                            //                 height: 5,
                            //               ),
                            //               const Text(
                            //                 "Download",
                            //                 style: TextStyle(
                            //                   fontSize: 14,
                            //                   fontWeight: FontWeight.w500,
                            //                   color: Color.fromARGB(255, 143, 143, 143),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        onDoubleTap: () {
                          if (pdfpopup_controller.pdfModel.value.genearatedPDF.value != null) {
                            widget.showReadablePdf(context);
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
                            animation: pdfpopup_controller.pdfModel.value.animation,
                            builder: (context, child) {
                              return Positioned(
                                top: (590) * pdfpopup_controller.pdfModel.value.animation.value, // Adjust top position
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
                          'Quote',
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
                          path.basename(pdfpopup_controller.pdfModel.value.genearatedPDF.value?.path ?? ""),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (pdfpopup_controller.pdfModel.value.whatsapp_selectionStatus.value)
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
                                controller: pdfpopup_controller.pdfModel.value.phoneNumber.value,
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
                    if (pdfpopup_controller.pdfModel.value.gmail_selectionStatus.value)
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
                                    controller: pdfpopup_controller.pdfModel.value.Email.value,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Primary_colors.Dark,
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                      labelStyle: const TextStyle(
                                        fontSize: Primary_font_size.Text7,
                                        color: Color.fromARGB(255, 167, 165, 165),
                                      ),
                                      border: const OutlineInputBorder(),
                                      suffixIcon: MouseRegion(
                                        cursor: SystemMouseCursors.click, // Change cursor to hand
                                        child: GestureDetector(
                                          onTap: () {
                                            pdfpopup_controller.toggleCCemailvisibility(!pdfpopup_controller.pdfModel.value.CCemailToggle.value);
                                          },
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    pdfpopup_controller.pdfModel.value.CCemailToggle.value ? Icons.closed_caption_outlined : Icons.closed_caption_disabled_outlined,
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
                          if (pdfpopup_controller.pdfModel.value.CCemailToggle.value)
                            const SizedBox(
                              height: 10,
                            ),
                          if (pdfpopup_controller.pdfModel.value.CCemailToggle.value)
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
                                      controller: pdfpopup_controller.pdfModel.value.CCemailController.value,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color.fromARGB(255, 38, 39, 44),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                        labelStyle: TextStyle(
                                          fontSize: Primary_font_size.Text7,
                                          color: Color.fromARGB(255, 167, 165, 165),
                                        ),
                                        border: OutlineInputBorder(),
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
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: TextFormField(
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
                                        pdfpopup_controller.pickFile(context);
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
                              controller: pdfpopup_controller.pdfModel.value.filePathController.value,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                      pdfpopup_controller.pdfModel.value.whatsapp_selectionStatus.value = pdfpopup_controller.pdfModel.value.whatsapp_selectionStatus.value == false ? true : false;
                                    },
                                    icon: Image.asset(
                                      'assets/images/whatsapp.png',
                                    ),
                                  ),
                                  if (pdfpopup_controller.pdfModel.value.whatsapp_selectionStatus.value)
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
                                      pdfpopup_controller.pdfModel.value.gmail_selectionStatus.value = pdfpopup_controller.pdfModel.value.gmail_selectionStatus.value == false ? true : false;
                                    },
                                    icon: Image.asset('assets/images/gmail.png'),
                                  ),
                                  if (pdfpopup_controller.pdfModel.value.gmail_selectionStatus.value)
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
                        controller: pdfpopup_controller.pdfModel.value.feedback.value,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  widget.printPdf();
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(height: 40, 'assets/images/printer.png'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "Print",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 143, 143, 143),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 30), // Space between buttons
                            // Download Button
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  widget.downloadPdf(
                                      context, path.basename(pdfpopup_controller.pdfModel.value.genearatedPDF.value?.path ?? ""), pdfpopup_controller.pdfModel.value.genearatedPDF.value);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(height: 40, 'assets/images/pdfdownload.png'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "Download",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 143, 143, 143),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        if (pdfpopup_controller.pdfModel.value.whatsapp_selectionStatus.value || pdfpopup_controller.pdfModel.value.gmail_selectionStatus.value)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: BasicButton(
                                    text: "Send",
                                    colors: Colors.blue,
                                    onPressed: () {
                                      widget.postData(context, pdfpopup_controller.fetch_messageType());
                                    })),
                          ),
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}
