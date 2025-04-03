// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/services/Hierarchy_services/Company_service.dart';

import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/button.dart';

class CompanyEditor extends StatefulWidget with CompanyService {
  final double screenWidth;
  final Rx<CompanysData> data;
  final HierarchyController controller;

  CompanyEditor({
    super.key,
    required this.screenWidth,
    required this.data,
    required this.controller,
  });

  @override
  _CompanyEditorState createState() => _CompanyEditorState();
}

class _CompanyEditorState extends State<CompanyEditor> {
  void autofill() {
    widget.controller.hierarchyModel.comp_IdController.value.text = (widget.data.value.customerId ?? "").toString();
    widget.controller.hierarchyModel.comp_NameController.value.text = widget.data.value.customerName ?? "";
    widget.controller.hierarchyModel.comp_siteTypeController.value.text = widget.data.value.siteType ?? "";
    widget.controller.hierarchyModel.comp_organizationidController.value.text = (widget.data.value.organizationId ?? "").toString();
    widget.controller.hierarchyModel.comp_contactpersonController.value.text = widget.data.value.contactperson ?? "";
    widget.controller.hierarchyModel.comp_contactpersonnoController.value.text = widget.data.value.contactpersonno ?? "";
    widget.controller.hierarchyModel.comp_emailIdController.value.text = widget.data.value.email ?? "";
    widget.controller.hierarchyModel.comp_addressController.value.text = widget.data.value.address ?? "";
    widget.controller.hierarchyModel.comp_billingaddressController.value.text = widget.data.value.billingAddress ?? "";
    widget.controller.hierarchyModel.comp_pannumberController.value.text = widget.data.value.pannumber ?? "";
    widget.controller.hierarchyModel.comp_cinnoController.value.text = widget.data.value.cinno ?? "";
    widget.controller.hierarchyModel.comp_ccodeController.value.text = widget.data.value.ccode ?? "";
    if (mounted) setState(() {});
  }

  Widget buildTextField(String label, TextEditingController controller, bool readOnly) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(color: Primary_colors.Color9, fontSize: Primary_font_size.Text8),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "  : ",
              style: TextStyle(color: Primary_colors.Color9, fontSize: Primary_font_size.Text8),
            ),
          ),
          Expanded(
            flex: 4,
            child: TextFormField(
              maxLines: null,
              readOnly: readOnly,
              controller: controller,
              style: TextStyle(color: readOnly ? const Color.fromARGB(255, 167, 167, 167) : Primary_colors.Color1, fontSize: Primary_font_size.Text8),
              decoration: InputDecoration(
                fillColor: Colors.black,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: readOnly ? Colors.white : Primary_colors.Color3, width: 2),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 94, 94, 94), width: 1),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    autofill();
    ever(widget.data, (_) {
      autofill();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: GlassmorphicContainer(
        width: widget.screenWidth * 0.3,
        height: double.infinity,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 78, 77, 77).withOpacity(0.1),
            const Color.fromARGB(255, 105, 104, 104).withOpacity(0.05),
          ],
        ),
        borderGradient: const LinearGradient(
          colors: [
            Primary_colors.Light,
            Primary_colors.Dark,
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TabBar(
                indicatorColor: Primary_colors.Color4,
                tabs: [
                  Tab(text: 'KYC'),
                  // Tab(text: 'PACKAGE'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                buildTextField("Company ID", widget.controller.hierarchyModel.comp_IdController.value, true),
                                buildTextField("Customer Name", widget.controller.hierarchyModel.comp_NameController.value, false),
                                buildTextField("Site type", widget.controller.hierarchyModel.comp_siteTypeController.value, true),
                                buildTextField("Organization ID", widget.controller.hierarchyModel.comp_organizationidController.value, true),
                                buildTextField("Contact person", widget.controller.hierarchyModel.comp_contactpersonController.value, false),
                                buildTextField("Contact no", widget.controller.hierarchyModel.comp_contactpersonnoController.value, false),
                                buildTextField("Email ID", widget.controller.hierarchyModel.comp_emailIdController.value, false),
                                buildTextField("Address", widget.controller.hierarchyModel.comp_addressController.value, false),
                                buildTextField("Billing address", widget.controller.hierarchyModel.comp_billingaddressController.value, false),
                                buildTextField("PAN number", widget.controller.hierarchyModel.comp_pannumberController.value, false),
                                buildTextField("CIN number", widget.controller.hierarchyModel.comp_cinnoController.value, true),
                                buildTextField("Customer code", widget.controller.hierarchyModel.comp_ccodeController.value, true),
                              ],
                            ),
                          ),
                        ),
                        const Divider(color: Colors.white),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // BasicButton(text: "Revert", colors: Colors.redAccent, onPressed: () {}),
                            BasicButton(
                              text: "Update",
                              colors: Colors.blue,
                              onPressed: () {
                                widget.UpdateKYC(
                                  context,
                                  widget.controller.hierarchyModel.comp_IdController.value.text,
                                  widget.controller.hierarchyModel.comp_NameController.value.text,
                                  widget.controller.hierarchyModel.comp_siteTypeController.value.text,
                                  widget.controller.hierarchyModel.comp_organizationidController.value.text,
                                  widget.controller.hierarchyModel.comp_contactpersonController.value.text,
                                  widget.controller.hierarchyModel.comp_contactpersonnoController.value.text,
                                  widget.controller.hierarchyModel.comp_emailIdController.value.text,
                                  widget.controller.hierarchyModel.comp_addressController.value.text,
                                  widget.controller.hierarchyModel.comp_billingaddressController.value.text,
                                  widget.controller.hierarchyModel.comp_pannumberController.value.text,
                                  widget.controller.hierarchyModel.comp_cinnoController.value.text,
                                  widget.controller.hierarchyModel.comp_ccodeController.value.text,
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(
                          width: 660,
                          child: Text(
                            textAlign: TextAlign.center,
                            'The approved Quotation shown beside can be used as a reference for generating the Invoice. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                            style: TextStyle(color: Primary_colors.Color9, fontSize: Primary_font_size.Text7),
                          ),
                        ),
                      ],
                    ),
                    // Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
