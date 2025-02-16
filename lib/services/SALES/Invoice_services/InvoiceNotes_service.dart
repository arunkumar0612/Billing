import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/Invoice_actions.dart';
import 'package:ssipl_billing/models/entities/SALES/Invoice_entities.dart';
// import 'package:ssipl_billing/views/screens/SALES/Generate_Invoice/Invoice_template.dart';

import '../../../controllers/viewSend_actions.dart';
import '../../../themes/style.dart';
import '../../../views/components/view_send_pdf.dart';
import '../../../views/screens/SALES/Generate_Invoice/invoice_template.dart';
// import '../../../views/screens/SALES/Generate_Invoice/invoice_template.dart';

mixin InvoicenotesService {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final ViewsendController viewsendController = Get.find<ViewsendController>();

  void addtable_row(context) {
    invoiceController.updateRec_ValueControllerText(invoiceController.invoiceModel.recommendationHeadingController.value.text);
    bool exists = invoiceController.invoiceModel.Invoice_recommendationList.any((note) => note.key == invoiceController.invoiceModel.recommendationKeyController.value.text);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('This note Name already exists.'),
        ),
      );
      return;
    }
    invoiceController.addRecommendation(key: invoiceController.invoiceModel.recommendationKeyController.value.text, value: invoiceController.invoiceModel.recommendationValueController.value.text);
    cleartable_Fields();
  }

  void updatenote() {
    if (invoiceController.invoiceModel.noteformKey.value.currentState?.validate() ?? false) {
      invoiceController.updateNoteList(invoiceController.invoiceModel.notecontentController.value.text, invoiceController.invoiceModel.note_editIndex.value!);
      clearnoteFields();
      invoiceController.updateNoteEditindex(null);
    }
  }

  void updatetable() {
    invoiceController.updateRecommendation(index: invoiceController.invoiceModel.recommendation_editIndex.value!, key: invoiceController.invoiceModel.recommendationKeyController.value.text.toString(), value: invoiceController.invoiceModel.recommendationValueController.value.text.toString());
    cleartable_Fields();
    invoiceController.updateRecommendationEditindex(null);
  }

  void editnote(int index) {
    Note note = invoiceController.invoiceModel.Invoice_noteList[index];
    invoiceController.updateNoteContentControllerText(note.notename);
    invoiceController.updateNoteEditindex(index);
  }

  void editnotetable(int index) {
    final note = invoiceController.invoiceModel.Invoice_recommendationList[index];
    invoiceController.updateRec_KeyControllerText(note.key.toString());
    invoiceController.updateRec_ValueControllerText(note.value.toString());
    invoiceController.updateRecommendationEditindex(index);
  }

  void resetEditingStateNote() {
    () {
      clearnoteFields();
      cleartable_Fields();
      invoiceController.updateNoteEditindex(null);
      invoiceController.updateRecommendationEditindex(null);
    };
  }

  void clearnoteFields() {
    invoiceController.invoiceModel.notecontentController.value.clear();
  }

  void cleartable_Fields() {
    invoiceController.invoiceModel.recommendationKeyController.value.clear();
    invoiceController.invoiceModel.recommendationValueController.value.clear();
  }

  void addNotes(context) {
    if (invoiceController.invoiceModel.noteformKey.value.currentState?.validate() ?? false) {
      bool exists = invoiceController.invoiceModel.Invoice_noteList.any((note) => note.notename == invoiceController.invoiceModel.notecontentController.value.text);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This note Name already exists.'),
          ),
        );
        return;
      }
      invoiceController.addNote(invoiceController.invoiceModel.notecontentController.value.text);
      clearnoteFields();
    }
  }

  void Generate_Invoice(BuildContext context) async {
    // Start generating PDF data as a Future
    viewsendController.setLoading(false);
    final pdfGenerationFuture = generate_Invoice(PdfPageFormat.a4, invoiceController.invoiceModel.Invoice_products, invoiceController.invoiceModel.clientAddressNameController.value.text, invoiceController.invoiceModel.clientAddressController.value.text, invoiceController.invoiceModel.billingAddressNameController.value.text, invoiceController.invoiceModel.billingAddressController.value.text, invoiceController.invoiceModel.Invoice_no.value, invoiceController.invoiceModel.TitleController.value.text, 9, invoiceController.invoiceModel.Invoice_gstTotals);
    // Show the dialog immediately (not awaited)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Primary_colors.Light,
          content: Generate_popup(
            type: 'E://Invoice.pdf', // Pass the expected file path
          ),
        );
      },
    );

    // Wait for PDF data generation to complete
    final pdfData = await pdfGenerationFuture;
    const filePath = 'E://Invoice.pdf';
    final file = File(filePath);

    // Perform file writing and any other future tasks in parallel
    await Future.wait([
      file.writeAsBytes(pdfData), // Write PDF to file asynchronously
      // Future.delayed(const Duration(seconds: )), // Simulate any other async task if needed
    ]);

    // Continue execution while the dialog is still open
    viewsendController.setLoading(true);
  }
}
