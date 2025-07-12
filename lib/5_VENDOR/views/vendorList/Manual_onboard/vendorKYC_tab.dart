import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/controllers/vendorList_actions.dart';
import 'package:ssipl_billing/5_VENDOR/services/vendorList_services.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

class VendorKYC extends StatefulWidget with VendorlistServices {
  VendorKYC({super.key});

  @override
  State<VendorKYC> createState() => VendorKYCState();
}

class VendorKYCState extends State<VendorKYC> {
  final VendorListController vendorListController = Get.find<VendorListController>();

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
                    key: vendorListController.vendorListModel.vendorKYCformKey.value,
                    child: Wrap(
                      runSpacing: 25,
                      spacing: 35,
                      runAlignment: WrapAlignment.end,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Name of the Vendor/Company',
                          controller: vendorListController.vendorListModel.vendorNameController.value,
                          icon: Icons.title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter vendor name';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Address',
                          controller: vendorListController.vendorListModel.vendorAddressController.value,
                          icon: Icons.location_on,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter vendor address';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'State',
                          controller: vendorListController.vendorListModel.vendorAddressStateController.value,
                          icon: Icons.location_city,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter vendor address';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: true,
                          width: 400,
                          readonly: false,
                          text: 'Pincode',
                          controller: vendorListController.vendorListModel.vendorAddressPincodeController.value,
                          icon: Icons.location_pin,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter pincode';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Contact Person Name',
                          controller: vendorListController.vendorListModel.contactpersonName.value,
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter contact person name';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Contact Person Designation',
                          controller: vendorListController.vendorListModel.contactPersonDesignation.value,
                          icon: Icons.work,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter contact person designation';
                            }
                            return null;
                          },
                        ),
                        BasicTextfield(
                          digitsOnly: true,
                          width: 400,
                          readonly: false,
                          text: 'Contact Person Phone No',
                          controller: vendorListController.vendorListModel.contactPersonPhoneNumber.value,
                          icon: Icons.phone,
                          validator: (value) {
                            return Validators.phnNo_validator(value);
                          },
                        ),
                        BasicTextfield(
                            digitsOnly: false,
                            width: 400,
                            readonly: false,
                            text: 'Email',
                            controller: vendorListController.vendorListModel.contactPersonEmail.value,
                            icon: Icons.email,
                            validator: (value) {
                              return Validators.email_validator(value);
                            }),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BasicButton(
                                colors: Colors.green,
                                text: 'Add Details',
                                onPressed: () async {
                                  if (vendorListController.vendorListModel.vendorKYCformKey.value.currentState?.validate() ?? false) {
                                    widget.nextTab(context);
                                  }
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
                      'KYC details are crucial for verifying vendor authenticity and are required to successfully onboard new vendors.',
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
