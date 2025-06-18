import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4.SALES/models/constants/DC_constants.dart';
import 'package:ssipl_billing/4.SALES/models/entities/DC_entities.dart';
import 'package:ssipl_billing/4.SALES/models/entities/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class DcController extends GetxController {
  var dcModel = DcModel();

  /// Initializes the TabController for delivery challan tabs.
  void initializeTabController(TabController tabController) {
    dcModel.tabController.value = tabController;
  }

  /// Navigates to the next tab if available.
  void nextTab() {
    if (dcModel.tabController.value!.index < dcModel.tabController.value!.length - 1) {
      dcModel.tabController.value!.animateTo(dcModel.tabController.value!.index + 1);
    }
  }

  /// Navigates to the previous tab if not at the first tab.
  void backTab() {
    if (dcModel.tabController.value!.index > 0) {
      dcModel.tabController.value!.animateTo(dcModel.tabController.value!.index - 1);
    }
  }

  /// Removes a product from the delivery challan product list.
  void removeFromProductList(index) {
    dcModel.Dc_products.removeAt(index);
  }

  /// Updates the edit index for notes in delivery challan.
  void updateNoteEditindex(int? index) {
    dcModel.note_editIndex.value = index;
  }

  /// Updates the heading of the challan table.
  void updateChallanTableHeading(String tableHeading) {
    dcModel.Dc_table_heading.value = tableHeading;
  }

  /// Updates a note in the note list at the edit index.
  void updateNoteList(String value, int index) {
    dcModel.Dc_noteList[dcModel.note_editIndex.value!] = dcModel.notecontentController.value.text;
  }

  /// Updates the TabController for delivery challan (duplicate of initialize).
  void updateTabController(TabController tabController) {
    dcModel.tabController.value = tabController;
  }

  /// Updates the title text field for the delivery challan.
  void updateTitle(String text) {
    dcModel.TitleController.value.text = text;
  }

  /// Updates the delivery challan number.
  void updateDcnumber(String text) {
    dcModel.Dc_no.value = text;
  }

  /// Updates the invoice reference number.
  void update_invoiceRef_number(String text) {
    dcModel.invRef_no.value = text;
  }

  /// Updates the GST number field.
  void updateGSTnumber(String text) {
    dcModel.gstNumController.value.text = text;
  }

  /// Updates the client's address name field.
  void updateClientAddressName(String text) {
    dcModel.clientAddressNameController.value.text = text;
  }

  /// Updates the client's full address field.
  void updateClientAddress(String text) {
    dcModel.clientAddressController.value.text = text;
  }

  /// Updates the billing address name field.
  void updateBillingAddressName(String text) {
    dcModel.billingAddressNameController.value.text = text;
  }

  /// Updates the billing address field.
  void updateBillingAddress(String text) {
    dcModel.billingAddressController.value.text = text;
  }

  /// Updates the client's phone number.
  void updatePhone(String phone) {
    dcModel.phoneController.value.text = phone;
  }

  /// Updates the client's email address.
  void updateEmail(String email) {
    dcModel.emailController.value.text = email;
  }

  /// Updates the CC (carbon copy) email field.
  void updatCC(String CC) {
    dcModel.CCemailController.value.text = CC;
  }

  /// Toggles the visibility of the CC email input field.
  void toggleCCemailvisibility(bool value) {
    dcModel.CCemailToggle.value = value;
  }

  /// Updates the edit index for a recommendation entry.
  void updateRecommendationEditindex(int? index) {
    dcModel.recommendation_editIndex.value = index;
  }

  /// Updates the text in the note content controller.
  void updateNoteContentControllerText(String text) {
    dcModel.notecontentController.value.text = text;
  }

  /// Updates the recommendation heading controller text.
  void updateRec_HeadingControllerText(String text) {
    dcModel.recommendationHeadingController.value.text = text;
  }

  /// Updates the recommendation key controller text.
  void updateRec_KeyControllerText(String text) {
    dcModel.recommendationKeyController.value.text = text;
  }

  /// Updates the recommendation value controller text.
  void updateRec_ValueControllerText(String text) {
    dcModel.recommendationValueController.value.text = text;
  }

  /// Adds a note to the note suggestion list.
  void addNoteToList(String note) {
    dcModel.noteSuggestion.add(note);
  }

  // void addProductEditindex(int? index) {
  //   dcModel.product_editIndex.value = index;
  // }

  /// Sets the process ID for the delivery challan.
  void setProcessID(int processid) {
    dcModel.processID.value = processid;
  }

  /// Updates the selected PDF file.
  void updateSelectedPdf(File file) {
    dcModel.selectedPdf.value = file;
  }

  /// Toggles the loading state.
  void setLoading(bool value) {
    dcModel.isLoading.value = value;
  }

  /// Toggles the PDF-specific loading state.
  void setpdfLoading(bool value) {
    dcModel.ispdfLoading.value = value;
  }

  /// Toggles WhatsApp selection status.
  void toggleWhatsApp(bool value) {
    dcModel.whatsapp_selectionStatus.value = value;
  }

  /// Toggles Gmail selection status.
  void toggleGmail(bool value) {
    dcModel.gmail_selectionStatus.value = value;
  }

  /// Toggles the "Select All" status for products.
  void togglProduct_selectAll(bool value) {
    dcModel.selectall_status.value = value;
  }

  /// Toggles the selection of a specific product by index.
  void toggleProduct_selection(bool value, int index) {
    dcModel.checkboxValues[index] = value;
  }

  /// Applies the "Select All" state to all product checkboxes.
  void refactorSelection() {
    for (int i = 0; i < dcModel.checkboxValues.length; i++) {
      if (dcModel.selectall_status.value) {
        dcModel.checkboxValues[i] = true;
      } else {
        dcModel.checkboxValues[i] = false;
      }
    }
  }

  /// Updates the phone number text field.
  void updatePhoneNumber(String phoneNumber) {
    dcModel.phoneController.value.text = phoneNumber;
  }

  /// Updates the feedback text field.
  void updateFeedback(String feedback) {
    dcModel.feedbackController.value.text = feedback;
  }

  /// Updates the file path text field.
  void updateFilePath(String filePath) {
    dcModel.filePathController.value.text = filePath;
  }

  /// Updates the total DC (Delivery Challan) amount.
  void update_dcAmount(double amount) {
    dcModel.dc_amount.value = amount;
  }

  /// Opens file picker and handles file selection and size validation.
  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'], lockParentWindow: true);

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
        dcModel.pickedFile.value = null;
        dcModel.selectedPdf.value = null;
      } else {
        dcModel.pickedFile.value = result;
        dcModel.selectedPdf.value = file;

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  /// Returns message type code based on selected communication methods.
  int fetch_messageType() {
    if (dcModel.whatsapp_selectionStatus.value && dcModel.gmail_selectionStatus.value) return 3;
    if (dcModel.whatsapp_selectionStatus.value) return 2;
    if (dcModel.gmail_selectionStatus.value) return 1;

    return 0;
  }

  /// Simulates and updates a progress bar from 0 to 100%.
  Future<void> startProgress() async {
    setLoading(true);
    dcModel.progress.value = 0.0;

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      dcModel.progress.value = i / 100; // Convert to percentage
    }

    setLoading(false);
  }

  /// Adds a recommendation entry with key-value pair if both are non-empty.
  void addRecommendation({required String key, required String value}) {
    if (key.isNotEmpty && value.isNotEmpty) {
      dcModel.Dc_recommendationList.add(Recommendation(key: key, value: value));
    } else {
      if (kDebugMode) {
        print('Key and value must not be empty');
      }
    }
  }

  /// Updates an existing recommendation at a given index.
  void updateRecommendation({
    required int index,
    required String key,
    required String value,
  }) {
    if (index >= 0 && index < dcModel.Dc_recommendationList.length) {
      if (key.isNotEmpty && value.isNotEmpty) {
        dcModel.Dc_recommendationList[index] = Recommendation(key: key, value: value);
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

  /// Adds a note to the list if not empty.
  void addNote(String noteContent) {
    if (noteContent.isNotEmpty) {
      dcModel.Dc_noteList.add(noteContent);
    } else {
      if (kDebugMode) {
        print('Note content must not be empty');
      } // Handle empty input (optional)
    }
  }

  // void updateProduct({
  //   required BuildContext context,
  //   required int editIndex,
  //   required String productName,
  //   required String hsn,
  //   required double price,
  //   required int quantity,
  //   required double gst,
  // }) {
  //   try {
  //     // Validate input fields
  //     if (productName.trim().isEmpty || hsn.trim().isEmpty || price <= 0 || quantity <= 0 || gst < 0) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text('Please provide valid product details.'),
  //         ),
  //       );
  //       return;
  //     }

  //     // Check if the editIndex is valid
  //     if (editIndex < 0 || editIndex >= dcModel.Dc_products.length) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text('Invalid product index.'),
  //         ),
  //       );
  //       return;
  //     }

  //     // Update the product details at the specified index
  //     dcModel.Dc_products[editIndex] = DcProduct(sno: (editIndex + 1), productName: productName, hsn: int.parse(hsn), gst: gst, price: price, quantity: quantity, productid: 0);

  //     // ProductDetail(
  //     //   productName: productName.trim(),
  //     //   hsn: hsn.trim(),
  //     //   price: price,
  //     //   quantity: quantity,
  //     //   gst: gst,
  //     // );

  //     // Notify success
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   const SnackBar(
  //     //     backgroundColor: Colors.green,
  //     //     content: Text('Product updated successfully.'),
  //     //   ),
  //     // );

  //     // Optional: Update UI or state if needed
  //     // .updateProductDetails(dcController.dcModel.Dc_productDetails);
  //   } catch (e) {
  //     // Handle unexpected errors
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text('An error occurred while updating the product.'),
  //       ),
  //     );
  //   }
  // }

  /// Adds a list of note suggestions from the given map.
  void add_noteSuggestion(Map<String, dynamic> suggestionList) {
    for (var item in suggestionList['notes']) {
      dcModel.noteSuggestion.add(item);
      if (kDebugMode) {
        print(dcModel.noteSuggestion[0]);
      }
    }
  }

  /// Removes a note at the specified index and resets the edit index.
  void removeFromNoteList(int index) {
    dcModel.Dc_noteList.removeAt(index);
    dcModel.note_editIndex.value = null;
  }

  /// Removes a recommendation at the given index and resets the edit index.
  void removeFromRecommendationList(int index) {
    dcModel.Dc_recommendationList.removeAt(index);
    // dcModel.Dc_recommendationList.isEmpty ? dcModel.recommendationHeadingController.value.clear() : null;
    dcModel.recommendation_editIndex.value = null;
  }

  /// Initializes text controllers with quantity values from product list.
  void initializeTextControllers() {
    dcModel.textControllers.clear();
    for (int i = 0; i < dcModel.Dc_products.length; i++) {
      DcProduct product = dcModel.Dc_products[i];
      dcModel.textControllers.add(TextEditingController(text: product.quantity.toString()));
    }
  }

  /// Initializes observable quantity values from the product list.
  void initializeQuantities(List<DcProduct> productList) {
    dcModel.quantities.assignAll(productList.map((product) => product.quantity.obs).toList());
  }

  /// Initializes focus nodes and sets up listeners for focus changes.
  void initializeFocusNodes(int count) {
    dcModel.focusNodes.assignAll(List.generate(count, (_) => FocusNode().obs));
    dcModel.isFocused.assignAll(List.generate(count, (_) => false));

    for (int i = 0; i < count; i++) {
      dcModel.focusNodes[i].value.addListener(() {
        dcModel.isFocused[i] = dcModel.focusNodes[i].value.hasFocus;
      });
    }
  }

  /// Increments the quantity of a product at the given index within the max limit.
  void incrementQTY(int index, int maxValue) {
    if (dcModel.quantities[index].value < maxValue) {
      dcModel.quantities[index].value++;
      dcModel.textControllers[index].text = dcModel.quantities[index].value.toString();
    }
  }

  /// Decrements the quantity of a product at the given index with a minimum of 1.
  void decrementQTY(int index) {
    if (dcModel.quantities[index].value > 1) {
      dcModel.quantities[index].value--;
      dcModel.textControllers[index].text = dcModel.quantities[index].value.toString();
    }
  }

  /// Updates the product list and resets checkbox selection states.
  void updateProducts(List<DcProduct> products) {
    dcModel.Dc_products.value = products;
    dcModel.checkboxValues.clear();
    for (int i = 0; i < products.length; i++) {
      dcModel.checkboxValues.add(false);
    }
  }

  /// Validates and sets the quantity value for a product at the given index.
  void setQtyvalue(String value, String maxQty, int index) {
    // if (value.isEmpty) value=0; // Prevent processing empty values

    int convertedValue = int.tryParse(value) ?? 1;
    int convertedMaxQty = int.tryParse(maxQty) ?? 1;
    int minQty = 1;

    if (convertedValue >= convertedMaxQty) {
      convertedValue = convertedMaxQty;
    } else if (convertedValue <= minQty) {
      convertedValue = minQty;
    }

    // Preserve Cursor Position
    TextEditingController controller = dcModel.textControllers[index];
    // int cursorPosition = controller.selection.baseOffset; // Get current cursor position

    controller.text = convertedValue.toString();

    // Restore Cursor Position
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    dcModel.quantities[index].value = convertedValue;
  }

  /// Populates delivery challan model from API response data.
  void update_requiredData(CMDmResponse value) {
    RequiredData instance = RequiredData.fromJson(value);
    dcModel.Dc_no.value = instance.eventnumber;
    updateProducts(instance.product);
    update_invoiceRef_number(instance.invoice_num);
    update_invoiceRef_number(instance.invoice_num);
    updateTitle(instance.title!);
    updateEmail(instance.emailId!);
    updateGSTnumber(instance.gst!);
    updatePhone(instance.phoneNo!);
    updateClientAddressName(instance.name!);
    updateClientAddress(instance.address!);
    updateBillingAddressName(instance.billingAddressName!);
    updateBillingAddress(instance.billingAddress!);
    initializeTextControllers();
    initializeQuantities(instance.product);
    initializeFocusNodes(instance.product.length);
    // for(int i=0;i<instance.product.length;i++){
    //    dcController.addProduct(context: context, productName: dcController.dcModel.productNameController.value.text, hsn: dcController.dcModel.hsnController.value.text, price: double.parse(dcController.dcModel.priceController.value.text), quantity: int.parse(dcController.dcModel.quantityController.value.text), gst: double.parse(dcController.dcModel.gstController.value.text));

    // }
  }

  /// Validates required fields before generating delivery challan draft.
  bool generate_Datavalidation() {
    return (dcModel.TitleController.value.text.isEmpty ||
        dcModel.processID.value == null ||
        dcModel.clientAddressNameController.value.text.isEmpty ||
        dcModel.clientAddressController.value.text.isEmpty ||
        dcModel.billingAddressNameController.value.text.isEmpty ||
        dcModel.billingAddressController.value.text.isEmpty ||
        dcModel.gstNumController.value.text.isEmpty ||
        dcModel.selected_dcProducts.isEmpty ||
        dcModel.Dc_noteList.isEmpty ||
        dcModel.Dc_no.value == null);
  }

  /// Validates data before submitting delivery challan with communication preferences.
  bool postDatavalidation() {
    return (dcModel.TitleController.value.text.isEmpty ||
        dcModel.processID.value == null ||
        dcModel.clientAddressNameController.value.text.isEmpty ||
        dcModel.clientAddressController.value.text.isEmpty ||
        dcModel.billingAddressNameController.value.text.isEmpty ||
        dcModel.billingAddressController.value.text.isEmpty ||
        (dcModel.gmail_selectionStatus.value && dcModel.emailController.value.text.isEmpty) ||
        (dcModel.whatsapp_selectionStatus.value && dcModel.phoneController.value.text.isEmpty) ||
        dcModel.gstNumController.value.text.isEmpty ||
        dcModel.selected_dcProducts.isEmpty ||
        dcModel.Dc_noteList.isEmpty ||
        dcModel.Dc_no.value == null);
  }
// If any one is empty or null, then it returns true

  // void resetData() {
  //   dcModel.tabController.value = null;
  //   dcModel.processID.value = null;
  //   dcModel.Dc_no.value = null;
  //   dcModel.Dc_table_heading.value = "";

  //   dcModel.gstNumController.value.clear();
  //   dcModel.dc_amount.value = null;

  //   // Reset details
  //   dcModel.TitleController.value.clear();
  //   dcModel.clientAddressNameController.value.clear();
  //   dcModel.clientAddressController.value.clear();
  //   dcModel.billingAddressNameController.value.clear();
  //   dcModel.billingAddressController.value.clear();
  //   dcModel.detailsKey.value = GlobalKey<FormState>();

  //   // Reset products
  //   dcModel.Dc_products.clear();
  //   dcModel.selected_dcProducts.clear();
  //   dcModel.Dc_gstTotals.clear();
  //   dcModel.checkboxValues.clear();
  //   dcModel.selectall_status.value = false;
  //   dcModel.product_feedback.value = "";
  //   dcModel.productNameController.value.clear();
  //   dcModel.textControllers.clear();
  //   dcModel.quantities.clear();
  //   dcModel.focusNodes.clear();
  //   dcModel.isFocused.clear();

  //   // Reset notes
  //   dcModel.noteformKey.value = GlobalKey<FormState>();
  //   dcModel.progress.value = 0.0;
  //   dcModel.isLoading.value = false;
  //   dcModel.note_editIndex.value = null;
  //   dcModel.notecontentController.value.clear();
  //   dcModel.recommendation_editIndex.value = null;
  //   dcModel.recommendationHeadingController.value.clear();
  //   dcModel.recommendationKeyController.value.clear();
  //   dcModel.recommendationValueController.value.clear();
  //   dcModel.Dc_noteList.clear();
  //   dcModel.Dc_recommendationList.clear();
  //   dcModel.noteSuggestion.clear();

  //   // Reset post-related data
  //   dcModel.pickedFile.value = null;
  //   dcModel.selectedPdf.value = null;
  //   dcModel.ispdfLoading.value = false;
  //   dcModel.whatsapp_selectionStatus.value = true;
  //   dcModel.gmail_selectionStatus.value = true;
  //   dcModel.phoneController.value.clear();
  //   dcModel.emailController.value.clear();
  //   dcModel.CCemailController.value.clear();
  //   dcModel.feedbackController.value.clear();
  //   dcModel.filePathController.value.clear();
  //   dcModel.CCemailToggle.value = false;
  // }

  void resetData() {
    // TAB, PROCESS & GENERAL
    dcModel.tabController.value = null;
    dcModel.processID.value = null;
    dcModel.Dc_no.value = null;
    dcModel.Dc_table_heading.value = '';
    dcModel.gstNumController.value.clear();
    dcModel.dc_amount.value = null;

    // DETAILS
    dcModel.TitleController.value.clear();
    dcModel.clientAddressNameController.value.clear();
    dcModel.clientAddressController.value.clear();
    dcModel.billingAddressNameController.value.clear();
    dcModel.billingAddressController.value.clear();
    dcModel.detailsKey.value = GlobalKey<FormState>();

    // PRODUCTS
    dcModel.Dc_products.clear();
    dcModel.selected_dcProducts.clear();
    dcModel.pending_dcProducts.clear();
    dcModel.Dc_gstTotals.clear();
    dcModel.checkboxValues.clear();
    dcModel.selectall_status.value = false;
    dcModel.product_feedback.value = '';
    dcModel.productNameController.value.clear();

    for (var controller in dcModel.textControllers) {
      controller.clear();
    }
    dcModel.textControllers.clear();

    dcModel.quantities.clear();

    for (var node in dcModel.focusNodes) {
      node.value.dispose();
    }
    dcModel.focusNodes.clear();
    dcModel.isFocused.clear();

    // NOTES
    dcModel.noteformKey.value = GlobalKey<FormState>();
    dcModel.progress.value = 0.0;
    dcModel.isLoading.value = false;
    dcModel.note_editIndex.value = null;
    dcModel.notecontentController.value.clear();
    dcModel.recommendation_editIndex.value = null;
    dcModel.recommendationHeadingController.value.clear();
    dcModel.recommendationKeyController.value.clear();
    dcModel.recommendationValueController.value.clear();
    dcModel.Dc_noteList.clear();
    dcModel.Dc_recommendationList.clear();
    dcModel.noteSuggestion.clear();

    // POST
    dcModel.pickedFile.value = null;
    dcModel.selectedPdf.value = null;
    dcModel.ispdfLoading.value = false;
    dcModel.whatsapp_selectionStatus.value = true;
    dcModel.gmail_selectionStatus.value = true;
    dcModel.phoneController.value.clear();
    dcModel.emailController.value.clear();
    dcModel.CCemailController.value.clear();
    dcModel.feedbackController.value.clear();
    dcModel.filePathController.value.clear();
    dcModel.CCemailToggle.value = false;
  }
}
