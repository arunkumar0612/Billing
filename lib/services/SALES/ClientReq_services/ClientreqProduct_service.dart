import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/SALES/product_entities.dart';

import '../../../controllers/SALEScontrollers/ClientReq_actions.dart';

mixin ClientreqProductService {
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  void clearFields() {
    clientreqController.clientReqModel.productNameController.value.clear();
    clientreqController.clientReqModel.quantityController.value.clear();
    // clientreqController.clientReqModel.gstController.value.clear();
  }

  void addproduct(context) {
    if (clientreqController.clientReqModel.productFormkey.value.currentState?.validate() ?? false) {
      bool exists = clientreqController.clientReqModel.clientReqProductDetails.any((product) => product.productName == clientreqController.clientReqModel.productNameController.value.text);

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This product already exists.'),
          ),
        );
        return;
      }
      clientreqController.addProduct(context: context, productName: clientreqController.clientReqModel.productNameController.value.text, quantity: int.parse(clientreqController.clientReqModel.quantityController.value.text));

      clearFields();
    }
  }

  void updateproduct(context) {
    if (clientreqController.clientReqModel.productFormkey.value.currentState?.validate() ?? false) {
      clientreqController.updateProduct(
        context: context,
        editIndex: clientreqController.clientReqModel.product_editIndex.value!, // The index of the product to be updated
        productName: clientreqController.clientReqModel.productNameController.value.text,

        quantity: int.parse(clientreqController.clientReqModel.quantityController.value.text),
      );

      clearFields();
      clientreqController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    ClientreqProduct product = clientreqController.clientReqModel.clientReqProductDetails[index];
    clientreqController.updateProductName(product.productName);
    clientreqController.updateQuantity(product.quantity);
    clientreqController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    clientreqController.addProductEditindex(null);
  }
}
