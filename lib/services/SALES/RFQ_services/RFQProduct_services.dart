import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/models/entities/product_entities.dart';

mixin RFQproductService {
  final RFQController rfqController = Get.find<RFQController>();
  void clearFields() {
    rfqController.rfqModel.productNameController.value.clear();
    rfqController.rfqModel.hsnController.value.clear();
    rfqController.rfqModel.priceController.value.clear();
    rfqController.rfqModel.quantityController.value.clear();
    rfqController.rfqModel.gstController.value.clear();
  }

  void addproduct(context) {
    if (rfqController.rfqModel.productKey.value.currentState?.validate() ?? false) {
      bool exists = rfqController.rfqModel.RFQ_products.any((product) => product.productName == rfqController.rfqModel.productNameController.value.text && product.hsn == rfqController.rfqModel.hsnController.value.text && product.quantity == int.parse(rfqController.rfqModel.quantityController.value.text));

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This product already exists.'),
          ),
        );
        return;
      }
      rfqController.addProduct(context: context, productName: rfqController.rfqModel.productNameController.value.text, hsn: rfqController.rfqModel.hsnController.value.text, price: double.parse(rfqController.rfqModel.priceController.value.text), quantity: int.parse(rfqController.rfqModel.quantityController.value.text), gst: double.parse(rfqController.rfqModel.gstController.value.text));

      clearFields();
    }
  }

  void updateproduct(context) {
    if (rfqController.rfqModel.productKey.value.currentState?.validate() ?? false) {
      rfqController.updateProduct(
        context: context,
        editIndex: rfqController.rfqModel.product_editIndex.value!, // The index of the product to be updated
        productName: rfqController.rfqModel.productNameController.value.text,
        hsn: rfqController.rfqModel.hsnController.value.text,
        price: double.parse(rfqController.rfqModel.priceController.value.text),
        quantity: int.parse(rfqController.rfqModel.quantityController.value.text),
        gst: double.parse(rfqController.rfqModel.gstController.value.text),
      );

      clearFields();
      rfqController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    RFQProduct product = rfqController.rfqModel.RFQ_products[index];

    rfqController.updateProductName(product.productName);
    rfqController.updateHSN(product.hsn);
    rfqController.updatePrice(product.price);
    rfqController.updateQuantity(product.quantity);
    rfqController.updateGST(product.gst);
    rfqController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    rfqController.addProductEditindex(null);
  }
}
