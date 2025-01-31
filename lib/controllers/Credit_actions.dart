import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/constants/Credit_constants.dart';
import '../models/entities/Credit_entities.dart';
import '../models/entities/product_entities.dart';

class CreditController extends GetxController {
  var creditModel = CreditModel();

  void initializeTabController(TabController tabController) {
    creditModel.tabController.value = tabController;
  }

  void nextTab() {
    if (creditModel.tabController.value!.index < creditModel.tabController.value!.length - 1) {
      creditModel.tabController.value!.animateTo(creditModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (creditModel.tabController.value!.index > 0) {
      creditModel.tabController.value!.animateTo(creditModel.tabController.value!.index - 1);
    }
  }

  void updateProductName(String productName) {
    creditModel.productNameController.value.text = productName;
  }

  void updateHSN(String hsn) {
    creditModel.hsnController.value.text = hsn;
  }

  void updatePrice(double price) {
    creditModel.priceController.value.text = price.toString();
  }

  void updateQuantity(int quantity) {
    creditModel.quantityController.value.text = quantity.toString();
  }

  void updateGST(double gst) {
    creditModel.gstController.value.text = gst.toString();
  }

  void updateClientAddress(String addrName, String addr) {
    creditModel.Credit_client_addr_name.value = addrName;
    creditModel.Credit_client_addr.value = addr;
  }

  void updateBillingAddress(String addrName, String addr) {
    creditModel.Credit_bill_addr_name.value = addrName;
    creditModel.Credit_bill_addr.value = addr;
  }

  void updateChallanTitle(String title) {
    creditModel.Credit_title.value = title;
  }

  void updateNoteEditindex(int? index) {
    creditModel.note_editIndex.value = index;
  }

  void updateChallanTableHeading(String tableHeading) {
    creditModel.Credit_table_heading.value = tableHeading;
  }

  void updateNoteList(String value, int index) {
    creditModel.Credit_noteList[creditModel.note_editIndex.value!] = Note(notename: creditModel.notecontentController.value.text);
  }

  void updateTabController(TabController tabController) {
    creditModel.tabController.value = tabController;
  }

  void updateTitleControllerText(String text) {
    creditModel.TitleController.value.text = text;
  }

  void updateClientAddressNameControllerText(String text) {
    creditModel.clientAddressNameController.value.text = text;
  }

  void updateClientAddressControllerText(String text) {
    creditModel.clientAddressController.value.text = text;
  }

  void updateBillingAddressNameControllerText(String text) {
    creditModel.billingAddressNameController.value.text = text;
  }

  void updateBillingAddressControllerText(String text) {
    creditModel.billingAddressController.value.text = text;
  }

  void updateRecommendationEditindex(int? index) {
    creditModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    creditModel.notecontentController.value.text = text;
  }

  void updateTableHeadingControllerText(String text) {
    creditModel.recommendationHeadingController.value.text = text;
  }

  void updateTableKeyControllerText(String text) {
    creditModel.recommendationKeyController.value.text = text;
  }

  void updateTableValueControllerText(String text) {
    creditModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    creditModel.notecontent.add(note);
  }

  void addProductEditindex(int? index) {
    creditModel.product_editIndex.value = index;
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      creditModel.Credit_recommendationList.add(Recommendation(key: key, value: value));
    } else {
      print('Key and value must not be empty');
    }
  }

  void updateRecommendation({
    required int index,
    required String key,
    required String value,
  }) {
    if (index >= 0 && index < creditModel.Credit_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        creditModel.Credit_recommendationList[index] = Recommendation(key: key, value: value);
      } else {
        print('Key and value must not be empty');
      }
    } else {
      print('Invalid index provided');
    }
  }

  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      creditModel.Credit_noteList.add(Note(notename: noteContent));
    } else {
      print('Note content must not be empty'); // Handle empty input (optional)
    }
  }

  void addProduct({
    required BuildContext context,
    required String productName,
    required String hsn,
    required double price,
    required int quantity,
    required double gst,
  }) {
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

      creditModel.Credit_products.add(CreditProduct(
        (creditModel.Credit_products.length + 1).toString(),
        productName,
        hsn,
        gst,
        price,
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
    required double price,
    required int quantity,
    required double gst,
  }) {
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
      if (editIndex < 0 || editIndex >= creditModel.Credit_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      creditModel.Credit_products[editIndex] = CreditProduct((editIndex + 1).toString(), productName, hsn, gst, price, quantity);

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
      // .updateProductDetails(creditController.creditModel.Credit_productDetails);
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
  void updateProducts(List<CreditProduct> products) {
    creditModel.Credit_products.value = products;
  }

  void removeFromNoteList(int index) {
    creditModel.Credit_noteList.removeAt(index);
  }

  void removeFromRecommendationList(int index) {
    creditModel.Credit_recommendationList.removeAt(index);
  }

  void removeFromProductList(index) {
    creditModel.Credit_products.removeAt(index);
  }

  void clearAll() {
    // Reset all observable strings to empty
    creditModel.Credit_client_addr_name.value = '';
    creditModel.Credit_client_addr.value = '';
    creditModel.Credit_bill_addr_name.value = '';
    creditModel.Credit_bill_addr.value = '';
    creditModel.Credit_no.value = '';
    creditModel.Credit_title.value = '';
    creditModel.Credit_table_heading.value = '';

    // Clear note list and recommendation list
    creditModel.Credit_noteList.clear();
    creditModel.Credit_recommendationList.clear();
    // creditModel.Credit_productDetails.clear();

    // Clear products list
    creditModel.Credit_products.clear();

    // Reset text controllers
    creditModel.TitleController.value.clear();
    creditModel.clientAddressNameController.value.clear();
    creditModel.clientAddressController.value.clear();
    creditModel.billingAddressNameController.value.clear();
    creditModel.billingAddressController.value.clear();
    creditModel.productNameController.value.clear();
    creditModel.hsnController.value.clear();
    creditModel.priceController.value.clear();
    creditModel.quantityController.value.clear();
    creditModel.gstController.value.clear();
    creditModel.notecontentController.value.clear();
    creditModel.recommendationHeadingController.value.clear();
    creditModel.recommendationKeyController.value.clear();
    creditModel.recommendationValueController.value.clear();

    // Reset form keys
    creditModel.detailsKey.value = GlobalKey<FormState>();
    creditModel.productKey.value = GlobalKey<FormState>();
    creditModel.noteformKey.value = GlobalKey<FormState>();

    // Reset edit indices
    creditModel.product_editIndex.value = null;
    creditModel.note_editIndex.value = null;
    creditModel.recommendation_editIndex.value = null;

    // Reset heading type and note arrays
    // creditModel.selectedheadingType.value = null;
    // creditModel.notelength.value = 0;
    // creditModel.notetablelength.value = 0;
    creditModel.notecontent.clear();
    // creditModel.noteType.clear();
    // creditModel.noteType.addAll([
    //   'With Heading',
    //   'Without Heading'
    // ]);
  }
}
