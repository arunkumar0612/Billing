import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/services/SUBSCRIPTION/Quotation_services/SUBSCRIPTION_QuoteSite_services.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';

class SUBSCRIPTION_QuoteSites extends StatefulWidget with SUBSCRIPTION_QuotesiteService {
  SUBSCRIPTION_QuoteSites({super.key});

  @override
  State<SUBSCRIPTION_QuoteSites> createState() => _SUBSCRIPTION_QuoteSitesState();
}

class _SUBSCRIPTION_QuoteSitesState extends State<SUBSCRIPTION_QuoteSites> {
  final SUBSCRIPTION_QuoteController quoteController = Get.find<SUBSCRIPTION_QuoteController>();

  Widget clientreq_SiteDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < quoteController.quoteModel.QuoteSiteDetails.length; i++)
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
                              '${i + 1}. ${quoteController.quoteModel.QuoteSiteDetails[i].siteName}', // Display camera type from map
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                quoteController.removeFromProductList(i);
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
                key: quoteController.quoteModel.siteFormkey.value,
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
                            controller: quoteController.quoteModel.siteNameController.value,
                            icon: Icons.home,
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
                            controller: quoteController.quoteModel.cameraquantityController.value,
                            icon: Icons.production_quantity_limits,
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
                            controller: quoteController.quoteModel.addressController.value,
                            icon: Icons.location_city,
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
                                text: quoteController.quoteModel.site_editIndex.value == null ? 'Back' : 'Cancle',
                                onPressed: () {
                                  quoteController.quoteModel.site_editIndex.value == null ? quoteController.backTab() : widget.resetEditingState(); // Reset editing state when going back
                                },
                              ),
                              const SizedBox(width: 30),
                              BasicButton(
                                colors: quoteController.quoteModel.site_editIndex.value == null ? Colors.blue : Colors.orange,
                                text: quoteController.quoteModel.site_editIndex.value == null ? 'Add Site' : 'Update',
                                onPressed: () {
                                  quoteController.quoteModel.site_editIndex.value == null ? widget.addsite(context) : widget.updateSite(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 85),
                          const SizedBox(
                            // width: 750,
                            child: Text(
                              textAlign: TextAlign.center,
                              "The client requirement Site details play a crucial role in the procurement process. Please ensure accuracy when entering Site names and quantities, as these details directly impact order processing, inventory management, and subsequent workflows.",
                              style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
                            ),
                          )
                        ],
                      ),
                    ),
                    // if (length != 0) const SizedBox(width: 60),
                    if (quoteController.quoteModel.QuoteSiteDetails.isNotEmpty)
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
                          if (quoteController.quoteModel.QuoteSiteDetails.isNotEmpty)
                            BasicButton(
                              colors: Colors.green,
                              text: 'Submit',
                              onPressed: () {
                                quoteController.nextTab();
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
