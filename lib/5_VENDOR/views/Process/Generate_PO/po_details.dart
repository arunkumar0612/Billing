// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/Process/PO_actions.dart';
import 'package:ssipl_billing/5_VENDOR/services/Process/PO_services/PODetails_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

class PODetails extends StatefulWidget with POdetailsService {
  PODetails({super.key});

  @override
  State<PODetails> createState() => _PODetailsState();
}

class _PODetailsState extends State<PODetails> {
  final POController poController = Get.find<POController>();

  @override
  void initState() {
    // widget.get_VendorList(context, 0);
    // widget.get_requiredData(
    //   context,
    //   "requestforquotation",
    //   widget.eventID,
    // );
    // widget.get_productSuggestionList(context);
    // widget.get_noteSuggestionList(context);
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
                      const Text('PO no :   ', style: TextStyle(fontSize: Primary_font_size.Text7, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 169, 168, 168))),
                      Text('${poController.poModel.PO_no.value}', style: const TextStyle(fontSize: Primary_font_size.Text7, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Form(
                      key: poController.poModel.detailsKey.value,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // const SizedBox(height: 25),

                              BasicTextfield(
                                digitsOnly: false,
                                width: 400,
                                readonly: false,
                                text: 'Vendor Address ',
                                controller: poController.poModel.AddressController.value,
                                icon: Icons.location_history_outlined,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Vendor Address';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              BasicTextfield(
                                digitsOnly: false,
                                width: 400,
                                readonly: false,
                                text: 'Vendor GSTIN',
                                controller: poController.poModel.gstNumController.value,
                                icon: Icons.location_history_outlined,
                                validator: (value) {
                                  return Validators.GST_validator(value);
                                },
                              ),
                              const SizedBox(height: 25),
                              BasicTextfield(
                                digitsOnly: false,
                                width: 400,
                                readonly: false,
                                text: 'Email',
                                controller: poController.poModel.emailController.value,
                                icon: Icons.location_history_outlined,
                                validator: (value) {
                                  return Validators.email_validator(value);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              BasicTextfield(
                                digitsOnly: false,
                                width: 400,
                                readonly: false,
                                text: 'Vendor PAN',
                                controller: poController.poModel.PAN_Controller.value,
                                icon: Icons.location_history_outlined,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter PAN NUmber';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              BasicTextfield(
                                digitsOnly: false,
                                width: 400,
                                readonly: false,
                                text: 'Conatct Person',
                                controller: poController.poModel.contactPerson_Controller.value,
                                icon: Icons.location_history_outlined,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Contact Person Name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              BasicTextfield(
                                digitsOnly: false,
                                width: 400,
                                readonly: false,
                                text: 'Contact Number',
                                controller: poController.poModel.phoneController.value,
                                icon: Icons.location_history_outlined,
                                validator: (value) {
                                  return Validators.phnNo_validator(value);
                                },
                              ),

                              // const SizedBox(height: 25),
                              // BasicTextfield(
                              //   digitsOnly: false,
                              //   width: 400,
                              //   readonly: false,
                              //   text: 'GST number',
                              //   controller: poController.poModel.gstNumController.value,
                              //   icon: Icons.price_change,
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please enter GST number';
                              //     }
                              //     return null;
                              //   },
                              // ),
                              const SizedBox(height: 30),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BasicButton(
                                    colors: Colors.green,
                                    text: 'Add Details',
                                    onPressed: () {
                                      poController.nextTab();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const SizedBox(
                      width: 660,
                      child: Text(
                        textAlign: TextAlign.center,
                        'The Quotation shown beside can be used as a reference for generating the RRFQ. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                        style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
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
