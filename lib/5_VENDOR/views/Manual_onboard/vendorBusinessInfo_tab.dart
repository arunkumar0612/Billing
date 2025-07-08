import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/manual_onboard_actions.dart';
import 'package:ssipl_billing/5_VENDOR/services/manual_onboard_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

class VendorBusinessInfo extends StatefulWidget with ManualOnboardService {
  VendorBusinessInfo({super.key});

  @override
  State<VendorBusinessInfo> createState() => VendorBusinessInfoState();
}

class VendorBusinessInfoState extends State<VendorBusinessInfo> {
  final ManualOnboardController manualOnboardController = Get.find<ManualOnboardController>();

  @override
  void initState() {
    super.initState();
    // widget.get_productSuggestionList(context);
    // widget.get_OrganizationList(context);
    // clientreqController.updateGST("33AABCC2462L1ZT");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Form(
                    key: manualOnboardController.manualOnboardModel.vendorBusinessInfoFormKey.value,
                    child: Wrap(
                      runSpacing: 25,
                      spacing: 35,
                      runAlignment: WrapAlignment.end,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasicTextfield(
                              digitsOnly: false,
                              width: 400,
                              readonly: false,
                              text: 'Type of Business/ Service',
                              controller: manualOnboardController.manualOnboardModel.typeOfBusiness.value,
                              icon: Icons.business,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter business type';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 3),
                            const Text(
                              'E.g. Manufacturer, Distributor, Service, Provider, Others etc.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Primary_colors.Color7,
                              ),
                            ),
                          ],
                        ),
                        BasicTextfield(
                          digitsOnly: true,
                          width: 400,
                          readonly: false,
                          text: 'Year of Establishment',
                          controller: manualOnboardController.manualOnboardModel.yearOfEstablishment.value,
                          icon: Icons.date_range_sharp,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter year of establishment';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'GST Number',
                          controller: manualOnboardController.manualOnboardModel.vendorGstNo.value,
                          icon: Icons.receipt,
                          validator: (value) {
                            return Validators.GST_validator(value);
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'PAN Number',
                          controller: manualOnboardController.manualOnboardModel.vendorPanNo.value,
                          icon: Icons.recent_actors_sharp,
                          validator: (value) {
                            return Validators.PAN_validator(value);
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Annual Turnover',
                          controller: manualOnboardController.manualOnboardModel.vendorAnnualTurnover.value,
                          icon: Icons.currency_rupee,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter annual turnover';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'List of Products/Services',
                          controller: manualOnboardController.manualOnboardModel.productInputController,
                          icon: Icons.list_alt_sharp,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter product details';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            // Update the list of products when the input changes
                            manualOnboardController.updateListOfProducts(value);
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'HSN/SAC Code',
                          controller: manualOnboardController.manualOnboardModel.HSNcodeController,
                          icon: Icons.list_alt_sharp,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter HSN/SAC Code';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            // Update the list of products when the input changes
                            manualOnboardController.updateHSNcodeList(value);
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Description of Products/Services',
                          controller: manualOnboardController.manualOnboardModel.descriptionOfProducts.value,
                          icon: Icons.description,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BasicButton(
                                colors: Colors.red,
                                text: 'Back',
                                onPressed: () async {
                                  // if (clientreqController.clientReqModel.detailsformKey.value.currentState?.validate() ?? false) {
                                  widget.backTab(context);
                                  // }
                                },
                              ),
                              const SizedBox(width: 10),
                              BasicButton(
                                colors: Colors.green,
                                text: 'Add Details',
                                onPressed: () async {
                                  // if (clientreqController.clientReqModel.detailsformKey.value.currentState?.validate() ?? false) {
                                  widget.nextTab(context);
                                  // }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(
                    width: 750,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Generating a client requirement is the initial step in acquiring essential data that will be reflected in subsequent processes. Therefore, please exercise caution when handling sensitive information such as phone numbers, email addresses, GST numbers, and physical addresses.',
                      style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
