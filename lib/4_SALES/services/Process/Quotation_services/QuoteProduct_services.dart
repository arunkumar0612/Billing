import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/Quote_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Quote_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';

mixin QuoteproductService {
  final QuoteController quoteController = Get.find<QuoteController>();
  void clearFields() {
    quoteController.quoteModel.productNameController.value.clear();
    quoteController.quoteModel.hsnController.value.clear();
    quoteController.quoteModel.priceController.value.clear();
    quoteController.quoteModel.quantityController.value.clear();
    quoteController.quoteModel.gstController.value.clear();
  }

  void addproduct(context) {
    if (quoteController.quoteModel.productKey.value.currentState?.validate() ?? false) {
      // ignore: unrelated_type_equality_checks
      bool exists = quoteController.quoteModel.Quote_products.any((product) =>
          product.productName == quoteController.quoteModel.productNameController.value.text &&
          // ignore: unrelated_type_equality_checks
          product.hsn == quoteController.quoteModel.hsnController.value.text &&
          product.quantity == int.parse(quoteController.quoteModel.quantityController.value.text));

      if (exists) {
        Get.snackbar("Product", "This product already exists.");
        return;
      }
      quoteController.addProduct(
          context: context,
          productName: quoteController.quoteModel.productNameController.value.text,
          hsn: quoteController.quoteModel.hsnController.value.text,
          price: double.parse(quoteController.quoteModel.priceController.value.text),
          quantity: int.parse(quoteController.quoteModel.quantityController.value.text),
          gst: double.parse(quoteController.quoteModel.gstController.value.text));

      clearFields();
    }
  }

  void onSubmit() {
    quoteController.quoteModel.Quote_gstTotals.assignAll(
      quoteController.quoteModel.Quote_products
          .fold<Map<double, double>>({}, (Map<double, double> accumulator, QuoteProduct product) {
            accumulator[product.gst] = (accumulator[product.gst] ?? 0) + product.total;
            return accumulator;
          })
          .entries
          .map((entry) => QuoteGSTtotals(
                gst: entry.key, // Convert key to String
                total: entry.value, // Convert value to String
              ))
          .toList(),
    );
  }

  void updateproduct(context) {
    if (quoteController.quoteModel.productKey.value.currentState?.validate() ?? false) {
      quoteController.updateProduct(
        context: context,
        editIndex: quoteController.quoteModel.product_editIndex.value!, // The index of the product to be updated
        productName: quoteController.quoteModel.productNameController.value.text,
        hsn: quoteController.quoteModel.hsnController.value.text,
        price: double.parse(quoteController.quoteModel.priceController.value.text),
        quantity: int.parse(quoteController.quoteModel.quantityController.value.text),
        gst: double.parse(quoteController.quoteModel.gstController.value.text),
      );

      clearFields();
      quoteController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    QuoteProduct product = quoteController.quoteModel.Quote_products[index];

    quoteController.updateProductName(product.productName);
    quoteController.updateHSN(product.hsn);
    quoteController.updatePrice(product.price);
    quoteController.updateQuantity(product.quantity);
    quoteController.updateGST(product.gst);
    quoteController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    quoteController.addProductEditindex(null);
  }

  void set_ProductValues(ProductSuggestion value) {
    quoteController.updateHSN(int.parse(value.productHsn));
    quoteController.updateGST(value.productGst);
    quoteController.updatePrice(value.productPrice);
  }
}
