import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4_SALES/controllers/CustomPDF_Controllers/CustomPDF_Quote_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/Quote_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/CustomPDF_entities/CustomPDF_Product_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Quote_entities.dart';
import 'package:ssipl_billing/4_SALES/views/CustomPDF/Quote/Quote_PostAll.dart';
import 'package:ssipl_billing/COMPONENTS-/CustomPDF_templates/CustomPDF_Quote_template.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

import '../../../../API/invoker.dart';

class Custom_Quote_Services {
  final Invoker apiController = Get.find<Invoker>();
  final QuoteController quoteController = Get.find<QuoteController>();
  final CustomPDF_QuoteController pdfpopup_controller = Get.find<CustomPDF_QuoteController>();

  /// Calculates and assigns GST totals for manual quote products.
  ///
  /// This method filters out products with non-empty GST and total fields, groups them
  /// by GST percentage, and computes the total value per GST group. The resulting list
  /// of `QuoteGSTtotals` is assigned to `manualQuote_gstTotals` in the `pdfpopup_controller`.
  ///
  /// Logic:
  /// - Groups `manualQuoteproducts` by their GST percentage.
  /// - Sums up the `total` values for each GST group.
  /// - Updates `manualQuote_gstTotals` with the new grouped totals.
  ///
  /// Note:
  /// - Assumes `gst` and `total` fields are valid numeric strings.
  /// - Skips products with empty GST or total values.

  void assign_GSTtotals() {
    pdfpopup_controller.pdfModel.value.manualQuote_gstTotals.assignAll(
      pdfpopup_controller.pdfModel.value.manualQuoteproducts
          .where((product) => product.gst.isNotEmpty && product.total.isNotEmpty) // Filter out empty values
          .fold<Map<double, double>>({}, (Map<double, double> accumulator, CustomPDF_QuoteProduct product) {
            double gstValue = double.parse(product.gst);
            double totalValue = double.parse(product.total);
            accumulator[gstValue] = (accumulator[gstValue] ?? 0) + totalValue;
            return accumulator;
          })
          .entries
          .map((entry) => QuoteGSTtotals(
                gst: entry.key,
                total: entry.value,
              ))
          .toList(),
    );
  }

  /// Generates a custom quote PDF and saves it to the temporary cache directory.
  ///
  /// This method:
  /// - Uses data from `pdfpopup_controller` to generate a custom PDF quote.
  /// - Sanitizes the quote number to form a valid filename.
  /// - Saves the generated PDF bytes to the device's temporary cache folder.
  /// - Updates `genearatedPDF` in `pdfModel` with the saved file reference.
  /// - Optionally logs the file path in debug mode.
  /// - Displays the generated PDF using `show_generatedPDF()`.
  ///
  /// Parameters:
  /// - [context]: BuildContext used to display the generated PDF dialog.
  ///
  /// Note:
  /// - Uses `generate_CustomPDFQuote()` to create the PDF content.
  /// - File is named after the sanitized quote number (slashes and hyphens replaced).
  /// - File is stored under: `<temporary_cache_path>/<quoteNo>.pdf`.
  Future<void> savePdfToCache(context) async {
    Uint8List pdfData = await generate_CustomPDFQuote(
        PdfPageFormat.a4,
        pdfpopup_controller.pdfModel.value.date.value.text,
        pdfpopup_controller.pdfModel.value.manualQuoteproducts,
        pdfpopup_controller.pdfModel.value.clientName.value.text,
        pdfpopup_controller.pdfModel.value.clientAddress.value.text,
        pdfpopup_controller.pdfModel.value.billingName.value.text,
        pdfpopup_controller.pdfModel.value.billingAddres.value.text,
        pdfpopup_controller.pdfModel.value.manualquoteNo.value.text,
        "",
        pdfpopup_controller.pdfModel.value.GSTnumber.value.text,
        pdfpopup_controller.pdfModel.value.manualQuote_gstTotals,
        isGST_Local(pdfpopup_controller.pdfModel.value.GSTnumber.value.text));

    Directory tempDir = await getTemporaryDirectory();
    String? sanitizedQuoteNo = Returns.replace_Slash_hypen(pdfpopup_controller.pdfModel.value.manualquoteNo.value.text);
    String filePath = '${tempDir.path}/$sanitizedQuoteNo.pdf';
    File file = File(filePath);
    await file.writeAsBytes(pdfData);

    if (kDebugMode) {
      print("PDF stored in cache: $filePath");
    }
    pdfpopup_controller.pdfModel.value.genearatedPDF.value = file;
    await show_generatedPDF(context);

    // return file;
  }

  /// Displays a dialog showing the generated PDF preview.
  ///
  /// This method:
  /// - Shows a modal dialog containing the `PostQuote` widget, used to render the PDF preview UI.
  /// - Prevents the dialog from being dismissed by tapping outside (`barrierDismissible: false`).
  /// - Includes a close button at the top-right corner.
  /// - On close:
  ///   - Clears post-generation fields using `pdfpopup_controller.clear_postFields()`.
  ///   - Closes the dialog.
  ///
  /// Parameters:
  /// - [context]: The build context from which the dialog is shown.
  ///
  /// UI Size:
  /// - Width: 900
  /// - Height: 650
  ///
  /// Note:
  /// - Old code for discarding unsaved form data is commented out but retained for future use.
  /// - Uses `Primary_colors.Light` as the background color.
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
                child: PostQuote(),
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
                    // // || ( quoteController.quoteModel.Quote_gstTotals.isNotEmpty)
                    // if ((quoteController.quoteModel.Quote_products.isNotEmpty) ||
                    //     (quoteController.quoteModel.Quote_noteList.isNotEmpty) ||
                    //     (quoteController.quoteModel.Quote_recommendationList.isNotEmpty) ||
                    //     (quoteController.quoteModel.clientAddressNameController.value.text != "") ||
                    //     (quoteController.quoteModel.clientAddressController.value.text != "") ||
                    //     (quoteController.quoteModel.billingAddressNameController.value.text != "") ||
                    //     (quoteController.quoteModel.billingAddressController.value.text != "") ||
                    //     (quoteController.quoteModel.Quote_no.value != "") ||
                    //     (quoteController.quoteModel.TitleController.value.text != "") ||
                    //     (quoteController.quoteModel.Quote_table_heading.value != "")) {
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
                    //               quoteController.resetData();
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
                    //     quoteController.quoteModel.Quote_products.clear();
                    //     quoteController.quoteModel.Quote_noteList.clear();
                    //     quoteController.quoteModel.Quote_recommendationList.clear();
                    //     quoteController.quoteModel.clientAddressNameController.value.clear();
                    //     quoteController.quoteModel.clientAddressController.value.clear();
                    //     quoteController.quoteModel.billingAddressNameController.value.clear();
                    //     quoteController.quoteModel.billingAddressController.value.clear();
                    //     quoteController.quoteModel.Quote_no.value = "";
                    //     quoteController.quoteModel.TitleController.value.clear();
                    //     quoteController.quoteModel.Quote_table_heading.value = "";
                    //   }
                    // } else {
                    //   Navigator.of(context).pop();
                    // }
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
