// ignore_for_file: unrelated_type_equality_checks, duplicate_ignore

import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';

mixin DcproductService {
  final DcController dcController = Get.find<DcController>();

  // void clearFields() {
  //   dcController.dcModel.productNameController.value.clear();
  //   dcController.dcModel.hsnController.value.clear();
  //   dcController.dcModel.priceController.value.clear();
  //   dcController.dcModel.quantityController.value.clear();
  //   dcController.dcModel.gstController.value.clear();
  // }

  // void addproduct(context) {
  //   if (dcController.dcModel.productKey.value.currentState?.validate() ?? false) {
  //     bool exists = dcController.dcModel.Dc_products.any((product) =>
  //         product.productName == dcController.dcModel.productNameController.value.text &&
  //         product.hsn == dcController.dcModel.hsnController.value.text &&
  //         product.quantity == int.parse(dcController.dcModel.quantityController.value.text));

  //     if (exists) {
  //       Get.snackbar("Product", "This product already exists.");
  //       return;
  //     }
  //     dcController.addProduct(
  //         context: context,
  //         productName: dcController.dcModel.productNameController.value.text,
  //         hsn: dcController.dcModel.hsnController.value.text,
  //         price: double.parse(dcController.dcModel.priceController.value.text),
  //         quantity: int.parse(dcController.dcModel.quantityController.value.text),
  //         gst: double.parse(dcController.dcModel.gstController.value.text));

  //     clearFields();
  //   }
  // }

  // void onSubmit() {
  //   dcController.dcModel.Dc_gstTotals.assignAll(
  //     dcController.dcModel.Dc_products
  //         .fold<Map<double, double>>({}, (Map<double, double> accumulator, DcProduct product) {
  //           accumulator[product.gst] = (accumulator[product.gst] ?? 0) + product.total;
  //           return accumulator;
  //         })
  //         .entries
  //         .map((entry) => DcGSTtotals(
  //               gst: entry.key, // Convert key to String
  //               total: entry.value, // Convert value to String
  //             ))
  //         .toList(),
  //   );
  // }

  // void updateproduct(context) {
  //   if (dcController.dcModel.productKey.value.currentState?.validate() ?? false) {
  //     dcController.updateProduct(
  //       context: context,
  //       editIndex: dcController.dcModel.product_editIndex.value!, // The index of the product to be updated
  //       productName: dcController.dcModel.productNameController.value.text,
  //       hsn: dcController.dcModel.hsnController.value.text,
  //       price: double.parse(dcController.dcModel.priceController.value.text),
  //       quantity: int.parse(dcController.dcModel.quantityController.value.text),
  //       gst: double.parse(dcController.dcModel.gstController.value.text),
  //     );

  //     clearFields();
  //     dcController.addProductEditindex(null);
  //   }
  // }

  // void editproduct(int index) {
  //   DcProduct product = dcController.dcModel.Dc_products[index];

  //   dcController.updateProductName(product.productName);
  //   dcController.updateHSN(product.hsn);
  //   dcController.updatePrice(product.price);
  //   dcController.updateQuantity(product.quantity);
  //   dcController.updateGST(product.gst);
  //   dcController.addProductEditindex(index);
  // }

  // void resetEditingState() {
  //   clearFields();
  //   dcController.addProductEditindex(null);
  // }

  void addto_Selectedproducts() {
    dcController.dcModel.selected_dcProducts.clear();
    dcController.dcModel.pending_dcProducts.clear();
    dcController.dcModel.product_feedback.value = "";

    int pendingProducts = 0;

    for (int i = 0; i < dcController.dcModel.checkboxValues.length; i++) {
      int totalQty = dcController.dcModel.Dc_products[i].quantity;
      int selectedQty = dcController.dcModel.checkboxValues[i] ? dcController.dcModel.quantities[i].value : 0;
      int pendingQty = totalQty - selectedQty;

// return DcProduct(
//       sno: sno, // auto-injected externally
//       productName: json['productname'] as String,
//       hsn: json['producthsn'] as int,
//       gst: (json['productgst'] as num).toDouble(),
//       price: (json['productprice'] as num).toDouble(),
//       quantity: json['productquantity'] as int,
//       productid: json['productid'] as int,
//     );

      if (selectedQty > 0) {
        // Add selected product with updated quantity
        DcProduct copiedProduct = DcProduct.fromJson({
          "productname": dcController.dcModel.Dc_products[i].productName,
          "producthsn": dcController.dcModel.Dc_products[i].hsn,
          "productgst": dcController.dcModel.Dc_products[i].gst,
          "productprice": dcController.dcModel.Dc_products[i].price,
          "productquantity": selectedQty,
          "productid": dcController.dcModel.Dc_products[i].productid,
        }, i + 1);
        dcController.dcModel.selected_dcProducts.add(copiedProduct);
      }

      if (pendingQty > 0) {
        // Add the remaining quantity to pending products
        DcProduct pendingProduct = DcProduct(
          sno: dcController.dcModel.Dc_products[i].sno,
          productName: dcController.dcModel.Dc_products[i].productName,
          hsn: dcController.dcModel.Dc_products[i].hsn,
          gst: dcController.dcModel.Dc_products[i].gst,
          price: dcController.dcModel.Dc_products[i].price,
          quantity: pendingQty, // Only the remaining quantity
          productid: dcController.dcModel.Dc_products[i].productid,
        );
        dcController.dcModel.pending_dcProducts.add(pendingProduct);
        pendingProducts += 1;
      }
    }
    if (dcController.dcModel.pending_dcProducts.isNotEmpty) {
      dcController.dcModel.Dc_recommendationList.clear();
      dcController.updateRec_HeadingControllerText("PENDING PRODUCTS FOR DELIVERY");
      for (int i = 0; i < dcController.dcModel.pending_dcProducts.length; i++) {
        dcController.addRecommendation(key: dcController.dcModel.pending_dcProducts[i].productName, value: dcController.dcModel.pending_dcProducts[i].quantity.toString());
      }
    }

    if (pendingProducts > 0) {
      dcController.dcModel.product_feedback.value = "Still $pendingProducts products need to be delivered!";
    } else {
      dcController.dcModel.product_feedback.value = "Delivery completed!";
    }
  }
}
