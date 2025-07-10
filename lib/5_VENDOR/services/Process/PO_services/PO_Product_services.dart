import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/PO_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/product_entities.dart';
import 'package:ssipl_billing/API/api.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/UTILS/helpers/basicAPI_functions.dart';

mixin PoproductService {
  final vendor_PoController poController = Get.find<vendor_PoController>();
  void clearFields() {
    poController.poModel.productNameController.value.clear();
    // poController.poModel.hsnController.value.clear();
    // poController.poModel.priceController.value.clear();
    poController.poModel.quantityController.value.clear();
    poController.poModel.hsnController.value.clear();
    // poController.poModel.gstController.value.clear();
  }

  void get_ProductsSuggestion(context) async {
    try {
      Map<String, dynamic> body = {"vendorid": poController.poModel.vendorID.value};
      Map<String, dynamic>? response = await apiController.GetbyQueryString(body, API.vendor_productsSuggestion);
      if (response?['statusCode'] == 200) {
        CMDlResponse value = CMDlResponse.fromJson(response ?? {});
        if (value.code) {
          poController.add_vendorProduct_suggestions(value);
          // poController.update_vendorList(value);
          // await Basic_dialog(context: context,showCancel: false, title: 'Organization List', content: value.message!, onOk: () {});
          // clientreqController.update_CompanyList(value);
        } else {
          await Error_dialog(context: context, title: 'Fetching Vendor Products Error', content: value.message ?? "", onOk: () {});
          // Navigator.of(context).pop();
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
    if (poController.poModel.productKey.value.currentState?.validate() ?? false) {
      // ignore: unrelated_type_equality_checks
      bool exists = poController.poModel.Po_products.any((product) => product.productName == poController.poModel.productNameController.value.text
          // ignore: unrelated_type_equality_checks

          );

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
        // gst: double.parse(poController.poModel.gstController.value.text)
      );

      clearFields();
    }
  }

  // void onSubmit() {
  //   poController.poModel.Po_gstTotals.assignAll(
  //     poController.poModel.Po_products
  //         .fold<Map<double, double>>({}, (Map<double, double> accumulator, POProduct product) {
  //           accumulator[product.gst] = (accumulator[product.gst] ?? 0) + product.total;
  //           return accumulator;
  //         })
  //         .entries
  //         .map((entry) => PoGSTtotals(
  //               gst: entry.key, // Convert key to String
  //               total: entry.value, // Convert value to String
  //             ))
  //         .toList(),
  //   );
  // }

  void updateproduct(context) {
    if (poController.poModel.productKey.value.currentState?.validate() ?? false) {
      poController.updateProduct(
        context: context,
        editIndex: poController.poModel.product_editIndex.value!, // The index of the product to be updated
        productName: poController.poModel.productNameController.value.text,
        hsn: poController.poModel.hsnController.value.text,
        price: double.parse(poController.poModel.priceController.value.text),
        quantity: int.parse(poController.poModel.quantityController.value.text),
        // gst: double.parse(poController.poModel.gstController.value.text),
      );

      clearFields();
      poController.addProductEditindex(null);
    }
  }

  void editproduct(int index) {
    POProduct product = poController.poModel.Po_products[index];

    poController.updateProductName(product.productName);
    poController.updateHsn(product.hsn);
    poController.updatePrice(product.price);
    poController.updateQuantity(product.quantity);
    // poController.updateGST(product.gst);
    poController.addProductEditindex(index);
  }

  void resetEditingState() {
    clearFields();
    poController.addProductEditindex(null);
  }

  // void set_ProductValues(ProductSuggestion value) {
  //   poController.updateHSN(int.parse(value.productHsn));
  //   poController.updateGST(value.productGst);
  //   poController.updatePrice(value.productPrice);
  // }
}
