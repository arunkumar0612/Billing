import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/THEMES-/style.dart';
import 'package:ssipl_billing/4.SALES/controllers/CustomPDF_Controllers/CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/4.SALES/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/4.SALES/models/entities/CustomPDF_entities/CustomPDF_Product_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Invoice_entities.dart';
import 'package:ssipl_billing/4.SALES/views/CustomPDF/Invoice/Invoice_PostAll.dart';
import 'package:ssipl_billing/COMPONENTS-/CustomPDF_templates/CustomPDF_Invoice_template.dart';
import 'package:ssipl_billing/UTILS-/helpers/returns.dart';

import '../../../../API-/invoker.dart';

class Custom_Invoice_Services {
  final Invoker apiController = Get.find<Invoker>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final CustomPDF_InvoiceController pdfpopup_controller = Get.find<CustomPDF_InvoiceController>();

  void assign_GSTtotals() {
    pdfpopup_controller.pdfModel.value.manualInvoice_gstTotals.assignAll(
      pdfpopup_controller.pdfModel.value.manualInvoiceproducts
          .where((product) => product.gst.isNotEmpty && product.total.isNotEmpty) // Filter out empty values
          .fold<Map<double, double>>({}, (Map<double, double> accumulator, CustomPDF_InvoiceProduct product) {
            double gstValue = double.parse(product.gst);
            double totalValue = double.parse(product.total);
            accumulator[gstValue] = (accumulator[gstValue] ?? 0) + totalValue;
            return accumulator;
          })
          .entries
          .map((entry) => InvoiceGSTtotals(
                gst: entry.key,
                total: entry.value,
              ))
          .toList(),
    );
  }

  Future<void> savePdfToCache(context) async {
    Uint8List pdfData = await generate_CustomPDFInvoice(
      PdfPageFormat.a4,
      pdfpopup_controller.pdfModel.value.date.value.text,
      pdfpopup_controller.pdfModel.value.manualInvoiceproducts,
      pdfpopup_controller.pdfModel.value.clientName.value.text,
      pdfpopup_controller.pdfModel.value.clientAddress.value.text,
      pdfpopup_controller.pdfModel.value.billingName.value.text,
      pdfpopup_controller.pdfModel.value.billingAddres.value.text,
      pdfpopup_controller.pdfModel.value.manualinvoiceNo.value.text,
      "",
      pdfpopup_controller.pdfModel.value.GSTnumber.value.text,
      pdfpopup_controller.pdfModel.value.manualInvoice_gstTotals,
    );

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedInvoiceNo = Returns.replace_Slash_hypen(pdfpopup_controller.pdfModel.value.manualinvoiceNo.value.text);
    String filePath = '${tempDir.path}/$sanitizedInvoiceNo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    pdfpopup_controller.pdfModel.value.genearatedPDF.value = file;
    await show_generatedPDF(context);

    // return file;
  }

  dynamic show_generatedPDF(context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by clicking outside
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Primary_colors.Light,
          content: Stack(
            children: [
              SizedBox(
                height: 650,
                width: 900,
                child: PostInvoice(),
              ),
              Positioned(
                top: 3,
                right: 0,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 219, 216, 216),
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                  onPressed: () async {
                    // // Check if the data has any value
                    // // || ( invoiceController.invoiceModel.Invoice_gstTotals.isNotEmpty)
                    // if ((invoiceController.invoiceModel.Invoice_products.isNotEmpty) ||
                    //     (invoiceController.invoiceModel.Invoice_noteList.isNotEmpty) ||
                    //     (invoiceController.invoiceModel.Invoice_recommendationList.isNotEmpty) ||
                    //     (invoiceController.invoiceModel.clientAddressNameController.value.text != "") ||
                    //     (invoiceController.invoiceModel.clientAddressController.value.text != "") ||
                    //     (invoiceController.invoiceModel.billingAddressNameController.value.text != "") ||
                    //     (invoiceController.invoiceModel.billingAddressController.value.text != "") ||
                    //     (invoiceController.invoiceModel.Invoice_no.value != "") ||
                    //     (invoiceController.invoiceModel.TitleController.value.text != "") ||
                    //     (invoiceController.invoiceModel.Invoice_table_heading.value != "")) {
                    //   // Show confirmation dialog
                    //   bool? proceed = await showDialog<bool>(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         title: const Text("Warning"),
                    //         content: const Text(
                    //           "The data may be lost. Do you want to proceed?",
                    //         ),
                    //         actions: [
                    //           TextButton(
                    //             onPressed: () {
                    //               Navigator.of(context).pop(false); // No action
                    //             },
                    //             child: const Text("No"),
                    //           ),
                    //           TextButton(
                    //             onPressed: () {
                    //               invoiceController.resetData();
                    //               Navigator.of(context).pop(true); // Yes action
                    //             },
                    //             child: const Text("Yes"),
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   );

                    //   if (proceed == true) {
                    //     Navigator.of(context).pop();
                    //     invoiceController.invoiceModel.Invoice_products.clear();
                    //     invoiceController.invoiceModel.Invoice_noteList.clear();
                    //     invoiceController.invoiceModel.Invoice_recommendationList.clear();
                    //     invoiceController.invoiceModel.clientAddressNameController.value.clear();
                    //     invoiceController.invoiceModel.clientAddressController.value.clear();
                    //     invoiceController.invoiceModel.billingAddressNameController.value.clear();
                    //     invoiceController.invoiceModel.billingAddressController.value.clear();
                    //     invoiceController.invoiceModel.Invoice_no.value = "";
                    //     invoiceController.invoiceModel.TitleController.value.clear();
                    //     invoiceController.invoiceModel.Invoice_table_heading.value = "";
                    //   }
                    // } else {
                    //   Navigator.of(context).pop();
                    // }
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
