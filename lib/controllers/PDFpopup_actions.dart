import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/constants/pdfPopup_constants.dart';
import 'package:ssipl_billing/models/entities/PDFpopup_entities.dart';
import 'package:ssipl_billing/utils/helpers/support_functions.dart';

class PDFpopupController extends GetxController {
  var pdfModel = PDFpopupModel().obs;
  void initializeCheckboxes() {
    pdfModel.value.checkboxValues.assignAll(List.generate(pdfModel.value.products.length, (index) => false));
  }

  void initializeTextControllers() {
    pdfModel.value.textControllers.assignAll(
      pdfModel.value.products.map((product) {
        return [
          TextEditingController(text: product.sNo),
          TextEditingController(text: product.description),
          TextEditingController(text: product.hsn),
          TextEditingController(text: product.gst),
          TextEditingController(text: product.price),
          TextEditingController(text: product.quantity),
          TextEditingController(text: product.total), // Total is read-only
        ];
      }).toList(),
    );
  }

  void update_noteCotent(value, index) {
    pdfModel.value.notecontent[index] = value;
  }

  void deleteNote(int index) {
    pdfModel.value.noteControllers.removeAt(index);
    pdfModel.value.notecontent.removeAt(index);
    pdfModel.refresh();
  }

  void updateCell(int rowIndex, int colIndex, String value) {
    final product = pdfModel.value.products[rowIndex];

    // Allow only numeric values for specific columns
    if ([0, 2, 3, 4, 5].contains(colIndex) && !RegExp(r'^[0-9]*$').hasMatch(value)) {
      return;
    }

    switch (colIndex) {
      case 0:
        product.sNo = value;
        break;
      case 1:
        product.description = value;
        break;
      case 2:
        product.hsn = value;
        break;
      case 3:
        product.gst = value;
        break;
      case 4:
        product.price = value;
        break;
      case 5:
        product.quantity = value;
        break;
    }

    if (colIndex == 4 || colIndex == 5) {
      calculateTotal(rowIndex);
    }

    pdfModel.refresh();
  }

  void calculateTotal(int rowIndex) {
    final product = pdfModel.value.products[rowIndex];

    double price = double.tryParse(product.price) ?? 0;
    double quantity = double.tryParse(product.quantity) ?? 0;
    String newTotal = (price * quantity).toString();

    product.total = newTotal;
    pdfModel.value.textControllers[rowIndex][6].text = newTotal;
    finalCalc();
    pdfModel.refresh();
  }

  void finalCalc() {
    double addedSubTotal = 0.0;
    double addedCGST = 0.0;
    double addedSGST = 0.0;
    double addedRoundoff = 0.0;

    for (var product in pdfModel.value.products) {
      double subTotal = double.tryParse(product.total) ?? 0.0;
      double price = double.tryParse(product.price) ?? 0.0;
      double gst = double.tryParse(product.gst) ?? 0.0;
      double cgst = (gst / 100) * price / 2;
      double sgst = (gst / 100) * price / 2;

      addedCGST += cgst;
      addedSGST += sgst;
      addedSubTotal += subTotal;
    }
    addedRoundoff = addedSubTotal + addedCGST + addedSGST;

    pdfModel.value.subTotal.value.text = addedSubTotal.toStringAsFixed(2);
    pdfModel.value.CGST.value.text = addedCGST.toStringAsFixed(2);
    pdfModel.value.SGST.value.text = addedSGST.toStringAsFixed(2);
    pdfModel.value.roundOff.value.text = formatCurrencyRoundedPaisa(addedRoundoff);
    pdfModel.value.roundoffDiff.value = calculateFormattedDifference(addedRoundoff);
    pdfModel.value.Total.value.text = formatCurrencyRoundedPaisa(addedRoundoff);

    pdfModel.refresh();
  }

  void deleteRow() {
    for (int i = pdfModel.value.checkboxValues.length - 1; i >= 0; i--) {
      if (pdfModel.value.checkboxValues[i]) {
        pdfModel.value.products.removeAt(i);
        pdfModel.value.textControllers.removeAt(i);
        pdfModel.value.checkboxValues.removeAt(i);
      }
    }

    pdfModel.refresh(); // Ensure UI updates
  }

  void addRow() {
    pdfModel.value.textControllers.add(
      List.generate(7, (index) => TextEditingController()),
    );

    pdfModel.value.products.add(ManualProduct(
      sNo: "",
      description: "",
      hsn: "",
      gst: "",
      price: "",
      quantity: "",
      total: "0.0",
    ));

    pdfModel.value.checkboxValues.add(false);

    pdfModel.refresh();
  }
}
