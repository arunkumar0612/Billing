import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/Subscription_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/services/subscription_service.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Recurringinvoice extends StatefulWidget with SubscriptionServices {
  Recurringinvoice({super.key});

  @override
  State<Recurringinvoice> createState() => _RecurringinvoiceState();
}

class _RecurringinvoiceState extends State<Recurringinvoice> {
  final SubscriptionController subscriptionController = Get.find<SubscriptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Primary_colors.Color3, Primary_colors.Color3], // Example gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10), // Ensure border radius for smooth corners
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Invoice ID',
                                style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Client',
                                style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Date',
                                style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Amount',
                                style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            SizedBox(width: 5),
                            // Expanded(
                            //   flex: 2,
                            //   child: Text(
                            //     'Status',
                            //     style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                            //   ),
                            // ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'View',
                                style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Share',
                                style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Download',
                                style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: subscriptionController.subscriptionModel.reccuringInvoice_list.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) => Container(
                                height: 1,
                                color: const Color.fromARGB(94, 125, 125, 125),
                              ),
                              itemCount: subscriptionController.subscriptionModel.reccuringInvoice_list.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Primary_colors.Light,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                subscriptionController.subscriptionModel.reccuringInvoice_list[index].invoiceNo,
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                subscriptionController.subscriptionModel.reccuringInvoice_list[index].clientAddressName,
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                subscriptionController.subscriptionModel.reccuringInvoice_list[index].date,
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                subscriptionController.subscriptionModel.reccuringInvoice_list[index].totalAmount.toString(),
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            // Expanded(
                                            //     flex: 2,
                                            //     child: Row(
                                            //       children: [
                                            //         Container(
                                            //           height: 22,
                                            //           width: 60,
                                            //           decoration: BoxDecoration(
                                            //             borderRadius: BorderRadius.circular(20),
                                            //             color: subscriptionController. subscriptionModel.reccuringInvoice_list[index]. == 'Paid' ? const Color.fromARGB(193, 222, 244, 223) : const Color.fromARGB(208, 244, 214, 212),
                                            //           ),
                                            //           child: Center(
                                            //             child: Text(
                                            //               invoice_list[index]['Status'],
                                            //               style: TextStyle(
                                            //                   color: invoice_list[index]['Status'] == 'Paid' ? const Color.fromARGB(255, 0, 122, 4) : Colors.red,
                                            //                   fontSize: Primary_font_size.Text5,
                                            //                   fontWeight: FontWeight.bold),
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       ],
                                            //     )),
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      bool success = await widget.Get_RecurredPDFfile(
                                                        context,
                                                        subscriptionController.subscriptionModel.reccuringInvoice_list[index].recurredbillid,
                                                      );
                                                      if (success) {
                                                        File? file = subscriptionController.subscriptionModel.recurred_pdfFile.value;

                                                        if (file != null) {
                                                          if (await file.exists() && await file.length() > 0) {
                                                            Uint8List? temp = await convertFileToUint8List(subscriptionController.subscriptionModel.recurred_pdfFile.value!);
                                                            showDialog(
                                                              context: context,
                                                              builder: (context) => Dialog(
                                                                insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
                                                                child: SizedBox(
                                                                  width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
                                                                  height: MediaQuery.of(context).size.height * 0.95, // 80% of screen height
                                                                  child: SfPdfViewer.memory(temp),
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            Error_dialog(
                                                              context: context,
                                                              title: "Error",
                                                              content: "The  PDF file is empty or missing.",
                                                              // showCancel: false,
                                                            );
                                                          }
                                                        } else {
                                                          Error_dialog(
                                                            context: context,
                                                            title: "Error",
                                                            content: "The  PDF file is empty or missing.",
                                                            // showCancel: false,
                                                          );
                                                        }
                                                      } else {
                                                        Error_SnackBar(context, "ERROR viewing file, Please contact administration!");
                                                      }
                                                    },
                                                    child: Image.asset(height: 30, 'assets/images/pdfdownload.png'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      subscriptionController.clear_sharedata();
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Obx(
                                                            () {
                                                              return AlertDialog(
                                                                // shadowColor: Primary_colors.Color3,
                                                                titlePadding: const EdgeInsets.all(5),
                                                                backgroundColor: const Color.fromARGB(255, 194, 198, 253), // Matching background color
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10), // Consistent with Snackbar
                                                                ),
                                                                title: Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(7),
                                                                    color: Primary_colors.Color3,
                                                                  ),
                                                                  child: const Padding(
                                                                    padding: EdgeInsets.all(7),
                                                                    child: Text(
                                                                      "Share",
                                                                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                                content: IntrinsicHeight(
                                                                  child: SizedBox(
                                                                    // height: 200,
                                                                    width: 500,
                                                                    child: Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            const Text("File name"),
                                                                            const SizedBox(
                                                                              width: 20,
                                                                            ),
                                                                            const Text(":"),
                                                                            const SizedBox(
                                                                              width: 20,
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                subscriptionController.subscriptionModel.customPdfList[index].filePath,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        if (subscriptionController.subscriptionModel.whatsapp_selectionStatus.value)
                                                                          const SizedBox(
                                                                            height: 20,
                                                                          ),
                                                                        if (subscriptionController.subscriptionModel.whatsapp_selectionStatus.value)
                                                                          Row(
                                                                            children: [
                                                                              const Text("whatsapp"),
                                                                              const SizedBox(
                                                                                width: 20,
                                                                              ),
                                                                              const Text(":"),
                                                                              const SizedBox(
                                                                                width: 20,
                                                                              ),
                                                                              Expanded(
                                                                                child: TextFormField(
                                                                                  // maxLines: 5,
                                                                                  controller: subscriptionController.subscriptionModel.phoneController.value,
                                                                                  style: const TextStyle(fontSize: 13, color: Colors.black),
                                                                                  decoration: const InputDecoration(
                                                                                      // contentPadding: const EdgeInsets.all(10),
                                                                                      // filled: true,
                                                                                      // fillColor: Primary_colors.Dark,
                                                                                      // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                                                      // // enabledBorder: InputBorder.none, // Removes the enabled border
                                                                                      // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                                                      // hintStyle: const TextStyle(
                                                                                      //   fontSize: Primary_font_size.Text7,
                                                                                      //   color: Color.fromARGB(255, 167, 165, 165),
                                                                                      // ),
                                                                                      // hintText: 'Enter Feedback...',
                                                                                      // prefixIcon: const Icon(
                                                                                      //   Icons.feedback_outlined,
                                                                                      //   color: Colors.white,
                                                                                      // ),
                                                                                      // suffixIcon: Padding(
                                                                                      //   padding: const EdgeInsets.only(top: 50),
                                                                                      //   child: IconButton(
                                                                                      //     onPressed: () {},
                                                                                      //     icon: const Icon(
                                                                                      //       Icons.send,
                                                                                      //       color: Colors.red,
                                                                                      //     ),
                                                                                      //   ),
                                                                                      // ),
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        if (subscriptionController.subscriptionModel.gmail_selectionStatus.value)
                                                                          const SizedBox(
                                                                            height: 20,
                                                                          ),
                                                                        if (subscriptionController.subscriptionModel.gmail_selectionStatus.value)
                                                                          Row(
                                                                            children: [
                                                                              const Text("E-mail"),
                                                                              const SizedBox(
                                                                                width: 50,
                                                                              ),
                                                                              const Text(":"),
                                                                              const SizedBox(
                                                                                width: 20,
                                                                              ),

                                                                              Expanded(
                                                                                child: SizedBox(
                                                                                  // width: 400,
                                                                                  child: TextFormField(
                                                                                    readOnly: false,
                                                                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                                                                                    controller: subscriptionController.subscriptionModel.emailController.value,
                                                                                    decoration: InputDecoration(
                                                                                      // filled: true,
                                                                                      fillColor: Primary_colors.Dark,
                                                                                      // focusedBorder: const OutlineInputBorder(
                                                                                      //   borderSide: BorderSide(
                                                                                      //     color: Colors.black,
                                                                                      //   ),
                                                                                      // ),
                                                                                      // enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                                      // labelStyle: const TextStyle(
                                                                                      //   fontSize: Primary_font_size.Text7,
                                                                                      //   color: Color.fromARGB(255, 167, 165, 165),
                                                                                      // ),
                                                                                      // border: const OutlineInputBorder(),
                                                                                      suffixIcon: MouseRegion(
                                                                                        cursor: SystemMouseCursors.click, // Change cursor to hand
                                                                                        child: GestureDetector(
                                                                                          onTap: () {
                                                                                            subscriptionController
                                                                                                .toggleCCemailvisibility(!subscriptionController.subscriptionModel.CCemailToggle.value);
                                                                                          },
                                                                                          child: SizedBox(
                                                                                            height: 20,
                                                                                            width: 20,
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: Alignment.center,
                                                                                                  child: Icon(
                                                                                                    subscriptionController.subscriptionModel.CCemailToggle.value
                                                                                                        ? Icons.closed_caption_outlined
                                                                                                        : Icons.closed_caption_disabled_outlined,
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
                                                                                    validator: (value) {
                                                                                      Validators.email_validator(value);

                                                                                      return null;
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              // Expanded(
                                                                              //   child: TextFormField(
                                                                              //     // maxLines: 5,
                                                                              //     controller: subscriptionController.subscriptionModel.emailController.value,
                                                                              //     style: const TextStyle(fontSize: 13, color: Colors.black),
                                                                              //     decoration: const InputDecoration(
                                                                              //         // contentPadding: const EdgeInsets.all(10),
                                                                              //         // filled: true,
                                                                              //         // fillColor: Primary_colors.Dark,
                                                                              //         // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                                              //         // // enabledBorder: InputBorder.none, // Removes the enabled border
                                                                              //         // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                                              //         // hintStyle: const TextStyle(
                                                                              //         //   fontSize: Primary_font_size.Text7,
                                                                              //         //   color: Color.fromARGB(255, 167, 165, 165),
                                                                              //         // ),
                                                                              //         // hintText: 'Enter Feedback...',
                                                                              //         // prefixIcon: const Icon(
                                                                              //         //   Icons.feedback_outlined,
                                                                              //         //   color: Colors.white,
                                                                              //         // ),
                                                                              //         // suffixIcon: Padding(
                                                                              //         //   padding: const EdgeInsets.only(top: 50),
                                                                              //         //   child: IconButton(
                                                                              //         //     onPressed: () {},
                                                                              //         //     icon: const Icon(
                                                                              //         //       Icons.send,
                                                                              //         //       color: Colors.red,
                                                                              //         //     ),
                                                                              //         //   ),
                                                                              //         // ),
                                                                              //         ),
                                                                              //   ),
                                                                              // ),
                                                                            ],
                                                                          ),
                                                                        if (subscriptionController.subscriptionModel.CCemailToggle.value &&
                                                                            subscriptionController.subscriptionModel.gmail_selectionStatus.value)
                                                                          const SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                        if (subscriptionController.subscriptionModel.CCemailToggle.value &&
                                                                            subscriptionController.subscriptionModel.gmail_selectionStatus.value)
                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                            children: [
                                                                              const Text(
                                                                                '                                      Cc :',
                                                                                style: TextStyle(fontSize: 13, color: Primary_colors.Dark, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Expanded(
                                                                                child: SizedBox(
                                                                                  // height: 30,
                                                                                  // width: 400,
                                                                                  child: TextFormField(
                                                                                    scrollPadding: const EdgeInsets.only(top: 10),
                                                                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                                                                                    controller: subscriptionController.subscriptionModel.CCemailController.value,
                                                                                    // decoration: const InputDecoration(
                                                                                    //   filled: true,
                                                                                    //   fillColor: Color.fromARGB(255, 38, 39, 44),
                                                                                    //   focusedBorder: OutlineInputBorder(
                                                                                    //     borderSide: BorderSide(
                                                                                    //       color: Colors.black,
                                                                                    //     ),
                                                                                    //   ),
                                                                                    //   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                                    //   labelStyle: TextStyle(
                                                                                    //     fontSize: Primary_font_size.Text7,
                                                                                    //     color: Color.fromARGB(255, 167, 165, 165),
                                                                                    //   ),
                                                                                    //   border: OutlineInputBorder(),
                                                                                    // ),
                                                                                    validator: (value) {
                                                                                      Validators.email_validator(value);

                                                                                      return null;
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        const SizedBox(
                                                                          height: 20,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            const Text("Select"),
                                                                            const SizedBox(
                                                                              width: 50,
                                                                            ),
                                                                            const Text(":"),
                                                                            const SizedBox(
                                                                              width: 20,
                                                                            ),
                                                                            Stack(
                                                                              alignment: FractionalOffset.topRight,
                                                                              children: [
                                                                                IconButton(
                                                                                  iconSize: 30,
                                                                                  onPressed: () {
                                                                                    subscriptionController.subscriptionModel.whatsapp_selectionStatus.value =
                                                                                        subscriptionController.subscriptionModel.whatsapp_selectionStatus.value == false ? true : false;
                                                                                  },
                                                                                  icon: Image.asset(
                                                                                    'assets/images/whatsapp.png',
                                                                                  ),
                                                                                ),
                                                                                if (subscriptionController.subscriptionModel.whatsapp_selectionStatus.value)
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
                                                                                    subscriptionController.subscriptionModel.gmail_selectionStatus.value =
                                                                                        subscriptionController.subscriptionModel.gmail_selectionStatus.value == false ? true : false;
                                                                                  },
                                                                                  icon: Image.asset('assets/images/gmail.png'),
                                                                                ),
                                                                                if (subscriptionController.subscriptionModel.gmail_selectionStatus.value)
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
                                                                        const SizedBox(
                                                                          height: 20,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.bottomLeft,
                                                                              child: SizedBox(
                                                                                width: 380,
                                                                                // height: 100,
                                                                                child: TextFormField(
                                                                                  maxLines: 5,
                                                                                  controller: subscriptionController.subscriptionModel.feedbackController.value,
                                                                                  style: const TextStyle(fontSize: 13, color: Colors.white),
                                                                                  decoration: InputDecoration(
                                                                                    contentPadding: const EdgeInsets.all(10),
                                                                                    filled: true,
                                                                                    fillColor: Primary_colors.Dark,
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                                                    // enabledBorder: InputBorder.none, // Removes the enabled border
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
                                                                                    hintStyle: const TextStyle(
                                                                                      fontSize: Primary_font_size.Text7,
                                                                                      color: Color.fromARGB(255, 167, 165, 165),
                                                                                    ),
                                                                                    hintText: 'Enter Feedback...',
                                                                                    // prefixIcon: const Icon(
                                                                                    //   Icons.feedback_outlined,s
                                                                                    //   color: Colors.white,
                                                                                    // ),
                                                                                    // suffixIcon: Padding(
                                                                                    //   padding: const EdgeInsets.only(top: 50),
                                                                                    //   child: IconButton(
                                                                                    //     onPressed: () {},
                                                                                    //     icon: const Icon(
                                                                                    //       Icons.send,
                                                                                    //       color: Primary_colors.Color3,
                                                                                    //     ),
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            // const SizedBox(
                                                                            //   width: 20,
                                                                            // ),
                                                                            // Container(
                                                                            //   // width: 400,
                                                                            //   height: 50,
                                                                            //   color: Primary_colors.Light,
                                                                            //   child:
                                                                            // )
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                          height: 20,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          children: [
                                                                            MouseRegion(
                                                                              cursor: subscriptionController.subscriptionModel.whatsapp_selectionStatus.value ||
                                                                                      subscriptionController.subscriptionModel.gmail_selectionStatus.value
                                                                                  ? SystemMouseCursors.click
                                                                                  : SystemMouseCursors.forbidden,
                                                                              child: GestureDetector(
                                                                                onTap: () async {
                                                                                  bool success = await widget.Get_RecurredPDFfile(
                                                                                    context,
                                                                                    subscriptionController.subscriptionModel.reccuringInvoice_list[index].recurredbillid,
                                                                                  );
                                                                                  if (success) {
                                                                                    File? file = subscriptionController.subscriptionModel.recurred_pdfFile.value;

                                                                                    if (await file!.exists() && await file.length() > 0) {
                                                                                      widget.postData_sendPDF(
                                                                                        context,
                                                                                        widget.fetch_messageType(),
                                                                                        file,
                                                                                      );
                                                                                    } else {
                                                                                      Error_dialog(
                                                                                        context: context,
                                                                                        title: "Error",
                                                                                        content: "The PDF file is empty or missing.",
                                                                                        // showCancel: false,
                                                                                      );
                                                                                    }
                                                                                  } else {
                                                                                    Error_SnackBar(context, "ERROR sending file, Please contact administration!");
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  width: 105,
                                                                                  // height: 40,
                                                                                  decoration: BoxDecoration(
                                                                                    color: subscriptionController.subscriptionModel.whatsapp_selectionStatus.value ||
                                                                                            subscriptionController.subscriptionModel.gmail_selectionStatus.value
                                                                                        ? const Color.fromARGB(255, 81, 89, 212)
                                                                                        : const Color.fromARGB(255, 39, 41, 73),
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                  ),

                                                                                  child: const Padding(
                                                                                    padding: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        "Send",
                                                                                        style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    // actions: [
                                                                    //   if (showCancel)
                                                                    //     TextButton(
                                                                    //       onPressed: () => Navigator.of(context).pop(false), // Cancel returns `false`
                                                                    //       child: const Text('Cancel', style: TextStyle(color: Primary_colors.Light, fontSize: 14, fontWeight: FontWeight.bold)),
                                                                    //     ),
                                                                    //   TextButton(
                                                                    //     onPressed: () {
                                                                    //       Navigator.of(context).pop(true); // OK returns `true`
                                                                    //       if (onOk != null) {
                                                                    //         onOk(); // Call onOk only if it's provided
                                                                    //       }
                                                                    //     },
                                                                    //     child: const Text('OK', style: TextStyle(color: Primary_colors.Light, fontSize: 14, fontWeight: FontWeight.bold)),
                                                                    //   ),
                                                                    // ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Image.asset(height: 22, 'assets/images/share.png'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      bool success = await widget.Get_RecurredPDFfile(context, subscriptionController.subscriptionModel.reccuringInvoice_list[index].recurredbillid);

                                                      if (success) {
                                                        widget.downloadPdf(
                                                            context,
                                                            subscriptionController.subscriptionModel.reccuringInvoice_list[index].pdfPathString
                                                                .replaceAll(RegExp(r'[\/\\:*?"<>|.]'), '') // Removes invalid symbols
                                                                .replaceAll(" ", ""),
                                                            subscriptionController.subscriptionModel.recurred_pdfFile.value);
                                                      } else {
                                                        Error_SnackBar(context, "ERROR downloading file, Please conatct administration!");
                                                      }
                                                    },
                                                    child: Image.asset(height: 20, 'assets/images/download.png'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // const Expanded(flex: 2, child: Icon(Icons.keyboard_control)),
                                            // const Expanded(flex: 2, child: Icon(Icons.keyboard_control)),
                                            // const Expanded(flex: 2, child: Icon(Icons.keyboard_control))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Lottie.asset(
                                      'assets/animations/JSON/emptyprocesslist.json',
                                      // width: 264,
                                      height: 150,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 164),
                                    child: Text(
                                      'No Active Invoices',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueGrey[800],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 204),
                                    child: Text(
                                      'When you genrate a invoice, it will appear here',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blueGrey[400],
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Primary_colors.Light),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            'CUSTOMER LIST',
                            style: TextStyle(
                              letterSpacing: 1,
                              wordSpacing: 3,
                              color: Primary_colors.Color3,
                              fontSize: Primary_font_size.Text10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            key: const ValueKey(1),
                            child: subscriptionController.subscriptionModel.recurredcustomerList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: subscriptionController.subscriptionModel.recurredcustomerList.length,
                                    itemBuilder: (context, index) {
                                      final customername = subscriptionController.subscriptionModel.recurredcustomerList[index].customerName;
                                      final customerid = subscriptionController.subscriptionModel.recurredcustomerList[index].customerId;
                                      return _buildSubscription_ClientCard(customername, customerid, index);
                                    },
                                  )
                                : Center(
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 40),
                                          child: Lottie.asset(
                                            'assets/animations/JSON/emptycustomerlist.json',
                                            // width: 264,
                                            height: 150,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 204),
                                          child: Text(
                                            'No Customers',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blueGrey[800],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 244),
                                          child: Text(
                                            'When you add customers, they will appear here',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.blueGrey[400],
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubscription_ClientCard(String customername, int customerid, int index) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Card(
            color: (subscriptionController.subscriptionModel.showcustomerprocess.value != null && subscriptionController.subscriptionModel.showcustomerprocess.value == index)
                ? Primary_colors.Color3
                : Primary_colors.Dark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            // colors: (subscriptionController.subscriptionModel.showcustomerprocess.value != null && subscriptionController.subscriptionModel.showcustomerprocess.value == index)
            //     ? [Primary_colors.Color3, Primary_colors.Color3]
            //     : [Primary_colors.Dark, Primary_colors.Dark],
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //   ),
            //   borderRadius: BorderRadius.circular(20), // Ensure border radius for smooth corners
            // ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              splashColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.all(7),
                child: CircleAvatar(
                  backgroundColor: subscriptionController.subscriptionModel.showcustomerprocess.value == index ? const Color.fromARGB(118, 18, 22, 33) : const Color.fromARGB(99, 100, 110, 255),
                  child: Text(
                    customername.trim().isEmpty
                        ? ''
                        : customername.contains(' ') // If there's a space, take first letter of both words
                            ? (customername[0].toUpperCase() + customername[customername.indexOf(' ') + 1].toUpperCase())
                            : customername[0].toUpperCase(), // If no space, take only the first letter
                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              // leading: const Icon(
              //   Icons.people,
              //   color: Colors.white,
              //   size: 25,
              // ),
              title: Text(
                customername,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
                ),
              ),
              // trailing: IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     size: 20,
              //     Icons.notifications,
              //     color: subscriptionController.subscriptionModel.showcustomerprocess.value == index ? Colors.red : Colors.amber,
              //   ),
              // ),
              // trailing: GestureDetector(
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       color: Color.fromARGB(0, 233, 4, 4),
              //       // shape: BoxShape.circle,
              //     ),
              //     child: Icon(
              //       Icons.info_rounded,
              //       color: subscriptionController.subscriptionModel.showcustomerprocess.value == index ? Primary_colors.Dark : Primary_colors.Color3,
              //     ),
              //   ),
              //   onTap: () {
              //     widget.Getclientprofile(context, customerid);
              //   },
              // ),
              onTap: subscriptionController.subscriptionModel.showcustomerprocess.value != index
                  ? () {
                      subscriptionController.updateshowcustomerprocess(index);
                      subscriptionController.updatecustomerId(customerid);

                      widget.Get_RecurringInvoiceList(customerid);
                    }
                  : () {
                      subscriptionController.updateshowcustomerprocess(null);
                      subscriptionController.updatecustomerId(0);
                      widget.Get_RecurringInvoiceList(null);
                    },
            ),
          ),
        );
      },
    );
  }
}
