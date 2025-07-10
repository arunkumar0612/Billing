// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/controllers/Process/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3_SUBSCRIPTION/services/Process/Quotation_services/SUBSCRIPTION_QuoteDetails_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class SUBSCRIPTION_QuoteDetails extends StatefulWidget with SUBSCRIPTION_QuotedetailsService {
  SUBSCRIPTION_QuoteDetails({super.key, required this.eventtype, required this.eventID});
  int eventID;
  String eventtype;
  @override
  State<SUBSCRIPTION_QuoteDetails> createState() => _SUBSCRIPTION_QuoteDetailsState();
}

class _SUBSCRIPTION_QuoteDetailsState extends State<SUBSCRIPTION_QuoteDetails> {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();

  @override
  void initState() {
    // widget.get_requiredData(context, widget.eventtype, widget.eventID);
    // widget.get_CompanyBasedPackages(context, quoteController.quoteModel.companyid.value);

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
                      Text('${widget.eventtype == 'revisedquotation' ? 'Revised quotation no' : 'Quotation No'} :   ',
                          style: const TextStyle(fontSize: Primary_font_size.Text7, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 169, 168, 168))),
                      Text('${quoteController.quoteModel.Quote_no.value}', style: const TextStyle(fontSize: Primary_font_size.Text7, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Form(
                        key: quoteController.quoteModel.detailsKey.value,
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
                                //   controller: quoteController.quoteModel.TitleController.value,
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
                                  controller: quoteController.quoteModel.clientAddressNameController.value,
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
                                  digitsOnly: false,
                                  width: 400,
                                  readonly: false,
                                  text: 'Client Address ',
                                  controller: quoteController.quoteModel.clientAddressController.value,
                                  icon: Icons.location_history_outlined,
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
                                  controller: quoteController.quoteModel.gstNumController.value,
                                  icon: Icons.price_change,
                                  validator: (value) {
                                    return null;

                                    // return Validators.GST_validator(value);
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
                                  controller: quoteController.quoteModel.billingAddressNameController.value,
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
                                  digitsOnly: false,
                                  width: 400,
                                  readonly: false,
                                  text: 'Billing Address',
                                  controller: quoteController.quoteModel.billingAddressController.value,
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
                        widget.eventtype == 'revisedquotation'
                            ? 'The Quotation shown beside can be used as a reference for generating the Quote. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.'
                            : 'The client request shown beside can be used as a reference for generating the Quote. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
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
