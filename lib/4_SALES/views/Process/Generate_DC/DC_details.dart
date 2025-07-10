// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/Process/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/services/Process/DC_services/DC_Details_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

class DcDetails extends StatefulWidget with DcdetailsService {
  DcDetails({super.key, required this.eventID, required this.eventName});
  int eventID;
  String eventName;
  @override
  State<DcDetails> createState() => _DcDetailsState();
}

class _DcDetailsState extends State<DcDetails> {
  final DcController dcController = Get.find<DcController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Delivery challan no :   ', style: TextStyle(fontSize: Primary_font_size.Text7, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 169, 168, 168))),
                      Text('${dcController.dcModel.Dc_no.value}', style: const TextStyle(fontSize: Primary_font_size.Text7, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Form(
                        key: dcController.dcModel.detailsKey.value,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const SizedBox(height: 25),
                                // BasicTextfield(
                                //   digitsOnly: false,
                                //   width: 400,
                                //   readonly: false,
                                //   text: 'Title',
                                //   controller: dcController.dcModel.TitleController.value,
                                //   icon: Icons.title,
                                //   validator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return 'Please enter Title number';
                                //     }
                                //     return null;
                                //   },
                                // ),
                                // const SizedBox(height: 25),
                                BasicTextfield(
                                  digitsOnly: false,
                                  width: 400,
                                  readonly: false,
                                  text: 'Client Address name',
                                  controller: dcController.dcModel.clientAddressNameController.value,
                                  icon: Icons.account_circle,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Client Address name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 25),
                                BasicTextfield(
                                  digitsOnly: false,
                                  width: 400,
                                  readonly: false,
                                  text: 'Client Address ',
                                  controller: dcController.dcModel.clientAddressController.value,
                                  icon: Icons.location_on_outlined,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Client Address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 25),
                                BasicTextfield(
                                  digitsOnly: false,
                                  width: 400,
                                  readonly: false,
                                  text: 'GST number',
                                  controller: dcController.dcModel.gstNumController.value,
                                  icon: Icons.receipt_long,
                                  validator: (value) {
                                    return Validators.GST_validator(value);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const SizedBox(height: 10),
                                BasicTextfield(
                                  digitsOnly: false,
                                  width: 400,
                                  readonly: false,
                                  text: 'Billing Address name',
                                  controller: dcController.dcModel.billingAddressNameController.value,
                                  icon: Icons.business,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Billing Address name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 25),
                                BasicTextfield(
                                  digitsOnly: false,
                                  width: 400,
                                  readonly: false,
                                  text: 'Billing Address',
                                  controller: dcController.dcModel.billingAddressController.value,
                                  icon: Icons.location_city,
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
                                    BasicButton(
                                      colors: Colors.green,
                                      text: 'Add Details',
                                      onPressed: () {
                                        widget.nextTab();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 660,
                      child: Text(
                        textAlign: TextAlign.center,
                        widget.eventName == 'Invoice'
                            ? 'The Invoice shown beside can be used as a reference for generating the Dc. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.'
                            : 'The Delivery challan shown beside can be used as a reference for generating the Dc. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                        style: const TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
