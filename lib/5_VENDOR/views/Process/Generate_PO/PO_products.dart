import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/PO_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/PO_entities.dart';
import 'package:ssipl_billing/5_VENDOR/services/PO_services/PO_Product_services.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class PoProducts extends StatefulWidget with PoproductService {
  PoProducts({super.key});

  @override
  State<PoProducts> createState() => _PoProductsState();
}

class _PoProductsState extends State<PoProducts> {
  final vendor_PoController poController = Get.find<vendor_PoController>();

  Widget Po_productDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < poController.poModel.Po_products.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.editproduct(i);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
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
                                '${i + 1}. ${poController.poModel.Po_products[i].productName}', // Display camera type from map
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  poController.removeFromProductList(i);
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
              ),
              const SizedBox(height: 15),
            ],
          ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.get_ProductsSuggestion(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: poController.poModel.productKey.value,
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
                          return DropdownMenu<VendorProduct_suggestions>(
                            menuHeight: 350,
                            leadingIcon: const Icon(
                              Icons.production_quantity_limits,
                              color: Colors.white,
                            ),
                            trailingIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 122, 121, 121),
                            ),
                            label: const Text(
                              "Product",
                              style: TextStyle(
                                color: Color.fromARGB(255, 167, 165, 165),
                                fontSize: Primary_font_size.Text7,
                              ),
                            ),
                            textStyle: const TextStyle(
                              color: Primary_colors.Color1,
                              fontSize: Primary_font_size.Text7,
                            ),
                            width: 400,
                            inputDecorationTheme: const InputDecorationTheme(
                              contentPadding: EdgeInsets.only(left: 10, right: 5),
                              filled: true,
                              fillColor: Primary_colors.Dark,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 167, 165, 165),
                              ),
                            ),
                            controller: poController.poModel.productNameController.value,
                            dropdownMenuEntries: poController.poModel.VendorProduct_sugestions.map<DropdownMenuEntry<VendorProduct_suggestions>>((suggestion) {
                              return DropdownMenuEntry<VendorProduct_suggestions>(
                                value: suggestion,
                                label: suggestion.productName,
                              );
                            }).toList(),
                            onSelected: (VendorProduct_suggestions? selectedSuggestion) {
                              // if (selectedSuggestion != null) {
                              //   poController.set_ProductValues(selectedSuggestion);
                              // }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () {
                          return SizedBox(
                            width: 400,
                            child: TextFormField(
                              readOnly: false,
                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                // labelText: text,
                                hintText: 'Product HSN',
                                hintStyle: TextStyle(
                                  fontSize: Primary_font_size.Text7,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.numbers,
                                  color: Colors.white,
                                ),
                              ),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              controller: poController.poModel.hsnController.value,
                              keyboardType: TextInputType.number,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Product HSN';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () {
                          return SizedBox(
                            width: 400,
                            child: TextFormField(
                              readOnly: false,
                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                // labelText: text,
                                hintText: 'Product Price',
                                hintStyle: TextStyle(
                                  fontSize: Primary_font_size.Text7,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.price_change,
                                  color: Colors.white,
                                ),
                              ),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              controller: poController.poModel.priceController.value,
                              keyboardType: TextInputType.number,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Product Price';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () {
                          return SizedBox(
                            width: 400,
                            child: TextFormField(
                              readOnly: false,
                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                // labelText: text,
                                hintText: 'Product Quantity',
                                hintStyle: TextStyle(
                                  fontSize: Primary_font_size.Text7,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.production_quantity_limits_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              controller: poController.poModel.quantityController.value,
                              keyboardType: TextInputType.number,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Product Quantity';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      Obx(
                        () {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BasicButton(
                                colors: Colors.red,
                                text: poController.poModel.product_editIndex.value == null ? 'Back' : 'Cancel',
                                onPressed: () {
                                  poController.poModel.product_editIndex.value == null ? poController.backTab() : widget.resetEditingState(); // Reset editing state when going back
                                },
                              ),
                              const SizedBox(width: 30),
                              BasicButton(
                                colors: poController.poModel.product_editIndex.value == null ? Colors.blue : Colors.orange,
                                text: poController.poModel.product_editIndex.value == null ? 'Add product' : 'Update',
                                onPressed: () {
                                  poController.poModel.product_editIndex.value == null ? widget.addproduct(context) : widget.updateproduct(context);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        // width: 750,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Product details in PO play a crucial role in the procurement process. Please ensure accuracy when entering product names and quantities, as these details directly impact order processing, inventory management, and subsequent workflows.",
                          style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                        ),
                      )
                    ],
                  ),
                ),
                // if (length != 0) const SizedBox(width: 60),

                Obx(
                  () {
                    return (poController.poModel.Po_products.isNotEmpty)
                        ? Expanded(
                            child: Column(
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
                                              child: Po_productDetailss(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              if (poController.poModel.Po_products.isNotEmpty)
                                BasicButton(
                                  colors: Colors.green,
                                  text: 'Submit',
                                  onPressed: () {
                                    // widget.onSubmit();
                                    poController.nextTab();
                                  },
                                ),
                            ],
                          ))
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
