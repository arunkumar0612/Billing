import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';

import '../../../../../controllers/SALEScontrollers/ClientReq_actions.dart';
import '../../../../../services/SALES/ClientReq_services/Clientreqdetails_service.dart';
import '../../../../../utils/validators/minimal_validators.dart';

class enquryDetails extends StatefulWidget with ClientreqDetailsService {
  enquryDetails({super.key});

  @override
  State<enquryDetails> createState() => enquryDetailsState();
}

class enquryDetailsState extends State<enquryDetails> {
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.getEnquiry_processID(context);
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Textfield_1(
                            readonly: false,
                            text: 'Title',
                            controller: clientreqController.clientReqModel.titleController.value,
                            icon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter client name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
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
                          const SizedBox(height: 25),
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
                          const SizedBox(height: 25),
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
                          const SizedBox(
                            height: 25,
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
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Textfield_1(
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
                          const SizedBox(height: 25),
                          Textfield_1(
                            readonly: false,
                            text: 'Billing name',
                            controller: clientreqController.clientReqModel.billingAddressNameController.value,
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
                            controller: clientreqController.clientReqModel.billingAddressController.value,
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
                                          widget.MORaction(context);
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
                                  if (clientreqController.clientReqModel.detailsformKey.value.currentState?.validate() ?? false) {
                                    widget.add_details(context);
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
