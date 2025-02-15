import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/SALEScontrollers/Invoice_actions.dart';
import '../../../../services/SALES/Invoice_services/InvoiceDetails_service.dart';

class InvoiceDetails extends StatefulWidget with InvoicedetailsService {
  InvoiceDetails({super.key});

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Form(
                  key: invoiceController.invoiceModel.detailsKey.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 25),
                          BasicTextfield(
                            readonly: false,
                            text: 'Title',
                            controller: invoiceController.invoiceModel.TitleController.value,
                            icon: Icons.title,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Title number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          BasicTextfield(
                            readonly: false,
                            text: 'Client Address name',
                            controller: invoiceController.invoiceModel.clientAddressNameController.value,
                            icon: Icons.people,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Client Address name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          BasicTextfield(
                            readonly: false,
                            text: 'Client Address ',
                            controller: invoiceController.invoiceModel.clientAddressController.value,
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
                          BasicTextfield(
                            readonly: false,
                            text: 'Billing Address name',
                            controller: invoiceController.invoiceModel.billingAddressNameController.value,
                            icon: Icons.price_change,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Billing Address name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          BasicTextfield(
                            readonly: false,
                            text: 'Billing Address',
                            controller: invoiceController.invoiceModel.billingAddressController.value,
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
                                  widget.add_details();
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
                  'The approved Quotation shown beside can be used as a reference for generating the Invoice. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                  style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
