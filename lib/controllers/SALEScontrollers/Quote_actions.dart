import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/constants/SALES_constants/Quote_constants.dart';
import '../../models/entities/SALES/Quote_entities.dart';
import '../../models/entities/SALES/product_entities.dart';

class QuoteController extends GetxController {
  var quoteModel = QuoteModel();

  void initializeTabController(TabController tabController) {
    quoteModel.tabController.value = tabController;
  }

  void nextTab() {
    if (quoteModel.tabController.value!.index < quoteModel.tabController.value!.length - 1) {
      quoteModel.tabController.value!.animateTo(quoteModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (quoteModel.tabController.value!.index > 0) {
      quoteModel.tabController.value!.animateTo(quoteModel.tabController.value!.index - 1);
    }
  }

  void updateProductName(String productName) {
    quoteModel.productNameController.value.text = productName;
  }

  void updateHSN(String hsn) {
    quoteModel.hsnController.value.text = hsn;
  }

  void updatePrice(double price) {
    quoteModel.priceController.value.text = price.toString();
  }

  void updateQuantity(int quantity) {
    quoteModel.quantityController.value.text = quantity.toString();
  }

  void updateGST(double gst) {
    quoteModel.gstController.value.text = gst.toString();
  }

  void updateNoteEditindex(int? index) {
    quoteModel.note_editIndex.value = index;
  }

  void updateChallanTableHeading(String tableHeading) {
    quoteModel.Quote_table_heading.value = tableHeading;
  }

  void updateNoteList(String value, int index) {
    quoteModel.Quote_noteList[quoteModel.note_editIndex.value!] = Note(notename: quoteModel.notecontentController.value.text);
  }

  void updateTabController(TabController tabController) {
    quoteModel.tabController.value = tabController;
  }

  void updateTitleControllerText(String text) {
    quoteModel.TitleController.value.text = text;
  }

  void updateClientAddressNameControllerText(String text) {
    quoteModel.clientAddressNameController.value.text = text;
  }

  void updateClientAddressControllerText(String text) {
    quoteModel.clientAddressController.value.text = text;
  }

  void updateBillingAddressNameControllerText(String text) {
    quoteModel.billingAddressNameController.value.text = text;
  }

  void updateBillingAddressControllerText(String text) {
    quoteModel.billingAddressController.value.text = text;
  }

  void updateRecommendationEditindex(int? index) {
    quoteModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    quoteModel.notecontentController.value.text = text;
  }

  void updateTableHeadingControllerText(String text) {
    quoteModel.recommendationHeadingController.value.text = text;
  }

  void updateTableKeyControllerText(String text) {
    quoteModel.recommendationKeyController.value.text = text;
  }

  void updateTableValueControllerText(String text) {
    quoteModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    quoteModel.notecontent.add(note);
  }

  void addProductEditindex(int? index) {
    quoteModel.product_editIndex.value = index;
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      quoteModel.Quote_recommendationList.add(Recommendation(key: key, value: value));
    } else {
      if (kDebugMode) {
        print('Key and value must not be empty');
      }
    }
  }

  void updateRecommendation({
    required int index,
    required String key,
    required String value,
  }) {
    if (index >= 0 && index < quoteModel.Quote_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        quoteModel.Quote_recommendationList[index] = Recommendation(key: key, value: value);
      } else {
        if (kDebugMode) {
          print('Key and value must not be empty');
        }
      }
    } else {
      if (kDebugMode) {
        print('Invalid index provided');
      }
    }
  }

  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      quoteModel.Quote_noteList.add(Note(notename: noteContent));
    } else {
      if (kDebugMode) {
        print('Note content must not be empty');
      } // Handle empty input (optional)
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

      quoteModel.Quote_products.add(QuoteProduct(
        (quoteModel.Quote_products.length + 1).toString(),
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
      if (editIndex < 0 || editIndex >= quoteModel.Quote_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      quoteModel.Quote_products[editIndex] = QuoteProduct((editIndex + 1).toString(), productName, hsn, gst, price, quantity);

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
      // .updateProductDetails(quoteController.quoteModel.Quote_productDetails);
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
  void updateProducts(List<QuoteProduct> products) {
    quoteModel.Quote_products.value = products;
  }

  void removeFromNoteList(int index) {
    quoteModel.Quote_noteList.removeAt(index);
  }

  void removeFromRecommendationList(int index) {
    quoteModel.Quote_recommendationList.removeAt(index);
    quoteModel.Quote_recommendationList.isEmpty ? quoteModel.recommendationHeadingController.value.clear() : null;
  }

  void removeFromProductList(index) {
    quoteModel.Quote_products.removeAt(index);
  }

  void clearAll() {
    // Reset all observable strings to empty

    quoteModel.Quote_no.value = '';
    quoteModel.Quote_table_heading.value = '';

    // Clear note list and recommendation list
    quoteModel.Quote_noteList.clear();
    quoteModel.Quote_recommendationList.clear();
    // quoteModel.Quote_productDetails.clear();

    // Clear products list
    quoteModel.Quote_products.clear();

    // Reset text controllers
    quoteModel.TitleController.value.clear();
    quoteModel.clientAddressNameController.value.clear();
    quoteModel.clientAddressController.value.clear();
    quoteModel.billingAddressNameController.value.clear();
    quoteModel.billingAddressController.value.clear();
    quoteModel.productNameController.value.clear();
    quoteModel.hsnController.value.clear();
    quoteModel.priceController.value.clear();
    quoteModel.quantityController.value.clear();
    quoteModel.gstController.value.clear();
    quoteModel.notecontentController.value.clear();
    quoteModel.recommendationHeadingController.value.clear();
    quoteModel.recommendationKeyController.value.clear();
    quoteModel.recommendationValueController.value.clear();

    // Reset form keys
    quoteModel.detailsKey.value = GlobalKey<FormState>();
    quoteModel.productKey.value = GlobalKey<FormState>();
    quoteModel.noteformKey.value = GlobalKey<FormState>();

    // Reset edit indices
    quoteModel.product_editIndex.value = null;
    quoteModel.note_editIndex.value = null;
    quoteModel.recommendation_editIndex.value = null;

    // Reset heading type and note arrays
    // quoteModel.selectedheadingType.value = null;
    // quoteModel.notelength.value = 0;
    // quoteModel.notetablelength.value = 0;
    quoteModel.notecontent.clear();
    // quoteModel.noteType.clear();
    // quoteModel.noteType.addAll([
    //   'With Heading',
    //   'Without Heading'
    // ]);
  }
}
