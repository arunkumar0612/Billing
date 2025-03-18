// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ssipl_billing/views/components/Comp_card.dart';

import 'package:ssipl_billing/views/screens/HIERARCHY/Hierarchy.dart';

class CompanyGrid extends StatelessWidget {
  final BuildContext context;
  CompanyGrid({
    super.key,
    required this.context,
  });

  var companys = <Map<String, dynamic>>[].obs;
  var organizations = <Map<String, dynamic>>[].obs;
  var OrgID = "0".obs;
  File? picked_file;
  dynamic Fetch_organization_list() async {
    try {
      organizations.clear();
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      final requestBody = {"sitetype": 0};

      final response = await http.post(Uri.parse("http://192.168.0.200:8080/admin/organization"), headers: headers, body: json.encode(requestBody));

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final code = decodedResponse['code'];

        if (code == true) {
          List<dynamic> data = decodedResponse['data'];

          Set<String> organizationIdSet = {};
          for (var org in data) {
            String organizationId = org['Organization_id'].toString();

            if (!organizationIdSet.contains(organizationId)) {
              organizationIdSet.add(organizationId);

              Uint8List? fileBytes;
              if (org['Organization_Logo'] != null && org['Organization_Logo']['data'] != null) {
                try {
                  List<int> logoBytes = List<int>.from(org['Organization_Logo']['data']); // ✅ Correct Casting
                  fileBytes = Uint8List.fromList(logoBytes);
                } catch (e) {
                  print("Error parsing logo bytes: $e");
                }
              }

              // Use an empty image if conversion fails
              Uint8List placeholderImage = Uint8List.fromList([]);

              Map<String, dynamic> orgMap = {
                'Id': organizationId,
                'Name': org['Organization_Name'],
                'email': org['Email_id'],
                'logo': fileBytes ?? placeholderImage, // Use placeholder if parsing fails
              };

              organizations.add(orgMap);
            }
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Fetching organization List failed'),
                content: const Text('message'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Fetch_organization_list();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Fetching organization List failed'),
              content: const Text('Server Error!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
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

  dynamic Fetch_company_list() async {
    try {
      companys.clear();
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      final requestBody = {"sitetype": 404, "organizationid": OrgID.value};

      final response = await http.post(Uri.parse("http://192.168.0.200:8080/admin/companylist"), headers: headers, body: json.encode(requestBody));

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final code = decodedResponse['code'];

        if (code == true) {
          List<dynamic> data = decodedResponse['data'];

          Set<String> companyIdSet = {};
          for (var comp in data) {
            String companyId = comp['Customer_id'].toString();

            if (!companyIdSet.contains(companyId)) {
              companyIdSet.add(companyId);

              Uint8List? fileBytes;
              if (comp['Customer_Logo'] != null && comp['Customer_Logo']['data'] != null) {
                try {
                  List<int> logoBytes = List<int>.from(comp['Customer_Logo']['data']); // ✅ Correct Casting
                  fileBytes = Uint8List.fromList(logoBytes);
                } catch (e) {
                  print("Error parsing logo bytes: $e");
                }
              }

              // Use an empty image if conversion fails
              Uint8List placeholderImage = Uint8List.fromList([]);

              Map<String, dynamic> compMap = {
                'Id': companyId,
                'Name': comp['Customer_name'],
                'email': comp['Email_id'],
                'logo': fileBytes ?? placeholderImage, // Use placeholder if parsing fails
              };

              companys.add(compMap);
            }
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Fetching company List failed'),
                content: const Text('message'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Fetch_company_list();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Fetching company List failed'),
              content: const Text('Server Error!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
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

  Future<bool> pickFile(BuildContext context, int id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result != null) {
      final file = File(result.files.single.path!);
      final fileLength = await file.length();

      if (fileLength > 2 * 1024 * 1024) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(content: const Text('Selected file exceeds 2MB in size.'), actions: [ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))]),
        );

        picked_file = null;
      } else {
        picked_file = file;
        uploadImage(file, 'company', id);
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  dynamic uploadImage(File file, String logoType, int id) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      List<int> fileBytes = await file.readAsBytes();
      print("Binary Data: ${fileBytes.length}"); // Prints file in binary format
      final requestBody = {"logotype": logoType, "id": id, "image": fileBytes};

      final response = await http.post(Uri.parse("http://192.168.0.200:8081/admin/uploadlogo"), headers: headers, body: json.encode(requestBody));

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final code = decodedResponse['code'];

        if (code == true) {
          Fetch_company_list();
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Upload failed'),
                content: const Text('message'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Fetch_company_list();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Upload failed'),
              content: const Text('Server Error!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
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

  @override
  Widget build(BuildContext context) {
    Fetch_company_list();
    Fetch_organization_list();
    return Obx(() {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Enterprise_Hierarchy.widget_type.value = 1;
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 15,
                    )),
                const Text(
                  "COMPANYS",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  children: companys.map<Widget>((org) {
                    return GestureDetector(
                      onTap: () => pickFile(context, int.parse(org['Id']!)),
                      child: CompanyCard(
                        name: org['Name']!,
                        id: org['Id']!,
                        email: org['email']!,
                        imageBytes: org['logo']! as Uint8List,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
