import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4.SALES/controllers/CustomPDF_Controllers/CustomPDF_DC_actions.dart';
import 'package:ssipl_billing/4.SALES/views/CustomPDF/DC/DC_PostAll.dart';
import 'package:ssipl_billing/COMPONENTS-/CustomPDF_templates/CustomPDF_DC_template.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';

import '../../../../API/invoker.dart';

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

  /// Generates a custom PDF for the Delivery Challan using provided data.
  ///
  /// Retrieves user input from the PDF model, such as date, client/billing
  /// details, and the list of manual products, and passes it to a custom
  /// PDF generation function.
  ///
  /// The resulting PDF is stored as a file in the device's temporary
  /// cache directory with a sanitized filename based on the DC number.
  ///
  /// If in debug mode, logs the path of the stored PDF file to the console.
  ///
  /// Updates the model's `genearatedPDF` field with the saved PDF file
  /// so it can be used elsewhere (like sharing or previewing).
  ///
  /// Finally, shows a preview dialog with the generated PDF content.
  ///
  /// Parameters:
  /// - [context]: The build context used to present the PDF preview.
  ///
  /// Returns:
  /// - A [Future] that completes when the PDF is saved and previewed.
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

  /// Displays the generated Delivery Challan PDF in a modal dialog.
  ///
  /// Presents an [AlertDialog] with a custom `PostDc` widget as its content,
  /// sized to accommodate PDF preview dimensions.
  ///
  /// Prevents the user from closing the dialog by tapping outside the dialog area
  /// (`barrierDismissible: false`), ensuring intentional user action is required.
  ///
  /// Includes a close (X) icon positioned at the top-right, which when clicked:
  /// - Clears relevant post fields from the `pdfpopup_controller`.
  /// - Dismisses the dialog using `Navigator.pop`.
  ///
  /// Parameters:
  /// - [context]: The build context used to render the modal dialog.
  ///
  /// Returns:
  /// - A [Future] that completes when the dialog is dismissed.
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
                    pdfpopup_controller.clear_postFields();
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
