import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/SALES/Invoice_entities.dart';
import 'package:ssipl_billing/services/SALES/Invoice_services/InvoiceProduct_services.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/SALEScontrollers/Invoice_actions.dart';

class InvoiceProducts extends StatefulWidget with InvoiceproductService {
  InvoiceProducts({super.key});

  @override
  State<InvoiceProducts> createState() => _InvoiceProductsState();
}

class _InvoiceProductsState extends State<InvoiceProducts> {
  final InvoiceController invoiceController = Get.find<InvoiceController>();

  Widget Invoice_productDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < invoiceController.invoiceModel.Invoice_products.length; i++)
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
                              '${i + 1}. ${invoiceController.invoiceModel.Invoice_products[i].productName}', // Display camera type from map
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                invoiceController.removeFromProductList(i);
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
            key: invoiceController.invoiceModel.productKey.value,
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
                              //     // value: invoiceController.invoiceModel.productNameController.value.text,
                              //     items: invoiceController.invoiceModel.Invoice_productSuggestion.map((product) {
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
                              DropdownMenu<ProductSuggestion>(
                            trailingIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 122, 121, 121),
                            ),
                            label: const Text(
                              "Product",
                              style: TextStyle(color: Color.fromARGB(255, 167, 165, 165), fontSize: Primary_font_size.Text7),
                            ),
                            textStyle: const TextStyle(color: Primary_colors.Color1),
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
                            controller: invoiceController.invoiceModel.productNameController.value,
                            dropdownMenuEntries: invoiceController.invoiceModel.Invoice_productSuggestion.map<DropdownMenuEntry<ProductSuggestion>>((ProductSuggestion suggestion) {
                              return DropdownMenuEntry<ProductSuggestion>(
                                value: suggestion, // Passing the entire object
                                label: suggestion.productName, // Display product name in dropdown
                              );
                            }).toList(),
                            onSelected: (ProductSuggestion? selectedSuggestion) {
                              if (selectedSuggestion != null) {
                                widget.set_ProductValues(selectedSuggestion);
                              }
                            },
                          );

                          // BasicTextfield(
                          //   digitsOnly: false,
                          //   width: 400,
                          //   readonly: false,
                          //   text: 'Product Name',
                          //   controller: invoiceController.invoiceModel.productNameController.value,
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
                            controller: invoiceController.invoiceModel.hsnController.value,
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
                              controller: invoiceController.invoiceModel.gstController.value,
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
                              controller: invoiceController.invoiceModel.priceController.value,
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
                              controller: invoiceController.invoiceModel.quantityController.value,
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
                                text: invoiceController.invoiceModel.product_editIndex.value == null ? 'Back' : 'Cancel',
                                onPressed: () {
                                  invoiceController.invoiceModel.product_editIndex.value == null ? invoiceController.backTab() : widget.resetEditingState(); // Reset editing state when going back
                                },
                              ),
                              const SizedBox(width: 30),
                              BasicButton(
                                colors: invoiceController.invoiceModel.product_editIndex.value == null ? Colors.blue : Colors.orange,
                                text: invoiceController.invoiceModel.product_editIndex.value == null ? 'Add product' : 'Update',
                                onPressed: () {
                                  invoiceController.invoiceModel.product_editIndex.value == null ? widget.addproduct(context) : widget.updateproduct(context);
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
                    return (invoiceController.invoiceModel.Invoice_products.isNotEmpty)
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
                                              child: Invoice_productDetailss(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              if (invoiceController.invoiceModel.Invoice_products.isNotEmpty)
                                BasicButton(
                                  colors: Colors.green,
                                  text: 'Submit',
                                  onPressed: () {
                                    widget.onSubmit();
                                    invoiceController.nextTab();
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
