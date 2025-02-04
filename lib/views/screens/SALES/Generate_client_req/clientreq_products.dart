import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/services/SALES/ClientReq_services/ClientreqProduct_service.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/ClientReq_actions.dart';

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
                    Column(
                      children: [
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Product Name',
                          controller: clientreqController.clientReqModel.productNameController.value,
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
                            controller: clientreqController.clientReqModel.quantityController.value,
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
                              text: clientreqController.clientReqModel.product_editIndex.value == null ? 'Back' : 'Cancle',
                              onPressed: () {
                                clientreqController.clientReqModel.product_editIndex.value == null ? clientreqController.backTab() : widget.resetEditingState(); // Reset editing state when going back
                              },
                            ),
                            const SizedBox(width: 30),
                            Button1(
                              colors: clientreqController.clientReqModel.product_editIndex.value == null ? Colors.blue : Colors.orange,
                              text: clientreqController.clientReqModel.product_editIndex.value == null ? 'Add product' : 'Update',
                              onPressed: () {
                                clientreqController.clientReqModel.product_editIndex.value == null ? widget.addproduct(context) : widget.updateproduct(context);
                              },
                            ),
                          ],
                        ),
                      ],
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
                            Button1(
                              colors: Colors.green,
                              text: 'Submit',
                              onPressed: () {
                                // clientreq_products.clear();
                                // // Step 1: Add non-duplicate items to clientreq_products
                                // for (var entry in clientreqProducts.clientreq_productDetails) {
                                //   // final isDuplicate = clientreq_products.any((product) => product.productName == entry['productName'] && product.quantity == entry['quantity']);

                                //   // if (!isDuplicate) {
                                //   final index = clientreq_products.length + 1; // Generate serial number
                                //   clientreq_products.add(Product(
                                //     index.toString(),
                                //     entry['productName'] as String,
                                //     entry['quantity'] as int,
                                //   ));
                                //   // }
                                // }

                                // Step 2: Navigate to the next tab
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
