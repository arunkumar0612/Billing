import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/constants/SALES_constants/ClientReq_constants.dart';

import '../../models/entities/SALES/ClientReq_entities.dart';
import '../../models/entities/SALES/product_entities.dart';

class ClientreqController extends GetxController {
  var clientReqModel = ClientReqModel();

  void initializeTabController(TabController tabController) {
    clientReqModel.tabController.value = tabController;
  }

  void nextTab() {
    if (clientReqModel.tabController.value!.index < clientReqModel.tabController.value!.length - 1) {
      clientReqModel.tabController.value!.animateTo(clientReqModel.tabController.value!.index + 1);
    }
  }

  void backTab() {
    if (clientReqModel.tabController.value!.index > 0) {
      clientReqModel.tabController.value!.animateTo(clientReqModel.tabController.value!.index - 1);
    }
  }

  void updateTabController(TickerProvider vsync, int length) {
    clientReqModel.tabController.value = TabController(length: length, vsync: vsync);
  }

  // Update PDF File
  void updateSelectedPdf(String filePath) {
    clientReqModel.selectedPdf.value = File(filePath);
  }

  // Update Form Key
  void updateFormKey(GlobalKey<FormState> newKey) {
    clientReqModel.detailsformKey.value = newKey;
  }

  // Update Text Controllers
  void updateClientName(String name) {
    clientReqModel.clientNameController.value.text = name;
  }

  void updateClientAddress(String address) {
    clientReqModel.clientAddressController.value.text = address;
  }

  void updateBillingAddressName(String name) {
    clientReqModel.billingAddressNameController.value.text = name;
  }

  void updateBillingAddress(String address) {
    clientReqModel.billingAddressController.value.text = address;
  }

  void updateMOR(String morValue) {
    clientReqModel.morController.value.text = morValue;
  }

  void updatePhone(String phone) {
    clientReqModel.phoneController.value.text = phone;
  }

  void updateEmail(String email) {
    clientReqModel.emailController.value.text = email;
  }

  void updateGST(String gst) {
    clientReqModel.gstController.value.text = gst;
  }

  // Update Table Heading and Client Req Number
  void updateClientReqTableHeading(String heading) {
    clientReqModel.clientReqTableHeading.value = heading;
  }

  void updateClientReqNo(String number) {
    clientReqModel.clientReqNo.value = number;
  }

  void addProductEditindex(int? index) {
    clientReqModel.product_editIndex.value = index;
  }

  void updateProductName(String productName) {
    clientReqModel.productNameController.value.text = productName;
  }

  void updateQuantity(int quantity) {
    clientReqModel.quantityController.value.text = quantity.toString();
  }

  void updateTableValueControllerText(String text) {
    clientReqModel.tableValueController.value.text = text;
  }

  void updateNoteList(String value, int index) {
    clientReqModel.clientReqNoteList[clientReqModel.noteEditIndex.value!] = Note(notename: clientReqModel.noteContentController.value.text);
  }

  void updateNoteEditindex(int? index) {
    clientReqModel.noteEditIndex.value = index;
  }

  void updateRecommendationEditindex(int? index) {
    clientReqModel.noteTableEditIndex.value = index;
  }

  void updateNoteContentControllerText(String text) {
    clientReqModel.noteContentController.value.text = text;
  }

  void updateTableKeyControllerText(String text) {
    clientReqModel.tableKeyController.value.text = text;
  }

  void removeFromProductList(index) {
    clientReqModel.clientReqProductDetails.removeAt(index);
  }

  void removeFromNoteList(int index) {
    clientReqModel.clientReqNoteList.removeAt(index);
  }

  void removeFromRecommendationList(int index) {
    clientReqModel.clientReqRecommendationList.removeAt(index);
    clientReqModel.clientReqRecommendationList.isEmpty ? clientReqModel.tableHeadingController.value.clear() : null;
  }

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        // File exceeds 2 MB size limit
        if (kDebugMode) {
          print('Selected file exceeds 2MB in size.');
        }
        // Show Alert Dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Selected file exceeds 2MB in size.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        clientReqModel.pickedFile.value = null;
        clientReqModel.morFile.value = null;
      } else {
        clientReqModel.pickedFile.value = result;
        clientReqModel.morFile.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      clientReqModel.clientReqRecommendationList.add(Recommendation(key: key, value: value));
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
    if (index >= 0 && index < clientReqModel.clientReqRecommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        clientReqModel.clientReqRecommendationList[index] = Recommendation(key: key, value: value);
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
      clientReqModel.clientReqNoteList.add(Note(notename: noteContent));
    } else {
      if (kDebugMode) {
        print('Note content must not be empty');
      } // Handle empty input (optional)
    }
  }

  void addProduct({required BuildContext context, required String productName, required int quantity}) {
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

      clientReqModel.clientReqProductDetails.add(ClientreqProduct((clientReqModel.clientReqProductDetails.length + 1).toString(), productName, quantity));

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

  void updateProduct({required BuildContext context, required int editIndex, required String productName, required int quantity}) {
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
      if (editIndex < 0 || editIndex >= clientReqModel.clientReqProductDetails.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid product index.'),
          ),
        );
        return;
      }

      // Update the product details at the specified index
      clientReqModel.clientReqProductDetails[editIndex] = ClientreqProduct((editIndex + 1).toString(), productName, quantity);

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
      // .updateProductDetails(creditController.clientReqModel.clientReq_productDetails);
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

  // Clear Picked Files
  void clearPickedFiles() {
    clientReqModel.pickedFile.value = null;
    clientReqModel.morFile.value = null;
  }
}
