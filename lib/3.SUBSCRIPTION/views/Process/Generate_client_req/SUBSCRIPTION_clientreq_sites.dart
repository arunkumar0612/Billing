import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_ClientReq_actions.dart' show SUBSCRIPTION_ClientreqController;
import 'package:ssipl_billing/3.SUBSCRIPTION/services/ClientReq_services/SUBSCRIPTION_ClientreqSite_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart' show BasicButton;
import 'package:ssipl_billing/COMPONENTS-/textfield.dart' show BasicTextfield;
import 'package:ssipl_billing/THEMES-/style.dart';

class SUBSCRIPTION_clientreqSites extends StatefulWidget with SUBSCRIPTION_ClientreqSiteService {
  SUBSCRIPTION_clientreqSites({super.key});

  @override
  State<SUBSCRIPTION_clientreqSites> createState() => _SUBSCRIPTION_clientreqSitesState();
}

class _SUBSCRIPTION_clientreqSitesState extends State<SUBSCRIPTION_clientreqSites> {
  final SUBSCRIPTION_ClientreqController clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();

  Widget clientreq_SiteDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < clientreqController.clientReqModel.clientReqSiteDetails.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.editsite(i);
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Primary_colors.Light),
                  height: 40,
                  width: 300,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 230,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              '${i + 1}. ${clientreqController.clientReqModel.clientReqSiteDetails[i].siteName}', // Display camera type from map
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                clientreqController.removeFromSiteList(i);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: clientreqController.clientReqModel.siteFormkey.value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          BasicTextfield(
                            digitsOnly: false,
                            width: 400,
                            readonly: false,
                            text: 'Site Name',
                            controller: clientreqController.clientReqModel.siteNameController.value,
                            icon: Icons.business,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Site name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          BasicTextfield(
                            digitsOnly: true,
                            width: 400,
                            readonly: false,
                            text: 'Camera Quantity',
                            controller: clientreqController.clientReqModel.cameraquantityController.value,
                            icon: Icons.photo_camera,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Camera Quantity';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          BasicTextfield(
                            digitsOnly: false,
                            width: 400,
                            readonly: false,
                            text: 'Address',
                            controller: clientreqController.clientReqModel.addressController.value,
                            icon: Icons.location_on,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Site Address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BasicButton(
                                colors: Colors.red,
                                text: clientreqController.clientReqModel.site_editIndex.value == null ? 'Back' : 'Cancle',
                                onPressed: () {
                                  clientreqController.clientReqModel.site_editIndex.value == null ? clientreqController.backTab() : widget.resetEditingState(); // Reset editing state when going back
                                },
                              ),
                              const SizedBox(width: 30),
                              BasicButton(
                                colors: clientreqController.clientReqModel.site_editIndex.value == null ? Colors.blue : Colors.orange,
                                text: clientreqController.clientReqModel.site_editIndex.value == null ? 'Add Site' : 'Update',
                                onPressed: () {
                                  clientreqController.clientReqModel.site_editIndex.value == null ? widget.addsite(context) : widget.updateSite(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 85),
                          const SizedBox(
                            // width: 750,
                            child: Text(
                              textAlign: TextAlign.center,
                              "Site details in client requirement play a crucial role in the procurement process. Please ensure accuracy when entering Site names, camera quantities and physical addresses, as these details directly impact order processing, inventory management, and subsequent workflows.",
                              style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                            ),
                          )
                        ],
                      ),
                    ),
                    // if (length != 0) const SizedBox(width: 60),
                    if (clientreqController.clientReqModel.clientReqSiteDetails.isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 25),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Primary_colors.Dark,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10, top: 15),
                              child: Column(
                                children: [
                                  const Text(
                                    'Product List',
                                    style: TextStyle(fontSize: Primary_font_size.Text10, color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 295,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: clientreq_SiteDetailss(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          if (clientreqController.clientReqModel.clientReqSiteDetails.isNotEmpty)
                            BasicButton(
                              colors: Colors.green,
                              text: 'Submit',
                              onPressed: () {
                                clientreqController.nextTab();
                              },
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
