import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/DC_actions.dart';
import 'package:ssipl_billing/models/entities/SALES/DC_entities.dart';
import 'package:ssipl_billing/services/SALES/DC_services/DC_Product_services.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';

class DcProducts extends StatefulWidget with DcproductService {
  DcProducts({super.key});

  @override
  State<DcProducts> createState() => _DcProductsState();
}

class _DcProductsState extends State<DcProducts> {
  final DcController dcController = Get.find<DcController>();

  Widget Dc_productDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < dcController.dcModel.Dc_products.length; i++)
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
                              '${i + 1}. ${dcController.dcModel.Dc_products[i].productName}', // Display camera type from map
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                dcController.removeFromProductList(i);
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: dcController.dcModel.productKey.value,
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
                          return

                              // ConstrainedBox(
                              //   constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                              //   child: DropdownButtonFormField<String>(
                              //     isExpanded: true,
                              //     dropdownColor: Primary_colors.Dark,
                              //     decoration: const InputDecoration(
                              //         label: Text(
                              //           'Product',
                              //           style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 177, 176, 176)),
                              //         ),
                              //         // hintText: 'Customer Type',hintStyle: TextStyle(),
                              //         contentPadding: EdgeInsets.all(13),
                              //         labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                              //         filled: true,
                              //         fillColor: Primary_colors.Dark,
                              //         border: OutlineInputBorder(
                              //           borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                              //         ),
                              //         enabledBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                              //         ),
                              //         focusedBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(),
                              //         ),
                              //         prefixIcon: Icon(
                              //           Icons.people,
                              //           color: Colors.white,
                              //         )),
                              //     // value: dcController.dcModel.productNameController.value.text,
                              //     items: dcController.dcModel.Dc_productSuggestion.map((product) {
                              //       return DropdownMenuItem<String>(
                              //         value: product.productName,
                              //         child: Text(
                              //           product.productName,
                              //           style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1, overflow: TextOverflow.ellipsis),
                              //         ),
                              //       );
                              //     }).toList(),
                              //     onChanged: (String? newValue) async {
                              //       // clientreqController.updateCompanyName(newValue!);
                              //       // clientreqController.update_customerID(newValue, null);
                              //       // widget.on_Compselected(context, newValue);
                              //       // setState(() {});
                              //     },
                              //     validator: (value) {
                              //       if (value == null || value.isEmpty) {
                              //         return 'Please Select customer type';
                              //       }
                              //       return null;
                              //     },
                              //   ),
                              // );
                              DropdownMenu<String>(
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
                              style: TextStyle(color: Color.fromARGB(255, 167, 165, 165), fontSize: Primary_font_size.Text7),
                            ),
                            textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: 13),
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
                            controller: dcController.dcModel.productNameController.value,
                            dropdownMenuEntries: dcController.dcModel.Dc_productSuggestion.map<DropdownMenuEntry<String>>((ProductSuggestion suggestion) {
                              return DropdownMenuEntry<String>(
                                value: suggestion.productName, // Assuming ProductSuggestion has a productName field
                                label: suggestion.productName,
                              );
                            }).toList(),
                          );

                          // BasicTextfield(
                          //   digitsOnly: false,
                          //   width: 400,
                          //   readonly: false,
                          //   text: 'Product Name',
                          //   controller: dcController.dcModel.productNameController.value,
                          //   icon: Icons.production_quantity_limits,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please enter Product name';
                          //     }
                          //     return null;
                          //   },
                          // );
                        },
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () {
                          return BasicTextfield(
                            digitsOnly: true,
                            width: 400,
                            readonly: false,
                            text: 'HSN',
                            controller: dcController.dcModel.hsnController.value,
                            icon: Icons.numbers,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter HSN';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 400,
                        child: Obx(
                          () {
                            return TextFormField(
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
                                hintText: 'Product GST',
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
                              controller: dcController.dcModel.gstController.value,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Product GST';
                                }
                                return null;
                              },
                            );
                          },
                        ),
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
                                  Icons.currency_rupee,
                                  color: Colors.white,
                                ),
                              ),
                              controller: dcController.dcModel.priceController.value,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Product price';
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
                                  Icons.production_quantity_limits,
                                  color: Colors.white,
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: dcController.dcModel.quantityController.value,
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
                                text: dcController.dcModel.product_editIndex.value == null ? 'Back' : 'Cancel',
                                onPressed: () {
                                  dcController.dcModel.product_editIndex.value == null ? dcController.backTab() : widget.resetEditingState(); // Reset editing state when going back
                                },
                              ),
                              const SizedBox(width: 30),
                              BasicButton(
                                colors: dcController.dcModel.product_editIndex.value == null ? Colors.blue : Colors.orange,
                                text: dcController.dcModel.product_editIndex.value == null ? 'Add product' : 'Update',
                                onPressed: () {
                                  dcController.dcModel.product_editIndex.value == null ? widget.addproduct(context) : widget.updateproduct(context);
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
                          "The Quotation product details play a crucial role in the procurement process. Please ensure accuracy when entering product names,HSN codes, GST% and quantities, as these details directly impact order processing, inventory management, and subsequent workflows.",
                          style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                        ),
                      )
                    ],
                  ),
                ),
                // if (length != 0) const SizedBox(width: 60),

                Obx(
                  () {
                    return (dcController.dcModel.Dc_products.isNotEmpty)
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
                                              child: Dc_productDetailss(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              if (dcController.dcModel.Dc_products.isNotEmpty)
                                BasicButton(
                                  colors: Colors.green,
                                  text: 'Submit',
                                  onPressed: () {
                                    widget.onSubmit();
                                    dcController.nextTab();
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
