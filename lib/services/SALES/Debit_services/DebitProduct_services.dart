import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Debit_actions.dart';
import 'package:ssipl_billing/models/entities/product_entities.dart';

mixin DebitproductService {
  final DebitController debitController = Get.find<DebitController>();
  void clearFields() {
    debitController.debitModel.productNameController.value.clear();
    debitController.debitModel.hsnController.value.clear();
    debitController.debitModel.priceController.value.clear();
    debitController.debitModel.quantityController.value.clear();
    debitController.debitModel.gstController.value.clear();
  }

  void addproduct(context) {
    if (debitController.debitModel.productKey.value.currentState?.validate() ?? false) {
      bool exists = debitController.debitModel.Debit_products.any((product) => product.productName == debitController.debitModel.productNameController.value.text && product.hsn == debitController.debitModel.hsnController.value.text && product.quantity == int.parse(debitController.debitModel.quantityController.value.text));

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This product already exists.'),
          ),
        );
        return;
      }
      debitController.addProduct(context: context, productName: debitController.debitModel.productNameController.value.text, hsn: debitController.debitModel.hsnController.value.text, price: double.parse(debitController.debitModel.priceController.value.text), quantity: int.parse(debitController.debitModel.quantityController.value.text), gst: double.parse(debitController.debitModel.gstController.value.text));

      clearFields();
    }
  }

  void updateproduct(context) {
    if (debitController.debitModel.productKey.value.currentState?.validate() ?? false) {
      debitController.updateProduct(
        context: context,
        editIndex: debitController.debitModel.product_editIndex.value!, // The index of the product to be updated
        productName: debitController.debitModel.productNameController.value.text,
        hsn: debitController.debitModel.hsnController.value.text,
        price: double.parse(debitController.debitModel.priceController.value.text),
        quantity: int.parse(debitController.debitModel.quantityController.value.text),
        gst: double.parse(debitController.debitModel.gstController.value.text),
      );

      clearFields();
      debitController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    DebitProduct product = debitController.debitModel.Debit_products[index];

    debitController.updateProductName(product.productName);
    debitController.updateHSN(product.hsn);
    debitController.updatePrice(product.price);
    debitController.updateQuantity(product.quantity);
    debitController.updateGST(product.gst);
    debitController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    debitController.addProductEditindex(null);
  }
}
