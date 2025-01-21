import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_client_req/sub_clientreq_template.dart';
import 'package:ssipl_billing/SUBSCRIPTION/Generate_client_req/sub_generate_clientreq.dart';
import 'package:ssipl_billing/button.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';

class sub_clientreqDetails extends StatefulWidget {
  final String customer_type;
  const sub_clientreqDetails({super.key, required this.customer_type});

  @override
  State<sub_clientreqDetails> createState() => sub_clientreqDetailsState();
}

class sub_clientreqDetailsState extends State<sub_clientreqDetails> {
  final TextEditingController clientnameController = TextEditingController();
  final TextEditingController clientaddressController = TextEditingController();
  final TextEditingController billingaddressnameController = TextEditingController();
  final TextEditingController billingaddressController = TextEditingController();
  final TextEditingController MOR_Controller = TextEditingController();
  final TextEditingController phone_Controller = TextEditingController();
  final TextEditingController Email_Controller = TextEditingController();
  final TextEditingController gst_Controller = TextEditingController();
  // String? _selectedModelType;
  static FilePickerResult? pickedFile;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // initialDirectory: r'\\192.168.0.14', // Specify your network path here
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg'],
    );
    if (result != null) {
      if (kDebugMode) {
        print(result);
      }
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        // 2 MB size limit
        if (kDebugMode) {
          print('Selected file exceeds 2MB in size.');
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Selected file exceeds 2MB in size.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        setState(() {
          pickedFile = null;
        });
      } else {
        setState(() {
          pickedFile = result;
          if (kDebugMode) {
            print(pickedFile.toString());
          }
        });

        if (kDebugMode) {
          print("Selected File Name: ${result.files.single.name}");
        }
      }
    }
  }

  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    clientnameController.text = sub_clientreq_client_addr_name;
    clientaddressController.text = sub_clientreq_client_addr;
    billingaddressnameController.text = sub_clientreq_bill_addr_name;
    billingaddressController.text = sub_clientreq_bill_addr;
    phone_Controller.text = sub_clientreq_contact_number;
    Email_Controller.text = sub_clientreq_email;
    gst_Controller.text = sub_clientreq_GST;
    MOR_Controller.text = sub_clientreq_MOR;

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
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 25),
                        widget.customer_type == 'Enquiry'
                            ? SizedBox(
                                width: 400,
                                height: 50,
                                child: TextFormField(
                                  controller: clientnameController,
                                  style: const TextStyle(fontSize: 13, color: Colors.white),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(1),
                                    filled: true,
                                    fillColor: Primary_colors.Dark,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                                    hintStyle: const TextStyle(
                                      fontSize: Primary_font_size.Text7,
                                      color: Color.fromARGB(255, 167, 165, 165),
                                    ),
                                    hintText: 'Enter Name',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                                  ),
                                ),
                              )
                            : ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
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
                                  value: sub_clientreq_client_addr_name == "" ? null : sub_clientreq_client_addr_name,
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
                                        sub_clientreq_client_addr_name = newValue!;
                                      },
                                    );
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
                        Textfield_1(
                          readonly: false,
                          text: 'Contact Number',
                          controller: phone_Controller,
                          icon: Icons.people,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter contact number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Email',
                          controller: Email_Controller,
                          icon: Icons.people,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Client Address ',
                          controller: clientaddressController,
                          icon: Icons.location_history_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Client Address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'GST',
                          controller: gst_Controller,
                          icon: Icons.people,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Client GST';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Textfield_1(
                          readonly: false,
                          text: 'Billing Address name',
                          controller: billingaddressnameController,
                          icon: Icons.price_change,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Billing Address name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Textfield_1(
                          readonly: false,
                          text: 'Billing Address',
                          controller: billingaddressController,
                          icon: Icons.price_change,
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
                        Textfield_1(
                          readonly: false,
                          text: 'Mode of request',
                          controller: MOR_Controller,
                          icon: Icons.price_change,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the mode of request';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
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
                                          if (pickedFile != null)
                                            Text(
                                              pickedFile!.files.single.name,
                                              style: const TextStyle(fontSize: 13, color: Colors.white),
                                            ),
                                          if (pickedFile == null)
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
                                        sub_clientreq_client_addr_name = clientnameController.text;
                                        sub_clientreq_client_addr = clientaddressController.text;
                                        sub_clientreq_bill_addr_name = billingaddressnameController.text;
                                        sub_clientreq_bill_addr = billingaddressController.text;
                                        sub_clientreq_MOR = MOR_Controller.text;
                                        sub_clientreq_email = Email_Controller.text;
                                        sub_clientreq_contact_number = phone_Controller.text;
                                        sub_clientreq_GST = gst_Controller.text;
                                        _pickFile();
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
                        const SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Button1(
                              colors: Colors.green,
                              text: 'Add Details',
                              onPressed: () {
                                if (formKey1.currentState?.validate() ?? false) {
                                  sub_clientreq_client_addr_name = clientnameController.text;
                                  sub_clientreq_client_addr = clientaddressController.text;
                                  sub_clientreq_bill_addr_name = billingaddressnameController.text;
                                  sub_clientreq_bill_addr = billingaddressController.text;
                                  sub_clientreq_MOR = MOR_Controller.text;
                                  sub_clientreq_email = Email_Controller.text;
                                  sub_clientreq_contact_number = phone_Controller.text;
                                  sub_clientreq_GST = gst_Controller.text;

                                  Generate_sub_clientreq.nextTab();
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
                'The Client requirement shown beside can be used as a reference for generating the sub_clientreq. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
