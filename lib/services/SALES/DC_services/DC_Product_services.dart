import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/DC_actions.dart';
import 'package:ssipl_billing/models/entities/SALES/DC_entities.dart';
import 'package:ssipl_billing/models/entities/SALES/product_entities.dart';

mixin DcproductService {
  final DcController dcController = Get.find<DcController>();
  void clearFields() {
    dcController.dcModel.productNameController.value.clear();
    dcController.dcModel.hsnController.value.clear();
    dcController.dcModel.priceController.value.clear();
    dcController.dcModel.quantityController.value.clear();
    dcController.dcModel.gstController.value.clear();
  }

  void addproduct(context) {
    if (dcController.dcModel.productKey.value.currentState?.validate() ?? false) {
      bool exists = dcController.dcModel.Dc_products.any((product) => product.productName == dcController.dcModel.productNameController.value.text && product.hsn == dcController.dcModel.hsnController.value.text && product.quantity == int.parse(dcController.dcModel.quantityController.value.text));

      if (exists) {
        Get.snackbar("Product", "This product already exists.");
        return;
      }
      dcController.addProduct(context: context, productName: dcController.dcModel.productNameController.value.text, hsn: dcController.dcModel.hsnController.value.text, price: double.parse(dcController.dcModel.priceController.value.text), quantity: int.parse(dcController.dcModel.quantityController.value.text), gst: double.parse(dcController.dcModel.gstController.value.text));

      clearFields();
    }
  }

  void onSubmit() {
    dcController.dcModel.Dc_gstTotals.assignAll(
      dcController.dcModel.Dc_products
          .fold<Map<double, double>>({}, (Map<double, double> accumulator, DcProduct product) {
            accumulator[product.gst] = (accumulator[product.gst] ?? 0) + product.total;
            return accumulator;
          })
          .entries
          .map((entry) => DcGSTtotals(
                gst: entry.key, // Convert key to String
                total: entry.value, // Convert value to String
              ))
          .toList(),
    );
  }

  void updateproduct(context) {
    if (dcController.dcModel.productKey.value.currentState?.validate() ?? false) {
      dcController.updateProduct(
        context: context,
        editIndex: dcController.dcModel.product_editIndex.value!, // The index of the product to be updated
        productName: dcController.dcModel.productNameController.value.text,
        hsn: dcController.dcModel.hsnController.value.text,
        price: double.parse(dcController.dcModel.priceController.value.text),
        quantity: int.parse(dcController.dcModel.quantityController.value.text),
        gst: double.parse(dcController.dcModel.gstController.value.text),
      );

      clearFields();
      dcController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    DcProduct product = dcController.dcModel.Dc_products[index];

    dcController.updateProductName(product.productName);
    dcController.updateHSN(product.hsn);
    dcController.updatePrice(product.price);
    dcController.updateQuantity(product.quantity);
    dcController.updateGST(product.gst);
    dcController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    dcController.addProductEditindex(null);
  }
}
