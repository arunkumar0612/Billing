import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/CustomPDF_Controllers/CustomPDF_DC_actions.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/utils/helpers/returns.dart';
import 'package:ssipl_billing/views/components/CustomPDF_templates/CustomPDF_DC_template.dart';
import 'package:ssipl_billing/views/screens/SALES/CustomPDF/DC/DC_PostAll.dart';
import '../../../APIservices/invoker.dart';

class Custom_Dc_Services {
  final Invoker apiController = Get.find<Invoker>();
  // final DcController dcController = Get.find<DcController>();
  final CustomPDF_DcController pdfpopup_controller = Get.find<CustomPDF_DcController>();

  // void assign_GSTtotals() {
  //   pdfpopup_controller.pdfModel.value.manualDc_gstTotals.assignAll(
  //     pdfpopup_controller.pdfModel.value.manualDcproducts
  //         .where((product) => product.gst.isNotEmpty && product.total.isNotEmpty) // Filter out empty values
  //         .fold<Map<double, double>>({}, (Map<double, double> accumulator, CustomPDF_DcProduct product) {
  //           double gstValue = double.parse(product.gst);
  //           double totalValue = double.parse(product.total);
  //           accumulator[gstValue] = (accumulator[gstValue] ?? 0) + totalValue;
  //           return accumulator;
  //         })
  //         .entries
  //         .map((entry) => DcGSTtotals(
  //               gst: entry.key,
  //               total: entry.value,
  //             ))
  //         .toList(),
  //   );
  // }

  Future<void> savePdfToCache(context) async {
    Uint8List pdfData = await generate_CustomPDFDc(
        PdfPageFormat.a4,
        pdfpopup_controller.pdfModel.value.date.value.text,
        pdfpopup_controller.pdfModel.value.manualDcproducts,
        pdfpopup_controller.pdfModel.value.clientName.value.text,
        pdfpopup_controller.pdfModel.value.clientAddress.value.text,
        pdfpopup_controller.pdfModel.value.billingName.value.text,
        pdfpopup_controller.pdfModel.value.billingAddres.value.text,
        pdfpopup_controller.pdfModel.value.manualdcNo.value.text,
        "",
        pdfpopup_controller.pdfModel.value.GSTnumber.value.text);

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedDcNo = Returns.replace_Slash_hypen(pdfpopup_controller.pdfModel.value.manualdcNo.value.text);
    String filePath = '${tempDir.path}/$sanitizedDcNo.pdf';
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
                child: PostDc(),
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
                    // // || ( dcController.dcModel.Dc_gstTotals.isNotEmpty)
                    // if ((dcController.dcModel.Dc_products.isNotEmpty) ||
                    //     (dcController.dcModel.Dc_noteList.isNotEmpty) ||
                    //     (dcController.dcModel.Dc_recommendationList.isNotEmpty) ||
                    //     (dcController.dcModel.clientAddressNameController.value.text != "") ||
                    //     (dcController.dcModel.clientAddressController.value.text != "") ||
                    //     (dcController.dcModel.billingAddressNameController.value.text != "") ||
                    //     (dcController.dcModel.billingAddressController.value.text != "") ||
                    //     (dcController.dcModel.Dc_no.value != "") ||
                    //     (dcController.dcModel.TitleController.value.text != "") ||
                    //     (dcController.dcModel.Dc_table_heading.value != "")) {
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
                    //               dcController.resetData();
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
                    //     dcController.dcModel.Dc_products.clear();
                    //     dcController.dcModel.Dc_noteList.clear();
                    //     dcController.dcModel.Dc_recommendationList.clear();
                    //     dcController.dcModel.clientAddressNameController.value.clear();
                    //     dcController.dcModel.clientAddressController.value.clear();
                    //     dcController.dcModel.billingAddressNameController.value.clear();
                    //     dcController.dcModel.billingAddressController.value.clear();
                    //     dcController.dcModel.Dc_no.value = "";
                    //     dcController.dcModel.TitleController.value.clear();
                    //     dcController.dcModel.Dc_table_heading.value = "";
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
