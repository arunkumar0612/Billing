import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Quote_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

import '../models/constants/Quote_constants.dart';

class QuoteController extends GetxController {
  var quoteModel = QuoteModel();

  /// Initializes the TabController and stores it in the model.
  void initializeTabController(TabController tabController) {
    quoteModel.tabController.value = tabController;
  }

  /// Navigates to the next tab if not already on the last one.
  void nextTab() {
    if (quoteModel.tabController.value!.index < quoteModel.tabController.value!.length - 1) {
      quoteModel.tabController.value!.animateTo(quoteModel.tabController.value!.index + 1);
    }
  }

  /// Navigates to the previous tab if not already on the first one.
  void backTab() {
    if (quoteModel.tabController.value!.index > 0) {
      quoteModel.tabController.value!.animateTo(quoteModel.tabController.value!.index - 1);
    }
  }

  /// Adds a list of product suggestions to the model.
  void add_productSuggestion(List<dynamic> suggestionList) {
    for (var item in suggestionList) {
      quoteModel.Quote_productSuggestion.add(ProductSuggestion.fromJson(item));
    }
  }

  /// Updates the product name in the text controller.
  void updateProductName(String productName) {
    quoteModel.productNameController.value.text = productName;
  }

  /// Updates the HSN code in the text controller.
  void updateHSN(int hsn) {
    quoteModel.hsnController.value.text = hsn.toString();
  }

  /// Updates the price in the text controller.
  void updatePrice(double price) {
    quoteModel.priceController.value.text = price.toString();
  }

  /// Updates the quantity in the text controller.
  void updateQuantity(int quantity) {
    quoteModel.quantityController.value.text = quantity.toString();
  }

  /// Updates the GST value in the text controller.
  void updateGST(double gst) {
    quoteModel.gstController.value.text = gst.toString();
  }

  /// Updates the current editing index for notes.
  void updateNoteEditindex(int? index) {
    quoteModel.note_editIndex.value = index;
  }

  // void updateChallanTableHeading(String tableHeading) {
  //   quoteModel.Quote_table_heading.value = tableHeading;
  // }

  /// Updates a note in the list at the current edit index with the controller's text.
  void updateNoteList(String value, int index) {
    quoteModel.Quote_noteList[quoteModel.note_editIndex.value!] = quoteModel.notecontentController.value.text;
  }

  /// Updates the stored TabController in the model.
  void updateTabController(TabController tabController) {
    quoteModel.tabController.value = tabController;
  }

  /// Updates the quote title in the controller.
  void updateTitle(String text) {
    quoteModel.TitleController.value.text = text;
  }

  /// Updates the quote number value.
  void updateQuotenumber(String text) {
    quoteModel.Quote_no.value = text;
  }

  /// Updates the GST number in the controller.
  void updateGSTnumber(String text) {
    quoteModel.gstNumController.value.text = text;
  }

  /// Updates the client’s name in the address section.
  void updateClientAddressName(String text) {
    quoteModel.clientAddressNameController.value.text = text;
  }

  /// Updates the client’s address details.
  void updateClientAddress(String text) {
    quoteModel.clientAddressController.value.text = text;
  }

  /// Updates the billing address name in the controller.
  void updateBillingAddressName(String text) {
    quoteModel.billingAddressNameController.value.text = text;
  }

  /// Updates the billing address details.
  void updateBillingAddress(String text) {
    quoteModel.billingAddressController.value.text = text;
  }

  /// Updates the client’s phone number.
  void updatePhone(String phone) {
    quoteModel.phoneController.value.text = phone;
  }

  /// Updates the client’s email address.
  void updateEmail(String email) {
    quoteModel.emailController.value.text = email;
  }

  /// Updates the CC email address field.
  void updatCC(String CC) {
    quoteModel.CCemailController.value.text = CC;
  }

  /// Toggles visibility of the CC email field.
  void toggleCCemailvisibility(bool value) {
    quoteModel.CCemailToggle.value = value;
  }

  /// Updates the current editing index for the recommendation section.
  void updateRecommendationEditindex(int? index) {
    quoteModel.recommendation_editIndex.value = index;
  }

  /// Updates the note content controller text.
  void updateNoteContentControllerText(String text) {
    quoteModel.notecontentController.value.text = text;
  }

