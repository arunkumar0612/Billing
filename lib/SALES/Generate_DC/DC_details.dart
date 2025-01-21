import 'package:flutter/material.dart';
import 'package:ssipl_billing/SALES/Generate_DC/DC_template.dart';
import 'package:ssipl_billing/SALES/Generate_DC/generateDC.dart';

import 'package:ssipl_billing/button.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';

class Delivery_challanDetails extends StatefulWidget {
  const Delivery_challanDetails({super.key});

  @override
  State<Delivery_challanDetails> createState() => _Delivery_challanDetailsState();
}

class _Delivery_challanDetailsState extends State<Delivery_challanDetails> {
  final TextEditingController TitleController = TextEditingController();
  final TextEditingController clientaddressnameController = TextEditingController();
  final TextEditingController clientaddressController = TextEditingController();
  final TextEditingController billingaddressnameController = TextEditingController();
  final TextEditingController billingaddressController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    clientaddressnameController.text = Delivery_challan_client_addr_name;
    clientaddressController.text = Delivery_challan_client_addr;
    billingaddressnameController.text = Delivery_challan_bill_addr_name;
    billingaddressController.text = Delivery_challan_bill_addr;

    TitleController.text = Delivery_challan_title;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Form(
                key: formKey1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Title',
                          controller: TitleController,
                          icon: Icons.title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Title number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Client Address name',
                          controller: clientaddressnameController,
                          icon: Icons.people,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Client Address name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Client Address ',
                          controller: clientaddressController,
                          icon: Icons.location_history_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Client Address';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Textfield_1(
                          readonly: false,
                          text: 'Billing Address name',
                          controller: billingaddressnameController,
                          icon: Icons.price_change,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Billing Address name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Billing Address',
                          controller: billingaddressController,
                          icon: Icons.price_change,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Billing Address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Button1(
                              colors: Colors.green,
                              text: 'Add Details',
                              onPressed: () {
                                if (formKey1.currentState?.validate() ?? false) {
                                  Delivery_challan_client_addr_name = clientaddressnameController.text;
                                  Delivery_challan_client_addr = clientaddressController.text;
                                  Delivery_challan_bill_addr_name = billingaddressnameController.text;
                                  Delivery_challan_bill_addr = billingaddressController.text;

                                  Delivery_challan_title = TitleController.text;
                                  GenerateDelivery_challan.nextTab();
                                }
                                // if (_formKey.currentState?.validate() == true) {

                                // }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 25),
            const SizedBox(
              width: 660,
              child: Text(
                textAlign: TextAlign.center,
                'The approved Quotation shown beside can be used as a reference for generating the Delivery_challan. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
