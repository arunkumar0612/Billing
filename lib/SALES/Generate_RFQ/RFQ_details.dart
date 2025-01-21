import 'package:flutter/material.dart';
import 'package:ssipl_billing/SALES/Generate_RFQ/generateRFQ.dart';
import 'package:ssipl_billing/SALES/Generate_RFQ/RFQ_template.dart';
import 'package:ssipl_billing/button.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';

class RFQDetails extends StatefulWidget {
  const RFQDetails({super.key});

  @override
  State<RFQDetails> createState() => _RFQDetailsState();
}

class _RFQDetailsState extends State<RFQDetails> {
  // final TextEditingController vendorname_controller = TextEditingController();
  final TextEditingController vendor_address_controller = TextEditingController();
  final TextEditingController vendor_phone_controller = TextEditingController();
  final TextEditingController vendor_email_controller = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // vendorname_controller.text = vendor_name;
    vendor_address_controller.text = vendor_address;
    vendor_phone_controller.text = vendor_phoneno;
    vendor_email_controller.text = vendor_email;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Form(
                key: formKey1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        // Textfield_1(
                        //   readonly: false,
                        //   text: 'Title',
                        //   controller: titleController,
                        //   icon: Icons.title,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter Title';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // const SizedBox(height: 25),
                        // Textfield_1(
                        //   readonly: false,
                        //   text: 'Vendor name',
                        //   controller: vendorname_controller,
                        //   icon: Icons.people,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter Vendor name';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: DropdownButtonFormField<String>(
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
                            value: vendor_name,
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
                              setState(
                                () {
                                  vendor_name = newValue!;
                                },
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select the vendor';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Vendor Address ',
                          controller: vendor_address_controller,
                          icon: Icons.location_history_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Vendor Address';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Vendor Phone number',
                          controller: vendor_phone_controller,
                          icon: Icons.price_change,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Vendor Email address',
                          controller: vendor_email_controller,
                          icon: Icons.price_change,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email Address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Button1(
                              colors: Colors.green,
                              text: 'Add Details',
                              onPressed: () {
                                if (formKey1.currentState?.validate() ?? false) {
                                  // vendor_name = vendorname_controller.text;
                                  vendor_email = vendor_address_controller.text;
                                  vendor_phoneno = vendor_phone_controller.text;
                                  vendor_address = vendor_email_controller.text;

                                  GenerateRFQ.nextTab();
                                }
                                // if (_formKey.currentState?.validate() == true) {

                                // }
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
                'The Client requirement shown beside can be used as a reference for generating the RFQ. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