  /// Updates the recommendation heading controller text.
  void updateRec_HeadingControllerText(String text) {
    quoteModel.recommendationHeadingController.value.text = text;
  }

  /// Updates the recommendation key controller text.
  void updateRec_KeyControllerText(String text) {
    quoteModel.recommendationKeyController.value.text = text;
  }

  /// Updates the recommendation value controller text.
  void updateRec_ValueControllerText(String text) {
    quoteModel.recommendationValueController.value.text = text;
  }

  /// Adds a note string to the note content list.
  void addNoteToList(String note) {
    quoteModel.notecontent.add(note);
  }

  /// Sets the current editing index for the product section.
  void addProductEditindex(int? index) {
    quoteModel.product_editIndex.value = index;
  }

  /// Sets the selected process ID.
  void setProcessID(int processid) {
    quoteModel.processID.value = processid;
  }

  /// Updates the selected PDF file in the model.
  void updateSelectedPdf(File file) {
    quoteModel.selectedPdf.value = file;
  }

  /// Toggles the general loading state.
  void setLoading(bool value) {
    quoteModel.isLoading.value = value;
  }

  /// Toggles the PDF-specific loading state.
  void setpdfLoading(bool value) {
    quoteModel.ispdfLoading.value = value;
  }

  // Toggle WhatsApp state
  void toggleWhatsApp(bool value) {
    quoteModel.whatsapp_selectionStatus.value = value;
  }

  /// Toggle Gmail state
  void toggleGmail(bool value) {
    quoteModel.gmail_selectionStatus.value = value;
  }

  /// Update phone number text
  void updatePhoneNumber(String phoneNumber) {
    quoteModel.phoneController.value.text = phoneNumber;
  }

  /// Update feedback text
  void updateFeedback(String feedback) {
    quoteModel.feedbackController.value.text = feedback;
  }

  /// Update file path text
  void updateFilePath(String filePath) {
    quoteModel.filePathController.value.text = filePath;
  }

