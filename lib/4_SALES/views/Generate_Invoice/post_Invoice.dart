// ignore_for_file: depend_on_referenced_packages, deprecated_member_use
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:ssipl_billing/4_SALES/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/4_SALES/services/Invoice_services/InvoicePost_services.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/PDFviewonly.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/IAM/controllers/IAM_actions.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

// ignore: must_be_immutable
class PostInvoice extends StatefulWidget with PostServices {
  String type;
  PostInvoice({super.key, required this.type});

  @override
  State<PostInvoice> createState() => PostInvoiceState();
}

class PostInvoiceState extends State<PostInvoice> with SingleTickerProviderStateMixin {
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  @override
  void initState() {
    super.initState();
    // invoiceController.invoiceModel.selected
    // Pdf.value = File(widget.type);
    invoiceController.invoiceModel.filePathController.value = TextEditingController(text: invoiceController.invoiceModel.selectedPdf.value?.path.toString());
    invoiceController.invoiceModel.animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    invoiceController.invoiceModel.animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: invoiceController.invoiceModel.animationController,
        curve: Curves.linear,
      ),
    );
    widget.animation_control();
    // update();
  }

  @override
  void dispose() {
    invoiceController.invoiceModel.animationController.dispose(); // Dispose of the animation controller
    invoiceController.invoiceModel.filePathController.value.dispose(); // Dispose of the text controller
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
              invoiceController.invoiceModel.ispdfLoading.value
                  ? Expanded(
                      child: GestureDetector(
                        child: Stack(
                          children: [
                            invoiceController.invoiceModel.selectedPdf.value != null
                                ? PDFviewonly.dialogWidget(invoiceController.invoiceModel.selectedPdf.value!)
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
                          if (invoiceController.invoiceModel.selectedPdf.value != null) {
                            PDFviewonly.show(context, invoiceController.invoiceModel.selectedPdf.value!);
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
                            ),
                          ),
                          AnimatedBuilder(
                            animation: invoiceController.invoiceModel.animation,
                            builder: (context, child) {
                              return Positioned(
                                top: (590) * invoiceController.invoiceModel.animation.value, // Adjust top position
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
                            'Invoice',
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
                            path.basename(invoiceController.invoiceModel.selectedPdf.value?.path ?? ""),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (invoiceController.invoiceModel.whatsapp_selectionStatus.value)
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
                                  controller: invoiceController.invoiceModel.phoneController.value,
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
                      if (invoiceController.invoiceModel.gmail_selectionStatus.value)
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
                                      controller: invoiceController.invoiceModel.emailController.value,
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
                                              invoiceController.toggleCCemailvisibility(!invoiceController.invoiceModel.CCemailToggle.value);
                                            },
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      invoiceController.invoiceModel.CCemailToggle.value ? Icons.closed_caption_outlined : Icons.closed_caption_disabled_outlined,
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
                            if (invoiceController.invoiceModel.CCemailToggle.value)
                              const SizedBox(
                                height: 10,
                              ),
                            if (invoiceController.invoiceModel.CCemailToggle.value)
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
                                        controller: invoiceController.invoiceModel.CCemailController.value,
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
                                          //     invoiceController.toggleCCemailvisibility(!invoiceController.invoiceModel.CCemailToggle.value);
                                          //   },
                                          //   child: Icon(
                                          //     invoiceController.invoiceModel.CCemailToggle.value ? Icons.closed_caption_outlined : Icons.closed_caption_disabled_outlined,
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
                                  //       controller: invoiceController.invoiceModel.CCemailController.value,
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
                                          invoiceController.pickFile(context);
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
                                controller: invoiceController.invoiceModel.filePathController.value,
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
                                        invoiceController.invoiceModel.whatsapp_selectionStatus.value = invoiceController.invoiceModel.whatsapp_selectionStatus.value == false ? true : false;
                                      },
                                      icon: Image.asset(
                                        'assets/images/whatsapp.png',
                                      ),
                                    ),
                                    if (invoiceController.invoiceModel.whatsapp_selectionStatus.value)
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
                                        invoiceController.invoiceModel.gmail_selectionStatus.value = invoiceController.invoiceModel.gmail_selectionStatus.value == false ? true : false;
                                      },
                                      icon: Image.asset('assets/images/gmail.png'),
                                    ),
                                    if (invoiceController.invoiceModel.gmail_selectionStatus.value)
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
                          controller: invoiceController.invoiceModel.feedbackController.value,
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
                                  invoiceController.backTab();
                                },
                              ),
                            ),
                          ),
                          if (invoiceController.invoiceModel.whatsapp_selectionStatus.value || invoiceController.invoiceModel.gmail_selectionStatus.value)
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: BasicButton(
                                  text: "Send",
                                  colors: Colors.blue,
                                  onPressed: () {
                                    widget.postData(context, invoiceController.fetch_messageType());
                                  },
                                ),
                              ),
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ),
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
