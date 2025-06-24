import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

import '../../controllers/ClientReq_actions.dart';

mixin ClientreqProductService {
  final ClientreqController clientreqController = Get.find<ClientreqController>();

  /// Clears the product name and quantity input fields.
  ///
  /// This just resets the product name and quantity text boxes to empty.
  /// Helpful after adding a product or when starting fresh.
  void clearFields() {
    clientreqController.clientReqModel.productNameController.value.clear();
    clientreqController.clientReqModel.quantityController.value.clear();
    // clientreqController.clientReqModel.gstController.value.clear();
  }

  /// Adds a new product to the list if it passes validation and isn’t already added.
  ///
  /// First, this checks if the product form is valid. If a product with the same name
  /// already exists in the list, it shows a snackbar and stops. Otherwise, it adds
  /// the product using the current input values, then clears the form fields.
  ///
  /// [context] – Required to show the error snackbar and pass to the `addProduct` method.
  void addproduct(context) {
    if (clientreqController.clientReqModel.productFormkey.value.currentState?.validate() ?? false) {
      bool exists = clientreqController.clientReqModel.clientReqProductDetails.any((product) => product.productName == clientreqController.clientReqModel.productNameController.value.text);

      if (exists) {
        Error_SnackBar(context, 'This product already exists.');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     backgroundColor: Colors.blue,
        //     content: Text('This product already exists.'),
        //   ),
        // );
        return;
      }
      clientreqController.addProduct(
          context: context, productName: clientreqController.clientReqModel.productNameController.value.text, quantity: int.parse(clientreqController.clientReqModel.quantityController.value.text));

      clearFields();
    }
  }

  /// Updates a product in the list if the form is valid.
  ///
  /// This checks if the product form passes validation. If it does, it updates the product
  /// at the current edit index with the new name and quantity. Once updated, it clears
  /// the input fields and resets the edit index so nothing is being edited anymore.
  ///
  /// [context] – Used when calling the update method inside the controller.
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

  /// Loads a product’s details into the form for editing.
  ///
  /// This grabs the product at the given [index], fills in its name and quantity
  /// into the input fields, and stores the index to track that we're editing it.
  void editproduct(int index) {
    ClientreqProduct product = clientreqController.clientReqModel.clientReqProductDetails[index];
    clientreqController.updateProductName(product.productName);
    clientreqController.updateQuantity(product.quantity);
    clientreqController.addProductEditindex(index);
  }

  /// Resets the editing state for product entries.
  ///
  /// This clears the input fields and sets the edit index to null,
  /// basically ending any ongoing edit and returning the form to a clean state.
  void resetEditingState() {
    clearFields();
    clientreqController.addProductEditindex(null);
  }
}
