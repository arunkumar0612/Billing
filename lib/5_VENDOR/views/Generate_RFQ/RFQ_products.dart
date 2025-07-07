import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/RFQ_entities.dart';
import 'package:ssipl_billing/5_VENDOR/services/RFQ_services/RFQ_Product_services.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class RfqProducts extends StatefulWidget with RfqproductService {
  RfqProducts({super.key});

  @override
  State<RfqProducts> createState() => _RfqProductsState();
}

class _RfqProductsState extends State<RfqProducts> {
  final vendor_RfqController rfqController = Get.find<vendor_RfqController>();

  Widget Rfq_productDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < rfqController.rfqModel.Rfq_products.length; i++)
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
                                '${i + 1}. ${rfqController.rfqModel.Rfq_products[i].productName}', // Display camera type from map
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  rfqController.removeFromProductList(i);
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
            key: rfqController.rfqModel.productKey.value,
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
                            controller: rfqController.rfqModel.productNameController.value,
                            dropdownMenuEntries: rfqController.rfqModel.VendorProduct_sugestions.map<DropdownMenuEntry<VendorProduct_suggestions>>((suggestion) {
                              return DropdownMenuEntry<VendorProduct_suggestions>(
                                value: suggestion,
                                label: suggestion.productName,
                              );
                            }).toList(),
                            onSelected: (VendorProduct_suggestions? selectedSuggestion) {
                              // if (selectedSuggestion != null) {
                              //   rfqController.set_ProductValues(selectedSuggestion);
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              controller: rfqController.rfqModel.quantityController.value,
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
                                text: rfqController.rfqModel.product_editIndex.value == null ? 'Back' : 'Cancel',
                                onPressed: () {
                                  rfqController.rfqModel.product_editIndex.value == null ? rfqController.backTab() : widget.resetEditingState(); // Reset editing state when going back
                                },
                              ),
                              const SizedBox(width: 30),
                              BasicButton(
                                colors: rfqController.rfqModel.product_editIndex.value == null ? Colors.blue : Colors.orange,
                                text: rfqController.rfqModel.product_editIndex.value == null ? 'Add product' : 'Update',
                                onPressed: () {
                                  rfqController.rfqModel.product_editIndex.value == null ? widget.addproduct(context) : widget.updateproduct(context);
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
                          "Product details in RFQ play a crucial role in the procurement process. Please ensure accuracy when entering product names and quantities, as these details directly impact order processing, inventory management, and subsequent workflows.",
                          style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                        ),
                      )
                    ],
                  ),
                ),
                // if (length != 0) const SizedBox(width: 60),

                Obx(
                  () {
                    return (rfqController.rfqModel.Rfq_products.isNotEmpty)
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
                                              child: Rfq_productDetailss(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              if (rfqController.rfqModel.Rfq_products.isNotEmpty)
                                BasicButton(
                                  colors: Colors.green,
                                  text: 'Submit',
                                  onPressed: () {
                                    // widget.onSubmit();
                                    rfqController.nextTab();
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
