import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/basicAPI_functions.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

void shareAnyPDF(BuildContext context, String filePath, File pdfToShare) {
  final ctrl = Get.put(SharePDFController());

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Obx(() {
      return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: EdgeInsets.all(20),
          child: Container(
              decoration: BoxDecoration(
                color: Primary_colors.Dark,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 500,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Primary_colors.Color3,
                          Primary_colors.Color3.withOpacity(0.85),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.share, color: Colors.white, size: 24),
                        const SizedBox(width: 16),
                        const Text(
                          'Share',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildServiceIcon(icon: FontAwesomeIcons.whatsapp, baseColor: Colors.teal, selected: ctrl.whatsappSelection.value, onTap: () => ctrl.whatsappSelection.toggle(), text: 'Whatsapp'),
                            const SizedBox(width: 60),
                            _buildServiceIcon(icon: Icons.mail, baseColor: Colors.red, selected: ctrl.gmailSelection.value, onTap: () => ctrl.gmailSelection.toggle(), text: 'Mail'),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(children: [
                          const Text(
                            "File name",
                            style: TextStyle(color: Color.fromARGB(255, 167, 165, 165)),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            " :",
                            style: TextStyle(color: Color.fromARGB(255, 167, 165, 165)),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              filePath,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ]),
                        // const SizedBox(height: 15),
                        if (ctrl.whatsappSelection.value) ...[
                          const SizedBox(height: 20),
                          Row(children: [
                            const Text(
                              "Whatsapp",
                              style: TextStyle(color: Color.fromARGB(255, 167, 165, 165)),
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              ":",
                              style: TextStyle(color: Color.fromARGB(255, 167, 165, 165)),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                controller: ctrl.phoneController,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 167, 165, 165)),
                                    borderRadius: BorderRadius.circular(8), // optional for rounded corners
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueAccent), // when focused
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Primary_colors.Light, // optional for background color
                                ),
                              ),
                            ),
                          ])
                        ],
                        if (ctrl.gmailSelection.value) ...[
                          const SizedBox(height: 20),
                          Row(children: [
                            const Text(
                              "E-mail",
                              style: TextStyle(color: Color.fromARGB(255, 167, 165, 165)),
                            ),
                            const SizedBox(width: 50),
                            const Text(
                              ":",
                              style: TextStyle(color: Color.fromARGB(255, 167, 165, 165)),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                controller: ctrl.emailController,
                                style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                  filled: true,
                                  fillColor: Primary_colors.Light,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 167, 165, 165)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: MouseRegion(
                                    cursor: SystemMouseCursors.click,
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
                                                color: ctrl.ccEmailVisible.value ? Colors.blueAccent : Color.fromARGB(255, 167, 165, 165),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Icon(
                                                size: 15,
                                                Icons.add,
                                                color: ctrl.ccEmailVisible.value ? Colors.blueAccent : const Color.fromARGB(255, 167, 165, 165),
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
                              const Text('                                      Cc :', style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 167, 165, 165), fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                    filled: true,
                                    fillColor: Primary_colors.Light,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromARGB(255, 167, 165, 165)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  controller: ctrl.ccEmailController,
                                  style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                                  validator: (value) => Validators.email_validator(value),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 460,
                              child: TextFormField(
                                maxLines: 5,
                                controller: ctrl.feedbackController,
                                style: const TextStyle(fontSize: 13, color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Primary_colors.Light,
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
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
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
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
              //
              )

          // content: IntrinsicHeight(
          //   child: SizedBox(
          //     width: 500,

          //   ),
          // ),
          );
    }),
  );
}

Widget _buildServiceIcon({
  required IconData icon,
  required Color baseColor,
  required bool selected,
  required VoidCallback onTap,
  required String text,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selected ? baseColor.withOpacity(0.1) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: baseColor,
                  size: 28,
                ),
              ),
            ),
            if (selected)
              Container(
                decoration: BoxDecoration(
                  color: baseColor,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(2),
                child: const Icon(Icons.check, color: Colors.white, size: 12),
              ),
          ],
        ),
      ),
      const SizedBox(height: 6),
      Text(
        text,
        style: TextStyle(
          color: Color.fromARGB(255, 167, 165, 165),
          // fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
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
