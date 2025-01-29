import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/constants/DC_constants.dart';
import '../models/entities/DC_entities.dart';
import '../models/entities/product_entities.dart';

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

  // Update product name
  void updateProductName(String productName) {
    dcModel.productNameController.value.text = productName;
  }

// Update HSN
  void updateHSN(String hsn) {
    dcModel.hsnController.value.text = hsn;
  }

// Update price
  void updatePrice(double price) {
    dcModel.priceController.value.text = price.toString();
  }

// Update quantity
  void updateQuantity(int quantity) {
    dcModel.quantityController.value.text = quantity.toString();
  }

// Update GST
  void updateGST(double gst) {
    dcModel.gstController.value.text = gst.toString();
  }

  // Update client address
  void updateClientAddress(String addrName, String addr) {
    dcModel.Delivery_challan_client_addr_name.value = addrName;
    dcModel.Delivery_challan_client_addr.value = addr;
  }

  // Update billing address
  void updateBillingAddress(String addrName, String addr) {
    dcModel.Delivery_challan_bill_addr_name.value = addrName;
    dcModel.Delivery_challan_bill_addr.value = addr;
  }

  // Update Delivery Challan title
  void updateChallanTitle(String title) {
    dcModel.Delivery_challan_title.value = title;
  }

  void updateNoteEditindex(int? index) {
    dcModel.noteeditIndex.value = index;
  }

  // Update Delivery Challan table heading
  void updateChallanTableHeading(String tableHeading) {
    dcModel.Delivery_challan_table_heading.value = tableHeading;
  }

  // Update note list
  void updateNoteList(String value, int index) {
    dcModel.Delivery_challan_noteList[dcModel.noteeditIndex.value!] = {
      'notecontent': dcModel.notecontentController.value.text,
    };
  }

  // Update products list
  void updateProducts(List<Product> products) {
    dcModel.Delivery_challan_products.value = products;
  }

  // Update Tab Controller
  void updateTabController(TabController tabController) {
    dcModel.tabController.value = tabController;
  }

  // Update Title Controller Text
  void updateTitleControllerText(String text) {
    dcModel.TitleController.value.text = text;
  }

  // Update client address name controller text
  void updateClientAddressNameControllerText(String text) {
    dcModel.clientAddressNameController.value.text = text;
  }

  // Update client address controller text
  void updateClientAddressControllerText(String text) {
    dcModel.clientAddressController.value.text = text;
  }

  // Update billing address name controller text
  void updateBillingAddressNameControllerText(String text) {
    dcModel.billingAddressNameController.value.text = text;
  }

  // Update billing address controller text
  void updateBillingAddressControllerText(String text) {
    dcModel.billingAddressController.value.text = text;
  }

  // Update formKey1
  void updateFormKey1(GlobalKey<FormState> formKey) {
    dcModel.formKey1.value = formKey;
  }

  // Update note length
  void updateNoteLength(int length) {
    dcModel.notelength.value = length;
  }

  // Update table length
  void updateNoteTableLength(int length) {
    dcModel.notetablelength.value = length;
  }

  void updateNoteTableEditindex(int? index) {
    dcModel.notetable_editIndex.value = index;
  }

  // Update note content controller text
  void updateNoteContentControllerText(String text) {
    dcModel.notecontentController.value.text = text;
  }

  // Update table heading controller text
  void updateTableHeadingControllerText(String text) {
    dcModel.tableHeadingController.value.text = text;
  }

  // Update table key controller text
  void updateTableKeyControllerText(String text) {
    dcModel.tableKeyController.value.text = text;
  }

  // Update table value controller text
  void updateTableValueControllerText(String text) {
    dcModel.tableValueController.value.text = text;
  }

  // Update selected heading type
  void updateSelectedHeadingType(String type) {
    dcModel.selectedheadingType.value = type;
  }

  // Add note to note content list
  void addNoteToList(String note) {
    dcModel.notecontent.add(note);
  }

  // Add note type
  void addNoteType(String type) {
    dcModel.noteType.add(type);
  }

  void addProductEditindex(int? index) {
    dcModel.editIndex1.value = index;
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      dcModel.Delivery_challan_recommendationList.add(Recommendation(key: key, value: value));
    } else {
      // Handle error if key or value is empty (optional)
      print('Key and value must not be empty');
    }
  }

  void updateRecommendation({
    required int index,
    required String key,
    required String value,
  }) {
    // Check if the index is within bounds
    if (index >= 0 && index < dcModel.Delivery_challan_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        // Update the recommendation at the specified index
        dcModel.Delivery_challan_recommendationList[index] = Recommendation(key: key, value: value);
      } else {
        // Handle error if key or value is empty
        print('Key and value must not be empty');
      }
    } else {
      // Handle invalid index error
      print('Invalid index provided');
    }
  }

  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      dcModel.Delivery_challan_noteList.add({
        'notecontent': noteContent,
      });
      dcModel.notelength.value = dcModel.Delivery_challan_noteList.length;
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

      // Add product details to the list
      dcModel.Delivery_challan_productDetails.add({
        'productName': productName.trim(),
        'hsn': hsn.trim(),
        'price': price,
        'quantity': quantity,
        'gst': gst,
      });

      // Notify success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Product added successfully.'),
        ),
      );

      // Optional: Update the product list length or UI if needed
      // updateProductDetailsLength(dcController.dcModel.Delivery_challan_productDetails.length);
    } catch (e) {
      // Handle unexpected errors
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
      if (editIndex < 0 || editIndex >= dcModel.Delivery_challan_productDetails.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      dcModel.Delivery_challan_productDetails[editIndex] = {
        'productName': productName.trim(),
        'hsn': hsn.trim(),
        'price': price,
        'quantity': quantity,
        'gst': gst,
      };

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

  void clearAll() {
    // Reset all observable strings to empty
    dcModel.Delivery_challan_client_addr_name.value = '';
    dcModel.Delivery_challan_client_addr.value = '';
    dcModel.Delivery_challan_bill_addr_name.value = '';
    dcModel.Delivery_challan_bill_addr.value = '';
    dcModel.Delivery_challan_no.value = '';
    dcModel.Delivery_challan_title.value = '';
    dcModel.Delivery_challan_table_heading.value = '';

    // Clear note list and recommendation list
    dcModel.Delivery_challan_noteList.clear();
    dcModel.Delivery_challan_recommendationList.clear();
    dcModel.Delivery_challan_productDetails.clear();

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
    dcModel.priceController.value.clear();
    dcModel.quantityController.value.clear();
    dcModel.gstController.value.clear();
    dcModel.notecontentController.value.clear();
    dcModel.tableHeadingController.value.clear();
    dcModel.tableKeyController.value.clear();
    dcModel.tableValueController.value.clear();

    // Reset form keys
    dcModel.formKey1.value = GlobalKey<FormState>();
    dcModel.productKey.value = GlobalKey<FormState>();
    dcModel.noteformKey.value = GlobalKey<FormState>();

    // Reset edit indices
    dcModel.editIndex1.value = null;
    dcModel.noteeditIndex.value = null;
    dcModel.notetable_editIndex.value = null;

    // Reset heading type and note arrays
    dcModel.selectedheadingType.value = null;
    dcModel.notelength.value = 0;
    dcModel.notetablelength.value = 0;
    dcModel.notecontent.clear();
    dcModel.noteType.clear();
    dcModel.noteType.addAll([
      'With Heading',
      'Without Heading'
    ]);
  }
}
