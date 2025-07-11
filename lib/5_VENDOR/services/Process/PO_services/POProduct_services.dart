import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Process/PO_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Process/PO_entities.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Process/product_entities.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/VENDOR_entities.dart';

mixin POproductService {
  final POController poController = Get.find<POController>();
  void clearFields() {
    poController.poModel.productNameController.value.clear();
    poController.poModel.hsnController.value.clear();
    poController.poModel.priceController.value.clear();
    poController.poModel.quantityController.value.clear();
    poController.poModel.gstController.value.clear();
  }

  void addproduct(context) {
    if (poController.poModel.productKey.value.currentState?.validate() ?? false) {
      // ignore: unrelated_type_equality_checks
      bool exists = poController.poModel.PO_products.any((product) =>
          product.productName == poController.poModel.productNameController.value.text &&
          // ignore: unrelated_type_equality_checks
          product.hsn == poController.poModel.hsnController.value.text &&
          product.quantity == int.parse(poController.poModel.quantityController.value.text));

      if (exists) {
        Get.snackbar("Product", "This product already exists.");
        return;
      }
      poController.addProduct(
          context: context,
          productName: poController.poModel.productNameController.value.text,
          hsn: poController.poModel.hsnController.value.text,
          price: double.parse(poController.poModel.priceController.value.text),
          quantity: int.parse(poController.poModel.quantityController.value.text),
          gst: double.parse(poController.poModel.gstController.value.text));

      clearFields();
    }
  }

  void onSubmit() {
    poController.poModel.PO_gstTotals.assignAll(
      poController.poModel.PO_products
          .fold<Map<double, double>>({}, (Map<double, double> accumulator, POProduct product) {
            accumulator[product.gst] = (accumulator[product.gst] ?? 0) + product.total;
            return accumulator;
          })
          .entries
          .map((entry) => POGSTtotals(
                gst: entry.key, // Convert key to String
                total: entry.value, // Convert value to String
              ))
          .toList(),
    );
  }

  void updateproduct(context) {
    if (poController.poModel.productKey.value.currentState?.validate() ?? false) {
      poController.updateProduct(
        context: context,
        editIndex: poController.poModel.product_editIndex.value!, // The index of the product to be updated
        productName: poController.poModel.productNameController.value.text,
        hsn: poController.poModel.hsnController.value.text,
        price: double.parse(poController.poModel.priceController.value.text),
        quantity: int.parse(poController.poModel.quantityController.value.text),
        gst: double.parse(poController.poModel.gstController.value.text),
      );

      clearFields();
      poController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    POProduct product = poController.poModel.PO_products[index];

    poController.updateProductName(product.productName);
    poController.updateHSN(product.hsn);
    poController.updatePrice(product.price);
    poController.updateQuantity(product.quantity);
    poController.updateGST(product.gst);
    poController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    poController.addProductEditindex(null);
  }

  void set_ProductValues(VendorProductSuggestion value) {
    poController.updateHSN(int.parse(value.productHsn));
    poController.updateGST(value.productGst);
    poController.updatePrice(value.productPrice);
  }
}
