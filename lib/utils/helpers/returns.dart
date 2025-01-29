import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadConfigFile(String path) async {
  final configString = await rootBundle.loadString(path);
  return jsonDecode(configString);
}
