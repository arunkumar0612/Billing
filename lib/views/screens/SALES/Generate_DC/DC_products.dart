import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/services/SALES/DC_services/DCproduct_services.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';

import '../../../../controllers/SALEScontrollers/DC_actions.dart';

class Delivery_challanProducts extends StatefulWidget with DcproductService {
  Delivery_challanProducts({super.key});

  @override
  State<Delivery_challanProducts> createState() => _Delivery_challanProductsState();
}

class _Delivery_challanProductsState extends State<Delivery_challanProducts> {
  final DCController dcController = Get.find<DCController>();

  Widget Delivery_challan_productDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < dcController.dcModel.Delivery_challan_products.length; i++)
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
                              '${i + 1}. ${dcController.dcModel.Delivery_challan_products[i].productName}', // Display camera type from map
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
                Column(
                  children: [
                    const SizedBox(height: 25),
                    Obx(
                      () {
                        return Textfield_1(
                          readonly: false,
                          text: 'Product Name',
                          controller: dcController.dcModel.productNameController.value,
                          icon: Icons.production_quantity_limits,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Product name';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    Obx(
                      () {
                        return Textfield_1(
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
                            Button1(
                              colors: Colors.red,
                              text: dcController.dcModel.product_editIndex.value == null ? 'Back' : 'Cancel',
                              onPressed: () {
                                dcController.dcModel.product_editIndex.value == null ? dcController.backTab() : widget.resetEditingState(); // Reset editing state when going back
                              },
                            ),
                            const SizedBox(width: 30),
                            Button1(
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
                  ],
                ),
                // if (length != 0) const SizedBox(width: 60),
                Obx(
                  () {
                    return (dcController.dcModel.Delivery_challan_products.isNotEmpty)
                        ? Column(
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
                                              child: Delivery_challan_productDetailss(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              if (dcController.dcModel.Delivery_challan_products.isNotEmpty)
                                Button1(
                                  colors: Colors.green,
                                  text: 'Submit',
                                  onPressed: () {
                                    dcController.nextTab();
                                  },
                                ),
                            ],
                          )
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
