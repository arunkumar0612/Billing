// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as path;
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/Subscription_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/services/subscription_service.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/downloadPDF.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/sharePDF.dart';
import 'package:ssipl_billing/COMPONENTS-/PDF_methods/showPDF.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

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
                              flex: 6,
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
                              flex: 1,
                              child: Text(
                                textAlign: TextAlign.right,
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
                              flex: 2,
                              child: Text(
                                textAlign: TextAlign.center,
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
                                              flex: 6,
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
                                              flex: 1,
                                              child: Text(
                                                formatCurrency(double.parse(subscriptionController.subscriptionModel.reccuringInvoice_list[index].totalAmount.toString())),
                                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            const SizedBox(width: 5),

                                            Expanded(
                                              flex: 2,
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
                                                        showPDF(context, subscriptionController.subscriptionModel.reccuringInvoice_list[index].invoiceNo, file);
                                                      }
                                                    },
                                                    child: Image.asset(height: 30, 'assets/images/pdfdownload.png')),
                                              ),
                                            ),
                                            // ,
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
                                                        shareAnyPDF(
                                                            context,
                                                            path
                                                                .basename(subscriptionController.subscriptionModel.reccuringInvoice_list[index].invoiceNo)
                                                                .replaceAll(RegExp(r'[\/\\:*?"<>|.]'), '') // Removes invalid symbols
                                                                .replaceAll(" ", ""),
                                                            file!);
                                                      }
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
                                                        downloadPdf(
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
