import 'dart:io';

// ignore: library_prefixes
import 'package:excel/excel.dart' as Excel;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/COMPONENTS-/Loading.dart';

class import_excel {
  static List<Map<String, dynamic>> excelData = [];

  String? _filePath;
  final loader = LoadingOverlay();

  Future<bool> pickExcelFile(context) async {
    try {
      loader.start(context);
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xls', 'xlsx'], dialogTitle: "PICK EXCEL - site_package_list", lockParentWindow: true);
      loader.stop();

      if (result != null && result.files.single.path != null) {
        _filePath = result.files.single.path!;
        await readExcel(_filePath!, context);
        return excelData.isNotEmpty; // ✅ Return success if data is read
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error in pickExcelFile: $e");
      }
    } finally {
      loader.stop();
    }
    return false; // ❌ Error or cancel
  }

  Future<void> readExcel(String filePath, context) async {
    try {
      var bytes = File(filePath).readAsBytesSync();
      var excel = Excel.Excel.decodeBytes(bytes);

      excelData.clear(); // ✅ Always clear before reading

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
              }
            }

            if (hasNonNullValue) {
              excelData.add(rowData);
            }
          }
        }
      }

      if (kDebugMode) {
        print('✅ Excel data length: ${excelData.length}');
        print('⚠️ Mismatched rows: $mismatchedRows');
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
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error in readExcel: $e");
      }
    }
  }
}
