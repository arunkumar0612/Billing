import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/constants/DC_constants.dart';
import '../models/entities/SALES/DC_entities.dart';
import '../models/entities/SALES/product_entities.dart';

class DCController extends GetxController {
  var dcModel = DCModel();

  void initializeTabController(TabController tabController) {
    dcModel.tabController.value = tabController;
  }

  void nextTab() {
    if (dcModel.tabController.value!.index < dcModel.tabController.value!.length - 1) {
      dcModel.tabController.value!.animateTo(dcModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (dcModel.tabController.value!.index > 0) {
      dcModel.tabController.value!.animateTo(dcModel.tabController.value!.index - 1);
    }
  }

  void updateProductName(String productName) {
    dcModel.productNameController.value.text = productName;
  }

  void updateHSN(String hsn) {
    dcModel.hsnController.value.text = hsn;
  }

  void updateQuantity(int quantity) {
    dcModel.quantityController.value.text = quantity.toString();
  }

  void updateNoteEditindex(int? index) {
    dcModel.note_editIndex.value = index;
  }

  void updateChallanTableHeading(String tableHeading) {
    dcModel.Delivery_challan_table_heading.value = tableHeading;
  }

  void updateNoteList(String value, int index) {
    dcModel.Delivery_challan_noteList[dcModel.note_editIndex.value!] = Note(notename: dcModel.notecontentController.value.text);
  }

  void updateTabController(TabController tabController) {
    dcModel.tabController.value = tabController;
  }

  void updateTitleControllerText(String text) {
    dcModel.TitleController.value.text = text;
  }

  void updateClientAddressNameControllerText(String text) {
    dcModel.clientAddressNameController.value.text = text;
  }

  void updateClientAddressControllerText(String text) {
    dcModel.clientAddressController.value.text = text;
  }

  void updateBillingAddressNameControllerText(String text) {
    dcModel.billingAddressNameController.value.text = text;
  }

  void updateBillingAddressControllerText(String text) {
    dcModel.billingAddressController.value.text = text;
  }

  void updateRecommendationEditindex(int? index) {
    dcModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    dcModel.notecontentController.value.text = text;
  }

  void updateTableHeadingControllerText(String text) {
    dcModel.recommendationHeadingController.value.text = text;
  }

  void updateTableKeyControllerText(String text) {
    dcModel.recommendationKeyController.value.text = text;
  }

  void updateTableValueControllerText(String text) {
    dcModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    dcModel.notecontent.add(note);
  }

  void addProductEditindex(int? index) {
    dcModel.product_editIndex.value = index;
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      dcModel.Delivery_challan_recommendationList.add(Recommendation(key: key, value: value));
    } else {
      print('Key and value must not be empty');
    }
  }

  void updateRecommendation({
    required int index,
    required String key,
    required String value,
  }) {
    if (index >= 0 && index < dcModel.Delivery_challan_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        dcModel.Delivery_challan_recommendationList[index] = Recommendation(key: key, value: value);
      } else {
        print('Key and value must not be empty');
      }
    } else {
      print('Invalid index provided');
    }
  }

  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      dcModel.Delivery_challan_noteList.add(Note(notename: noteContent));
    } else {
      print('Note content must not be empty'); // Handle empty input (optional)
    }
  }

  void addProduct({
    required BuildContext context,
    required String productName,
    required String hsn,
    required int quantity,
  }) {
    try {
      if (productName.trim().isEmpty || hsn.trim().isEmpty || quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      dcModel.Delivery_challan_products.add(DCProduct(
        (dcModel.Delivery_challan_products.length + 1).toString(),
        productName,
        hsn,
        quantity,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Product added successfully.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('An error occurred while adding the product.'),
        ),
      );
    }
  }

  void updateProduct({
    required BuildContext context,
    required int editIndex,
    required String productName,
    required String hsn,
    required int quantity,
  }) {
    try {
      // Validate input fields
      if (productName.trim().isEmpty || hsn.trim().isEmpty || quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= dcModel.Delivery_challan_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      dcModel.Delivery_challan_products[editIndex] = DCProduct((editIndex + 1).toString(), productName, hsn, quantity);

      // ProductDetail(
      //   productName: productName.trim(),
      //   hsn: hsn.trim(),
      //   price: price,
      //   quantity: quantity,
      //   gst: gst,
      // );

      // Notify success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Product updated successfully.'),
        ),
      );

      // Optional: Update UI or state if needed
      // .updateProductDetails(dcController.dcModel.Delivery_challan_productDetails);
    } catch (e) {
      // Handle unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('An error occurred while updating the product.'),
        ),
      );
    }
  }

  // Update products list
  void updateProducts(List<DCProduct> products) {
    dcModel.Delivery_challan_products.value = products;
  }

  void removeFromNoteList(int index) {
    dcModel.Delivery_challan_noteList.removeAt(index);
  }

  void removeFromRecommendationList(int index) {
    dcModel.Delivery_challan_recommendationList.removeAt(index);
    dcModel.Delivery_challan_recommendationList.isEmpty ? dcModel.recommendationHeadingController.value.clear() : null;
  }

  void removeFromProductList(index) {
    dcModel.Delivery_challan_products.removeAt(index);
  }

  void clearAll() {
    dcModel.Delivery_challan_table_heading.value = '';

    // Clear note list and recommendation list
    dcModel.Delivery_challan_noteList.clear();
    dcModel.Delivery_challan_recommendationList.clear();
    // dcModel.Delivery_challan_productDetails.clear();

    // Clear products list
    dcModel.Delivery_challan_products.clear();

    // Reset text controllers
    dcModel.TitleController.value.clear();
    dcModel.clientAddressNameController.value.clear();
    dcModel.clientAddressController.value.clear();
    dcModel.billingAddressNameController.value.clear();
    dcModel.billingAddressController.value.clear();
    dcModel.productNameController.value.clear();
    dcModel.hsnController.value.clear();
    dcModel.quantityController.value.clear();
    dcModel.notecontentController.value.clear();
    dcModel.recommendationHeadingController.value.clear();
    dcModel.recommendationKeyController.value.clear();
    dcModel.recommendationValueController.value.clear();

    // Reset form keys
    dcModel.detailsKey.value = GlobalKey<FormState>();
    dcModel.productKey.value = GlobalKey<FormState>();
    dcModel.noteformKey.value = GlobalKey<FormState>();

    // Reset edit indices
    dcModel.product_editIndex.value = null;
    dcModel.note_editIndex.value = null;
    dcModel.recommendation_editIndex.value = null;

    // Reset heading type and note arrays
    // dcModel.selectedheadingType.value = null;
    // dcModel.notelength.value = 0;
    // dcModel.notetablelength.value = 0;
    dcModel.notecontent.clear();
    // dcModel.noteType.clear();
    // dcModel.noteType.addAll([
    //   'With Heading',
    //   'Without Heading'
    // ]);
  }
}
