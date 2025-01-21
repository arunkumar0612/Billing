import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssipl_billing/SALES/Generate_RFQ/generateRFQ.dart';
import 'package:ssipl_billing/SALES/Generate_RFQ/RFQ_template.dart';
import 'package:ssipl_billing/button.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';

class RFQProducts extends StatefulWidget {
  const RFQProducts({super.key});

  @override
  State<RFQProducts> createState() => _RFQProductsState();
}

class _RFQProductsState extends State<RFQProducts> {
  int? editIndex1;
  final formKey1 = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  // final TextEditingController hsnController = TextEditingController();
  // final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  // final TextEditingController GSTController = TextEditingController();
  void _clearFields() {
    setState(
      () {
        productNameController.clear();
        // hsnController.clear();
        // priceController.clear();
        quantityController.clear();
        // GSTController.clear();
        // SGSTController.clear();
      },
    );
  }

  void _addproduct() {
    if (formKey1.currentState?.validate() ?? false) {
      // Check if a product with the same values already exists
      bool exists = RFQ_productDetails.any((product) => product['productName'] == productNameController.text && product['quantity'] == int.parse(quantityController.text));

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This product already exists.'),
          ),
        );
        return; // Exit the method without adding the product
      }

      setState(() {
        RFQ_productDetails.add({
          'productName': productNameController.text,
          // 'hsn': hsnController.text,
          // 'price': double.parse(priceController.text),
          'quantity': int.parse(quantityController.text),
          // 'gst': double.parse(GSTController.text),
        });

        _clearFields();
        // print(RFQ_productDetails.length);
      });
    }
  }

  void _updateproduct() {
    if (formKey1.currentState?.validate() ?? false) {
      setState(
        () {
          RFQ_productDetails[editIndex1!] = {
            'productName': productNameController.text,
            // 'hsn': hsnController.text,
            // 'price': double.parse(priceController.text),
            'quantity': int.parse(quantityController.text),
            // 'gst': double.parse(GSTController.text),
            // 'productSGST': SGSTController.text,
          };
          _clearFields();
          editIndex1 = null;
        },
      );
    }
  }

  void _editproduct(int index) {
    Map<String, dynamic> product = RFQ_productDetails[index];
    setState(
      () {
        productNameController.text = product['productName'] ?? '';
        // hsnController.text = product['hsn'] ?? '';
        // priceController.text = product['price'].toString();
        quantityController.text = product['quantity'].toString();
        // GSTController.text = product['gst'].toString();
        // SGSTController.text = product['productSGST'] ?? '';
        editIndex1 = index; // Set the index of the item being edited
      },
    );
    // print('Edit------------------${selected_notify_Items}');
  }

  void _resetEditingState() {
    setState(
      () {
        _clearFields();
        editIndex1 = null;
      },
    );
  }

  Widget RFQ_productDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < RFQ_productDetails.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _editproduct(i);
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
                              '${i + 1}. ${RFQ_productDetails[i]['productName']}', // Display camera type from map
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  RFQ_productDetails.removeAt(i);
                                });
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
            key: formKey1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 25),
                    Textfield_1(
                      readonly: false,
                      text: 'Product Name',
                      controller: productNameController,
                      icon: Icons.production_quantity_limits,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Product name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
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
                        controller: quantityController,
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
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button1(
                          colors: Colors.red,
                          text: editIndex1 == null ? 'Back' : 'Cancle',
                          onPressed: () {
                            editIndex1 == null ? GenerateRFQ.backTab() : _resetEditingState(); // Reset editing state when going back
                          },
                        ),
                        const SizedBox(width: 30),
                        Button1(
                          colors: editIndex1 == null ? Colors.blue : Colors.orange,
                          text: editIndex1 == null ? 'Add product' : 'Update',
                          onPressed: editIndex1 == null ? _addproduct : _updateproduct,
                        ),
                      ],
                    ),
                  ],
                ),
                // if (length != 0) const SizedBox(width: 60),
                if (RFQ_productDetails.isNotEmpty)
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
                                      child: RFQ_productDetailss(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      if (RFQ_productDetails.isNotEmpty)
                        Button1(
                          colors: Colors.green,
                          text: 'Submit',
                          onPressed: () {
                            RFQ_products.clear();
                            // Step 1: Add non-duplicate items to RFQ_products
                            for (var entry in RFQ_productDetails) {
                              // final isDuplicate = RFQ_products.any((product) => product.productName == entry['productName'] && product.quantity == entry['quantity']);

                              // if (!isDuplicate) {
                              final index = RFQ_products.length + 1; // Auto-generate serial number
                              RFQ_products.add(Product(
                                index.toString(),
                                entry['productName'] as String,
                                // entry['hsn'] as String,
                                // entry['gst'] as double,
                                // entry['price'] as double,
                                entry['quantity'] as int,
                              ));
                              // }
                            }

                            // Step 3: Navigate to the next tab
                            GenerateRFQ.nextTab();
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
  }
}
