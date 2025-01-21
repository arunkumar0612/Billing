// import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:ssipl_billing/SALES/Generate_client_requirements/clientreq_template.dart';
import 'package:ssipl_billing/SALES/Generate_client_requirements/generate_clientreq.dart';
// import 'package:ssipl_billing/SALES/Generate_client_requirements/generate_clientreq.dart';
import 'package:ssipl_billing/button.dart';
// import 'package:ssipl_billing/common_modules/api.dart';
import 'package:ssipl_billing/common_modules/encrypt_decrypt.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';
// import 'package:http/http.dart' as http;

class clientreqDetails extends StatefulWidget {
  final String customer_type;
  const clientreqDetails({super.key, required this.customer_type});
  // static String clientreq_client_addr_name = '';
  static TextEditingController clientnameController = TextEditingController();
  static TextEditingController clientaddressController = TextEditingController();
  static TextEditingController billingaddressnameController = TextEditingController();
  static TextEditingController billingaddressController = TextEditingController();
  static TextEditingController MOR_Controller = TextEditingController();
  static TextEditingController phone_Controller = TextEditingController();
  static TextEditingController Email_Controller = TextEditingController();
  static TextEditingController gst_Controller = TextEditingController();
  static String clientreq_table_heading = "";
  static String clientreq_no = '1';
  @override
  State<clientreqDetails> createState() => clientreqDetailsState();
}

class clientreqDetailsState extends State<clientreqDetails> {
  // String? _selectedModelType;
  static FilePickerResult? pickedFile;
  EncryptWithAES obj = const EncryptWithAES();
  File? MOR;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // initialDirectory: r'\\192.168.0.14', // Specify your network path here
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      setState(() {
        MOR = File(result.files.single.path!);
      });
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

  // Future<String> upload_MOR_reference_file() async {
  //   if (MOR == null) {
  //     // Show error if no file is selected
  //     await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Error'),
  //         content: const Text('No file selected. Please choose a file to upload.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //     return '';
  //   }

  //   try {
  //     var uri = Uri.parse(API.Upload_MOR_API);

  //     var request = http.MultipartRequest('POST', uri);
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'file',
  //       MOR!.path,
  //     ));
  //     request.headers['Content-Type'] = 'multipart/form-data';

  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       var responseData = await response.stream.bytesToString();
  //       var decodedData = jsonDecode(responseData);

  //       final message = decodedData['message'];
  //       final code = decodedData['code'];

  //       if (code == false) {
  //         // Show failure dialog
  //         await showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: const Text('Failed to Upload'),
  //               content: Text(message),
  //               actions: [
  //                 TextButton(
  //                   onPressed: () => Navigator.of(context).pop(),
  //                   child: const Text('OK'),
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //         return '';
  //       } else {
  //         // Return file path on success
  //         return decodedData['path'];
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print('API Request Failed with Status Code: ${response.statusCode}');
  //       }
  //       return '';
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error occurred: $e');
  //     }

  //     // Show error dialog
  //     await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Error'),
  //         content: Text('An error occurred: $e'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //     return '';
  //   }
  // }

  // void _addDetails(String MOR_path) async {
  //   String? valueToToken = await obj.get_stored_token();

  //   final formData = {
  //     "name": clientnameController.text,
  //     "emailid": Email_Controller.text,
  //     "phoneno": phone_Controller.text,
  //     "address": clientaddressController.text,
  //     "gst": gst_Controller.text,
  //     "billingaddressname": billingaddressnameController.text,
  //     "billingaddress": billingaddressController.text,
  //     "modeofrequest": MOR_Controller.text,
  //     "MORreference": MOR_path
  //   };

  //   final dataToEncrypt = jsonEncode(formData);
  //   final encryptedData = obj.encryptWithAES(valueToToken.toString().substring(0, 16), dataToEncrypt);

  //   final requestData = {
  //     "STOKEN": valueToToken,
  //     "querystring": encryptedData,
  //   };

  //   final response = await http.post(
  //     Uri.parse(API.sales_add_details_API),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(requestData),
  //   );
  //   if (response.statusCode == 200) {
  //     final responseData = jsonDecode(response.body);
  //     final encryptedResponse = responseData['encryptedResponse'];
  //     final decryptedResponse = obj.decryptWithAES(valueToToken.toString().substring(0, 16), encryptedResponse);
  //     final decodedResponse = jsonDecode(decryptedResponse);
  //     final Code = decodedResponse['code'];
  //     final Message = decodedResponse['message'];