  /// Opens a file picker to select an image file and validates its size (max 2MB).
  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'png',
          'jpg',
          'jpeg',
        ],
        lockParentWindow: true);

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        // File exceeds 2 MB size limit
        if (kDebugMode) {
          print('Selected file exceeds 2MB in size.');
        }
        // Show Alert Dialog
        Error_dialog(context: context, title: 'Error', content: 'Selected file exceeds 2MB in size.');
        quoteModel.pickedFile.value = null;
        quoteModel.selectedPdf.value = null;
      } else {
        quoteModel.pickedFile.value = result;
        quoteModel.selectedPdf.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  /// Returns an integer indicating the selected message type (0: none, 1: email, 2: WhatsApp, 3: both).
  int fetch_messageType() {
    if (quoteModel.whatsapp_selectionStatus.value && quoteModel.gmail_selectionStatus.value) return 3;
    if (quoteModel.whatsapp_selectionStatus.value) return 2;
    if (quoteModel.gmail_selectionStatus.value) return 1;

    return 0;
  }

  /// Simulates a progress bar animation from 0% to 100%.
  Future<void> startProgress() async {
    setLoading(true);
    quoteModel.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      quoteModel.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  /// Adds a recommendation entry to the list if both key and value are not empty.
  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      quoteModel.Quote_recommendationList.add(Recommendation(key: key, value: value));
    } else {
      if (kDebugMode) {
        print('Key and value must not be empty');
      }
    }
  }

  /// Updates a recommendation entry at a given index if inputs are valid.
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

  /// Adds a note to the note list if the content is not empty.
  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      quoteModel.Quote_noteList.add(noteContent);
    } else {
      if (kDebugMode) {
        print('Note content must not be empty');
      } // Handle empty input (optional)
    }
  }

  /// Adds a product to the product list after validating input fields.
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
        Error_SnackBar(context, 'Please provide valid product details.');

        return;
      }

      quoteModel.Quote_products.add(QuoteProduct(
        sno: (quoteModel.Quote_products.length + 1),
        productName: productName,
        hsn: int.parse(hsn),
        gst: gst,
        price: price,
        quantity: quantity,
      ));
    } catch (e) {
      Error_SnackBar(context, 'An error occurred while adding the product.');
    }
  }

  /// Updates a product in the list at the given index after validating inputs.
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
        Error_SnackBar(context, 'Please provide valid product details.');

        return;
      }

      // Check if the editIndex is valid
      if (editIndex < 0 || editIndex >= quoteModel.Quote_products.length) {
        Error_SnackBar(context, 'Invalid product index.');

        return;
      }

      // Update the product details at the specified index
      quoteModel.Quote_products[editIndex] = QuoteProduct(
        sno: (editIndex + 1),
        productName: productName,
        hsn: int.parse(hsn),
        gst: gst,
        price: price,
        quantity: quantity,
      );

      // ProductDetail(
      //   productName: productName.trim(),
      //   hsn: hsn.trim(),
      //   price: price,
      //   quantity: quantity,
      //   gst: gst,
      // );

      // Notify success
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     backgroundColor: Colors.green,
      //     content: Text('Product updated successfully.'),
      //   ),
      // );

      // Optional: Update UI or state if needed
      // .updateProductDetails(quoteController.quoteModel.Quote_productDetails);
    } catch (e) {
      // Handle unexpected errors
      Error_SnackBar(context, 'An error occurred while updating the product.');
    }
  }

  /// Updates the full list of products in the model.
  void updateProducts(List<QuoteProduct> products) {
    quoteModel.Quote_products.value = products;
  }

  /// Removes a note from the note list by index and resets the edit index.
  void removeFromNoteList(int index) {
    quoteModel.Quote_noteList.removeAt(index);
    quoteModel.note_editIndex.value = null;
  }

  /// Removes a recommendation from the list by index and resets the edit index.
  void removeFromRecommendationList(int index) {
    quoteModel.Quote_recommendationList.removeAt(index);
    // quoteModel.Quote_recommendationList.isEmpty ? quoteModel.recommendationHeadingController.value.clear() : null;
    quoteModel.recommendation_editIndex.value = null;
  }

  /// Removes a product from the product list by index and resets the edit index.
  void removeFromProductList(index) {
    quoteModel.Quote_products.removeAt(index);
    quoteModel.product_editIndex.value = null;
  }

  /// Updates all required quote fields from the given response and event type.
  void update_requiredData(
    CMDmResponse value,
    String eventtype,
  ) {
    RequiredData instance = RequiredData.fromJson(value);
    quoteModel.Quote_no.value = instance.eventnumber;
    updateQuotenumber(instance.eventnumber);
    updateTitle(instance.title!);
    updateEmail(instance.emailId!);
    updateGSTnumber(instance.gst!);
    updatePhone(instance.phoneNo!);
    updateClientAddressName(instance.name!);
    updateClientAddress(instance.address!);
    updateBillingAddressName(instance.billingAddressName!);
    updateBillingAddress(instance.billingAddress!);
    if (eventtype == 'revisedquotation') updateProducts(instance.product!);
  }

  /// Validates required fields before generating the quotation.
  bool generate_Datavalidation() {
    return (quoteModel.TitleController.value.text.isEmpty ||
        quoteModel.processID.value == null ||
        quoteModel.clientAddressNameController.value.text.isEmpty ||
        quoteModel.clientAddressController.value.text.isEmpty ||
        quoteModel.billingAddressNameController.value.text.isEmpty ||
        quoteModel.billingAddressController.value.text.isEmpty ||
        quoteModel.gstNumController.value.text.isEmpty ||
        quoteModel.Quote_products.isEmpty ||
        quoteModel.Quote_noteList.isEmpty ||
        quoteModel.Quote_no.value == null);
  }

  /// Validates all fields including communication options before posting data.
  bool postDatavalidation() {
    return (quoteModel.TitleController.value.text.isEmpty ||
        quoteModel.processID.value == null ||
        quoteModel.clientAddressNameController.value.text.isEmpty ||
        quoteModel.clientAddressController.value.text.isEmpty ||
        quoteModel.billingAddressNameController.value.text.isEmpty ||
        quoteModel.billingAddressController.value.text.isEmpty ||
        (quoteModel.gmail_selectionStatus.value && quoteModel.emailController.value.text.isEmpty) ||
        (quoteModel.whatsapp_selectionStatus.value && quoteModel.phoneController.value.text.isEmpty) ||
        quoteModel.gstNumController.value.text.isEmpty ||
        quoteModel.Quote_products.isEmpty ||
        quoteModel.Quote_noteList.isEmpty ||
        quoteModel.Quote_no.value == null);
  }

  // void resetData() {
  //   quoteModel.tabController.value = null;
  //   quoteModel.processID.value = null;
  //   quoteModel.Quote_no.value = null;
  //   quoteModel.gstNumController.value.text = "";
  //   quoteModel.Quote_table_heading.value = "";

  //   quoteModel.phoneController.value.text = "";
  //   quoteModel.emailController.value.text = "";
  //   quoteModel.CCemailToggle.value = false;
  //   quoteModel.CCemailController.value.clear();
  //   // Reset details
  //   quoteModel.TitleController.value.text = "";
  //   quoteModel.clientAddressNameController.value.text = "";
  //   quoteModel.clientAddressController.value.text = "";
  //   quoteModel.billingAddressNameController.value.text = "";
  //   quoteModel.billingAddressController.value.text = "";

  //   // Reset product details
  //   quoteModel.product_editIndex.value = null;
  //   quoteModel.productNameController.value.text = "";
  //   quoteModel.hsnController.value.text = "";
  //   quoteModel.priceController.value.text = "";
  //   quoteModel.quantityController.value.text = "";
  //   quoteModel.gstController.value.text = "";
  //   quoteModel.Quote_products.clear();
  //   quoteModel.Quote_gstTotals.clear();
  //   quoteModel.Quote_productSuggestion.clear();

  //   // Reset notes
  //   quoteModel.note_editIndex.value = null;
  //   quoteModel.notecontentController.value.text = "";
  //   quoteModel.recommendation_editIndex.value = null;
  //   quoteModel.recommendationHeadingController.value.text = "";
  //   quoteModel.recommendationKeyController.value.text = "";
  //   quoteModel.recommendationValueController.value.text = "";
  //   quoteModel.Quote_noteList.clear();
  //   quoteModel.Quote_recommendationList.clear();
  // }

  void resetData() {
    // TAB, PROCESS & GENERAL
    quoteModel.tabController.value = null;
    quoteModel.processID.value = null;
    quoteModel.Quote_no.value = null;
    // quoteModel.Quote_table_heading.value = '';
    quoteModel.gstNumController.value.clear();

    // DETAILS
    quoteModel.TitleController.value.clear();
    quoteModel.clientAddressNameController.value.clear();
    quoteModel.clientAddressController.value.clear();
    quoteModel.billingAddressNameController.value.clear();
    quoteModel.billingAddressController.value.clear();
    quoteModel.detailsKey.value = GlobalKey<FormState>();

    // PRODUCTS
    quoteModel.Quote_productSuggestion.clear();
    quoteModel.productKey.value = GlobalKey<FormState>();
    quoteModel.product_editIndex.value = null;
    quoteModel.productNameController.value.clear();
    quoteModel.hsnController.value.clear();
    quoteModel.priceController.value.clear();
    quoteModel.quantityController.value.clear();
    quoteModel.gstController.value.clear();
    quoteModel.Quote_products.clear();
    quoteModel.Quote_gstTotals.clear();

    // NOTES
    quoteModel.noteformKey.value = GlobalKey<FormState>();
    quoteModel.progress.value = 0.0;
    quoteModel.isLoading.value = false;
    quoteModel.note_editIndex.value = null;
    quoteModel.notecontentController.value.clear();
    quoteModel.recommendation_editIndex.value = null;
    quoteModel.recommendationHeadingController.value.clear();
    quoteModel.recommendationKeyController.value.clear();
    quoteModel.recommendationValueController.value.clear();
    quoteModel.Quote_noteList.clear();
    quoteModel.Quote_recommendationList.clear();
    quoteModel.notecontent.value = [
      'Delivery within 30 working days from the date of issuing the PO.',
      'Payment terms : 100% along with PO.',
      'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
    ];

    // POST
    quoteModel.pickedFile.value = null;
    quoteModel.selectedPdf.value = null;
    quoteModel.ispdfLoading.value = false;
    quoteModel.whatsapp_selectionStatus.value = true;
    quoteModel.gmail_selectionStatus.value = true;
    quoteModel.phoneController.value.clear();
    quoteModel.emailController.value.clear();
    quoteModel.CCemailController.value.clear();
    quoteModel.feedbackController.value.clear();
    quoteModel.filePathController.value.clear();
    quoteModel.CCemailToggle.value = false;
    quoteModel.isGST_local = true.obs;
  }
}
