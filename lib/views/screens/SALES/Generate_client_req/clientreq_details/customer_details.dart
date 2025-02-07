import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SALEScontrollers/ClientReq_actions.dart';
import 'package:ssipl_billing/services/SALES/ClientReq_services/Clientreqdetails_service.dart';
import 'package:ssipl_billing/utils/validators/minimal_validators.dart';
// import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class customerDetails extends StatefulWidget with ClientreqdetailsService {
  customerDetails({super.key});

  @override
  State<customerDetails> createState() => customerDetailsState();
}

class customerDetailsState extends State<customerDetails> {
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  List<ValueItem> client_list = [
    const ValueItem(label: 'Option 1', value: '1'),
    const ValueItem(label: 'Option 2', value: '2'),
    const ValueItem(label: 'Option 3', value: '3'),
    const ValueItem(label: 'Option 4', value: '4'),
    const ValueItem(label: 'Option 5', value: '5'),
    const ValueItem(label: 'Option 6', value: '6')
  ];
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
                      // const SizedBox(height: 25),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Primary_colors.Dark,
                          decoration: const InputDecoration(
                              label: Text(
                                'Customer Type',
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
                          value: clientreqController.clientReqModel.clientNameController.value.text == "" ? null : clientreqController.clientReqModel.clientNameController.value.text,
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
                            clientreqController.updateClientName(newValue!);
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
                          dropdownColor: Primary_colors.Dark,
                          decoration: const InputDecoration(
                              label: Text(
                                'Select Customer Name',
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
                          value: clientreqController.clientReqModel.clientNameController.value.text == "" ? null : clientreqController.clientReqModel.clientNameController.value.text,
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
                            clientreqController.updateClientName(newValue!);
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
                          value: clientreqController.clientReqModel.clientNameController.value.text == "" ? null : clientreqController.clientReqModel.clientNameController.value.text,
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
                            clientreqController.updateClientName(newValue!);
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
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Primary_colors.Dark,
                          decoration: const InputDecoration(
                              label: Text(
                                'Select Consolidate',
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
                          value: clientreqController.clientReqModel.clientNameController.value.text == "" ? null : clientreqController.clientReqModel.clientNameController.value.text,
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
                            clientreqController.updateClientName(newValue!);
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
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                        child: MultiSelectDropDown(
                          searchBackgroundColor: Primary_colors.Color1,
                          hint: 'Select Client',
                          selectedOptionTextColor: Primary_colors.Color1,
                          dropdownBorderRadius: 10,
                          dropdownBackgroundColor: Primary_colors.Dark,
                          selectedOptionBackgroundColor: Primary_colors.Dark,
                          optionsBackgroundColor: Primary_colors.Dark,
                          padding: const EdgeInsets.all(10),
                          dropdownMargin: 0,
                          searchEnabled: true,
                          hintColor: Colors.white,
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 102, 102, 102),
                          ),
                          inputDecoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)), color: Primary_colors.Dark, borderRadius: BorderRadius.circular(5)),
                          onOptionSelected: (options) {
                            setState(() {});
                          },
                          options: client_list,
                          maxItems: client_list.length,
                          selectionType: SelectionType.multi,
                          chipConfig: const ChipConfig(
                            deleteIconColor: Color.fromARGB(255, 105, 105, 105),
                            backgroundColor: Primary_colors.Light,
                            wrapType: WrapType.scroll,
                          ),
                          dropdownHeight: 300,
                          optionTextStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                          selectedOptionIcon: const Icon(Icons.check_circle),
                          clearIcon: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
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
                      // const SizedBox(height: 25),

                      // const SizedBox(height: 25),

                      // const SizedBox(height: 25),

                      // const SizedBox(height: 25),

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
                      // const SizedBox(height: 25),

                      // const SizedBox(height: 25),

                      // ConstrainedBox(
                      //   constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                      //   child: DropdownButtonFormField<String>(
                      //     dropdownColor: Primary_colors.Dark,
                      //     decoration: const InputDecoration(
                      //         label: Text(
                      //           'Select Type',
                      //           style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 177, 176, 176)),
                      //         ),
                      //         // hintText: 'Customer Type',hintStyle: TextStyle(),
                      //         contentPadding: EdgeInsets.all(13),
                      //         labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                      //         filled: true,
                      //         fillColor: Primary_colors.Dark,
                      //         border: OutlineInputBorder(
                      //           borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      //         ),
                      //         enabledBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      //         ),
                      //         focusedBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(),
                      //         ),
                      //         prefixIcon: Icon(
                      //           Icons.people,
                      //           color: Colors.white,
                      //         )),
                      //     value: clientreqController.clientReqModel.clientNameController.value.text == "" ? null : clientreqController.clientReqModel.clientNameController.value.text,
                      //     items: <String>[
                      //       'Option 1',
                      //       'Option 2',
                      //     ].map((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(
                      //           value,
                      //           style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                      //         ),
                      //       );
                      //     }).toList(),
                      //     onChanged: (String? newValue) {
                      //       clientreqController.updateClientName(newValue!);
                      //     },
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'Please Select customer type';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),

                      // const SizedBox(height: 25),

                      // const SizedBox(height: 25),

                      // const SizedBox(height: 25),

                      // const SizedBox(
                      //   height: 25,
                      // ),

                      // const SizedBox(
                      //   height: 25,
                      // ),

                      // const SizedBox(
                      //   height: 25,
                      // ),
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
