import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/DC_actions.dart';

mixin DcproductService {
  final DCController dcController = Get.find<DCController>();
  void clearFields() {
    dcController.dcModel.productNameController.value.clear();
    dcController.dcModel.hsnController.value.clear();
    dcController.dcModel.priceController.value.clear();
    dcController.dcModel.quantityController.value.clear();
    dcController.dcModel.gstController.value.clear();
    // SGSTController.clear();
  }

  void addproduct(context) {
    if (dcController.dcModel.productKey.value.currentState?.validate() ?? false) {
      bool exists = dcController.dcModel.Delivery_challan_productDetails.any((product) => product['productName'] == dcController.dcModel.productNameController.value.text && product['hsn'] == dcController.dcModel.hsnController.value.text && product['price'] == double.parse(dcController.dcModel.priceController.value.text) && product['quantity'] == int.parse(dcController.dcModel.quantityController.value.text) && product['gst'] == double.parse(dcController.dcModel.gstController.value.text));

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This product already exists.'),
          ),
        );
        return;
      }
      dcController.addProduct(context: context, productName: dcController.dcModel.productNameController.value.text, hsn: dcController.dcModel.hsnController.value.text, price: double.parse(dcController.dcModel.priceController.value.text), quantity: int.parse(dcController.dcModel.quantityController.value.text), gst: double.parse(dcController.dcModel.gstController.value.text));
      // dcController.dcModel.Delivery_challan_productDetails.add({
      //   'productName': dcController.dcModel.productNameController.value.text,
      //   'hsn': dcController.dcModel.hsnController.value.text,
      //   'price': double.parse(dcController.dcModel.priceController.value.text),
      //   'quantity': int.parse(dcController.dcModel.quantityController.value.text),
      //   'gst': double.parse(dcController.dcModel.gstController.value.text),
      // });

      clearFields();
    }
  }

  void updateproduct(context) {
    if (dcController.dcModel.productKey.value.currentState?.validate() ?? false) {
      dcController.updateProduct(
        context: context,
        editIndex: dcController.dcModel.editIndex1.value!, // The index of the product to be updated
        productName: dcController.dcModel.productNameController.value.text,
        hsn: dcController.dcModel.hsnController.value.text,
        price: double.parse(dcController.dcModel.priceController.value.text),
        quantity: int.parse(dcController.dcModel.quantityController.value.text),
        gst: double.parse(dcController.dcModel.gstController.value.text),
      );

      // dcController.dcModel.Delivery_challan_productDetails[dcController.dcModel.editIndex1.value!] = {
      //   'productName': dcController.dcModel.productNameController.value.text,
      //   'hsn': dcController.dcModel.hsnController.value.text,
      //   'price': double.parse(dcController.dcModel.priceController.value.text),
      //   'quantity': int.parse(dcController.dcModel.quantityController.value.text),
      //   'gst': double.parse(dcController.dcModel.gstController.value.text),
      //   // 'productSGST': SGSTController.text,
      // };
      clearFields();
      dcController.addProductEditindex(null);
      // dcController.dcModel.editIndex1.value = null;
    }
  }

  void editproduct(int index) {
    Map<String, dynamic> product = dcController.dcModel.Delivery_challan_productDetails[index];

    dcController.updateProductName(product['productName'] ?? '');
    dcController.updateHSN(product['hsn'] ?? '');
    dcController.updatePrice(product['price']);
    dcController.updateQuantity(product['quantity']);
    dcController.updateGST(product['gst']);
    dcController.addProductEditindex(index);

    // dcController.dcModel.productNameController.value.text = product['productName'] ?? '';
    // dcController.dcModel.hsnController.value.text = product['hsn'] ?? '';
    // dcController.dcModel.priceController.value.text = product['price'].toString();
    // dcController.dcModel.quantityController.value.text = product['quantity'].toString();
    // dcController.dcModel.gstController.value.text = product['gst'].toString();
    // // SGSTController.text = product['productSGST'] ?? '';
    // dcController.dcModel.editIndex1.value = index; // Set the index of the item being edited

    // print('Edit------------------${selected_notify_Items}');
  }

  void resetEditingState() {
    clearFields();
    dcController.addProductEditindex(null);
    // dcController.dcModel.editIndex1.value = null;
  }
}
