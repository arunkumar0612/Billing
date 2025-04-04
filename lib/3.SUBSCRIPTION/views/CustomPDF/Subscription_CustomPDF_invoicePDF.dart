import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/CustomPDF_Controllers/SUBSCRIPTION_CustomPDF_Invoice_actions.dart' show SUBSCRIPTION_CustomPDF_InvoiceController;
import 'package:ssipl_billing/3.SUBSCRIPTION/services/CustomPDF_services/SUBSCRIPTION_CustomPDF_Invoice_services.dart' show SUBSCRIPTION_CustomPDF_Services;
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart' show Basic_dialog;
import 'package:ssipl_billing/COMPONENTS-/button.dart' show BasicButton;
import 'package:ssipl_billing/THEMES-/style.dart';

class Subscription_CustomPDF_InvoicePDF {
  final SUBSCRIPTION_CustomPDF_InvoiceController pdfpopup_controller = Get.find<SUBSCRIPTION_CustomPDF_InvoiceController>();
  var inst = SUBSCRIPTION_CustomPDF_Services();
  void showA4StyledPopup(BuildContext context) async {
    try {
      await showDialog(
        context: context,
        barrierDismissible: false, // Prevents closing the dialog by clicking outside
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.green,
            content: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1.41, // A4 Aspect Ratio (210mm x 297mm)
                  child: Container(
                    height: 950,
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    child: Obx(
                      () {
                        return SingleChildScrollView(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Form(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                key: pdfpopup_controller.pdfModel.value.allData_key.value,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    header(), const SizedBox(height: 15),
                                    addresses(),
                                    Details(),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        BasicButton(
                                            text: "Add product",
                                            colors: const Color.fromARGB(202, 33, 149, 243),
                                            onPressed: () {
                                              pdfpopup_controller.addRow();
                                            }),
                                        if (pdfpopup_controller.pdfModel.value.checkboxValues.contains(true)) const SizedBox(width: 5),
                                        if (pdfpopup_controller.pdfModel.value.checkboxValues.contains(true))
                                          Container(
                                            width: 75,
                                            // height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(204, 244, 67, 54),
                                              // gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                              //   colors,
                                              //   colors,
                                              //   Primary_colors.Light,
                                              // ]),
                                              borderRadius: BorderRadius.circular(5),
                                            ),

                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                              child: TextButton(
                                                onPressed: () async {
                                                  pdfpopup_controller.deleteRow();
                                                  await Future.delayed(const Duration(milliseconds: 20));
                                                  // inst.assign_GSTtotals();
                                                },
                                                child: const Text(
                                                  "Delete",
                                                  style: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),

                                    // const SizedBox(height: 5),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      height: pdfpopup_controller.pdfModel.value.textControllers.length > 3 ? 200 : pdfpopup_controller.pdfModel.value.textControllers.length * 40 + 40,
                                      child: contentTable(pdfpopup_controller),
                                    ),
                                    const SizedBox(height: 20),
                                    collage(),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              SizedBox(height: pdfpopup_controller.pdfModel.value.textControllers.length > 3 ? 5 : 130 - pdfpopup_controller.pdfModel.value.textControllers.length * 40),
                              footer(context),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 0,
                  child: IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      height: 30,
                      width: 30,
                      child: const Icon(Icons.close, color: Colors.red),
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text('Are you sure you want to close this pop-up?'),
                            actions: [
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  pdfpopup_controller.resetData();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      Get.snackbar("ERROR", "$e");
    }
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/sporadaResized.jpeg', height: 100),
        const Text("INVOICE", style: TextStyle(fontSize: Primary_font_size.SubHeading, fontWeight: FontWeight.bold)),
        SizedBox(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Date          ", style: TextStyle(fontSize: Primary_font_size.Text7)),
                  const Text("  :  ", style: TextStyle(fontSize: Primary_font_size.Text7)),
                  SizedBox(
                    // height: 20,
                    width: 80,
                    child: TextFormField(
                      style: const TextStyle(fontSize: Primary_font_size.Text5, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.date.value,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: -6, fontSize: 0),
                        isDense: true,
                        contentPadding: EdgeInsets.all(7),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        labelStyle: TextStyle(
                          fontSize: Primary_font_size.Text7,
                          color: Color.fromARGB(255, 167, 165, 165),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    "Invoice no",
                    style: TextStyle(fontSize: Primary_font_size.Text7),
                  ),
                  const Text("  :  ", style: TextStyle(fontSize: Primary_font_size.Text7)),
                  SizedBox(
                    // height: 20,
                    width: 80,
                    child: TextFormField(
                      maxLines: null,
                      style: const TextStyle(fontSize: Primary_font_size.Text5, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.manualinvoiceNo.value,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: -6, fontSize: 0),
                        isDense: true,
                        contentPadding: EdgeInsets.all(7),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        labelStyle: TextStyle(
                          fontSize: Primary_font_size.Text7,
                          color: Color.fromARGB(255, 167, 165, 165),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget addresses() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                // width: 270,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "CLIENT ADDRESS",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 90,

                // width: 270,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.clientName.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -6, fontSize: 0),
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "ABS Enterprises",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text4, fontStyle: FontStyle.italic, color: Color.fromARGB(255, 58, 58, 58)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.clientAddress.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -6, fontSize: 0),
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "123, Business Park Avenue, Sector 45, Downtown City, State - 560102, Country - USA",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text4, fontStyle: FontStyle.italic, color: Color.fromARGB(255, 58, 58, 58)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                // width: 270,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "BILLING ADDRESS",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 90,

                // width: 270,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.billingName.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -6, fontSize: 0),
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "ABS Enterprises",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text4, fontStyle: FontStyle.italic, color: Color.fromARGB(255, 58, 58, 58)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.billingAddres.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -6, fontSize: 0),
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "123, Business Park Avenue, Sector 45, Downtown City, State - 560102, Country - USA",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text4, fontStyle: FontStyle.italic, color: Color.fromARGB(255, 58, 58, 58)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget Details() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                // width: 270,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "BILL PLAN DETAILS",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                // height: 90,

                // width: 270,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.planname.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "Secure - 360°",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Plan name              :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 5),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.customertype.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "Corporate",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),

                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Customer type     :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.plancharges.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "Annexed",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Plan charges         :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.internetcharges.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "100.00",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Internet charges  :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.billperiod.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "01/ 01 / 2025 - 31 / 01 /2025",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Bill Period                :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.billdate.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "01 / 01 / 2025",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Bill date                   :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.duedate.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "07 / 01 / 2025",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Due date                :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                // width: 270,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "CUSTOMER ACOUNT DETAILS",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                // height: 90,

                // width: 270,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.relationshipID.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "KV-CI-AR",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Relationship ID     :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.billnumber.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "KVCIAR/250101",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Bill number            :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.customerGSTIN.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "33AADCK2098J1ZF",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Customer GSTIN  :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.HSNcode.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "998319",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("HSN / SAC Code   :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.customerPO.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "07AAACL1234C1Z5",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Customer PO        :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.contactperson.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "AAAAAAAAAAA",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Contact person   :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black, height: 2.3),
                          controller: pdfpopup_controller.pdfModel.value.contactnumber.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: -1, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "1234567890",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 136, 136, 136)),
                            // border: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Primary_colors.Color3, width: 2),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, top: 11),
                              child: Text("Contact number :  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget contentTable(SUBSCRIPTION_CustomPDF_InvoiceController controller) {
    const tableHeaders = ['✔', 'S.No', 'Site ID', 'Site Name', 'Address', 'Monthly Charges'];

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table Header
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green,
            ),
            padding: const EdgeInsets.only(left: 0, top: 8, bottom: 8, right: 10),
            child: Row(
              children: tableHeaders.map((header) {
                return Expanded(
                  // flex: header == "Description" ? 3 : 1,
                  child: Text(
                    header,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, overflow: TextOverflow.ellipsis),
                    textAlign: header == tableHeaders.last ? TextAlign.end : TextAlign.center,
                  ),
                );
              }).toList(),
            ),
          ),
          // Table Rows
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  controller.pdfModel.value.textControllers.length,
                  (rowIndex) {
                    return Container(
                      height: 40,
                      color: rowIndex % 2 == 0 ? Colors.green.shade50 : Colors.white,
                      padding: const EdgeInsets.only(right: 5),
                      child: Row(
                        children: [
                          // Checkbox Column
                          Expanded(
                            child: SizedBox(
                              width: 20,
                              child: Obx(
                                () => Checkbox(
                                  activeColor: rowIndex % 2 == 0 ? Colors.green.shade50 : Colors.white,
                                  checkColor: Primary_colors.Color3,
                                  value: controller.pdfModel.value.checkboxValues[rowIndex],
                                  onChanged: (value) {
                                    controller.pdfModel.value.checkboxValues[rowIndex] = value!;
                                  },
                                ),
                              ),
                            ),
                          ),
                          // Data Columns with Expanded
                          ...List.generate(
                            tableHeaders.length - 1,
                            (colIndex) {
                              bool isNumericField = [5].contains(colIndex);

                              return Expanded(
                                // flex: colIndex == 1 ? 3 : 1, // Make "Description" column wider
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: TextFormField(
                                    maxLines: null,
                                    controller: controller.pdfModel.value.textControllers[rowIndex][colIndex],
                                    textAlign: isNumericField ? TextAlign.end : TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                    onChanged: (value) {
                                      // if (!isTotalField) {
                                      controller.updateCell(rowIndex, colIndex, value);

                                      // inst.assign_GSTtotals();
                                    },
                                    readOnly: false,
                                    inputFormatters: isNumericField ? [FilteringTextInputFormatter.digitsOnly] : null,
                                    keyboardType: isNumericField ? TextInputType.number : TextInputType.text,
                                    decoration: InputDecoration(
                                      errorStyle: const TextStyle(height: -1, fontSize: 0),
                                      hintText: tableHeaders[colIndex + 1],
                                      hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.grey),
                                      contentPadding: const EdgeInsets.all(1),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Primary_colors.Color3, width: 2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter ${tableHeaders[colIndex + 1]}';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget collage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: gstTable()),
        const SizedBox(width: 60),
        SizedBox(
          width: 220,
          child: amount_data(),
        )
      ],
    );
  }

  Widget amount_data() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sub total", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("CGST", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("SGST", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("Round off", style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(width: 10),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("  :  ", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("  :  ", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("  :  ", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("  :  ", style: TextStyle(fontSize: 12)),
              ],
            ),
            // const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // height: 20,
                    // width: 80,
                    child: TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.subTotal.value,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0, fontSize: 0),
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        hintText: "0.0",
                        hintStyle: TextStyle(),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    // height: 20,
                    child: TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.CGST.value,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0, fontSize: 0),
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        hintText: "0.0",
                        hintStyle: TextStyle(),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    // height: 20,
                    child: TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.SGST.value,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0, fontSize: 0),
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),

                        hintText: "0.0",
                        hintStyle: TextStyle(),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    // height: 20,
                    child: TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.roundOff.value,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0, fontSize: 0),
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        hintText: "0.0",
                        hintStyle: TextStyle(),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                  Text(
                    " ${pdfpopup_controller.pdfModel.value.roundoffDiff.value ?? ""}   ",
                    style: TextStyle(
                      fontSize: Primary_font_size.Text7,
                      color: pdfpopup_controller.pdfModel.value.roundoffDiff.value?.startsWith('-') == true ? Colors.red : Colors.green,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(height: 1, color: Colors.black),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Total", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 56, 61, 136)))],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("            ", style: TextStyle(fontSize: 12))],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 20,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: TextFormField(
                          readOnly: true,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 56, 61, 136), fontWeight: FontWeight.bold),
                          controller: pdfpopup_controller.pdfModel.value.Total.value,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(height: 0, fontSize: 0),
                            contentPadding: EdgeInsets.only(),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),

                            hintText: "0.0",
                            hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 56, 61, 136)),
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        signatory(),
      ],
    );
  }

