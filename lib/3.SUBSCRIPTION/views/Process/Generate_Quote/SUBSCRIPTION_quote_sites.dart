// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/controllers/SUBSCRIPTION_Quote_actions.dart';
import 'package:ssipl_billing/3.SUBSCRIPTION/services/Quotation_services/SUBSCRIPTION_QuoteSite_services.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/COMPONENTS-/textfield.dart';
import 'package:ssipl_billing/THEMES-/style.dart';

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
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
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
                                '${i + 1}. ${quoteController.quoteModel.QuoteSiteDetails[i].sitename}', // Display camera type from map
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
                            controller: quoteController.quoteModel.cameraquantityController.value,
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
                            controller: quoteController.quoteModel.addressController.value,
                            icon: Icons.location_on,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Site Address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: 400,
                            child: Row(
                              children: [
                                Expanded(
                                  child:
                                      _buildCustomRadio(context, type: 'billType', title: 'Individual  Bill', value: quoteController.quoteModel.Billingtype_Controller.value, groupValue: 'individual'),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildCustomRadio(context,
                                      type: 'billType', title: 'Consolidate  Bill', value: quoteController.quoteModel.Billingtype_Controller.value, groupValue: 'consolidate'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: 400,
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildCustomRadio(context, type: 'mailType', title: 'Individual Mail', value: quoteController.quoteModel.Mailtype_Controller.value, groupValue: 'individual'),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child:
                                      _buildCustomRadio(context, type: 'mailType', title: 'Consolidate Mail', value: quoteController.quoteModel.Mailtype_Controller.value, groupValue: 'consolidate'),
                                ),
                              ],
                            ),
                          ),
                          // ConstrainedBox(
                          //   constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                          //   child: DropdownButtonFormField<String>(
                          //     menuMaxHeight: 350,
                          //     isExpanded: true,
                          //     dropdownColor: Primary_colors.Dark,
                          //     decoration: const InputDecoration(
                          //         label: Text(
                          //           'Select Billing Type',
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
                          //           Icons.business,
                          //           color: Colors.white,
                          //         )),
                          //     value: quoteController.quoteModel.Billingtype_Controller.value == "" ? null : quoteController.quoteModel.Billingtype_Controller.value,
                          //     items: quoteController.quoteModel.BillingtypeList.map((String value) {
                          //       return DropdownMenuItem<String>(
                          //         value: value,
                          //         child: Text(value, style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7)),
                          //       );
                          //     }).toList(),
                          //     onChanged: (String? newValue) {
                          //       quoteController.updateBillingtype(newValue!);
                          //     },
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'Please Select billing type';
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(height: 25),
                          // ConstrainedBox(
                          //   constraints: const BoxConstraints(maxWidth: 400, maxHeight: 75),
                          //   child: DropdownButtonFormField<String>(
                          //     menuMaxHeight: 350,
                          //     isExpanded: true,
                          //     dropdownColor: Primary_colors.Dark,
                          //     decoration: const InputDecoration(
                          //         label: Text(
                          //           'Select Mail Type',
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
                          //           Icons.business,
                          //           color: Colors.white,
                          //         )),
                          //     value: quoteController.quoteModel.Mailtype_Controller.value == "" ? null : quoteController.quoteModel.Mailtype_Controller.value,
                          //     items: quoteController.quoteModel.MailtypeList.map((String value) {
                          //       return DropdownMenuItem<String>(
                          //         value: value,
                          //         child: Text(value, style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7)),
                          //       );
                          //     }).toList(),
                          //     onChanged: (String? newValue) {
                          //       quoteController.updateMailtype(newValue!);
                          //     },
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'Please Select mail type';
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          // ),
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
                                  quoteController.quoteModel.site_editIndex.value == null ? widget.addsite(context) : widget.updatesite(context);
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
                                    'Site List',
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

  Widget _buildCustomRadio(
    BuildContext context, {
    required String type,
    required String title,
    required String value,
    required String groupValue,
  }) {
    bool isSelected = value == groupValue;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        if (type == 'billType') {
          quoteController.updateBillingtype(groupValue);
        } else if (type == 'mailType') {
          quoteController.updateMailtype(groupValue);
        }
        // clientreqController.update_CustomerType(groupValue);
        false;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Primary_colors.Dark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: Primary_font_size.Text8,
                fontWeight: FontWeight.w500,
                color: isSelected ? Theme.of(context).primaryColor : const Color.fromARGB(255, 180, 180, 180),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
