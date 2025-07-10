import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';

mixin RfqproductService {
  final RfqController rfqController = Get.find<RfqController>();
  void clearFields() {
    rfqController.rfqModel.productNameController.value.clear();
    // rfqController.rfqModel.hsnController.value.clear();
    // rfqController.rfqModel.priceController.value.clear();
    rfqController.rfqModel.quantityController.value.clear();
    // rfqController.rfqModel.gstController.value.clear();
  }

  void addproduct(context) {
    if (rfqController.rfqModel.productKey.value.currentState?.validate() ?? false) {
      // ignore: unrelated_type_equality_checks
      bool exists = rfqController.rfqModel.Rfq_products.any((product) =>
          product.productName == rfqController.rfqModel.productNameController.value.text &&
          // ignore: unrelated_type_equality_checks
          // product.hsn == rfqController.rfqModel.hsnController.value.text &&
          product.quantity == int.parse(rfqController.rfqModel.quantityController.value.text));

      if (exists) {
        Get.snackbar("Product", "This product already exists.");
        return;
      }
      rfqController.addProduct(
        context: context,
        productName: rfqController.rfqModel.productNameController.value.text,
        // hsn: rfqController.rfqModel.hsnController.value.text,
        // price: double.parse(rfqController.rfqModel.priceController.value.text),
        quantity: int.parse(rfqController.rfqModel.quantityController.value.text),
        // gst: double.parse(rfqController.rfqModel.gstController.value.text)
      );

      clearFields();
    }
  }

  // void onSubmit() {
  //   rfqController.rfqModel.Rfq_gstTotals.assignAll(
  //     rfqController.rfqModel.Rfq_products
  //         .fold<Map<double, double>>({}, (Map<double, double> accumulator, RFQProduct product) {
  //           accumulator[product.gst] = (accumulator[product.gst] ?? 0) + product.total;
  //           return accumulator;
  //         })
  //         .entries
  //         .map((entry) => RfqGSTtotals(
  //               gst: entry.key, // Convert key to String
  //               total: entry.value, // Convert value to String
  //             ))
  //         .toList(),
  //   );
  // }

  void updateproduct(context) {
    if (rfqController.rfqModel.productKey.value.currentState?.validate() ?? false) {
      rfqController.updateProduct(
        context: context,
        editIndex: rfqController.rfqModel.product_editIndex.value!, // The index of the product to be updated
        productName: rfqController.rfqModel.productNameController.value.text,
        // hsn: rfqController.rfqModel.hsnController.value.text,
        // price: double.parse(rfqController.rfqModel.priceController.value.text),
        quantity: int.parse(rfqController.rfqModel.quantityController.value.text),
        // gst: double.parse(rfqController.rfqModel.gstController.value.text),
      );

      clearFields();
      rfqController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    RFQProduct product = rfqController.rfqModel.Rfq_products[index];

    rfqController.updateProductName(product.productName);
    // rfqController.updateHSN(product.hsn);
    // rfqController.updatePrice(product.price);
    rfqController.updateQuantity(product.quantity);
    // rfqController.updateGST(product.gst);
    rfqController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    rfqController.addProductEditindex(null);
  }

  // void set_ProductValues(ProductSuggestion value) {
  //   rfqController.updateHSN(int.parse(value.productHsn));
  //   rfqController.updateGST(value.productGst);
  //   rfqController.updatePrice(value.productPrice);
  // }
}
