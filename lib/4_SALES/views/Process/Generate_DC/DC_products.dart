import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/Process/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/services/Process/DC_services/DC_Product_services.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class DcProducts extends StatefulWidget with DcproductService {
  DcProducts({super.key});

  @override
  State<DcProducts> createState() => _DcProductsState();
}

class _DcProductsState extends State<DcProducts> {
  final DcController dcController = Get.find<DcController>();

  // Widget Dc_productDetailss() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       for (int i = 0; i < dcController.dcModel.Dc_products.length; i++)
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             GestureDetector(
  //               onTap: () {
  //                 widget.editproduct(i);
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
  //                             '${i + 1}. ${dcController.dcModel.Dc_products[i].productName}', // Display camera type from map
  //                             style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
  //                           ),
  //                         ),
  //                       ),
  //                       Row(
  //                         children: [
  //                           IconButton(
  //                             onPressed: () {
  //                               dcController.removeFromProductList(i);
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
                // const Expanded(
                //   flex: 1,
                //   child: Center(
                //     child: Padding(
                //       padding: EdgeInsets.only(),
                //       child: Text(
                //         'Total price',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 13,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
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
                  // final iera = site['InactiveDevices'] == '0';
                  // final offline_color = iera
                  //     ? const Color.fromARGB(255, 255, 255, 255)
                  //     : Colors.red;
                  const backgroundColor = Color.fromARGB(255, 255, 255, 255);

                  return Column(
                    children: [
                      buildProductRow(
                          product.productName, product.hsn.toString(), product.price.toString(), product.quantity.toString(), (product.price * product.quantity).toString(), backgroundColor, index),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BasicButton(
              colors: Colors.red,
              text: 'Back',
              onPressed: () {
                dcController.backTab();
              },
            ),
            const SizedBox(width: 20),
            BasicButton(
              text: "Submit",
              colors: Colors.green,
              onPressed: () {
                if (!dcController.dcModel.checkboxValues.contains(true)) {
                  Get.snackbar("Error", "Select at least one product!");
                  return;
                }

                widget.addto_Selectedproducts();
                dcController.nextTab();
              },
            ),
          ],
        ),
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
              color: Primary_colors.Dark,
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
                          side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2),
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
                      child: SizedBox(
                        height: 50,
                        child: Obx(() {
                          return TextFormField(
                            readOnly: true,
                            style: const TextStyle(color: Colors.blue, fontSize: 13),
                            controller: dcController.dcModel.textControllers[index],
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                            focusNode: dcController.dcModel.focusNodes[index].value, // Attach focus node
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(borderSide: BorderSide.none),
                              suffixIcon: Obx(() {
                                return dcController.dcModel.isFocused[index]
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          MouseRegion(
                                            cursor: dcController.dcModel.quantities[index].value >= int.parse(quantity) ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                dcController.incrementQTY(index, int.parse(quantity));
                                              },
                                              child: Icon(
                                                Icons.arrow_drop_up,
                                                color: dcController.dcModel.quantities[index].value >= int.parse(quantity) ? Colors.grey : Colors.white,
                                              ),
                                            ),
                                          ),
                                          MouseRegion(
                                            cursor: dcController.dcModel.quantities[index].value > 1 ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
                                            child: GestureDetector(
                                              onTap: () {
                                                dcController.decrementQTY(index);
                                              },
                                              child: Icon(
                                                Icons.arrow_drop_down,
                                                color: dcController.dcModel.quantities[index].value > 1 ? Colors.white : Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(); // Hide arrows when not focused
                              }),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                dcController.setQtyvalue(value, quantity, index);
                              }
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Center(
                //     child: Padding(
                //       padding: const EdgeInsets.only(),
                //       child: Text(
                //         totalPrice,
                //         style: TextStyle(
                //           color: backgroundColor,
                //           fontSize: 13,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
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
