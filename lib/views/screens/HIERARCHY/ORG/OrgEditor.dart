import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/button.dart';

class OrganizationEditor extends StatefulWidget {
  final double screenWidth;
  final Rx<OrganizationsData> data;
  final HierarchyController controller;
  const OrganizationEditor({
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
    if (mounted) setState(() {});
  }

  Widget buildTextField(String label, TextEditingController controller, bool readOnly) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "  : ",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
            child: TextFormField(
              maxLines: null,
              readOnly: readOnly,
              controller: controller,
              onChanged: (value) {}, // ✅ Avoids unnecessary Obx()
              style: TextStyle(
                color: readOnly ? const Color.fromARGB(255, 66, 66, 66) : Colors.black,
              ),
              decoration: InputDecoration(
                fillColor: Colors.black,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: readOnly ? Colors.black : Primary_colors.Color3, width: 2),
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
    return Container(
      width: widget.screenWidth * 0.3,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 249, 249),
            Color.fromARGB(255, 189, 189, 189),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Edit',
              style: TextStyle(fontSize: 20),
            ),
          ),
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
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BasicButton(text: "Revert", colors: Colors.redAccent, onPressed: () {}),
              BasicButton(text: "Update", colors: Colors.blue, onPressed: () {}),
            ],
          ),
          const SizedBox(height: 30),
          const SizedBox(
            width: 660,
            child: Text(
              textAlign: TextAlign.center,
              'The approved Quotation shown beside can be used as a reference for generating the Invoice. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
              style: TextStyle(
                color: Color.fromARGB(255, 46, 46, 46),
                fontSize: 14, // ✅ Replace with an actual font size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
