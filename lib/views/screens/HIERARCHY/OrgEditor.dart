import 'package:flutter/material.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/button.dart';

class OrganizationEditor extends StatefulWidget {
  final double screenWidth;
  const OrganizationEditor({super.key, required this.screenWidth});

  @override
  _OrganizationEditorState createState() => _OrganizationEditorState();
}

class _OrganizationEditorState extends State<OrganizationEditor> {
  final TextEditingController organizationIdController = TextEditingController(text: "1");
  final TextEditingController emailIdController = TextEditingController(text: "thulasinathan@khivrajmail.com");
  final TextEditingController organizationNameController = TextEditingController(text: "KHIVRAJ GROUP");
  final TextEditingController orgCodeController = TextEditingController(text: "null");
  final TextEditingController addressController = TextEditingController(text: "623, ANNA SALAI, CHENNAI – 600 006,TAMILNADU");
  final TextEditingController siteTypeController = TextEditingController(text: "live");

  @override
  void dispose() {
    organizationIdController.dispose();
    emailIdController.dispose();
    organizationNameController.dispose();
    orgCodeController.dispose();
    addressController.dispose();
    siteTypeController.dispose();
    super.dispose();
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
              style: TextStyle(color: readOnly ? const Color.fromARGB(255, 66, 66, 66) : Colors.black),
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
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.3,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 189, 189, 189),
            Color.fromARGB(255, 77, 77, 77),
            // Primary_colors.Dark,
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
          )),
          buildTextField("Organization ID", organizationIdController, true),
          buildTextField("Email ID", emailIdController, false),
          buildTextField("Organization Name", organizationNameController, true),
          buildTextField("Org Code", orgCodeController, true),
          buildTextField("Address", addressController, false),
          buildTextField("Site Type", siteTypeController, true),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BasicButton(text: "Revert", colors: Colors.redAccent, onPressed: () {}),
              BasicButton(text: "Update", colors: Colors.blue, onPressed: () {}),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: 660,
            child: Text(
              textAlign: TextAlign.center,
              'The approved Quotation shown beside can be used as a reference for generating the Invoice. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
              style: TextStyle(color: Color.fromARGB(255, 46, 46, 46), fontSize: Primary_font_size.Text7),
            ),
          )
        ],
      ),
    );
  }
}
