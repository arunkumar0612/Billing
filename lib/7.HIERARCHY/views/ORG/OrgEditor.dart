// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:ssipl_billing/7.HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7.HIERARCHY/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/7.HIERARCHY/services/Organization_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES-/style.dart';

class OrganizationEditor extends StatefulWidget with OrganizationService {
  final double screenWidth;
  final Rx<OrganizationsData> data;
  final HierarchyController controller;
  OrganizationEditor({
    super.key,
    required this.screenWidth,
    required this.data,
    required this.controller,
  });

  @override
  _OrganizationEditorState createState() => _OrganizationEditorState();
}

class _OrganizationEditorState extends State<OrganizationEditor> {
  void autofill() {
    widget.controller.hierarchyModel.org_IdController.value.text = (widget.data.value.organizationId ?? "").toString();
    widget.controller.hierarchyModel.org_emailIdController.value.text = widget.data.value.email ?? "";
    widget.controller.hierarchyModel.org_NameController.value.text = widget.data.value.organizationName ?? "";
    widget.controller.hierarchyModel.org_CodeController.value.text = widget.data.value.orgCode ?? "";
    widget.controller.hierarchyModel.org_addressController.value.text = widget.data.value.address ?? "";
    widget.controller.hierarchyModel.org_siteTypeController.value.text = widget.data.value.siteType ?? "";
    widget.controller.hierarchyModel.org_contactnoController.value.text = widget.data.value.contactno ?? "";
    widget.controller.hierarchyModel.org_contactpersonController.value.text = widget.data.value.contactperson ?? "";
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
              onChanged: (value) {}, // ✅ Avoids unnecessary Obx()
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

    // Listen to changes in widget.data and trigger autofill
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
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                buildTextField("Organization ID", widget.controller.hierarchyModel.org_IdController.value, true),
                                buildTextField("Email ID", widget.controller.hierarchyModel.org_emailIdController.value, false),
                                buildTextField("Organization Name", widget.controller.hierarchyModel.org_NameController.value, true),
                                buildTextField("Org Code", widget.controller.hierarchyModel.org_CodeController.value, true),
                                buildTextField("Address", widget.controller.hierarchyModel.org_addressController.value, false),
                                buildTextField("Site Type", widget.controller.hierarchyModel.org_siteTypeController.value, true),
                                buildTextField("Contact No", widget.controller.hierarchyModel.org_contactnoController.value, false),
                                buildTextField("Contact Person", widget.controller.hierarchyModel.org_contactpersonController.value, false),
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
                                    widget.controller.hierarchyModel.org_IdController.value.text,
                                    widget.controller.hierarchyModel.org_NameController.value.text,
                                    widget.controller.hierarchyModel.org_emailIdController.value.text,
                                    widget.controller.hierarchyModel.org_contactnoController.value.text,
                                    widget.controller.hierarchyModel.org_addressController.value.text,
                                    widget.controller.hierarchyModel.org_contactpersonController.value.text,
                                    widget.controller.hierarchyModel.org_CodeController.value.text == '' ? null : widget.controller.hierarchyModel.org_CodeController.value.text,
                                    widget.controller.hierarchyModel.org_siteTypeController.value.text,
                                  );
                                }),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(
                          width: 660,
                          child: Text(
                            textAlign: TextAlign.start,
                            'The approved Quotation shown beside can be used as a reference for generating the Invoice. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                            style: TextStyle(
                              color: Primary_colors.Color9,
                              fontSize: Primary_font_size.Text6, // ✅ Replace with an actual font size
                            ),
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
