import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/constants/Debit_constants.dart';
import '../models/entities/Debit_entities.dart';
import '../models/entities/product_entities.dart';

class DebitController extends GetxController {
  var debitModel = DebitModel();

  void initializeTabController(TabController tabController) {
    debitModel.tabController.value = tabController;
  }

  void nextTab() {
    if (debitModel.tabController.value!.index < debitModel.tabController.value!.length - 1) {
      debitModel.tabController.value!.animateTo(debitModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (debitModel.tabController.value!.index > 0) {
      debitModel.tabController.value!.animateTo(debitModel.tabController.value!.index - 1);
    }
  }

  void updateProductName(String productName) {
    debitModel.productNameController.value.text = productName;
  }

  void updateHSN(String hsn) {
    debitModel.hsnController.value.text = hsn;
  }

  void updatePrice(double price) {
    debitModel.priceController.value.text = price.toString();
  }

  void updateQuantity(int quantity) {
    debitModel.quantityController.value.text = quantity.toString();
  }

  void updateGST(double gst) {
    debitModel.gstController.value.text = gst.toString();
  }

  void updateremarks(String remarks) {
    debitModel.remarksController.value.text = remarks.toString();
  }

  void updateNoteEditindex(int? index) {
    debitModel.note_editIndex.value = index;
  }

  void updateChallanTableHeading(String tableHeading) {
    debitModel.Debit_table_heading.value = tableHeading;
  }

  void updateNoteList(String value, int index) {
    debitModel.Debit_noteList[debitModel.note_editIndex.value!] = Note(notename: debitModel.notecontentController.value.text);
  }

  void updateTabController(TabController tabController) {
    debitModel.tabController.value = tabController;
  }

  void updateClientAddressNameControllerText(String text) {
    debitModel.clientAddressNameController.value.text = text;
  }

  void updateClientAddressControllerText(String text) {
    debitModel.clientAddressController.value.text = text;
  }

  void updateBillingAddressNameControllerText(String text) {
    debitModel.billingAddressNameController.value.text = text;
  }

  void updateBillingAddressControllerText(String text) {
    debitModel.billingAddressController.value.text = text;
  }

  void updateRecommendationEditindex(int? index) {
    debitModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    debitModel.notecontentController.value.text = text;
  }

  void updateTableHeadingControllerText(String text) {
    debitModel.recommendationHeadingController.value.text = text;
  }

  void updateTableKeyControllerText(String text) {
    debitModel.recommendationKeyController.value.text = text;
  }

  void updateTableValueControllerText(String text) {
    debitModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    debitModel.notecontent.add(note);
  }

  void addProductEditindex(int? index) {
    debitModel.product_editIndex.value = index;
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      debitModel.Debit_recommendationList.add(Recommendation(key: key, value: value));
    } else {
      print('Key and value must not be empty');
    }
  }

  void updateRecommendation({
    required int index,
    required String key,
    required String value,
  }) {
    if (index >= 0 && index < debitModel.Debit_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        debitModel.Debit_recommendationList[index] = Recommendation(key: key, value: value);
      } else {
        print('Key and value must not be empty');
      }
    } else {
      print('Invalid index provided');
    }
  }

  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      debitModel.Debit_noteList.add(Note(notename: noteContent));
    } else {
      print('Note content must not be empty'); // Handle empty input (optional)
    }
  }

  void addProduct({required BuildContext context, required String productName, required String hsn, required double price, required int quantity, required double gst, required String remarks}) {
    try {
      if (productName.trim().isEmpty || hsn.trim().isEmpty || price <= 0 || quantity <= 0 || gst < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      debitModel.Debit_products.add(DebitProduct((debitModel.Debit_products.length + 1).toString(), productName, hsn, gst, price, quantity, remarks));

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

  void updateProduct({required BuildContext context, required int editIndex, required String productName, required String hsn, required double price, required int quantity, required double gst, required String remarks}) {
    try {
      // Validate input fields
      if (productName.trim().isEmpty || hsn.trim().isEmpty || price <= 0 || quantity <= 0 || gst < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= debitModel.Debit_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      debitModel.Debit_products[editIndex] = DebitProduct((editIndex + 1).toString(), productName, hsn, gst, price, quantity, remarks);

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
      // .updateProductDetails(debitController.debitModel.Debit_productDetails);
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
  void updateProducts(List<DebitProduct> products) {
    debitModel.Debit_products.value = products;
  }

  void removeFromNoteList(int index) {
    debitModel.Debit_noteList.removeAt(index);
  }

  void removeFromRecommendationList(int index) {
    debitModel.Debit_recommendationList.removeAt(index);
    debitModel.Debit_recommendationList.isEmpty ? debitModel.recommendationHeadingController.value.clear() : null;
  }

  void removeFromProductList(index) {
    debitModel.Debit_products.removeAt(index);
  }

  void clearAll() {
    // Reset all observable strings to empty

    debitModel.Debit_no.value = '';
    debitModel.Debit_table_heading.value = '';

    debitModel.Debit_noteList.clear();
    debitModel.Debit_recommendationList.clear();

    debitModel.Debit_products.clear();
    debitModel.clientAddressNameController.value.clear();
    debitModel.clientAddressController.value.clear();
    debitModel.billingAddressNameController.value.clear();
    debitModel.billingAddressController.value.clear();
    debitModel.productNameController.value.clear();
    debitModel.hsnController.value.clear();
    debitModel.priceController.value.clear();
    debitModel.quantityController.value.clear();
    debitModel.gstController.value.clear();
    debitModel.notecontentController.value.clear();
    debitModel.recommendationHeadingController.value.clear();
    debitModel.recommendationKeyController.value.clear();
    debitModel.recommendationValueController.value.clear();

    // Reset form keys
    debitModel.detailsKey.value = GlobalKey<FormState>();
    debitModel.productKey.value = GlobalKey<FormState>();
    debitModel.noteformKey.value = GlobalKey<FormState>();

    // Reset edit indices
    debitModel.product_editIndex.value = null;
    debitModel.note_editIndex.value = null;
    debitModel.recommendation_editIndex.value = null;

    // Reset heading type and note arrays
    // debitModel.selectedheadingType.value = null;
    // debitModel.notelength.value = 0;
    // debitModel.notetablelength.value = 0;
    debitModel.notecontent.clear();
    // debitModel.noteType.clear();
    // debitModel.noteType.addAll([
    //   'With Heading',
    //   'Without Heading'
    // ]);
  }
}
