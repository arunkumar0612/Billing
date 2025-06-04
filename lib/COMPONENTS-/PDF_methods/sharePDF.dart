import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/basicAPI_functions.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

void shareAnyPDF(BuildContext context, String filePath, File pdfToShare) {
  final ctrl = Get.put(SharePDFController());

  showDialog(
    context: context,
    builder: (_) => Obx(() {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 194, 198, 253),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Primary_colors.Color3,
          ),
          child: const Padding(
            padding: EdgeInsets.all(7),
            child: Text("Share", style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold)),
          ),
        ),
        content: IntrinsicHeight(
          child: SizedBox(
            width: 500,
            child: Column(
              children: [
                Row(children: [
                  const Text("File name"),
                  const SizedBox(width: 20),
                  const Text(":"),
                  const SizedBox(width: 20),
                  Expanded(child: Text(filePath)),
                ]),
                if (ctrl.whatsappSelection.value) ...[
                  const SizedBox(height: 20),
                  Row(children: [
                    const Text("Whatsapp"),
                    const SizedBox(width: 20),
                    const Text(":"),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: ctrl.phoneController,
                        style: const TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ),
                  ])
                ],
                if (ctrl.gmailSelection.value) ...[
                  const SizedBox(height: 20),
                  Row(children: [
                    const Text("E-mail"),
                    const SizedBox(width: 50),
                    const Text(":"),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: ctrl.emailController,
                        style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: MouseRegion(
                            cursor: SystemMouseCursors.click, // Change cursor to hand
                            child: GestureDetector(
                              onTap: () {
                                ctrl.toggleCCEmail();
                              },
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        ctrl.ccEmailVisible.value ? Icons.closed_caption_outlined : Icons.closed_caption_disabled_outlined,
                                        color: Primary_colors.Dark,
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(
                                        size: 15,
                                        Icons.add,
                                        color: Primary_colors.Dark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        validator: (value) => Validators.email_validator(value),
                      ),
                    ),
                  ]),
                ],
                if (ctrl.ccEmailVisible.value && ctrl.gmailSelection.value) ...[
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('                                      Cc :', style: TextStyle(fontSize: 13, color: Primary_colors.Dark, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: ctrl.ccEmailController,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                          validator: (value) => Validators.email_validator(value),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Select"),
                    const SizedBox(width: 50),
                    const Text(":"),
                    const SizedBox(width: 20),
                    _buildServiceIcon(
                      asset: 'assets/images/whatsapp.png',
                      selected: ctrl.whatsappSelection.value,
                      onTap: () => ctrl.whatsappSelection.toggle(),
                    ),
                    const SizedBox(width: 20),
                    _buildServiceIcon(
                      asset: 'assets/images/gmail.png',
                      selected: ctrl.gmailSelection.value,
                      onTap: () => ctrl.gmailSelection.toggle(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 380,
                      child: TextFormField(
                        maxLines: 5,
                        controller: ctrl.feedbackController,
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                          hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 167, 165, 165)),
                          hintText: 'Enter Feedback...',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (await pdfToShare.exists() && await pdfToShare.length() > 0) {
                          bool isSuccess = await sharePDF(
                            context,
                            ctrl.messageType,
                            pdfToShare,
                            ctrl.emailController.text,
                            ctrl.phoneController.text,
                            ctrl.feedbackController.text,
                            ctrl.ccEmailController.text,
                          );
                          if (isSuccess) ctrl.reset();
                        } else {
                          Error_dialog(
                            context: context,
                            title: "Error",
                            content: "The PDF file is empty or missing.",
                          );
                        }
                      },
                      child: Container(
                        width: 105,
                        decoration: BoxDecoration(
                          color: (ctrl.gmailSelection.value || ctrl.whatsappSelection.value) ? const Color.fromARGB(255, 81, 89, 212) : const Color.fromARGB(255, 39, 41, 73),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: Text("Send", style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }),
  );
}

Widget _buildServiceIcon({required String asset, required bool selected, required VoidCallback onTap}) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      IconButton(
        iconSize: 30,
        onPressed: onTap,
        icon: Image.asset(asset),
      ),
      if (selected)
        Container(
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(50)),
          child: const Padding(
            padding: EdgeInsets.all(2),
            child: Icon(Icons.check, color: Colors.white, size: 12),
          ),
        ),
    ],
  );
}

class SharePDFController extends GetxController {
  var whatsappSelection = true.obs;
  var gmailSelection = true.obs;
  var ccEmailVisible = false.obs;

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final ccEmailController = TextEditingController();
  final feedbackController = TextEditingController();

  void toggleCCEmail() => ccEmailVisible.toggle();

  int get messageType {
    if (whatsappSelection.value && gmailSelection.value) return 3;
    if (whatsappSelection.value) return 2;
    if (gmailSelection.value) return 1;
    return 0;
  }

  void reset() {
    phoneController.clear();
    emailController.clear();
    ccEmailController.clear();
    feedbackController.clear();
    ccEmailVisible.value = false;
  }
}
