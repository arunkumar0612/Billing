// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:ssipl_billing/Subscription/Generate_client_requirements/generate_sub_clientreq.dart';
// import 'package:ssipl_billing/Subscription/Generate_client_requirements/sub_clientreq_template.dart';
// import 'package:ssipl_billing/button.dart';
// import 'package:ssipl_billing/common_modules/style.dart';
// import 'package:ssipl_billing/textfield.dart';

// class sub_clientreqProducts extends StatefulWidget {
//   const sub_clientreqProducts({super.key});

//   @override
//   State<sub_clientreqProducts> createState() => _sub_clientreqProductsState();
// }

// class _sub_clientreqProductsState extends State<sub_clientreqProducts> {
//   int? editIndex1;
//   final formKey1 = GlobalKey<FormState>();
//   final TextEditingController productNameController = TextEditingController();
//   // final TextEditingController quantityController = TextEditingController();

//   void _clearFields() {
//     setState(
//       () {
//         productNameController.clear();

//         // quantityController.clear();
//         // SGSTController.clear();
//       },
//     );
//   }

//   void _addproduct() {
//     if (formKey1.currentState?.validate() ?? false) {
//       // Check if a product with the same values already exists
//       bool exists = sub_clientreq_productDetails.any((product) => product['productName'] == productNameController.text );

//       if (exists) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             backgroundColor: Colors.blue,
//             content: Text('This product already exists.'),
//           ),
//         );
//         return; // Exit the method without adding the product
//       }

//       setState(() {
//         sub_clientreq_productDetails.add({
//           'productName': productNameController.text,
//           // 'quantity': int.parse(quantityController.text),
//         });

//         _clearFields();
//         // print(sub_clientreq_productDetails.length);
//       });
//     }
//   }

//   void _updateproduct() {
//     if (formKey1.currentState?.validate() ?? false) {
//       setState(
//         () {
//           sub_clientreq_productDetails[editIndex1!] = {
//             'productName': productNameController.text,
//             // 'quantity': int.parse(quantityController.text),
//             // 'productSGST': SGSTController.text,
//           };
//           _clearFields();
//           editIndex1 = null;
//         },
//       );
//     }
//   }

//   void _editproduct(int index) {
//     Map<String, dynamic> product = sub_clientreq_productDetails[index];
//     setState(
//       () {
//         productNameController.text = product['productName'] ?? '';
//         // quantityController.text = product['quantity'].toString();
//         // SGSTController.text = product['productSGST'] ?? '';
//         editIndex1 = index; // Set the index of the item being edited
//       },
//     );
//     // print('Edit------------------${selected_notify_Items}');
//   }

//   void _resetEditingState() {
//     setState(
//       () {
//         _clearFields();
//         editIndex1 = null;
//       },
//     );
//   }

//   Widget sub_clientreq_productDetailss() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         for (int i = 0; i < sub_clientreq_productDetails.length; i++)
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   _editproduct(i);
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Primary_colors.Light),
//                   height: 40,
//                   width: 300,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: 230,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Text(
//                               overflow: TextOverflow.ellipsis,
//                               '${i + 1}. ${sub_clientreq_productDetails[i]['productName']}', // Display camera type from map
//                               style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   sub_clientreq_productDetails.removeAt(i);
//                                 });
//                               },
//                               icon: const Icon(
//                                 Icons.close,
//                                 size: 20,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//             ],
//           ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey1,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   children: [
//                     const SizedBox(height: 25),
//                     Textfield_1(
//                       readonly: false,
//                       text: 'Product Name',
//                       controller: productNameController,
//                       icon: Icons.production_quantity_limits,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter Product name';
//                         }
//                         return null;
//                       },
//                     ),
//                     // const SizedBox(height: 25),
//                     // SizedBox(
//                     //   width: 400,
//                     //   child: TextFormField(
//                     //     readOnly: false,
//                     //     style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
//                     //     decoration: const InputDecoration(
//                     //       filled: true,
//                     //       fillColor: Primary_colors.Dark,
//                     //       focusedBorder: OutlineInputBorder(
//                     //         borderSide: BorderSide(
//                     //           color: Colors.black,
//                     //         ),
//                     //       ),

//                     //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
//                     //       // labelText: text,
//                     //       hintText: 'Product Quantity',
//                     //       hintStyle: TextStyle(
//                     //         fontSize: Primary_font_size.Text7,
//                     //         color: Color.fromARGB(255, 167, 165, 165),
//                     //       ),
//                     //       border: OutlineInputBorder(),
//                     //       prefixIcon: Icon(
//                     //         Icons.production_quantity_limits,
//                     //         color: Colors.white,
//                     //       ),
//                     //     ),
//                     //     inputFormatters: [
//                     //       FilteringTextInputFormatter.digitsOnly
//                     //     ],
//                     //     controller: quantityController,
//                     //     keyboardType: TextInputType.number,
//                     //     // inputFormatters: [
//                     //     //   FilteringTextInputFormatter.digitsOnly
//                     //     // ],
//                     //     validator: (value) {
//                     //       if (value == null || value.isEmpty) {
//                     //         return 'Please enter Product Quantity';
//                     //       }
//                     //       return null;
//                     //     },
//                     //   ),
//                     // ),
//                     // const SizedBox(height: 30),
//                     // Row(
//                     //   crossAxisAlignment: CrossAxisAlignment.start,
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     Button1(
//                     //       colors: Colors.red,
//                     //       text: editIndex1 == null ? 'Back' : 'Cancle',
//                     //       onPressed: () {
//                     //         editIndex1 == null ? Generate_sub_clientreq.backTab() : _resetEditingState(); // Reset editing state when going back
//                     //       },
//                     //     ),
//                     //     const SizedBox(width: 30),
//                     //     Button1(
//                     //       colors: editIndex1 == null ? Colors.blue : Colors.orange,
//                     //       text: editIndex1 == null ? 'Add product' : 'Update',
//                     //       onPressed: editIndex1 == null ? _addproduct : _updateproduct,
//                     //     ),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//                 // if (length != 0) const SizedBox(width: 60),
//                 if (sub_clientreq_productDetails.isNotEmpty)
//                   Column(
//                     children: [
//                       const SizedBox(height: 25),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: Primary_colors.Dark,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 10, top: 15),
//                           child: Column(
//                             children: [
//                               const Text(
//                                 'Product List',
//                                 style: TextStyle(fontSize: Primary_font_size.Text10, color: Primary_colors.Color1, fontWeight: FontWeight.bold),
//                               ),
//                               const SizedBox(height: 10),
//                               SizedBox(
//                                 height: 295,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(bottom: 10),
//                                   child: SingleChildScrollView(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(10),
//                                       child: sub_clientreq_productDetailss(),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 25),
//                       if (sub_clientreq_productDetails.isNotEmpty)
//                         Button1(
//                           colors: Colors.green,
//                           text: 'Submit',
//                           onPressed: () {
//                             // Step 1: Add non-duplicate items to sub_clientreq_products
//                             for (var entry in sub_clientreq_productDetails) {
//                               final isDuplicate = sub_clientreq_products.any((product) => product.productName == entry['productName'] && product.quantity == entry['quantity']);

//                               if (!isDuplicate) {
//                                 final index = sub_clientreq_products.length + 1; // Generate serial number
//                                 sub_clientreq_products.add(Product(
//                                   index.toString(),
//                                   entry['productName'] as String,
//                                   entry['quantity'] as int,
//                                 ));
//                               }
//                             }

//                             // Step 2: Navigate to the next tab
//                             Generate_sub_clientreq.nextTab();
//                           },
//                         ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
