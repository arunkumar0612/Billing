import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/services/SALES/DC_services/DCdetails_service.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/SALEScontrollers/DC_actions.dart';

class Delivery_challanDetails extends StatefulWidget with DcdetailsService {
  Delivery_challanDetails({super.key});

  @override
  State<Delivery_challanDetails> createState() => _Delivery_challanDetailsState();
}

class _Delivery_challanDetailsState extends State<Delivery_challanDetails> {
  final DCController dcController = Get.find<DCController>();
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
                  key: dcController.dcModel.detailsKey.value,
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
                            controller: dcController.dcModel.TitleController.value,
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
                            controller: dcController.dcModel.clientAddressNameController.value,
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
                            controller: dcController.dcModel.clientAddressController.value,
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
                            controller: dcController.dcModel.billingAddressNameController.value,
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
                            controller: dcController.dcModel.billingAddressController.value,
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
                  'The approved Quotation shown beside can be used as a reference for generating the Delivery_challan. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
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
