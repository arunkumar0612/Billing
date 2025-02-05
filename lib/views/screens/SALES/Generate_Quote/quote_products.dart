import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/SALEScontrollers/Quote_actions.dart';
import '../../../../services/SALES/Quotation_services/QuoteProduct_services.dart';

class QuoteProducts extends StatefulWidget with QuoteproductService {
  QuoteProducts({super.key});

  @override
  State<QuoteProducts> createState() => _QuoteProductsState();
}

class _QuoteProductsState extends State<QuoteProducts> {
  final QuoteController quoteController = Get.find<QuoteController>();

  Widget Quote_productDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < quoteController.quoteModel.Quote_products.length; i++)
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
                              '${i + 1}. ${quoteController.quoteModel.Quote_products[i].productName}', // Display camera type from map
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                quoteController.removeFromProductList(i);
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
            key: quoteController.quoteModel.productKey.value,
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
                          controller: quoteController.quoteModel.productNameController.value,
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
                          controller: quoteController.quoteModel.hsnController.value,
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
                            controller: quoteController.quoteModel.gstController.value,
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
                            controller: quoteController.quoteModel.priceController.value,
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
                            controller: quoteController.quoteModel.quantityController.value,
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
                              text: quoteController.quoteModel.product_editIndex.value == null ? 'Back' : 'Cancel',
                              onPressed: () {
                                quoteController.quoteModel.product_editIndex.value == null ? quoteController.backTab() : widget.resetEditingState(); // Reset editing state when going back
                              },
                            ),
                            const SizedBox(width: 30),
                            Button1(
                              colors: quoteController.quoteModel.product_editIndex.value == null ? Colors.blue : Colors.orange,
                              text: quoteController.quoteModel.product_editIndex.value == null ? 'Add product' : 'Update',
                              onPressed: () {
                                quoteController.quoteModel.product_editIndex.value == null ? widget.addproduct(context) : widget.updateproduct(context);
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
                    return (quoteController.quoteModel.Quote_products.isNotEmpty)
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
                                              child: Quote_productDetailss(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              if (quoteController.quoteModel.Quote_products.isNotEmpty)
                                Button1(
                                  colors: Colors.green,
                                  text: 'Submit',
                                  onPressed: () {
                                    widget.onSubmit();
                                    quoteController.nextTab();
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
