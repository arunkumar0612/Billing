import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/CustomPDF_Controllers/SUBSCRIPTION_CustomPDF_Invoice_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/models/entities/CustomPDF_entities/CustomPDF_invoice_entities.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/views/CustomPDF/Subscription_PostAll.dart' show SUBSCRIPTION_PostInvoice;
import 'package:ssipl_billing/API-/invoker.dart' show Invoker;
import 'package:ssipl_billing/COMPONENTS-/CustomPDF_templates/SUBSCRIPTION_CustomPDF_Invoice_template.dart' show SUBSCRIPTION_generate_CustomPDFInvoice;
import 'package:ssipl_billing/THEMES-/style.dart' show Primary_colors;
import 'package:ssipl_billing/UTILS-/helpers/returns.dart' show Returns;

class SUBSCRIPTION_CustomPDF_Services {
  final Invoker apiController = Get.find<Invoker>();
  final SUBSCRIPTION_CustomPDF_InvoiceController pdfpopup_controller = Get.find<SUBSCRIPTION_CustomPDF_InvoiceController>();

  Future<void> savePdfToCache(context) async {
    Uint8List pdfData = await SUBSCRIPTION_generate_CustomPDFInvoice(
      PdfPageFormat.a4,
      SUBSCRIPTION_Custom_Invoice(
          date: pdfpopup_controller.pdfModel.value.date.value.text,
          invoiceNo: pdfpopup_controller.pdfModel.value.manualinvoiceNo.value.text,
          gstPercent: 18,
          pendingAmount: 500.0,
          addressDetails: Address(
            billingName: pdfpopup_controller.pdfModel.value.billingName.value.text,
            billingAddress: pdfpopup_controller.pdfModel.value.billingAddress.value.text,
            installation_serviceName: pdfpopup_controller.pdfModel.value.installation_serviceName.value.text,
            installation_serviceAddress: pdfpopup_controller.pdfModel.value.installation_serviceAddres.value.text,
          ),
          billPlanDetails: BillPlanDetails(
              planName: pdfpopup_controller.pdfModel.value.planname.value.text,
              customerType: pdfpopup_controller.pdfModel.value.customertype.value.text,
              planCharges: pdfpopup_controller.pdfModel.value.plancharges.value.text,
              internetCharges: double.tryParse(pdfpopup_controller.pdfModel.value.internetcharges.value.text) ?? 0.0,
              billPeriod: pdfpopup_controller.pdfModel.value.billperiod.value.text,
              // billDate: pdfpopup_controller.pdfModel.value.billdate.value.text,
              dueDate: pdfpopup_controller.pdfModel.value.duedate.value.text),
          customerAccountDetails: CustomerAccountDetails(
            relationshipId: pdfpopup_controller.pdfModel.value.relationshipID.value.text,
            // billNumber: pdfpopup_controller.pdfModel.value.billnumber.value.text,
            customerGSTIN: pdfpopup_controller.pdfModel.value.customerGSTIN.value.text,
            hsnSacCode: pdfpopup_controller.pdfModel.value.HSNcode.value.text,
            customerPO: pdfpopup_controller.pdfModel.value.customerPO.value.text,
            contactPerson: pdfpopup_controller.pdfModel.value.contactperson.value.text,
            contactNumber: pdfpopup_controller.pdfModel.value.contactnumber.value.text,
          ),
          siteData: pdfpopup_controller.pdfModel.value.manualInvoicesites,
          finalCalc: FinalCalculation.fromJson(pdfpopup_controller.pdfModel.value.manualInvoicesites, 18, 0.0),
          notes: pdfpopup_controller.pdfModel.value.notecontent,
          pendingInvoices: [],
          totalcaculationtable: TotalcaculationTable(
              previousdues: pdfpopup_controller.pdfModel.value.previousdues.value.text,
              payment: pdfpopup_controller.pdfModel.value.payment.value.text,
              adjustments_deduction: pdfpopup_controller.pdfModel.value.adjustments_deduction.value.text,
              currentcharges: pdfpopup_controller.pdfModel.value.Total.value.text,
              totalamountdue: pdfpopup_controller.pdfModel.value.totaldueamount.value.text),
          ispendingamount: pdfpopup_controller.pdfModel.value.ispendingamount.value),
    );
    // pdfData = pdfData.buffer.asUint8List(0, pdfData.length + 1);

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
