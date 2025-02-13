import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/ClientReq_actions.dart';

import 'package:ssipl_billing/services/SALES/ClientReq_services/Clientreqdetails_service.dart';
import 'package:ssipl_billing/services/SALES/sales_service.dart';
import 'package:ssipl_billing/utils/validators/minimal_validators.dart';
// import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:ssipl_billing/views/screens/SALES/Sales.dart';

class customerDetails extends StatefulWidget with ClientreqDetailsService, SalesServices {
  customerDetails({super.key});

  @override
  State<customerDetails> createState() => customerDetailsState();
}

class customerDetailsState extends State<customerDetails> {
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  // List<ValueItem> client_list = [
  //   const ValueItem(label: 'Option 1', value: '1'),
  //   const ValueItem(label: 'Option 2', value: '2'),
  //   const ValueItem(label: 'Option 3', value: '3'),
  //   const ValueItem(label: 'Option 4', value: '4'),
  //   const ValueItem(label: 'Option 5', value: '5'),
  //   const ValueItem(label: 'Option 6', value: '6')
  // ];
  late MultiValueDropDownController _cntMulti;

  @override
  void initState() {
    // TODO: implement initState
    _cntMulti = MultiValueDropDownController();
    super.initState();
    widget.get_OrganizatioList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
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
                      Textfield_1(
                        readonly: false,
                        text: 'GST',
                        controller: clientreqController.clientReqModel.gstController.value,
                        icon: Icons.people,
                        validator: (value) {
                          Validators.GST_validator(value);
                          return null;
                        },
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                        child: DropdownButtonFormField<String>(
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
                                Icons.people,
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
                      Textfield_1(
                        readonly: false,
                        text: 'Client Address ',
                        controller: clientreqController.clientReqModel.clientAddressController.value,
                        icon: Icons.location_history_outlined,
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
                                Icons.people,
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
                            widget.on_Compselected(context, newValue);
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Select customer type';
                            }
                            return null;
                          },
                        ),
                      ),
                      Textfield_1(
                        readonly: false,
                        text: 'Billing Address name',
                        controller: clientreqController.clientReqModel.billingAddressNameController.value,
                        icon: Icons.price_change,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Billing Address name';
                          }
                          return null;
                        },
                      ),
                      Textfield_1(
                        readonly: false,
                        text: 'Billing Address',
                        controller: clientreqController.clientReqModel.billingAddressController.value,
                        icon: Icons.price_change,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Billing Address';
                          }
                          return null;
                        },
                      ),
                      clientreqController.clientReqModel.BranchList.isNotEmpty
                          ? ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                              child: DropDownTextField.multiSelection(
                                submitButtonTextStyle: const TextStyle(color: Primary_colors.Color1),
                                submitButtonColor: Primary_colors.Color3,
                                controller: _cntMulti,
                                textStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                                // initialValue: const ["name1", "name2", "name8", "name3"],
                                displayCompleteItem: true,
                                checkBoxProperty: CheckBoxProperty(fillColor: WidgetStateProperty.all<Color>(Colors.white), checkColor: Colors.blue),
                                dropDownList: clientreqController.clientReqModel.BranchList,
                                onChanged: (val) {
                                  print(val);
                                  setState(() {});
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
                                    Icons.merge_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Textfield_1(
                              readonly: false,
                              text: 'Select Branch Name',
                              controller: clientreqController.clientReqModel.billingAddressController.value,
                              icon: Icons.merge_outlined,
                              validator: (value) {
                                return null;
                              },
                            ),
                      Textfield_1(
                        readonly: false,
                        text: 'Mode of request',
                        controller: clientreqController.clientReqModel.morController.value,
                        icon: Icons.price_change,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the mode of request';
                          }
                          return null;
                        },
                      ),
                      Textfield_1(
                        readonly: false,
                        text: 'Contact Number',
                        controller: clientreqController.clientReqModel.phoneController.value,
                        icon: Icons.people,
                        validator: (value) {
                          Validators.phnNo_validator(value);
                          return null;
                        },
                      ),
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 53,
                              decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(4), color: Primary_colors.Dark),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.file_copy,
                                    color: Primary_colors.Color1,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
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
                                            'Please Upload MOR referene',
                                            style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 161, 160, 160)),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      clientreqController.pickFile(context);
                                      widget.add_details(context);
                                    },
                                    style: ButtonStyle(
                                      overlayColor: WidgetStateProperty.all<Color>(
                                        Primary_colors.Dark,
                                      ),
                                      foregroundColor: WidgetStateProperty.all<Color>(
                                        Primary_colors.Dark,
                                      ),
                                      backgroundColor: WidgetStateProperty.all<Color>(Primary_colors.Light),
                                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
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
                      Textfield_1(
                        readonly: false,
                        text: 'Email',
                        controller: clientreqController.clientReqModel.emailController.value,
                        icon: Icons.people,
                        validator: (value) {
                          Validators.email_validator(value);
                          return null;
                        },
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Button1(
                              colors: Colors.green,
                              text: 'Add Details',
                              onPressed: () async {
                                if (clientreqController.clientReqModel.detailsformKey.value.currentState?.validate() ?? false) {
                                  widget.add_details(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 25),
                const SizedBox(
                  width: 660,
                  child: Text(
                    textAlign: TextAlign.center,
                    'The Client requirement shown beside can be used as a reference for generating the clientreq. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                    style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
