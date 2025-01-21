import 'package:flutter/material.dart';
import 'package:ssipl_billing/common_modules/style.dart';

class Textfield_1 extends StatelessWidget {
  final bool readonly;
  final String text;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final IconData icon;
  const Textfield_1({
    super.key,
    required this.readonly,
    required this.text,
    required this.controller,
    this.validator,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          TextFormField(
            readOnly: readonly,
            style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Primary_colors.Dark,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),

              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              // labelText: text,
              hintText: text,
              hintStyle: const TextStyle(
                fontSize: Primary_font_size.Text7,
                color: Color.fromARGB(255, 167, 165, 165),
              ),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
