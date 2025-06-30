import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/4_SALES/controllers/CustomPDF_Controllers/CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/4_SALES/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/CustomPDF_entities/CustomPDF_Product_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Invoice_entities.dart';
import 'package:ssipl_billing/4_SALES/views/CustomPDF/Invoice/Invoice_PostAll.dart';
import 'package:ssipl_billing/COMPONENTS-/CustomPDF_templates/CustomPDF_Invoice_template.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

import '../../../../API/invoker.dart';

class Custom_Invoice_Services {
  final Invoker apiController = Get.find<Invoker>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final CustomPDF_InvoiceController pdfpopup_controller = Get.find<CustomPDF_InvoiceController>();

  /// Calculates and assigns the total amount for each unique GST percentage in the manual invoice products.
  ///
  /// This function processes the `manualInvoiceproducts` list within `pdfpopup_controller.pdfModel`.
  /// It groups products by their GST percentage and sums their respective totals
  /// to provide a consolidated view of GST-wise totals.
  ///
  /// **Process:**
  /// 1.  **Filters Products:** It first filters `manualInvoiceproducts` to include
  ///     only those products where both `gst` and `total` fields are not empty.
  ///     This prevents errors from parsing invalid or missing data.
  /// 2.  **Aggregates Totals by GST:**
  ///     - It then uses the `fold` method to iterate over the filtered products.
  ///     - An `accumulator` (a `Map<double, double>`) is used to store the sum
  ///       of `total` for each unique `gstValue`.
  ///     - For each product, `gst` and `total` are parsed to `double`.
  ///     - The `totalValue` is added to the existing sum for its corresponding
  ///       `gstValue` in the `accumulator`. If a `gstValue` is encountered for
  ///       the first time, its sum starts from 0.
  /// 3.  **Transforms to `InvoiceGSTtotals` Objects:**
  ///     - The `entries` of the resulting `accumulator` map (which are key-value
  ///       pairs of `gstValue` and `summedTotal`) are then `map`ped into a list
  ///       of `InvoiceGSTtotals` objects. Each `InvoiceGSTtotals` object holds
  ///       a `gst` percentage and its corresponding `total` sum.
  /// 4.  **Assigns to Model:**
  ///     - Finally, the `assignAll` method is used to update the
  ///       `pdfpopup_controller.pdfModel.value.manualInvoice_gstTotals` with
  ///       this newly calculated list of `InvoiceGSTtotals` objects. This updates
  ///       the model that likely drives the UI display of GST summary.
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

  /// Generates a custom PDF invoice and saves it to the application's temporary cache directory.
  ///
  /// This asynchronous function orchestrates the creation of a PDF invoice using
  /// various data points from `pdfpopup_controller.pdfModel` and then stores
  /// the generated PDF file locally in a temporary directory.
  ///
  /// **Process:**
  /// 1.  **PDF Generation:**
  ///     - `generate_CustomPDFInvoice` is called with numerous parameters extracted
  ///       from `pdfpopup_controller.pdfModel.value`. These parameters include:
  ///         - `PdfPageFormat.a4`: Specifies the page size for the PDF.
  ///         - `date.value.text`: The invoice date.
  ///         - `manualInvoiceproducts`: The list of products in the manual invoice.
  ///         - `clientName.value.text`: The client's name.
  ///         - `clientAddress.value.text`: The client's address.
  ///         - `billingName.value.text`: The billing name.
  ///         - `billingAddres.value.text`: The billing address.
  ///         - `manualinvoiceNo.value.text`: The manual invoice number.
  ///         - `""`: An empty string, possibly a placeholder for a future field.
  ///         - `GSTnumber.value.text`: The client's GST number.
  ///         - `manualInvoice_gstTotals`: Pre-calculated GST totals for the invoice.
  ///         - `isGST_Local(...)`: A boolean indicating if the GST is local, determined
  ///           by another function based on the GST number.
  ///     - This function returns a `Uint8List` containing the byte data of the generated PDF.
  ///
  /// 2.  **Determining Cache Path:**
  ///     - `getTemporaryDirectory()` is called to obtain the `Directory` object
  ///       representing the system's temporary directory for the application.
  ///     - `Returns.replace_Slash_hypen(...)` is used to sanitize the
  ///       `manualinvoiceNo.value.text` by replacing slashes with hyphens. This
  ///       is crucial for creating a valid filename on various operating systems.
  ///     - The `filePath` for the PDF in the cache is constructed using the
  ///       temporary directory path and the sanitized invoice number, appended with `.pdf`.
  ///
  /// 3.  **Saving the PDF File:**
  ///     - A `File` object is created with the constructed `filePath`.
  ///     - `await file.writeAsBytes(pdfData)` writes the generated PDF's byte data
  ///       to the specified file in the cache.
  ///
  /// 4.  **Confirmation and Display:**
  ///     - In debug mode (`kDebugMode`), the path where the PDF is stored is printed to the console.
  ///     - `pdfpopup_controller.pdfModel.value.genearatedPDF.value` is updated
  ///       with the `File` object of the saved PDF. This makes the generated PDF
  ///       accessible within the model.
  ///     - `await show_generatedPDF(context)` is then called to display the
  ///       newly generated PDF to the user, likely in a PDF viewer.
  ///
  /// @param context The `BuildContext` used for obtaining the temporary directory
  ///                and for displaying the generated PDF.
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
        isGST_Local(pdfpopup_controller.pdfModel.value.GSTnumber.value.text));

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

  /// Displays a dialog containing the generated PDF invoice.
  ///
  /// This asynchronous function shows a modal `AlertDialog` to the user,
  /// which presents the previously generated PDF invoice for viewing. The dialog
  /// is configured to prevent dismissal by clicking outside.
  ///
  /// **Dialog Structure and Content:**
  /// - `await showDialog`: Displays the dialog and waits for it to be dismissed.
  /// - `context`: The `BuildContext` for showing the dialog.
  /// - `barrierDismissible: false`: Crucially prevents the user from closing the
  ///   dialog by tapping outside its bounds, forcing interaction with the provided controls.
  /// - `builder`: A function that returns the `AlertDialog` widget.
  ///   - `contentPadding`: Sets padding for the content inside the dialog.
  ///   - `shape`: Defines a rounded border for the dialog.
  ///   - `backgroundColor`: Sets the background color of the dialog to `Primary_colors.Light`.
  ///   - `content: Stack`: Uses a `Stack` to layer widgets:
  ///     - `SizedBox` containing `PostInvoice()`: This is the main area where the
  ///       generated PDF is presumably displayed. `PostInvoice()` is expected to be
  ///       a widget responsible for rendering the PDF content. It has fixed dimensions
  ///       of 650 height and 900 width.
  ///     - `Positioned` `IconButton`: An icon button is placed at the top-right corner
  ///       of the dialog.
  ///       - The icon itself is wrapped in a `Container` with a circular border
  ///         and a light gray background, making it visually distinct.
  ///       - It displays a close icon (`Icons.close`) in red.
  ///       - `onPressed`: When this button is pressed:
  ///         - `pdfpopup_controller.clear_postFields()` is called, likely to clear
  ///           any data related to the invoice posting process.
  ///         - `Navigator.of(context).pop()` is called to dismiss the `AlertDialog`.
  ///
  /// This function provides a controlled way to present the generated PDF to the user
  /// and allows them to close the viewer when done, while also cleaning up associated data.
  ///
  /// @param context The `BuildContext` used to display the dialog.
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
