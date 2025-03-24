import 'package:flutter/material.dart';

class CompanyEditor extends StatefulWidget {
  final double screenWidth;

  const CompanyEditor({super.key, required this.screenWidth});

  @override
  _CompanyEditorState createState() => _CompanyEditorState();
}

class _CompanyEditorState extends State<CompanyEditor> {
  final TextEditingController CompanyIdController = TextEditingController(text: "1");
  final TextEditingController customerNameController = TextEditingController(text: "KHIVRAJ MOTORS PRIVATE LIMITED");
  final TextEditingController ccodeController = TextEditingController(text: "KMCIAS");
  final TextEditingController emailIdController = TextEditingController(text: "thulasinathan@khivrajmail.com");
  final TextEditingController siteTypeController = TextEditingController(text: "live");

  Widget buildTextField(String label, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "  : ",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              fillColor: Colors.grey,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      padding: const EdgeInsets.all(10),
      width: widget.screenWidth * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextField("Company ID", CompanyIdController),
          const SizedBox(height: 15),
          buildTextField("Customer Name", customerNameController),
          const SizedBox(height: 15),
          buildTextField("CCODE", ccodeController),
          const SizedBox(height: 15),
          buildTextField("Email ID", emailIdController),
          const SizedBox(height: 15),
          buildTextField("Site Type", siteTypeController),
        ],
      ),
    );
  }
}
