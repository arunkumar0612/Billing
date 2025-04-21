// ignore_for_file: non_constant_identifier_names, camel_case_types, constant_identifier_names, library_prefixes

import 'dart:io';

import 'package:excel/excel.dart' as Excel;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';

class import_excel {
  static List<Map<String, dynamic>> excelData = [];

  String? _filePath;
  final loader = LoadingOverlay();

  Future<String?> pickExcelFile(context) async {
    try {
      loader.start(context);
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xls', 'xlsx'],
      );
      loader.stop();
      if (result != null && result.files.single.path != null) {
        _filePath = result.files.single.path!;
        readExcel(_filePath ?? "", context);
        return _filePath;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<void> readExcel(String filePath, context) async {
    try {
      var bytes = File(filePath).readAsBytesSync();
      var excel = Excel.Excel.decodeBytes(bytes);

      List<Map<String, dynamic>> mismatchedRows = [];

      for (var table in excel.tables.keys) {
        var rows = excel.tables[table]?.rows;
        if (rows != null && rows.isNotEmpty) {
          var headers = rows.first.map((cell) => cell?.value?.toString()).toList();
          var validHeaders = headers.where((header) => header != null && header.isNotEmpty).toList();

          for (var row in rows.skip(1)) {
            Map<String, dynamic> rowData = {};
            bool hasNonNullValue = false;

            if (row.length != validHeaders.length) {
              mismatchedRows.add({
                'rowIndex': rows.indexOf(row) + 1,
                'expectedLength': validHeaders.length,
                'actualLength': row.length,
              });
            }

            for (var i = 0; i < validHeaders.length; i++) {
              int cellIndex = headers.indexOf(validHeaders[i]);
              var cellValue = row.length > cellIndex ? row[cellIndex]?.value : null;

              if (cellValue != null && cellValue.toString().trim().isNotEmpty) {
                rowData[validHeaders[i]!] = cellValue.toString();
                hasNonNullValue = true;
              } else {
                if (kDebugMode) {
                  print('⚠️ Empty cell at Row ${rows.indexOf(row) + 1}, Column "${validHeaders[i]}"');
                }
              }
            }

            if (hasNonNullValue) {
              excelData.add(rowData);
            }
          }
        }
      }

      if (kDebugMode) {
        print('Excel data length: ${excelData.length}');
      }
      if (kDebugMode) {
        print('Mismatched rows: $mismatchedRows');
      }

      if (mismatchedRows.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Mismatched Row Lengths'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: mismatchedRows.map((row) {
                  return Text('Row ${row['rowIndex']}: Expected ${row['expectedLength']} columns, found ${row['actualLength']} columns');
                }).toList(),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
