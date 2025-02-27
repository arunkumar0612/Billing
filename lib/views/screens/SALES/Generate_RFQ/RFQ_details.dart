// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/RFQ_actions.dart';
import 'package:ssipl_billing/services/SALES/RFQ_services/RFQ_Details_service.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';

class RfqDetails extends StatefulWidget with RfqdetailsService {
  RfqDetails({super.key, required this.eventID});
  int eventID;
  @override
  State<RfqDetails> createState() => _RfqDetailsState();
}

class _RfqDetailsState extends State<RfqDetails> {
  final RfqController rfqController = Get.find<RfqController>();

  @override
  void initState() {
    widget.get_VendorList(context, 0);
    // widget.get_requiredData(context, widget.eventID, "requestforquotation");
    // widget.get_productSuggestionList(context);
    widget.get_noteSuggestionList(context);
    super.initState();
  }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const SizedBox(height: 25),
                          BasicTextfield(
                            digitsOnly: false,
                            width: 400,
                            readonly: false,
                            text: 'Title',
                            controller: rfqController.rfqModel.TitleController.value,
                            icon: Icons.title,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Title number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
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
                              // value: rfqController.rfqModel.vendorList .value == "" ? null : clientreqController.clientReqModel.Org_Controller.value,
                              items: rfqController.rfqModel.vendorList.map((vendor) {
                                return DropdownMenuItem<String>(
                                  value: vendor.vendorName,
                                  child: Text(
                                    vendor.vendorName,
                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1, overflow: TextOverflow.ellipsis),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                // clientreqController.updateOrgName(newValue!);
                                // widget.on_Orgselected(context, newValue);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Select customer type';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                          BasicTextfield(
                            digitsOnly: false,
                            width: 400,
                            readonly: false,
                            text: 'Client Address ',
                            controller: rfqController.rfqModel.clientAddressController.value,
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
                          // const SizedBox(height: 10),
                          // BasicTextfield(
                          //   digitsOnly: false,
                          //   width: 400,
                          //   readonly: false,
                          //   text: 'Billing Address name',
                          //   controller: rfqController.rfqModel.billingAddressNameController.value,
                          //   icon: Icons.price_change,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please enter Billing Address name';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // const SizedBox(height: 25),
                          // BasicTextfield(
                          //   digitsOnly: false,
                          //   width: 400,
                          //   readonly: false,
                          //   text: 'Billing Address',
                          //   controller: rfqController.rfqModel.billingAddressController.value,
                          //   icon: Icons.price_change,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please enter Billing Address';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          const SizedBox(height: 25),
                          BasicTextfield(
                            digitsOnly: false,
                            width: 400,
                            readonly: false,
                            text: 'GST number',
                            controller: rfqController.rfqModel.gstNumController.value,
                            icon: Icons.price_change,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter GST number';
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
              const SizedBox(
                width: 660,
                child: Text(
                  textAlign: TextAlign.center,
                  'The approved Quotation shown beside can be used as a reference for generating the Rfq. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
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
