// ignore_for_file: unrelated_type_equality_checks, duplicate_ignore

import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';

mixin DcproductService {
  final DcController dcController = Get.find<DcController>();

  /// Populates selected and pending product lists based on user input,
  /// and updates product feedback accordingly.
  ///
  /// This does the following:
  /// - Clears any previously selected or pending product entries.
  /// - Loops through all products, checking the selected quantity (if checkbox is ticked).
  /// - Adds selected products with their updated quantity to `selected_dcProducts`.
  /// - Calculates remaining quantity and, if any, adds them to `pending_dcProducts`.
  /// - If there are pending items, it also clears old recommendations and adds a note
  ///   for each pending product under the heading "PENDING PRODUCTS FOR DELIVERY".
  /// - Updates product feedback with either a “still pending” or “completed” message.
  void addto_Selectedproducts() {
    dcController.dcModel.selected_dcProducts.clear();
    dcController.dcModel.pending_dcProducts.clear();
    dcController.dcModel.product_feedback.value = "";

    int pendingProducts = 0;

    for (int i = 0; i < dcController.dcModel.checkboxValues.length; i++) {
      int totalQty = dcController.dcModel.Dc_products[i].quantity;
      int selectedQty = dcController.dcModel.checkboxValues[i] ? dcController.dcModel.quantities[i].value : 0;
      int pendingQty = totalQty - selectedQty;

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
