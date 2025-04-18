import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4.SALES/services/Invoice_services/InvoiceProduct_services.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES-/style.dart';

import '../../controllers/Invoice_actions.dart';

class InvoiceProducts extends StatefulWidget with InvoiceproductService {
  InvoiceProducts({super.key});

  @override
  State<InvoiceProducts> createState() => _InvoiceProductsState();
}

class _InvoiceProductsState extends State<InvoiceProducts> {
  final InvoiceController invoiceController = Get.find<InvoiceController>();

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
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
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
                Expanded(
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
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(),
                      child: Text(
                        'GST %',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(),
                      child: Text(
                        'Price',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
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
                itemCount: invoiceController.invoiceModel.Invoice_products.length,
                itemBuilder: (context, index) {
                  final product = invoiceController.invoiceModel.Invoice_products[index];
                  // final iera = site['InactiveDevices'] == '0';
                  // final offline_color = iera
                  //     ? const Color.fromARGB(255, 255, 255, 255)
                  //     : Colors.red;
                  const backgroundColor = Color.fromARGB(255, 255, 255, 255);

                  return Column(
                    children: [
                      buildProductRow(product.productName, product.hsn.toString(), product.gst.toString(), product.price.toString(), product.quantity.toString(), backgroundColor, index),
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
                invoiceController.backTab();
              },
            ),
            const SizedBox(width: 20),
            BasicButton(
              text: "proceed",
              colors: Colors.green,
              onPressed: () {
                // widget.addto_Selectedproducts();
                invoiceController.nextTab();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildProductRow(String productName, String HSN, String gst, String price, String quantity, Color backgroundColor, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Primary_colors.Dark,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    gst,
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
                    price,
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(padding: const EdgeInsets.all(16.0), child: buildProductlist()),
    );
  }
}
