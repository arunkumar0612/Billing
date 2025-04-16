// ignore_for_file: non_constant_identifier_names, camel_case_types, constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart' as Excel;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      print(e);
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
              var value = row[headers.indexOf(validHeaders[i])]?.value;
              if (value != null) {
                rowData[validHeaders[i]!] = value.toString();
                hasNonNullValue = true;
              }
            }

            if (hasNonNullValue) {
              excelData.add(rowData);
            }
          }
        }
      }

      print('Excel data length: ${excelData.length}');
      print('Mismatched rows: $mismatchedRows');

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
      print(e);
    }
  }

  Future<String?> update_site(BuildContext parentContext, String api) async {
    try {
      String? message;
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final requestBody = excelData;
      loader.start(parentContext);
      final response = await http.post(
        Uri.parse(api),
        headers: headers,
        body: json.encode(requestBody),
      );

      loader.stop();

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        print(decodedResponse);
        if (decodedResponse is List && decodedResponse.isNotEmpty) {
          showDialog(
            context: parentContext,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Response'),
                content: SizedBox(
                  width: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: decodedResponse.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: decodedResponse[index]["name"],
                                style: const TextStyle(color: Colors.red),
                              ),
                              TextSpan(
                                text: ': ${decodedResponse[index]["message"]} - ${decodedResponse[index]["id"]}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                actions: [
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
        } else {
          message = null;
        }
      }
      return message;
    } catch (e) {
      print(e);
    }
    return null;
  }

  void showExcelDataPopup(BuildContext context1, String api) {
    print(api);
    showDialog(
      context: context1,
      builder: (BuildContext context) {
        return Dialog(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: SizedBox(
            width: 1200,
            height: 700,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 55,
                        columns: excelData.isNotEmpty
                            ? excelData.first.keys
                                .map((String key) => DataColumn(
                                        label: Text(
                                      key,
                                      style: const TextStyle(color: Color.fromARGB(255, 177, 27, 27), fontSize: 10),
                                    )))
                                .toList()
                            : [],
                        rows: excelData.where((data) => data.values.any((value) => value != null)).map((data) {
                          return DataRow(
                            cells: data.keys.map((key) {
                              return DataCell(
                                Text(
                                  data[key]?.toString() ?? '', // Handle null values gracefully
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Container(
                    color: const Color.fromARGB(66, 90, 90, 90),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                            ),
                            height: 30,
                            width: 100,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel', style: TextStyle(color: Colors.white))),
                          ),
                          const SizedBox(width: 40),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue,
                            ),
                            height: 30,
                            width: 100,
                            child: TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await update_site(context1, api);
                                },
                                child: const Text(
                                  'Proceed',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ));
      },
    );
  }
}
