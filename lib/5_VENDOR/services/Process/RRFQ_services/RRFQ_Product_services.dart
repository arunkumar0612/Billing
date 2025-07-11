import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Process/RRFQ_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Process/product_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/UTILS/helpers/basicAPI_functions.dart';

mixin RrfqproductService {
  final vendor_RrfqController rrfqController = Get.find<vendor_RrfqController>();
  void clearFields() {
    rrfqController.rrfqModel.productNameController.value.clear();
    // rrfqController.rrfqModel.hsnController.value.clear();
    // rrfqController.rrfqModel.priceController.value.clear();
    rrfqController.rrfqModel.quantityController.value.clear();
    rrfqController.rrfqModel.hsnController.value.clear();
    // rrfqController.rrfqModel.gstController.value.clear();
  }

  void get_ProductsSuggestion(context) async {
    try {
      Map<String, dynamic> body = {"vendorid": rrfqController.rrfqModel.vendorID.value};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.vendor_productsSuggestion);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          rrfqController.add_vendorProduct_suggestions(value);
          // rrfqController.update_vendorList(value);
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_CompanyList(value);
        } else {
          await Error_dialog(context: context, title: 'Fetching Vendor Products Error', content: value.message ?? "", onOk: () {});
          Navigator.of(context).pop();
        }
      } else {
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
        Navigator.of(context).pop();
      }
    } catch (e) {
      Error_dialog(context: context, title: "ERROR", content: "$e");
      Navigator.of(context).pop();
    }
  }

  void addproduct(context) {
    if (rrfqController.rrfqModel.productKey.value.currentState?.validate() ?? false) {
      // ignore: unrelated_type_equality_checks
      bool exists = rrfqController.rrfqModel.Rrfq_products.any((product) => product.productName == rrfqController.rrfqModel.productNameController.value.text
          // ignore: unrelated_type_equality_checks

          );
      if (exists) {
        Get.snackbar("Product", "This product already exists.");
        return;
      }
      rrfqController.addProduct(
        context: context,
        productName: rrfqController.rrfqModel.productNameController.value.text,
        // hsn: rrfqController.rrfqModel.hsnController.value.text,
        // price: double.parse(rrfqController.rrfqModel.priceController.value.text),
        quantity: int.parse(rrfqController.rrfqModel.quantityController.value.text),
        // gst: double.parse(rrfqController.rrfqModel.gstController.value.text)
      );

      clearFields();
    }
  }

  // void onSubmit() {
  //   rrfqController.rrfqModel.Rrfq_gstTotals.assignAll(
  //     rrfqController.rrfqModel.Rrfq_products
  //         .fold<Map<double, double>>({}, (Map<double, double> accumulator, RRFQProduct product) {
  //           accumulator[product.gst] = (accumulator[product.gst] ?? 0) + product.total;
  //           return accumulator;
  //         })
  //         .entries
  //         .map((entry) => RrfqGSTtotals(
  //               gst: entry.key, // Convert key to String
  //               total: entry.value, // Convert value to String
  //             ))
  //         .toList(),
  //   );
  // }

  void updateproduct(context) {
    if (rrfqController.rrfqModel.productKey.value.currentState?.validate() ?? false) {
      rrfqController.updateProduct(
        context: context,
        editIndex: rrfqController.rrfqModel.product_editIndex.value!, // The index of the product to be updated
        productName: rrfqController.rrfqModel.productNameController.value.text,
        // hsn: rrfqController.rrfqModel.hsnController.value.text,
        // price: double.parse(rrfqController.rrfqModel.priceController.value.text),
        quantity: int.parse(rrfqController.rrfqModel.quantityController.value.text),
        // gst: double.parse(rrfqController.rrfqModel.gstController.value.text),
      );

      clearFields();
      rrfqController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    RRFQProduct product = rrfqController.rrfqModel.Rrfq_products[index];

    rrfqController.updateProductName(product.productName);
    // rrfqController.updateHSN(product.hsn);
    // rrfqController.updatePrice(product.price);
    rrfqController.updateQuantity(product.quantity);
    // rrfqController.updateGST(product.gst);
    rrfqController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    rrfqController.addProductEditindex(null);
  }

  // void set_ProductValues(ProductSuggestion value) {
  //   rrfqController.updateHSN(int.parse(value.productHsn));
  //   rrfqController.updateGST(value.productGst);
  //   rrfqController.updatePrice(value.productPrice);
  // }
}