  Widget signatory() {
    return Container(
      height: 90,
      width: 220,
      decoration: BoxDecoration(border: Border.all()),
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: Text("Authorized Signatory", style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 127, 126, 126))),
      ),
    );
  }

  Widget gstTable() {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 151, 150, 150))),
                height: 90,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                        child: Row(
                          children: [
                            Container(
                              width: 90,
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)),
                                ),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    'Taxable Value',
                                    style: TextStyle(
                                      fontSize: Primary_font_size.Text8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                        child: const Text(
                                          textAlign: TextAlign.center,
                                          'CGST',
                                          style: TextStyle(fontSize: Primary_font_size.Text8, overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: double.infinity,
                                              decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                              child: const Text(
                                                textAlign: TextAlign.center,
                                                '%',
                                                style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'amount',
                                                style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: const BoxDecoration(
                                    // border: Border(right: BorderSide()),
                                    ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                        child: const Text(
                                          textAlign: TextAlign.center,
                                          'SGST',
                                          style: TextStyle(fontSize: Primary_font_size.Text8, overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: double.infinity,
                                              decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                              child: const Text(
                                                textAlign: TextAlign.center,
                                                '%',
                                                style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 2,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'amount',
                                              style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
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
                    Expanded(
                      child: SizedBox(
                        height: 200, // Set a fixed height (adjust as needed)
                        child: ListView.builder(
                          shrinkWrap: true, // Prevents infinite height issue
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 44, // Set a height for each row to prevent overflow
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                    child: Center(
                                      child: Text(
                                        pdfpopup_controller.pdfModel.value.subTotal.value.text,
                                        style: const TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                                      child: Center(
                                                        child: Text(
                                                          (18 / 2).toString(),
                                                          style: const TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Center(
                                                      child: Text(
                                                        pdfpopup_controller.pdfModel.value.CGST.value.text,
                                                        style: const TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                                  child: Center(
                                                    child: Text(
                                                      (18 / 2).toString(),
                                                      style: const TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Center(
                                                  child: Text(
                                                    pdfpopup_controller.pdfModel.value.SGST.value.text,
                                                    style: const TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 55),
            notes(),
          ],
        );
      },
    );
  }

  Widget notes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("NOTES", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add, size: 18, color: Colors.blue),
              onPressed: () {
                pdfpopup_controller.add_Note();
              },
            ),
          ],
        ),
        // const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(5), color: Colors.green.shade50),
          width: 400,
          height: 90,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                pdfpopup_controller.pdfModel.value.notecontent.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${index + 1}.", // Auto-incrementing S.No
                          style: const TextStyle(fontSize: Primary_font_size.Text7, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5), // Space between number and textfield
                        Flexible(
                          child: IntrinsicWidth(
                            // Ensures TextField takes only required width
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 50), // Set a reasonable min width
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                maxLines: null,
                                controller: pdfpopup_controller.pdfModel.value.noteControllers[index],
                                onChanged: (value) {
                                  pdfpopup_controller.update_noteCotent(value, index);
                                },
                                style: const TextStyle(fontSize: 12),
                                decoration: InputDecoration(
                                  // contentPadding: const EdgeInsets.all(0),
                                  errorStyle: const TextStyle(height: 0, fontSize: 0),
                                  suffix: GestureDetector(
                                    child: const Icon(
                                      Icons.delete,
                                      size: 14,
                                      color: const Color.fromARGB(193, 244, 67, 54),
                                    ),
                                    onTap: () {
                                      pdfpopup_controller.deleteNote(index);
                                    },
                                  ),
                                  hintText: "Please enter the notes....",
                                  hintStyle: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                  isDense: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget footer(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Text(
            "This is a custom invoice generator designed to ensure accuracy and professionalism in your billing process. Please make sure that all details entered are valid and correct, as any discrepancies may affect the accuracy of your invoice and financial records.",
            style: TextStyle(fontSize: Primary_font_size.Text7),
          ),
        ),
        const SizedBox(width: 20),
        Obx(
          () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                pdfpopup_controller.pdfModel.value.isLoading.value
                    ? SizedBox(
                        width: 125,
                        child: Stack(
                          children: [
                            LinearPercentIndicator(
                              lineHeight: 27,
                              // width: 105,
                              percent: pdfpopup_controller.pdfModel.value.progress.value,
                              barRadius: const Radius.circular(5),
                              backgroundColor: const Color.fromARGB(255, 31, 38, 63),
                              progressColor: Colors.blue,
                              center: Text(
                                "${(pdfpopup_controller.pdfModel.value.progress.value * 100).toInt()}%",
                                style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
                              ),
                            ),
                            Positioned.fill(
                              child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.transparent,
                                      Primary_colors.Dark,
                                    ],
                                    stops: [
                                      0.0,
                                      0.5,
                                      1.0,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ).createShader(bounds);
                                },
                                child: LinearPercentIndicator(
                                  lineHeight: 30,
                                  // width: 105,
                                  percent: pdfpopup_controller.pdfModel.value.progress.value,
                                  barRadius: const Radius.circular(5),
                                  backgroundColor: Primary_colors.Dark,
                                  progressColor: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: 125,
                        // height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (pdfpopup_controller.pdfModel.value.allData_key.value.currentState?.validate() ?? false) {
                              try {
                                await Future.wait(
                                  [
                                    pdfpopup_controller.startProgress(),
                                    inst.savePdfToCache(context),
                                  ],
                                );
                              } catch (e, stackTrace) {
                                debugPrint("Error in Future.wait: $e");
                                debugPrint(stackTrace.toString());
                                Get.snackbar("Error", "Something went wrong. Please try again.");
                              }
                            } else {
                              Basic_dialog(context: context, title: "ERROR", content: "Please check for empty fields before proceeding1", showCancel: false);
                            }
                          },
                          child: const Text("Generate", style: TextStyle(fontSize: 12, color: Colors.white)),
                        )),
              ],
            );
          },
        ),
      ],
    );
  }
}
