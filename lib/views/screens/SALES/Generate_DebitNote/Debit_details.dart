import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/SALEScontrollers/Debit_actions.dart';
import '../../../../services/SALES/Debit_services/DebitDetails_service.dart';

class DebitDetails extends StatefulWidget with DebitdetailsService {
  DebitDetails({super.key});

  @override
  State<DebitDetails> createState() => _DebitDetailsState();
}

class _DebitDetailsState extends State<DebitDetails> {
  final DebitController debitController = Get.find<DebitController>();
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
                  key: debitController.debitModel.detailsKey.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BasicTextfield(
                            readonly: false,
                            text: 'Client Address name',
                            controller: debitController.debitModel.clientAddressNameController.value,
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
                            controller: debitController.debitModel.clientAddressController.value,
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
                          BasicTextfield(
                            readonly: false,
                            text: 'Billing Address name',
                            controller: debitController.debitModel.billingAddressNameController.value,
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
                            controller: debitController.debitModel.billingAddressController.value,
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
                  'The approved Quotation shown beside can be used as a reference for generating the Debit. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
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
