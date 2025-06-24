// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/controllers/RFQ_actions.dart';
import 'package:ssipl_billing/4_SALES/models/entities/RFQ_entities.dart';
import 'package:ssipl_billing/4_SALES/services/RFQ_services/RFQ_Details_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES/style.dart';

/// Generating RFQ ---- Details tab
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
                      const Text('RFQ no :   ', style: TextStyle(fontSize: Primary_font_size.Text7, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 169, 168, 168))),
                      Text('${rfqController.rfqModel.Rfq_no.value}', style: const TextStyle(fontSize: Primary_font_size.Text7, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Form(
                        key: rfqController.rfqModel.detailsKey.value,
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
                                  child: DropdownButtonFormField<VendorList>(
                                    menuMaxHeight: 350,
                                    isExpanded: true,
                                    dropdownColor: Primary_colors.Dark,
                                    decoration: const InputDecoration(
                                      label: Text(
                                        'Select Vendor',
                                        style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 177, 176, 176)),
                                      ),
                                      contentPadding: EdgeInsets.all(13),
                                      labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                                      filled: true,
                                      fillColor: Primary_colors.Dark,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
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
                                      ),
                                    ),
                                    items: rfqController.rfqModel.vendorList.map((vendor) {
                                      return DropdownMenuItem<VendorList>(
                                        value: vendor, // Store the full vendor object
                                        child: Text(
                                          vendor.vendorName, // Display vendor name
                                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1, overflow: TextOverflow.ellipsis),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (VendorList? selectedVendor) {
                                      if (selectedVendor != null) {
                                        rfqController.update_vendorCredentials_onSelect(selectedVendor);
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a vendor';
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
                                  controller: rfqController.rfqModel.AddressController.value,
                                  icon: Icons.location_history_outlined,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Client Address';
                                    }
                                    return null;
                                  },
                                ),
                                // const SizedBox(height: 25),
                                // BasicTextfield(
                                //   digitsOnly: false,
                                //   width: 400,
                                //   readonly: false,
                                //   text: 'GST number',
                                //   controller: rfqController.rfqModel.gstNumController.value,
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
                        'The Quotation shown beside can be used as a reference for generating the RFQ. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
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
