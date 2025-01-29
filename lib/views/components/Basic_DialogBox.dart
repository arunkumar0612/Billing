import 'package:flutter/material.dart';

Future<bool?> Basic_dialog({
  required BuildContext context,
  required String title,
  required String content,
  VoidCallback? onOk, // Optional action for the OK button
}) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: const TextStyle(color: Colors.black)),
        content: Text(content, style: const TextStyle(color: Colors.black54)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Cancel returns `false`
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // OK returns `true`
              if (onOk != null) {
                onOk(); // Call onOk only if it's provided
              }
            },
            child: const Text('OK', style: TextStyle(color: Colors.green)),
          ),
        ],
      );
    },
  );
}
