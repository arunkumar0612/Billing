// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES-/style.dart';
import '../../controllers/Quote_actions.dart';
import '../../services/Quotation_services/QuoteDetails_service.dart';

class QuoteDetails extends StatefulWidget with QuotedetailsService {
  QuoteDetails({super.key, required this.eventtype, required this.eventID});
  int eventID;
  String eventtype;
  @override
  State<QuoteDetails> createState() => _QuoteDetailsState();
}

class _QuoteDetailsState extends State<QuoteDetails> {
  final QuoteController quoteController = Get.find<QuoteController>();

  @override
  void initState() {
    widget.get_requiredData(context, widget.eventtype, widget.eventID);
    widget.get_productSuggestionList(context);
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
                  key: quoteController.quoteModel.detailsKey.value,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BasicTextfield(
                            digitsOnly: false,
                            width: 400,
                            readonly: false,
                            text: 'Title',
                            controller: quoteController.quoteModel.TitleController.value,
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
                            digitsOnly: false,
                            width: 400,
                            readonly: false,
                            text: 'Client Address name',
                            controller: quoteController.quoteModel.clientAddressNameController.value,
                            icon: Icons.account_circle, // changed from people
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
                            icon: Icons.location_on_outlined, // better location icon
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
                            digitsOnly: false,
                            width: 400,
                            readonly: false,
                            text: 'Billing Address name',
                            controller: quoteController.quoteModel.billingAddressNameController.value,
                            icon: Icons.business, // changed from price_change
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
                            icon: Icons.location_city, // changed from price_change
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Billing Address';
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
                            icon: Icons.receipt_long, // changed from price_change
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
                  'The approved Quotation shown beside can be used as a reference for generating the Quote. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
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
