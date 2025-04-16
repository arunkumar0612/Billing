import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES-/style.dart';
import 'package:ssipl_billing/UTILS-/validators/minimal_validators.dart';
import 'package:ssipl_billing/4.SALES/controllers/ClientReq_actions.dart';
import 'package:ssipl_billing/4.SALES/services/ClientReq_services/ClientreqDetails_service.dart';
import 'package:ssipl_billing/4.SALES/services/sales_service.dart';

class customerDetails extends StatefulWidget with ClientreqDetailsService, SalesServices {
  customerDetails({super.key});

  @override
  State<customerDetails> createState() => customerDetailsState();
}

class customerDetailsState extends State<customerDetails> {
  final ClientreqController clientreqController = Get.find<ClientreqController>();

  @override
  void initState() {
    super.initState();
    widget.get_productSuggestionList(context);
    widget.get_OrganizationList(context);
    clientreqController.updateGST("33AABCC2462L1ZT");
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
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'GST',
                          controller: clientreqController.clientReqModel.gstController.value,
                          icon: Icons.receipt,
                          validator: (value) {
                            return Validators.GST_validator(value);
                          },
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                          child: DropdownButtonFormField<String>(
                            menuMaxHeight: 350,
                            isExpanded: true,
                            dropdownColor: Primary_colors.Dark,
                            decoration: const InputDecoration(
                                label: Text(
                                  'Select Organization Name',
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
                              if (value == null || value.isEmpty) {
                                return 'Please Select customer type';
                              }
                              return null;
                            },
                          ),
                        ),
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
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                          child: DropdownButtonFormField<String>(
                            menuMaxHeight: 350,
                            isExpanded: true,
                            dropdownColor: Primary_colors.Dark,
                            decoration: const InputDecoration(
                                label: Text(
                                  'Select Company Name',
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
                                  Icons.business_center,
                                  color: Colors.white,
                                )),
                            value: clientreqController.clientReqModel.Company_Controller.value,
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
                              clientreqController.updateCompanyName(newValue!);
                              clientreqController.update_customerID(newValue, null);
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
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Billing Address name',
                          controller: clientreqController.clientReqModel.billingAddressNameController.value,
                          icon: Icons.credit_card,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Billing Address name';
                            }
                            return null;
                          },
                        ),
                        clientreqController.clientReqModel.BranchList_valueModel.isNotEmpty
                            ? ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                                child: DropDownTextField.multiSelection(
                                  clearOption: false,
                                  submitButtonTextStyle: const TextStyle(color: Primary_colors.Color1),
                                  submitButtonColor: Primary_colors.Color3,
                                  controller: clientreqController.clientReqModel.cntMulti.value,
                                  textStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                                  displayCompleteItem: true,
                                  checkBoxProperty: CheckBoxProperty(fillColor: WidgetStateProperty.all<Color>(Colors.white), checkColor: Colors.blue),
                                  dropDownList: clientreqController.clientReqModel.BranchList_valueModel,
                                  onChanged: (selectedList) {
                                    Future.delayed(const Duration(milliseconds: 10), () {
                                      if (mounted) {
                                        clientreqController.update_selectedBranches(selectedList);
                                      }
                                    });
                                  },
                                  textFieldDecoration: const InputDecoration(
                                    suffixIconColor: Color.fromARGB(255, 99, 98, 98),
                                    filled: true,
                                    fillColor: Primary_colors.Dark,
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),

                                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                    // labelText: text,
                                    hintText: 'Select Branch Name',
                                    hintStyle: const TextStyle(
                                      fontSize: Primary_font_size.Text7,
                                      color: Color.fromARGB(255, 167, 165, 165),
                                    ),
                                    border: const OutlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.account_tree,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 400,
                                child: TextFormField(
                                  readOnly: true,
                                  style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                                  // controller: controller,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 12, 15, 22),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),

                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                    // labelText: text,
                                    hintText: 'Select Branch Name',
                                    hintStyle: TextStyle(
                                      fontSize: Primary_font_size.Text7,
                                      color: Color.fromARGB(255, 131, 130, 130),
                                    ),
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.account_tree,
                                      color: Color.fromARGB(255, 187, 187, 187),
                                    ),
                                  ),
                                  // validator: validator,
                                ),
                              ),
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
                        BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Mode of request',
                          controller: clientreqController.clientReqModel.morController.value,
                          icon: Icons.request_quote,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the mode of request';
                            }
                            return null;
                          },
                        ),
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
                                            const Icon(Icons.file_copy, color: Primary_colors.Color1), // Change icon color if error
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
                                                style: TextStyle(color: Colors.white, fontSize: 11),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
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
                                  if (clientreqController.clientReqModel.detailsformKey.value.currentState?.validate() ?? false) {
                                    widget.nextTab(context);
                                  }
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
