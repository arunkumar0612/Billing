import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../themes/style.dart';

Future<bool?> Basic_dialog({
  required BuildContext context,
  required String title,
  required String content,
  required bool showCancel, // Show the Cancel button
  VoidCallback? onOk, // Optional action for the OK button
}) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // shadowColor: Primary_colors.Color3,
        titlePadding: const EdgeInsets.all(5),
        backgroundColor: const Color.fromARGB(255, 194, 198, 253), // Matching background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Consistent with Snackbar
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Primary_colors.Color3,
          ),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Text(
              title,
              style: const TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(color: Primary_colors.Light, fontSize: 12), // Adjusting text color for visibility
        ),
        actions: [
          if (showCancel)
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel returns `false`
              child: const Text('Cancel', style: TextStyle(color: Primary_colors.Light, fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // OK returns `true`
              if (onOk != null) {
                onOk(); // Call onOk only if it's provided
              }
            },
            child: const Text('OK', style: TextStyle(color: Primary_colors.Light, fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}

void Basic_SnackBar(BuildContext context, String message) {
  Flushbar(
    message: message,
    margin: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: Primary_colors.Color3,
    icon: const Icon(Icons.check_circle, color: Primary_colors.Color1),
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.BOTTOM, // Change to BOTTOM if needed
    animationDuration: const Duration(milliseconds: 500),
    leftBarIndicatorColor: Primary_colors.Color1,
    boxShadows: [
      BoxShadow(
        color: Primary_colors.Color3.withOpacity(0.3),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  ).show(context);
}
