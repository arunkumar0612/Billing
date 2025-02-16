import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/constants/SALES_constants/Invoice_constants.dart';
import '../../models/entities/SALES/Invoice_entities.dart';
import '../../models/entities/SALES/product_entities.dart';

class InvoiceController extends GetxController {
  var invoiceModel = InvoiceModel();

  void initializeTabController(TabController tabController) {
    invoiceModel.tabController.value = tabController;
  }

  void nextTab() {
    if (invoiceModel.tabController.value!.index < invoiceModel.tabController.value!.length - 1) {
      invoiceModel.tabController.value!.animateTo(invoiceModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (invoiceModel.tabController.value!.index > 0) {
      invoiceModel.tabController.value!.animateTo(invoiceModel.tabController.value!.index - 1);
    }
  }

  void updateProductName(String productName) {
    invoiceModel.productNameController.value.text = productName;
  }

  void updateHSN(String hsn) {
    invoiceModel.hsnController.value.text = hsn;
  }

  void updatePrice(double price) {
    invoiceModel.priceController.value.text = price.toString();
  }

  void updateQuantity(int quantity) {
    invoiceModel.quantityController.value.text = quantity.toString();
  }

  void updateGST(double gst) {
    invoiceModel.gstController.value.text = gst.toString();
  }

  void updateNoteEditindex(int? index) {
    invoiceModel.note_editIndex.value = index;
  }

  void updateChallanTableHeading(String tableHeading) {
    invoiceModel.Invoice_table_heading.value = tableHeading;
  }

  void updateNoteList(String value, int index) {
    invoiceModel.Invoice_noteList[invoiceModel.note_editIndex.value!] = Note(notename: invoiceModel.notecontentController.value.text);
  }

  void updateTabController(TabController tabController) {
    invoiceModel.tabController.value = tabController;
  }

  void updateTitleControllerText(String text) {
    invoiceModel.TitleController.value.text = text;
  }

  void updateClientAddressNameControllerText(String text) {
    invoiceModel.clientAddressNameController.value.text = text;
  }

  void updateClientAddressControllerText(String text) {
    invoiceModel.clientAddressController.value.text = text;
  }

  void updateBillingAddressNameControllerText(String text) {
    invoiceModel.billingAddressNameController.value.text = text;
  }

  void updateBillingAddressControllerText(String text) {
    invoiceModel.billingAddressController.value.text = text;
  }

  void updateRecommendationEditindex(int? index) {
    invoiceModel.recommendation_editIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    invoiceModel.notecontentController.value.text = text;
  }

  void updateRec_HeadingControllerText(String text) {
    invoiceModel.recommendationHeadingController.value.text = text;
  }

  void updateRec_KeyControllerText(String text) {
    invoiceModel.recommendationKeyController.value.text = text;
  }

  void updateRec_ValueControllerText(String text) {
    invoiceModel.recommendationValueController.value.text = text;
  }

  void addNoteToList(String note) {
    invoiceModel.notecontent.add(note);
  }

  void addProductEditindex(int? index) {
    invoiceModel.product_editIndex.value = index;
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      invoiceModel.Invoice_recommendationList.add(Recommendation(key: key, value: value));
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
    if (index >= 0 && index < invoiceModel.Invoice_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        invoiceModel.Invoice_recommendationList[index] = Recommendation(key: key, value: value);
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
      invoiceModel.Invoice_noteList.add(Note(notename: noteContent));
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

      invoiceModel.Invoice_products.add(InvoiceProduct(
        (invoiceModel.Invoice_products.length + 1).toString(),
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
      if (editIndex < 0 || editIndex >= invoiceModel.Invoice_products.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      invoiceModel.Invoice_products[editIndex] = InvoiceProduct((editIndex + 1).toString(), productName, hsn, gst, price, quantity);

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
      // .updateProductDetails(invoiceController.invoiceModel.Invoice_productDetails);
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
  void updateProducts(List<InvoiceProduct> products) {
    invoiceModel.Invoice_products.value = products;
  }

  void removeFromNoteList(int index) {
    invoiceModel.Invoice_noteList.removeAt(index);
  }

  void removeFromRecommendationList(int index) {
    invoiceModel.Invoice_recommendationList.removeAt(index);
    invoiceModel.Invoice_recommendationList.isEmpty ? invoiceModel.recommendationHeadingController.value.clear() : null;
  }

  void removeFromProductList(index) {
    invoiceModel.Invoice_products.removeAt(index);
  }

  void clearAll() {
    invoiceModel.Invoice_no.value = '';

    invoiceModel.Invoice_table_heading.value = '';

    // Clear note list and recommendation list
    invoiceModel.Invoice_noteList.clear();
    invoiceModel.Invoice_recommendationList.clear();
    // invoiceModel.Invoice_productDetails.clear();

    // Clear products list
    invoiceModel.Invoice_products.clear();

    // Reset text controllers
    invoiceModel.TitleController.value.clear();
    invoiceModel.clientAddressNameController.value.clear();
    invoiceModel.clientAddressController.value.clear();
    invoiceModel.billingAddressNameController.value.clear();
    invoiceModel.billingAddressController.value.clear();
    invoiceModel.productNameController.value.clear();
    invoiceModel.hsnController.value.clear();
    invoiceModel.priceController.value.clear();
    invoiceModel.quantityController.value.clear();
    invoiceModel.gstController.value.clear();
    invoiceModel.notecontentController.value.clear();
    invoiceModel.recommendationHeadingController.value.clear();
    invoiceModel.recommendationKeyController.value.clear();
    invoiceModel.recommendationValueController.value.clear();

    // Reset form keys
    invoiceModel.detailsKey.value = GlobalKey<FormState>();
    invoiceModel.productKey.value = GlobalKey<FormState>();
    invoiceModel.noteformKey.value = GlobalKey<FormState>();

    // Reset edit indices
    invoiceModel.product_editIndex.value = null;
    invoiceModel.note_editIndex.value = null;
    invoiceModel.recommendation_editIndex.value = null;

    // Reset heading type and note arrays
    // invoiceModel.selectedheadingType.value = null;
    // invoiceModel.notelength.value = 0;
    // invoiceModel.Rec_Length.value = 0;
    invoiceModel.notecontent.clear();
    // invoiceModel.noteType.clear();
    // invoiceModel.noteType.addAll([
    //   'With Heading',
    //   'Without Heading'
    // ]);
  }
}
