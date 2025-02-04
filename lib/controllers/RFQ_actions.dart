import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/constants/RFQ_constants.dart';
import '../models/entities/RFQ_entities.dart';
import '../models/entities/product_entities.dart';

class RFQController extends GetxController {
  var rfqModel = RFQModel();

  void initializeTabController(TabController tabController) {
    rfqModel.tabController.value = tabController;
  }

  void nextTab() {
    if (rfqModel.tabController.value!.index < rfqModel.tabController.value!.length - 1) {
      rfqModel.tabController.value!.animateTo(rfqModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (rfqModel.tabController.value!.index > 0) {
      rfqModel.tabController.value!.animateTo(rfqModel.tabController.value!.index - 1);
    }
  }

  void updateVendorname(String vendor) {
    rfqModel.vendor_name_controller.value.text = vendor;
  }

  void updateProductName(String productName) {
    rfqModel.productNameController.value.text = productName;
  }

  void updateQuantity(int quantity) {
    rfqModel.quantityController.value.text = quantity.toString();
  }

  void updateNoteEditindex(int? index) {
    rfqModel.note_editIndex.value = index;
  }

  void updateChallanTableHeading(String tableHeading) {
    rfqModel.RFQ_table_heading.value = tableHeading;
  }

  void updateNoteList(String value, int index) {
    rfqModel.RFQ_noteList[rfqModel.note_editIndex.value!] = Note(notename: rfqModel.notecontentController.value.text);
  }

  void updateTabController(TabController tabController) {
    rfqModel.tabController.value = tabController;
  }

  void updateVendorCredentials(String address, String phone, String email) {}

  void updateRecommendationEditindex(int? index) {
    rfqModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    rfqModel.notecontentController.value.text = text;
  }

  void updateTableHeadingControllerText(String text) {
    rfqModel.recommendationHeadingController.value.text = text;
  }

  void updateTableKeyControllerText(String text) {
    rfqModel.recommendationKeyController.value.text = text;
  }

  void updateTableValueControllerText(String text) {
    rfqModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    rfqModel.notecontent.add(note);
  }

  void addProductEditindex(int? index) {
    rfqModel.product_editIndex.value = index;
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      rfqModel.RFQ_recommendationList.add(Recommendation(key: key, value: value));
    } else {
      print('Key and value must not be empty');
    }
  }

  void updateRecommendation({
    required int index,
    required String key,
    required String value,
  }) {
    if (index >= 0 && index < rfqModel.RFQ_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        rfqModel.RFQ_recommendationList[index] = Recommendation(key: key, value: value);
      } else {
        print('Key and value must not be empty');
      }
    } else {
      print('Invalid index provided');
    }
  }

  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      rfqModel.RFQ_noteList.add(Note(notename: noteContent));
    } else {
      print('Note content must not be empty'); // Handle empty input (optional)
    }
  }

  void addProduct({
    required BuildContext context,
    required String productName,
    required int quantity,
  }) {
    try {
      if (productName.trim().isEmpty || quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      rfqModel.RFQ_products.add(RFQProduct(
        (rfqModel.RFQ_products.length + 1).toString(),
        productName,
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
    required int quantity,
  }) {
    try {
      // Validate input fields
      if (productName.trim().isEmpty || quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please provide valid product details.'),
          ),
        );
        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= rfqModel.RFQ_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      rfqModel.RFQ_products[editIndex] = RFQProduct((editIndex + 1).toString(), productName, quantity);

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
      // .updateProductDetails(rfqController.rfqModel.RFQ_productDetails);
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
  void updateProducts(List<RFQProduct> products) {
    rfqModel.RFQ_products.value = products;
  }

  void removeFromNoteList(int index) {
    rfqModel.RFQ_noteList.removeAt(index);
  }

  void removeFromRecommendationList(int index) {
    rfqModel.RFQ_recommendationList.removeAt(index);
    rfqModel.RFQ_recommendationList.isEmpty ? rfqModel.recommendationHeadingController.value.clear() : null;
  }

  void removeFromProductList(index) {
    rfqModel.RFQ_products.removeAt(index);
  }

  void clearAll() {
    // Reset all observable strings to empty
    rfqModel.vendor_address_controller.value.clear();
    rfqModel.vendor_email_controller.value.clear();
    rfqModel.vendor_name_controller.value.clear();
    rfqModel.vendor_phone_controller.value.clear();
    rfqModel.RFQ_no.value = '';
    rfqModel.RFQ_table_heading.value = '';

    // Clear note list and recommendation list
    rfqModel.RFQ_noteList.clear();
    rfqModel.RFQ_recommendationList.clear();
    // rfqModel.RFQ_productDetails.clear();

    // Clear products list
    rfqModel.RFQ_products.clear();

    // Reset text controllers

    rfqModel.productNameController.value.clear();
    rfqModel.quantityController.value.clear();

    rfqModel.notecontentController.value.clear();
    rfqModel.recommendationHeadingController.value.clear();
    rfqModel.recommendationKeyController.value.clear();
    rfqModel.recommendationValueController.value.clear();

    // Reset form keys
    rfqModel.detailsKey.value = GlobalKey<FormState>();
    rfqModel.productKey.value = GlobalKey<FormState>();
    rfqModel.noteformKey.value = GlobalKey<FormState>();

    // Reset edit indices
    rfqModel.product_editIndex.value = null;
    rfqModel.note_editIndex.value = null;
    rfqModel.recommendation_editIndex.value = null;

    // Reset heading type and note arrays
    // rfqModel.selectedheadingType.value = null;
    // rfqModel.notelength.value = 0;
    // rfqModel.notetablelength.value = 0;
    rfqModel.notecontent.clear();
    // rfqModel.noteType.clear();
    // rfqModel.noteType.addAll([
    //   'With Heading',
    //   'Without Heading'
    // ]);
  }
}
