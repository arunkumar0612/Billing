import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/SALEScontrollers/RFQ_actions.dart';
import '../../../../services/SALES/RFQ_services/RFQDetails_service.dart';

class RFQDetails extends StatefulWidget with RFQdetailsService {
  RFQDetails({super.key});

  @override
  State<RFQDetails> createState() => _RFQDetailsState();
}

class _RFQDetailsState extends State<RFQDetails> {
  final RFQController rfqController = Get.find<RFQController>();
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
                  key: rfqController.rfqModel.detailsKey.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 400,
                            ),
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Primary_colors.Dark,
                              decoration: const InputDecoration(
                                  label: Text(
                                    'Select Vendor',
                                    style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 177, 176, 176)),
                                  ),

                                  // hintText: 'Customer Type',hintStyle: TextStyle(),
                                  contentPadding: EdgeInsets.all(13),
                                  labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                                  filled: true,
                                  fillColor: Primary_colors.Dark,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.people,
                                    color: Colors.white,
                                  )),
                              value: rfqController.rfqModel.vendor_name_controller.value.text.isEmpty ? null : rfqController.rfqModel.vendor_name_controller.value.text,
                              items: <String>[
                                'Option 1',
                                'Option 2',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(
                                  () {
                                    rfqController.rfqModel.vendor_name_controller.value.text = newValue!;
                                  },
                                );
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Select the vendor';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                          BasicTextfield(
                            readonly: false,
                            text: 'Vendor Address ',
                            controller: rfqController.rfqModel.vendor_address_controller.value,
                            icon: Icons.location_history_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Vendor Address';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          BasicTextfield(
                            readonly: false,
                            text: 'Vendor Phone number',
                            controller: rfqController.rfqModel.vendor_phone_controller.value,
                            icon: Icons.price_change,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          BasicTextfield(
                            readonly: false,
                            text: 'Vendor Email address',
                            controller: rfqController.rfqModel.vendor_email_controller.value,
                            icon: Icons.price_change,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email Address';
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
                                  if (rfqController.rfqModel.detailsKey.value.currentState?.validate() ?? false) {
                                    widget.add_details();
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
                  'The Client requirement shown beside can be used as a reference for generating the RFQ. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
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
