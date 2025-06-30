import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/Invoice_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Invoice_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';

mixin InvoiceproductService {
  final InvoiceController invoiceController = Get.find<InvoiceController>();

  /// Clears all input fields related to product entry in the invoice form.
  ///
  /// This function resets the following controllers to empty strings:
  /// - Product Name
  /// - HSN Code
  /// - Price
  /// - Quantity
  /// - GST Percentage
  ///
  /// Useful after adding a product or when resetting the form.
  void clearFields() {
    invoiceController.invoiceModel.productNameController.value.clear();
    invoiceController.invoiceModel.hsnController.value.clear();
    invoiceController.invoiceModel.priceController.value.clear();
    invoiceController.invoiceModel.quantityController.value.clear();
    invoiceController.invoiceModel.gstController.value.clear();
  }

  /// Adds a new product to the invoice product list after validation.
  ///
  /// - Validates the product form using `productKey`.
  /// - Checks if the same product (name, HSN, and quantity) already exists in the list:
  ///   - If found, shows a snackbar warning and exits.
  /// - If unique, adds the product to the invoice using `addProduct()` method.
  /// - Clears the product input fields after successful addition.
  ///
  /// This helps ensure no duplicate entries and maintains clean user input handling.
  void addproduct(context) {
    if (invoiceController.invoiceModel.productKey.value.currentState?.validate() ?? false) {
      // ignore: unrelated_type_equality_checks
      bool exists = invoiceController.invoiceModel.Invoice_products.any((product) =>
          product.productName == invoiceController.invoiceModel.productNameController.value.text &&
          // ignore: unrelated_type_equality_checks
          product.hsn == invoiceController.invoiceModel.hsnController.value.text &&
          product.quantity == int.parse(invoiceController.invoiceModel.quantityController.value.text));

      if (exists) {
        Get.snackbar("Product", "This product already exists.");
        return;
      }
      invoiceController.addProduct(
          context: context,
          productName: invoiceController.invoiceModel.productNameController.value.text,
          hsn: invoiceController.invoiceModel.hsnController.value.text,
          price: double.parse(invoiceController.invoiceModel.priceController.value.text),
          quantity: int.parse(invoiceController.invoiceModel.quantityController.value.text),
          gst: double.parse(invoiceController.invoiceModel.gstController.value.text));

      clearFields();
    }
  }

  /// Calculates the total invoice amount grouped by GST percentage.
  ///
  /// - Iterates over all products in `Invoice_products`.
  /// - Aggregates the total amount for each GST rate using a map.
  /// - Converts the map entries into a list of `InvoiceGSTtotals`.
  /// - Updates the `Invoice_gstTotals` list with the new aggregated totals.
  ///
  /// Useful for summarizing how much tax applies at each GST slab.
  void onSubmit() {
    invoiceController.invoiceModel.Invoice_gstTotals.assignAll(
      invoiceController.invoiceModel.Invoice_products
          .fold<Map<double, double>>({}, (Map<double, double> accumulator, InvoiceProduct product) {
            accumulator[product.gst] = (accumulator[product.gst] ?? 0) + product.total;
            return accumulator;
          })
          .entries
          .map((entry) => InvoiceGSTtotals(
                gst: entry.key, // Convert key to String
                total: entry.value, // Convert value to String
              ))
          .toList(),
    );
  }

  /// Updates an existing product entry in the invoice.
  ///
  /// - Validates the product form using `productKey`.
  /// - If valid, calls `updateProduct()` with the current form values and the index of the product being edited.
  /// - Clears the input fields after update using `clearFields()`.
  /// - Resets the `product_editIndex` to null to exit edit mode.
  ///
  /// Ensures that product edits are reflected in the invoice correctly.
  void updateproduct(context) {
    if (invoiceController.invoiceModel.productKey.value.currentState?.validate() ?? false) {
      invoiceController.updateProduct(
        context: context,
        editIndex: invoiceController.invoiceModel.product_editIndex.value!, // The index of the product to be updated
        productName: invoiceController.invoiceModel.productNameController.value.text,
        hsn: invoiceController.invoiceModel.hsnController.value.text,
        price: double.parse(invoiceController.invoiceModel.priceController.value.text),
        quantity: int.parse(invoiceController.invoiceModel.quantityController.value.text),
        gst: double.parse(invoiceController.invoiceModel.gstController.value.text),
      );

      clearFields();
      invoiceController.addProductEditindex(null);
    }
  }

  /// Loads the selected product's details into the form fields for editing.
  ///
  /// - Fetches the product at the given `index` from `Invoice_products`.
  /// - Updates each form field (name, HSN, price, quantity, GST) with the product's values.
  /// - Sets the `product_editIndex` to indicate which product is being edited.
  ///
  /// This prepares the UI for the user to modify an existing product entry.
  void editproduct(int index) {
    InvoiceProduct product = invoiceController.invoiceModel.Invoice_products[index];

    invoiceController.updateProductName(product.productName);
    invoiceController.updateHSN(product.hsn);
    invoiceController.updatePrice(product.price);
    invoiceController.updateQuantity(product.quantity);
    invoiceController.updateGST(product.gst);
    invoiceController.addProductEditindex(index);
  }

  /// Resets the product editing state in the invoice form.
  ///
  /// - Clears all form input fields using `clearFields()`.
  /// - Sets the `product_editIndex` to null, indicating no product is currently being edited.
  ///
  /// This is typically used after submitting or cancelling a product edit.
  void resetEditingState() {
    clearFields();
    invoiceController.addProductEditindex(null);
  }

  /// Sets the invoice product form fields based on a selected product suggestion.
  ///
  /// - Updates the HSN, GST, and price fields in the invoice form with values from the `ProductSuggestion`.
  /// - Parses the HSN as an integer before setting.
  ///
  /// This function is typically called when a user selects a product from the suggestions list.
  void set_ProductValues(ProductSuggestion value) {
    invoiceController.updateHSN(int.parse(value.productHsn));
    invoiceController.updateGST(value.productGst);
    invoiceController.updatePrice(value.productPrice);
  }
}
