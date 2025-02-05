import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/DC_actions.dart';
import 'package:ssipl_billing/models/entities/SALES/product_entities.dart';

mixin DcproductService {
  final DCController dcController = Get.find<DCController>();
  void clearFields() {
    dcController.dcModel.productNameController.value.clear();
    dcController.dcModel.hsnController.value.clear();
    dcController.dcModel.quantityController.value.clear();
  }

  void addproduct(context) {
    if (dcController.dcModel.productKey.value.currentState?.validate() ?? false) {
      bool exists = dcController.dcModel.Delivery_challan_products.any((product) => product.productName == dcController.dcModel.productNameController.value.text && product.hsn == dcController.dcModel.hsnController.value.text && product.quantity == int.parse(dcController.dcModel.quantityController.value.text));

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This product already exists.'),
          ),
        );
        return;
      }
      dcController.addProduct(context: context, productName: dcController.dcModel.productNameController.value.text, hsn: dcController.dcModel.hsnController.value.text, quantity: int.parse(dcController.dcModel.quantityController.value.text));

      clearFields();
    }
  }

  void updateproduct(context) {
    if (dcController.dcModel.productKey.value.currentState?.validate() ?? false) {
      dcController.updateProduct(
        context: context,
        editIndex: dcController.dcModel.product_editIndex.value!, // The index of the product to be updated
        productName: dcController.dcModel.productNameController.value.text,
        hsn: dcController.dcModel.hsnController.value.text,
        quantity: int.parse(dcController.dcModel.quantityController.value.text),
      );

      clearFields();
      dcController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    DCProduct product = dcController.dcModel.Delivery_challan_products[index];

    dcController.updateProductName(product.productName);
    dcController.updateHSN(product.hsn);
    // dcController.updatePrice(product.price);
    dcController.updateQuantity(product.quantity);
    // dcController.updateGST(product.gst);
    dcController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    dcController.addProductEditindex(null);
  }
}
