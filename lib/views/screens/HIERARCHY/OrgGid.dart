import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/views/components/Org_card.dart';
import 'package:http/http.dart' as http;

class OrganizationGrid extends StatelessWidget {
  // final List<Map<String, dynamic>> organizations;
  // final Function(BuildContext, int) onTap;
  final BuildContext context;

  OrganizationGrid({
    super.key,
    // required this.organizations,
    // required this.onTap,
    required this.context,
  });
  var organizations = <Map<String, dynamic>>[].obs;

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
          // setState(() {});
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

  File? picked_file;

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
        uploadImage(file, 'organization', id);
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
          Fetch_organization_list();
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
    Fetch_organization_list();
    return Obx(() {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            children: organizations.map<Widget>((org) {
              return GestureDetector(
                onTap: () => pickFile(context, int.parse(org['Id']!)),
                child: OrganizationCard(
                  name: org['Name']!,
                  id: org['Id']!,
                  email: org['email']!,
                  imageBytes: org['logo']! as Uint8List,
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
