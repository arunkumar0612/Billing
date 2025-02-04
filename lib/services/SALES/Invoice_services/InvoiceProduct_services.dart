import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/models/entities/product_entities.dart';

import '../../../models/entities/Invoice_entities.dart';

mixin InvoiceproductService {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  void clearFields() {
    invoiceController.invoiceModel.productNameController.value.clear();
    invoiceController.invoiceModel.hsnController.value.clear();
    invoiceController.invoiceModel.priceController.value.clear();
    invoiceController.invoiceModel.quantityController.value.clear();
    invoiceController.invoiceModel.gstController.value.clear();
  }

  void addproduct(context) {
    if (invoiceController.invoiceModel.productKey.value.currentState?.validate() ?? false) {
      bool exists = invoiceController.invoiceModel.Invoice_products.any((product) =>
          product.productName == invoiceController.invoiceModel.productNameController.value.text &&
          product.hsn == invoiceController.invoiceModel.hsnController.value.text &&
          product.quantity == int.parse(invoiceController.invoiceModel.quantityController.value.text));

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This product already exists.'),
          ),
        );
        return;
      }
      invoiceController.addProduct(
          context: context,
          productName: invoiceController.invoiceModel.productNameController.value.text,
          hsn: invoiceController.invoiceModel.hsnController.value.text,
          price: double.parse(invoiceController.invoiceModel.priceController.value.text),
          quantity: int.parse(invoiceController.invoiceModel.quantityController.value.text),
          gst: double.parse(invoiceController.invoiceModel.gstController.value.text));

      clearFields();
    }
  }

  void onSubmit() {
    invoiceController.invoiceModel.Invoice_gstTotals.assignAll(
      invoiceController.invoiceModel.Invoice_products
          .fold<Map<double, double>>({}, (Map<double, double> accumulator, InvoiceProduct product) {
            accumulator[product.gst] = (accumulator[product.gst] ?? 0) + product.total;
            return accumulator;
          })
          .entries
          .map((entry) => InvoiceGSTtotals(
                key: entry.key.toString(), // Convert key to String
                value: entry.value.toString(), // Convert value to String
              ))
          .toList(),
    );
  }

  void updateproduct(context) {
    if (invoiceController.invoiceModel.productKey.value.currentState?.validate() ?? false) {
      invoiceController.updateProduct(
        context: context,
        editIndex: invoiceController.invoiceModel.product_editIndex.value!, // The index of the product to be updated
        productName: invoiceController.invoiceModel.productNameController.value.text,
        hsn: invoiceController.invoiceModel.hsnController.value.text,
        price: double.parse(invoiceController.invoiceModel.priceController.value.text),
        quantity: int.parse(invoiceController.invoiceModel.quantityController.value.text),
        gst: double.parse(invoiceController.invoiceModel.gstController.value.text),
      );

      clearFields();
      invoiceController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    InvoiceProduct product = invoiceController.invoiceModel.Invoice_products[index];

    invoiceController.updateProductName(product.productName);
    invoiceController.updateHSN(product.hsn);
    invoiceController.updatePrice(product.price);
    invoiceController.updateQuantity(product.quantity);
    invoiceController.updateGST(product.gst);
    invoiceController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    invoiceController.addProductEditindex(null);
  }
}
