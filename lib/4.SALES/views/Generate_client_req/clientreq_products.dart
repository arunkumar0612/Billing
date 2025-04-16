import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4.SALES/models/entities/Sales_entities.dart';
import 'package:ssipl_billing/4.SALES/services/ClientReq_services/ClientreqProduct_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES-/style.dart';

import '../../controllers/ClientReq_actions.dart';

class clientreqProducts extends StatefulWidget with ClientreqProductService {
  clientreqProducts({super.key});

  @override
  State<clientreqProducts> createState() => _clientreqProductsState();
}

class _clientreqProductsState extends State<clientreqProducts> {
  final ClientreqController clientreqController = Get.find<ClientreqController>();

  Widget clientreq_productDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < clientreqController.clientReqModel.clientReqProductDetails.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.editproduct(i);
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Primary_colors.Light),
                  height: 40,
                  width: 300,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 230,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              '${i + 1}. ${clientreqController.clientReqModel.clientReqProductDetails[i].productName}', // Display camera type from map
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                clientreqController.removeFromProductList(i);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: clientreqController.clientReqModel.productFormkey.value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          Obx(
                            () {
                              return DropdownMenu<ProductSuggestion>(
                                leadingIcon: const Icon(Icons.production_quantity_limits_rounded, color: Primary_colors.Color1),
                                menuHeight: 350,
                                trailingIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color.fromARGB(255, 122, 121, 121),
                                ),
                                label: const Text(
                                  "Product",
                                  style: TextStyle(color: Color.fromARGB(255, 167, 165, 165), fontSize: Primary_font_size.Text7),
                                ),
                                textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                width: 400,
                                inputDecorationTheme: const InputDecorationTheme(
                                  contentPadding: EdgeInsets.only(left: 10, right: 5),
                                  filled: true,
                                  fillColor: Primary_colors.Dark,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 167, 165, 165),
                                  ),
                                ),
                                controller: clientreqController.clientReqModel.productNameController.value,
                                dropdownMenuEntries: clientreqController.clientReqModel.clientReq_productSuggestion.map<DropdownMenuEntry<ProductSuggestion>>((ProductSuggestion suggestion) {
                                  return DropdownMenuEntry<ProductSuggestion>(
                                    value: suggestion, // Passing the entire object
                                    label: suggestion.productName, // Display product name in dropdown
                                  );
                                }).toList(),
                                onSelected: (ProductSuggestion? selectedSuggestion) {
                                  // if (selectedSuggestion != null) {
                                  //   widget.set_ProductValues(selectedSuggestion);
                                  // }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 25),
                          BasicTextfield(
                            digitsOnly: true,
                            width: 400,
                            readonly: false,
                            text: 'Product Quantity',
                            controller: clientreqController.clientReqModel.quantityController.value,
                            icon: Icons.production_quantity_limits_sharp,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Product Quantity';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BasicButton(
                                colors: Colors.red,
                                text: clientreqController.clientReqModel.product_editIndex.value == null ? 'Back' : 'Cancle',
                                onPressed: () {
                                  clientreqController.clientReqModel.product_editIndex.value == null
                                      ? clientreqController.backTab()
                                      : widget.resetEditingState(); // Reset editing state when going back
                                },
                              ),
                              const SizedBox(width: 30),
                              BasicButton(
                                colors: clientreqController.clientReqModel.product_editIndex.value == null ? Colors.blue : Colors.orange,
                                text: clientreqController.clientReqModel.product_editIndex.value == null ? 'Add product' : 'Update',
                                onPressed: () {
                                  clientreqController.clientReqModel.product_editIndex.value == null ? widget.addproduct(context) : widget.updateproduct(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 85),
                          const SizedBox(
                            // width: 750,
                            child: Text(
                              textAlign: TextAlign.center,
                              "The client requirement product details play a crucial role in the procurement process. Please ensure accuracy when entering product names and quantities, as these details directly impact order processing, inventory management, and subsequent workflows.",
                              style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                            ),
                          )
                        ],
                      ),
                    ),
                    // if (length != 0) const SizedBox(width: 60),
                    if (clientreqController.clientReqModel.clientReqProductDetails.isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 25),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Primary_colors.Dark,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10, top: 15),
                              child: Column(
                                children: [
                                  const Text(
                                    'Product List',
                                    style: TextStyle(fontSize: Primary_font_size.Text10, color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 295,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: clientreq_productDetailss(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          if (clientreqController.clientReqModel.clientReqProductDetails.isNotEmpty)
                            BasicButton(
                              colors: Colors.green,
                              text: 'Submit',
                              onPressed: () {
                                clientreqController.nextTab();
                              },
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
