import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/Quote_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Quote_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';

mixin QuoteproductService {
  final QuoteController quoteController = Get.find<QuoteController>();

  /// Clears all product-related input fields in the quote model.
  ///
  /// - Resets the values of:
  ///   - Product Name
  ///   - HSN Code
  ///   - Price
  ///   - Quantity
  ///   - GST
  ///
  /// This is typically used after adding or updating a product entry
  /// to prepare the fields for a new entry or to clear invalid data.
  void clearFields() {
    quoteController.quoteModel.productNameController.value.clear();
    quoteController.quoteModel.hsnController.value.clear();
    quoteController.quoteModel.priceController.value.clear();
    quoteController.quoteModel.quantityController.value.clear();
    quoteController.quoteModel.gstController.value.clear();
  }

  /// Adds a new product to the quotation if it doesn't already exist.
  ///
  /// - Validates the product input form.
  /// - Checks for duplicates based on:
  ///   - Product name
  ///   - HSN code
  ///   - Quantity
  /// - If no duplicates found:
  ///   - Calls `addProduct()` in the controller with current field values.
  ///   - Clears the input fields after successful addition.
  /// - If a duplicate is found:
  ///   - Shows a snackbar notifying the user.
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

  /// Calculates GST totals from the list of quote products and updates the model.
  ///
  /// - Uses `.fold()` to aggregate total amounts for each unique GST rate.
  /// - Converts the aggregated map into a list of `QuoteGSTtotals`.
  /// - Updates `Quote_gstTotals` with the new list.
  ///
  /// Example:
  /// If products have GST 18% with totals 1000 and 500, it results in:
  /// `QuoteGSTtotals(gst: 18, total: 1500)`
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

  /// Updates an existing product in the product list at the specified edit index.
  ///
  /// - Validates the form before proceeding.
  /// - Extracts updated values from the text controllers.
  /// - Calls `updateProduct()` in the controller to apply changes at the given index.
  /// - Clears the input fields and resets the edit index after the update.
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

  /// Loads the selected product's details into the input fields for editing.
  ///
  /// - Retrieves the product at the given index from the product list.
  /// - Populates the form fields (product name, HSN, price, quantity, GST) using controller methods.
  /// - Sets the current edit index so that the `updateproduct()` method knows which item to update.
  void editproduct(int index) {
    QuoteProduct product = quoteController.quoteModel.Quote_products[index];

    quoteController.updateProductName(product.productName);
    quoteController.updateHSN(product.hsn);
    quoteController.updatePrice(product.price);
    quoteController.updateQuantity(product.quantity);
    quoteController.updateGST(product.gst);
    quoteController.addProductEditindex(index);
  }

  /// Resets the product editing state by:
  /// - Clearing all product input fields.
  /// - Nullifying the edit index to indicate no product is currently being edited.
  void resetEditingState() {
    clearFields();
    quoteController.addProductEditindex(null);
  }

  /// Sets HSN, GST, and price fields in the quote controller
  /// using the selected product suggestion.
  ///
  /// Parses `productHsn` to an integer before updating.
  /// Directly updates `productGst` and `productPrice`.
  ///
  /// [value] - The selected product suggestion.
  void set_ProductValues(ProductSuggestion value) {
    quoteController.updateHSN(int.parse(value.productHsn));
    quoteController.updateGST(value.productGst);
    quoteController.updatePrice(value.productPrice);
  }
}
