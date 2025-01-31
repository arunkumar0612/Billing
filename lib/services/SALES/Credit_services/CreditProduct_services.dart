import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/product_entities.dart';

import '../../../controllers/credit_actions.dart';

mixin CreditproductService {
  final CreditController creditController = Get.find<CreditController>();
  void clearFields() {
    creditController.creditModel.productNameController.value.clear();
    creditController.creditModel.hsnController.value.clear();
    creditController.creditModel.priceController.value.clear();
    creditController.creditModel.quantityController.value.clear();
    creditController.creditModel.gstController.value.clear();
  }

  void addproduct(context) {
    if (creditController.creditModel.productKey.value.currentState?.validate() ?? false) {
      bool exists = creditController.creditModel.Credit_products.any((product) => product.productName == creditController.creditModel.productNameController.value.text && product.hsn == creditController.creditModel.hsnController.value.text && product.quantity == int.parse(creditController.creditModel.quantityController.value.text));

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This product already exists.'),
          ),
        );
        return;
      }
      creditController.addProduct(context: context, productName: creditController.creditModel.productNameController.value.text, hsn: creditController.creditModel.hsnController.value.text, price: double.parse(creditController.creditModel.priceController.value.text), quantity: int.parse(creditController.creditModel.quantityController.value.text), gst: double.parse(creditController.creditModel.gstController.value.text));

      clearFields();
    }
  }

  void updateproduct(context) {
    if (creditController.creditModel.productKey.value.currentState?.validate() ?? false) {
      creditController.updateProduct(
        context: context,
        editIndex: creditController.creditModel.product_editIndex.value!, // The index of the product to be updated
        productName: creditController.creditModel.productNameController.value.text,
        hsn: creditController.creditModel.hsnController.value.text,
        price: double.parse(creditController.creditModel.priceController.value.text),
        quantity: int.parse(creditController.creditModel.quantityController.value.text),
        gst: double.parse(creditController.creditModel.gstController.value.text),
      );

      clearFields();
      creditController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    CreditProduct product = creditController.creditModel.Credit_products[index];

    creditController.updateProductName(product.productName);
    creditController.updateHSN(product.hsn);
    creditController.updatePrice(product.price);
    creditController.updateQuantity(product.quantity);
    creditController.updateGST(product.gst);
    creditController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    creditController.addProductEditindex(null);
  }
}
