import 'package:flutter/material.dart';
import 'package:ssipl_billing/common_modules/style.dart';

class Button1 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color colors;
  const Button1({
    super.key,
    required this.text,
    required this.colors,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      // height: 40,
      decoration: BoxDecoration(
        color: colors,
        // gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
        //   colors,
        //   colors,
        //   Primary_colors.Light,
        // ]),
        borderRadius: BorderRadius.circular(5),
      ),

      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
        ),
      ),
    );
  }
}
