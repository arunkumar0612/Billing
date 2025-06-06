// ignore_for_file: deprecated_member_use

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart' show SUBSCRIPTION_ClientreqController;
import 'package:ssipl_billing/3.SUBSCRIPTION/services/ClientReq_services/SUBSCRIPTION_ClientreqDetails_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart' show BasicButton;
import 'package:ssipl_billing/COMPONENTS-/textfield.dart' show BasicTextfield;
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart' show Validators;

class enquryDetails extends StatefulWidget with SUBSCRIPTION_ClientreqDetailsService {
  enquryDetails({super.key});

  @override
  State<enquryDetails> createState() => enquryDetailsState();
}

class enquryDetailsState extends State<enquryDetails> {
  final SUBSCRIPTION_ClientreqController clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();
  @override
  void initState() {
    super.initState();
    // widget.get_OrganizationList(context);
    // widget.getEnquiry_processID(context);
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
                    key: clientreqController.clientReqModel.detailsformKey.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 400,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildCustomRadio(context, title: 'New', value: clientreqController.clientReqModel.customerType.value, groupValue: 'New'),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildCustomRadio(context, title: 'Existing', value: clientreqController.clientReqModel.customerType.value, groupValue: 'Existing'),
                                  ),
                                ],
                              ),
                            ),
                            if (clientreqController.clientReqModel.customerType.value == 'Existing') const SizedBox(height: 25),
                            if (clientreqController.clientReqModel.customerType.value == 'Existing')
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                                child: DropdownButtonFormField<String>(
                                  menuMaxHeight: 350,
                                  isExpanded: true,
                                  dropdownColor: Primary_colors.Dark,
                                  decoration: const InputDecoration(
                                      label: Text(
                                        'Select Organization Name',
                                        style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 177, 176, 176), fontWeight: FontWeight.normal),
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
                                        Icons.business,
                                        color: Colors.white,
                                      )),
                                  value: clientreqController.clientReqModel.Org_Controller.value == "" ? null : clientreqController.clientReqModel.Org_Controller.value,
                                  items: clientreqController.clientReqModel.organizationList.map((organization) {
                                    return DropdownMenuItem<String>(
                                      value: organization.organizationName,
                                      child: Text(
                                        organization.organizationName ?? "Unknown",
                                        style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1, overflow: TextOverflow.ellipsis),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    clientreqController.updateOrgName(newValue!);
                                    widget.on_Orgselected(context, newValue);
                                  },
                                  validator: (value) {
                                    if (clientreqController.clientReqModel.Companyname_Controller.value == "" || clientreqController.clientReqModel.Companyname_Controller.value == null) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Select customer type';
                                      }
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            if (clientreqController.clientReqModel.customerType.value == 'Existing') const SizedBox(height: 25),
                            if (clientreqController.clientReqModel.customerType.value == 'Existing')
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                                child: DropdownButtonFormField<String>(
                                  menuMaxHeight: 350,
                                  isExpanded: true,
                                  dropdownColor: Primary_colors.Dark,
                                  decoration: const InputDecoration(
                                      label: Text(
                                        'Select Company Name',
                                        style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 177, 176, 176), fontWeight: FontWeight.normal),
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
                                        Icons.business_center,
                                        color: Colors.white,
                                      )),
                                  value: clientreqController.clientReqModel.Companyname_Controller.value,
                                  items: clientreqController.clientReqModel.CompanyList.map((company) {
                                    return DropdownMenuItem<String>(
                                      value: company.companyName,
                                      child: Text(
                                        company.companyName ?? "Unknown",
                                        style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1, overflow: TextOverflow.ellipsis),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) async {
                                    // clientreqController.updateCompanyID(newValue!);
                                    // clientreqController.update_customerID(newValue, null);
                                    widget.on_Compselected(context, newValue);
                                    // setState(() {});
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
                              text: 'Title',
                              controller: clientreqController.clientReqModel.titleController.value,
                              icon: Icons.title,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter client name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 25),
                            BasicTextfield(
                              digitsOnly: true,
                              width: 400,
                              readonly: false,
                              text: 'Contact Number',
                              controller: clientreqController.clientReqModel.phoneController.value,
                              icon: Icons.phone,
                              validator: (value) {
                                return Validators.phnNo_validator(value);
                              },
                            ),
                            const SizedBox(height: 25),
                            BasicTextfield(
                              digitsOnly: false,
                              width: 400,
                              readonly: false,
                              text: 'Email',
                              controller: clientreqController.clientReqModel.emailController.value,
                              icon: Icons.email,
                              validator: (value) {
                                return Validators.email_validator(value);
                              },
                            ),
                            const SizedBox(height: 25),
                            BasicTextfield(
                              digitsOnly: false,
                              width: 400,
                              readonly: false,
                              text: 'GST',
                              controller: clientreqController.clientReqModel.gstController.value,
                              icon: Icons.receipt,
                              validator: (value) {
                                return null;

                                // return Validators.GST_validator(value);
                              },
                            ),
                            if (clientreqController.clientReqModel.customerType.value != 'Existing') const SizedBox(height: 25),
                            if (clientreqController.clientReqModel.customerType.value != 'Existing')
                              BasicTextfield(
                                digitsOnly: false,
                                width: 400,
                                readonly: false,
                                text: 'Mode of request',
                                controller: clientreqController.clientReqModel.morController.value,
                                icon: Icons.request_page,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the mode of request';
                                  }
                                  return null;
                                },
                              ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            if (clientreqController.clientReqModel.customerType.value == 'Existing')
                              BasicTextfield(
                                digitsOnly: false,
                                width: 400,
                                readonly: false,
                                text: 'Mode of request',
                                controller: clientreqController.clientReqModel.morController.value,
                                icon: Icons.request_page,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the mode of request';
                                  }
                                  return null;
                                },
                              ),
                            if (clientreqController.clientReqModel.customerType.value == 'Existing') const SizedBox(height: 25),
                            BasicTextfield(
                              digitsOnly: false,
                              width: 400,
                              readonly: false,
                              text: 'Client Name',
                              controller: clientreqController.clientReqModel.clientNameController.value,
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter client name';
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
                              controller: clientreqController.clientReqModel.clientAddressController.value,
                              icon: Icons.location_on,
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
                              text: 'Billing name',
                              controller: clientreqController.clientReqModel.billingAddressNameController.value,
                              icon: Icons.credit_card,
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
                              controller: clientreqController.clientReqModel.billingAddressController.value,
                              icon: Icons.home_work,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Billing Address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            FormField<FilePickerResult>(
                              validator: (value) => Validators.fileValidator(clientreqController.clientReqModel.pickedFile.value),
                              builder: (FormFieldState<FilePickerResult> field) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 400,
                                      height: 50,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 53,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: field.hasError ? Colors.red : Colors.black), // Change border color based on validation
                                              borderRadius: BorderRadius.circular(4),
                                              color: Primary_colors.Dark,
                                            ),
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 10),
                                                const Icon(Icons.attach_file, color: Primary_colors.Color1), // Change icon color if error
                                                const SizedBox(width: 8),
                                                SizedBox(
                                                  width: 246,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      if (clientreqController.clientReqModel.pickedFile.value != null)
                                                        Text(
                                                          clientreqController.clientReqModel.pickedFile.value!.files.single.name,
                                                          style: const TextStyle(fontSize: 13, color: Colors.white),
                                                        ),
                                                      if (clientreqController.clientReqModel.pickedFile.value == null)
                                                        const Text(
                                                          'Please Upload MOR reference',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color: Color.fromARGB(255, 161, 160, 160), // Change text color if error
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 2),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await widget.MORaction(context);
                                                    field.didChange(clientreqController.clientReqModel.pickedFile.value);
                                                    // clientreqController.clientReqModel.pickedFile.refresh();
                                                  },
                                                  style: ButtonStyle(
                                                    overlayColor: WidgetStateProperty.all<Color>(Primary_colors.Dark),
                                                    foregroundColor: WidgetStateProperty.all<Color>(Primary_colors.Dark),
                                                    backgroundColor: WidgetStateProperty.all<Color>(Primary_colors.Light),
                                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Choose File',
                                                    style: TextStyle(color: Colors.white, fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (field.hasError)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          field.errorText!,
                                          style: const TextStyle(color: Colors.red, fontSize: 12),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                BasicButton(
                                  colors: Colors.green,
                                  text: 'Add Details',
                                  onPressed: () async {
                                    if (clientreqController.clientReqModel.detailsformKey.value.currentState?.validate() ?? false) {
                                      widget.nextTab(context);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(
                    width: 660,
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

  Widget _buildCustomRadio(
    BuildContext context, {
    required String title,
    required String value,
    required String groupValue,
  }) {
    bool isSelected = value == groupValue;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        clientreqController.update_CustomerType(groupValue);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Primary_colors.Dark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: Primary_font_size.Text8,
                fontWeight: FontWeight.w500,
                color: isSelected ? Theme.of(context).primaryColor : const Color.fromARGB(255, 180, 180, 180),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
