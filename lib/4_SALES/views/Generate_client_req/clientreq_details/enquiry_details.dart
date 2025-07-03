import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/4_SALES/services/ClientReq_services/ClientreqDetails_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES/style.dart';
import 'package:ssipl_billing/UTILS/validators/minimal_validators.dart';

import '../../../controllers/ClientReq_actions.dart';

class enquryDetails extends StatefulWidget with ClientreqDetailsService {
  enquryDetails({super.key});

  @override
  State<enquryDetails> createState() => enquryDetailsState();
}

class enquryDetailsState extends State<enquryDetails> {
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  @override
  void initState() {
    super.initState();
    // widget.get_productSuggestionList(context);
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
                              icon: Icons.receipt_long,
                              validator: (value) {
                                return Validators.GST_validator(value);
                              },
                            ),
                            const SizedBox(height: 25),
                            BasicTextfield(
                              digitsOnly: false,
                              width: 400,
                              readonly: false,
                              text: 'Mode of request',
                              controller: clientreqController.clientReqModel.morController.value,
                              icon: Icons.contact_support,
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
                            BasicTextfield(
                              digitsOnly: false,
                              width: 400,
                              readonly: false,
                              text: 'Client Name',
                              controller: clientreqController.clientReqModel.clientNameController.value,
                              icon: Icons.person,
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
                              icon: Icons.location_on_outlined,
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
                              icon: Icons.badge,
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
                              icon: Icons.home_work_outlined,
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
}
