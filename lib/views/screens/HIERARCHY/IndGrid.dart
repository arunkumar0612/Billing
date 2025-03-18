// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/Indcard.dart';
import 'package:ssipl_billing/views/components/Org_card.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/Hierarchy.dart';

class BranchGrid extends StatelessWidget {
  final BuildContext context;
  BranchGrid({
    super.key,
    required this.context,
  });
  var individuals = <Map<String, dynamic>>[].obs;
  var organizations = <Map<String, dynamic>>[].obs;
  var OrgID = "0".obs;
  File? picked_file;

  dynamic Fetch_individual_list() async {
    try {
      individuals.clear();
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      final requestBody = {"sitetype": 0, "filter": 'ALL', "organizationid": OrgID.value, "companyid": "0"};

      final response = await http.post(Uri.parse("http://192.168.0.200:8080/admin/sitelist"), headers: headers, body: json.encode(requestBody));

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final code = decodedResponse['code'];

        if (code == true) {
          List<dynamic> branches = decodedResponse['sql'];

          Set<String> individualIdSet = {};
          for (var ind in branches) {
            String individualId = ind['Branch_id'].toString();

            if (!individualIdSet.contains(individualId)) {
              individualIdSet.add(individualId);

              Uint8List? fileBytes;
              if (ind['Branch_Logo'] != null && ind['Branch_Logo']['data'] != null) {
                try {
                  List<int> logoBytes = List<int>.from(ind['Branch_Logo']['data']); // ✅ Correct Casting
                  fileBytes = Uint8List.fromList(logoBytes);
                } catch (e) {
                  print("Error parsing logo bytes: $e");
                }
              }

              // Use an empty image if conversion fails
              Uint8List placeholderImage = Uint8List.fromList([]);

              Map<String, dynamic> indMap = {
                'Id': individualId,
                'Name': ind['Branch_name'],
                'email': ind['Email_id'],
                'logo': fileBytes ?? placeholderImage, // Use placeholder if parsing fails
              };

              individuals.add(indMap);
            }
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Fetching individual List failed'),
                content: const Text('message'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Fetch_individual_list();
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
              title: const Text('Fetching individual List failed'),
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
        uploadImage(file, 'branch', id);
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
          Fetch_individual_list();
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
                      Fetch_individual_list();
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

  @override
  Widget build(BuildContext context) {
    Fetch_organization_list();
    Fetch_individual_list();
    return Obx(() {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Enterprise_Hierarchy.widget_type.value = 2;
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 15,
                          )),
                      const Text(
                        "BRANCHES",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IntrinsicWidth(
                      child: Obx(() => DropdownButtonFormField<String>(
                            value: OrgID.value == '0' ? null : OrgID.value, // Ensure reset
                            hint: const Text(
                              'Organization Filter',
                              style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 212, 212, 212)),
                            ),
                            style: const TextStyle(color: Colors.blue),
                            dropdownColor: Primary_colors.Light,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(13),
                              prefixIcon: Icon(Icons.people, color: Colors.white),
                            ),
                            items: organizations.map((company) {
                              return DropdownMenuItem<String>(
                                value: company['Id'], // Ensure the value is a String
                                child: Text(company['Name'], style: const TextStyle(fontSize: 12, color: Colors.white)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              OrgID.value = newValue ?? '0'; // Update selected value
                              Fetch_individual_list();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select customer type';
                              }
                              return null;
                            },
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        OrgID.value = '0'; // Reset dropdown selection
                        Fetch_organization_list();
                        Fetch_individual_list(); // Refresh data
                      },
                      icon: const Icon(
                        Icons.clear,
                        size: 15,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  children: individuals.map<Widget>((org) {
                    return GestureDetector(
                      onTap: () => pickFile(context, int.parse(org['Id']!)),
                      child: BranchCard(
                        name: org['Name']!,
                        id: org['Id']!,
                        email: org['email'] ?? "",
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
