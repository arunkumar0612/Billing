import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/CustomPDF_Controllers/SUBSCRIPTION_CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Invoice_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/CustomPDF_entities/CustomPDF_invoice_entities.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/views/CustomPDF/Subscription_PostAll.dart' show SUBSCRIPTION_PostInvoice;
import 'package:ssipl_billing/API-/invoker.dart' show Invoker;
import 'package:ssipl_billing/COMPONENTS-/CustomPDF_templates/SUBSCRIPTION_CustomPDF_Invoice_template.dart' show SUBSCRIPTION_generate_CustomPDFInvoice;
import 'package:ssipl_billing/THEMES-/style.dart' show Primary_colors;
import 'package:ssipl_billing/UTILS-/helpers/returns.dart' show Returns;

class SUBSCRIPTION_CustomPDF_Services {
  final Invoker apiController = Get.find<Invoker>();
  final SUBSCRIPTION_InvoiceController invoiceController = Get.find<SUBSCRIPTION_InvoiceController>();
  final SUBSCRIPTION_CustomPDF_InvoiceController pdfpopup_controller = Get.find<SUBSCRIPTION_CustomPDF_InvoiceController>();

  // void assign_GSTtotals() {
  //   pdfpopup_controller.pdfModel.value.manualInvoice_gstTotals.assignAll(
  //     pdfpopup_controller.pdfModel.value.manualInvoicesites
  //         // ignore: unnecessary_null_comparison
  //         .where((site) => site.monthlyCharges != null ? false : true) // Ensure non-empty values
  //         .fold<Map<double, double>>({}, (accumulator, site) {
  //           int totalValue = site.monthlyCharges;
  //           double gstValue = 18.0; // Assuming 'gst' is a field in `site`

  //           accumulator[gstValue] = (accumulator[gstValue] ?? 0) + totalValue;
  //           return accumulator;
  //         })
  //         .entries
  //         .map((entry) => SUBSCRIPTION_invoiceInvoiceGSTtotals(
  //               gst: entry.key,
  //               total: entry.value,
  //             ))
  //         .toList(),
  //   );
  // }

  Future<void> savePdfToCache(context) async {
    Uint8List pdfData = await SUBSCRIPTION_generate_CustomPDFInvoice(
      PdfPageFormat.a4,
      SUBSCRIPTION_Custom_Invoice(
        date: pdfpopup_controller.pdfModel.value.date.value.text,
        invoiceNo: pdfpopup_controller.pdfModel.value.manualinvoiceNo.value.text,
        gstPercent: 18,
        pendingAmount: 500.0,
        addressDetails: Address(
          clientName: pdfpopup_controller.pdfModel.value.clientName.value.text,
          clientAddress: pdfpopup_controller.pdfModel.value.clientAddress.value.text,
          billingName: pdfpopup_controller.pdfModel.value.billingName.value.text,
          billingAddress: pdfpopup_controller.pdfModel.value.billingAddres.value.text,
        ),
        billPlanDetails: BillPlanDetails(
            planName: pdfpopup_controller.pdfModel.value.planname.value.text,
            customerType: pdfpopup_controller.pdfModel.value.customertype.value.text,
            planCharges: pdfpopup_controller.pdfModel.value.plancharges.value.text,
            internetCharges: double.tryParse(pdfpopup_controller.pdfModel.value.internetcharges.value.text) ?? 0.0,
            billPeriod: pdfpopup_controller.pdfModel.value.billperiod.value.text,
            billDate: pdfpopup_controller.pdfModel.value.billdate.value.text,
            dueDate: pdfpopup_controller.pdfModel.value.duedate.value.text),
        customerAccountDetails: CustomerAccountDetails(
            relationshipId: pdfpopup_controller.pdfModel.value.relationshipID.value.text,
            billNumber: pdfpopup_controller.pdfModel.value.billnumber.value.text,
            customerGSTIN: pdfpopup_controller.pdfModel.value.customerGSTIN.value.text,
            hsnSacCode: pdfpopup_controller.pdfModel.value.HSNcode.value.text,
            customerPO: pdfpopup_controller.pdfModel.value.customerPO.value.text,
            contactPerson: pdfpopup_controller.pdfModel.value.contactperson.value.text,
            contactNumber: pdfpopup_controller.pdfModel.value.contactnumber.value.text),
        siteData: pdfpopup_controller.pdfModel.value.manualInvoicesites,
        finalCalc: FinalCalculation.fromJson(pdfpopup_controller.pdfModel.value.manualInvoicesites, 18, 0.0
            // subtotal: double.tryParse(pdfpopup_controller.pdfModel.value.manualInvoicesites[1].monthlyCharges.toString()) ?? 00,
            // igst: 18,
            // cgst: 9,
            // sgst: 9,
            // roundOff: '100',
            // differene: '1',
            // total: 100,
            // pendingAmount: 200,
            // grandTotal: 400
            ),
        notes: pdfpopup_controller.pdfModel.value.notecontent,
        pendingInvoices: [],
      ),
    );
    // Uint8List pdfData = await SUBSCRIPTION_generate_CustomPDFInvoice(
    //   PdfPageFormat.a4,
    //   pdfpopup_controller.pdfModel.value.date.value.text,
    //   pdfpopup_controller.pdfModel.value.manualInvoicesites,
    //   pdfpopup_controller.pdfModel.value.clientName.value.text,
    //   pdfpopup_controller.pdfModel.value.clientAddress.value.text,
    //   pdfpopup_controller.pdfModel.value.billingName.value.text,
    //   pdfpopup_controller.pdfModel.value.billingAddres.value.text,
    //   pdfpopup_controller.pdfModel.value.manualinvoiceNo.value.text,
    //   "",
    //   pdfpopup_controller.pdfModel.value.GSTnumber.value.text,
    //   pdfpopup_controller.pdfModel.value.manualInvoice_gstTotals,
    // );

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
                child: SUBSCRIPTION_PostInvoice(),
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
                    // if ((invoiceController.invoiceModel.Invoice_sites.isNotEmpty) ||
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
                    //     invoiceController.invoiceModel.Invoice_sites.clear();
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
