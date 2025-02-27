import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/DC_actions.dart';
import 'package:ssipl_billing/services/SALES/DC_services/DC_Product_services.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';

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

  Widget buildProductlist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(36, 100, 110, 255),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.only(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              activeColor: Colors.green,
                              side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2),
                              value: dcController.dcModel.selectall_status.value,
                              onChanged: (_) {
                                dcController.togglProduct_selectAll(!dcController.dcModel.selectall_status.value);
                                dcController.refactorSelection();
                              },
                            ),
                            const Text(
                              'Select',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(),
                      child: Text(
                        'Product Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'HSN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(),
                      child: Text(
                        'Unit price',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(),
                      child: Text(
                        'Quantity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(),
                      child: Text(
                        'Total price',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            // height: 200,
            // width: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListView.builder(
                itemCount: dcController.dcModel.Dc_products.length,
                itemBuilder: (context, index) {
                  final product = dcController.dcModel.Dc_products[index];
                  final isEvenRow = index % 2 == 0;
                  // final iera = site['InactiveDevices'] == '0';
                  // final offline_color = iera
                  //     ? const Color.fromARGB(255, 255, 255, 255)
                  //     : Colors.red;
                  const backgroundColor = Color.fromARGB(211, 201, 200, 200);

                  return Column(
                    children: [
                      buildProductRow(
                          product.productName, product.hsn.toString(), product.price.toString(), product.quantity.toString(), (product.price * product.quantity).toString(), backgroundColor, index),
                      // const Text("dsfgdgdfg fgdfgdf df df df df df df df df df df df df df df df ggdfgdf fdgdfg dfgdfgdfg dfg df gdf gd "),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        BasicButton(
            text: "Submit",
            colors: Colors.green,
            onPressed: () {
              widget.addto_Selectedproducts();
              dcController.nextTab();
            })
      ],
    );
  }

  Widget buildProductRow(String productName, String HSN, String unitPrice, String quantity, String totalPrice, Color backgroundColor, int index) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 70, 69, 69),
            ),
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Checkbox(
                          activeColor: Colors.green,
                          value: dcController.dcModel.checkboxValues[index],
                          onChanged: (bool? newValue) {
                            dcController.toggleProduct_selection(newValue!, index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        productName,
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        HSN,
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        unitPrice,
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        quantity,
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        totalPrice,
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Center(
          child: Padding(padding: const EdgeInsets.all(16.0), child: buildProductlist()),
        );
      },
    );
  }
}