  //     if (!Code) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('Add details Failed'),
  //             content: Text(Message),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else {
  //       Generate_clientreq.nextTab();

  //       // showDialog(
  //       //   context: context,
  //       //   builder: (context) => AlertDialog(
  //       //     title: const Text('Success'),
  //       //     content: const Text('Details added Successfully.'),
  //       //     actions: [
  //       //       ElevatedButton(
  //       //         onPressed: () {
  //       //           Navigator.of(context).pop();
  //       //         },
  //       //         child: const Text('OK'),
  //       //       ),
  //       //     ],
  //       //   ),
  //       // );
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print('API Request Failed with Status Code: ${response.statusCode}');
  //     }
  //   }
  // }

  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // clientnameController.text = clientreqDetails.clientreq_client_addr_name;
    // clientaddressController.text = clientreq_client_addr;
    // billingaddressnameController.text = clientreq_bill_addr_name;
    // billingaddressController.text = clientreq_bill_addr;
    // phone_Controller.text = clientreq_contact_number;
    // Email_Controller.text = clientreq_email;
    // gst_Controller.text = clientreq_GST;
    // MOR_Controller.text = clientreq_MOR;

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
                          ? Textfield_1(
                              readonly: false,
                              text: 'Client Name',
                              controller: clientreqDetails.clientnameController,
                              icon: Icons.person,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter client name';
                                }
                                return null;
                              },
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
                                value: clientreqDetails.clientnameController.text == "" ? null : clientreqDetails.clientnameController.text,
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
                                      clientreqDetails.clientnameController.text = newValue!;
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
                        controller: clientreqDetails.phone_Controller,
                        icon: Icons.people,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter contact number';
                          }
                          if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Please enter a valid 10-digit number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      Textfield_1(
                        readonly: false,
                        text: 'Email',
                        controller: clientreqDetails.Email_Controller,
                        icon: Icons.people,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the email';
                          }
                          if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      Textfield_1(
                        readonly: false,
                        text: 'Client Address ',
                        controller: clientreqDetails.clientaddressController,
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
                        controller: clientreqDetails.gst_Controller,
                        icon: Icons.people,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter GST number';
                          }
                          if (!RegExp(r'^[0-9]{15}$').hasMatch(value)) {
                            return 'Please enter a valid 15-digit GST number';
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
                        controller: clientreqDetails.billingaddressnameController,
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
                        controller: clientreqDetails.billingaddressController,
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
                        controller: clientreqDetails.MOR_Controller,
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
                                      // clientreqDetails.clientreq_client_addr_name = clientreqDetails.clientnameController.text;
                                      // clientreq_client_addr = clientaddressController.text;
                                      // clientreq_bill_addr_name = billingaddressnameController.text;
                                      // clientreq_bill_addr = billingaddressController.text;
                                      // clientreq_MOR = MOR_Controller.text;
                                      // clientreq_email = Email_Controller.text;
                                      // clientreq_contact_number = phone_Controller.text;
                                      // clientreq_GST = gst_Controller.text;
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
                            onPressed: () async {
                              if (formKey1.currentState?.validate() ?? false) {
                                // clientreqDetails.clientreq_client_addr_name = clientnameController.text;
                                // clientreq_client_addr = clientaddressController.text;
                                // clientreq_bill_addr_name = billingaddressnameController.text;
                                // clientreq_bill_addr = billingaddressController.text;
                                // clientreq_MOR = MOR_Controller.text;
                                // clientreq_email = Email_Controller.text;
                                // clientreq_contact_number = phone_Controller.text;
                                // clientreq_GST = gst_Controller.text;
                                // await upload_MOR_reference_file();
                                // _addDetails(await upload_MOR_reference_file());
                                // _addDetails();
                                // Generate_clientreq.nextTab();
                                Generate_clientreq.nextTab();
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
              ),
            ),
            const SizedBox(height: 25),
            const SizedBox(
              width: 660,
              child: Text(
                textAlign: TextAlign.center,
                'The Client requirement shown beside can be used as a reference for generating the clientreq. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
