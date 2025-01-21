import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_Quotation/sub_generateQuotaion.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_Quotation/sub_quotation_template.dart';
import 'package:ssipl_billing/button.dart';
import 'package:ssipl_billing/common_modules/style.dart';

class sub_QuotationProducts extends StatefulWidget {
  const sub_QuotationProducts({super.key});

  @override
  State<sub_QuotationProducts> createState() => _sub_QuotationProductsState();
}

class _sub_QuotationProductsState extends State<sub_QuotationProducts> {
  // int? editIndex1;
  final formKey1 = GlobalKey<FormState>();
  final TextEditingController package_Controller = TextEditingController();
  final TextEditingController special_price_Controller = TextEditingController();
  final TextEditingController regular_price_Controller = TextEditingController();
  final TextEditingController GSTController = TextEditingController();

  // void _addproduct() {
  //   if (formKey1.currentState?.validate() ?? false) {
  //     // Check if a product with the same values already exists
  //     bool exists = sub_quote_productDetails.any((product) => product['package'] == package_Controller.text && product['regualar_price'] == regular_price_Controller.text && product['special_price'] == double.parse(special_price_Controller.text) && product['gst'] == double.parse(GSTController.text));

  //     if (exists) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.blue,
  //           content: Text('This product already exists.'),
  //         ),
  //       );
  //       return; // Exit the method without adding the product
  //     }

  //     setState(() {
  //       sub_quote_productDetails.add({
  //         'package': package_Controller.text,
  //         'regular_price': double.parse(regular_price_Controller.text),
  //         'special_price': double.parse(special_price_Controller.text),
  //         'gst': double.parse(GSTController.text),
  //       });

  //       _clearFields();
  //       // print(productDetails.length);
  //     });
  //   }
  // }

  // void _updateproduct() {
  //   if (formKey1.currentState?.validate() ?? false) {
  //     setState(
  //       () {
  //         sub_quote_productDetails[editIndex1!] = {
  //           'package': package_Controller.text,
  //           'regular_price': double.parse(regular_price_Controller.text),
  //           'special_price': double.parse(special_price_Controller.text),
  //           'gst': double.parse(GSTController.text),
  //           // 'productSGST': SGSTController.text,
  //         };
  //         _clearFields();
  //         editIndex1 = null;
  //       },
  //     );
  //   }
  // }

  // void _editproduct(int index) {
  //   Map<String, dynamic> product = sub_quote_productDetails[index];
  //   setState(
  //     () {
  //       package_Controller.text = product['package'] ?? '';
  //       regular_price_Controller.text = product['regular_price'] ?? '';
  //       special_price_Controller.text = product['special_price'].toString();
  //       GSTController.text = product['gst'].toString();
  //       // SGSTController.text = product['productSGST'] ?? '';
  //       editIndex1 = index; // Set the index of the item being edited
  //     },
  //   );
  //   // print('Edit------------------${selected_notify_Items}');
  // }

  // void _resetEditingState() {
  //   setState(
  //     () {
  //       _clearFields();
  //       editIndex1 = null;
  //     },
  //   );
  // }

  // Widget productDetailss() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       for (int i = 0; i < sub_quote_productDetails.length; i++)
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             GestureDetector(
  //               onTap: () {
  //                 _editproduct(i);
  //               },
  //               child: Container(
  //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Primary_colors.Light),
  //                 height: 40,
  //                 width: 300,
  //                 child: Center(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       SizedBox(
  //                         width: 230,
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(left: 10),
  //                           child: Text(
  //                             overflow: TextOverflow.ellipsis,
  //                             '${i + 1}. ${sub_quote_productDetails[i]['package']}', // Display camera type from map
  //                             style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
  //                           ),
  //                         ),
  //                       ),
  //                       Row(
  //                         children: [
  //                           IconButton(
  //                             onPressed: () {
  //                               setState(() {
  //                                 sub_quote_productDetails.removeAt(i);
  //                               });
  //                             },
  //                             icon: const Icon(
  //                               Icons.close,
  //                               size: 20,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 15),
  //           ],
  //         ),
  //     ],
  //   );
  // }

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
                          hintText: 'Package name',
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
                        controller: package_Controller,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter package name';
                          }
                          return null;
                        },
                      ),
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
                          hintText: 'Regular price',
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
                        controller: regular_price_Controller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter regular price';
                          }
                          return null;
                        },
                      ),
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
                          hintText: 'Special price',
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
                        controller: special_price_Controller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter special price';
                          }
                          return null;
                        },
                      ),
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
                        controller: GSTController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter GST value';
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
                          text: 'Back',
                          onPressed: () {
                            Generatesub_Quotation.backTab(); // Reset editing state when going back
                          },
                        ),
                        // const SizedBox(width: 30),
                        // Button1(
                        //   colors:   Colors.blue ,
                        //   text:  'Add product' : 'Update',
                        //   onPressed: editIndex1 == null ? _addproduct : _updateproduct,
                        // ),
                        const SizedBox(width: 30),
                        if (package_Controller.text != "" && regular_price_Controller.text != "" && special_price_Controller.text != "" && GSTController.text != "")
                          Button1(
                            colors: Colors.green,
                            text: 'Submit',
                            onPressed: () {
                              sub_quote_products.clear();

                              sub_quote_products.add(sub_Product(
                                "1",
                                package_Controller.text,
                                double.parse(regular_price_Controller.text),
                                double.parse(special_price_Controller.text),
                                double.parse(GSTController.text),
                              ));

                              Generatesub_Quotation.nextTab();
                            },
                          ),
                      ],
                    ),
                  ],
                ),
                // if (length != 0) const SizedBox(width: 60),
                // if (sub_quote_productDetails.isNotEmpty)
                // Column(
                //   children: [
                //     const SizedBox(height: 25),
                //     Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(7),
                //         color: Primary_colors.Dark,
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.only(bottom: 10, top: 15),
                //         child: Column(
                //           children: [
                //             const Text(
                //               'Product List',
                //               style: TextStyle(fontSize: Primary_font_size.Text10, color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                //             ),
                //             const SizedBox(height: 10),
                //             SizedBox(
                //               height: 295,
                //               child: Padding(
                //                 padding: const EdgeInsets.only(bottom: 10),
                //                 child: SingleChildScrollView(
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(10),
                //                     child: productDetailss(),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     const SizedBox(height: 25),
                //     if (sub_quote_productDetails.isNotEmpty)
                //       Button1(
                //         colors: Colors.green,
                //         text: 'Submit',
                //         onPressed: () {
                //           sub_quote_products.clear(); // Step 1: Add non-duplicate items to products
                //           for (var entry in sub_quote_productDetails) {
                //             // final isDuplicate = sub_quote_products.any((product) => product.productName == entry['productName'] && product.hsn == entry['hsn'] && product.gst == entry['gst'] && product.price == entry['price'] && product.quantity == entry['quantity']);

                //             // if (!isDuplicate) {
                //             final index = sub_quote_products.length + 1; // Auto-generate serial number
                //             sub_quote_products.add(sub_Product(
                //               index.toString(),
                //               entry['package'] as String,
                //               entry['regular_price'] as double,
                //               entry['special_price'] as double,
                //               entry['gst'] as double,
                //             ));
                //             // }
                //           }

                //           // Step 2: Group products by GST and calculate total for each group

                //           print(sub_quote_productDetails);

                //           // Step 3: Navigate to the next tab
                //           Generatesub_Quotation.nextTab();
                //         },
                //       ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
