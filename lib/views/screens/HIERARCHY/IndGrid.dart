// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ssipl_billing/views/components/Indcard.dart';
import 'package:ssipl_billing/views/components/Loading.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/CompGrid.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/Hierarchy.dart';

class BranchGrid extends StatefulWidget {
  const BranchGrid({super.key});

  @override
  _BranchGridState createState() => _BranchGridState();
}

class _BranchGridState extends State<BranchGrid> with SingleTickerProviderStateMixin {
  var individuals = <Map<String, dynamic>>[].obs;
  var organizations = <Map<String, dynamic>>[].obs;
  var OrgID = "0".obs;
  File? picked_file;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  final loader = LoadingOverlay();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0), // Slide from left
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));

    apiCall();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller.forward();
    });
  }

  void apiCall() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // await Future.wait([
    //   fetchOrganizationList(),
    // ]);
    loader.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchIndividualList() async {
    try {
      individuals.clear();
      final headers = {'Content-Type': 'application/json'};
      final requestBody = {"sitetype": 0, "filter": 'ALL', "organizationid": OrgID.value, "companyid": "0"};

      final response = await http.post(
        Uri.parse("http://192.168.0.200:8080/admin/sitelist"),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse['code'] == true) {
          List<dynamic> branches = decodedResponse['sql'];
          Set<String> individualIdSet = {};

          for (var ind in branches) {
            String individualId = ind['Branch_id'].toString();
            if (!individualIdSet.contains(individualId)) {
              individualIdSet.add(individualId);

              Uint8List? fileBytes;
              if (ind['Branch_Logo'] != null && ind['Branch_Logo']['data'] != null) {
                try {
                  List<int> logoBytes = List<int>.from(ind['Branch_Logo']['data']);
                  fileBytes = Uint8List.fromList(logoBytes);
                } catch (e) {
                  print("Error parsing logo bytes: $e");
                }
              }

              individuals.add({
                'Id': individualId,
                'Name': ind['Branch_name'],
                'email': ind['Email_id'],
                'logo': fileBytes ?? Uint8List.fromList([]),
              });
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchOrganizationList() async {
    try {
      organizations.clear();
      final headers = {'Content-Type': 'application/json'};
      final requestBody = {"sitetype": 0};

      final response = await http.post(
        Uri.parse("http://192.168.0.200:8080/admin/organization"),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse['code'] == true) {
          List<dynamic> data = decodedResponse['data'];
          Set<String> organizationIdSet = {};

          for (var org in data) {
            String organizationId = org['Organization_id'].toString();
            if (!organizationIdSet.contains(organizationId)) {
              organizationIdSet.add(organizationId);

              Uint8List? fileBytes;
              if (org['Organization_Logo'] != null && org['Organization_Logo']['data'] != null) {
                try {
                  List<int> logoBytes = List<int>.from(org['Organization_Logo']['data']);
                  fileBytes = Uint8List.fromList(logoBytes);
                } catch (e) {
                  print("Error parsing logo bytes: $e");
                }
              }

              organizations.add({
                'Id': organizationId,
                'Name': org['Organization_Name'],
                'email': org['Email_id'],
                'logo': fileBytes ?? Uint8List.fromList([]),
              });
            }
          }
        }
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
          builder: (context) => AlertDialog(
            content: const Text('Selected file exceeds 2MB in size.'),
            actions: [ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          ),
        );
        return false;
      } else {
        uploadImage(file, 'organization', id);
        return true;
      }
    }
    return false;
  }

  Future<void> uploadImage(File file, String logoType, int id) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.0.200:8081/admin/uploadlogo"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "logotype": logoType,
          "id": id,
          "image": await file.readAsBytes(),
        }),
      );
      if (response.statusCode == 200 && json.decode(response.body)['code'] == true) {
        fetchOrganizationList();
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchOrganizationList();
    fetchIndividualList();
    return Obx(() {
      return Expanded(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    loader.start(context);
                    CompanyGrid.tween = 1.5;
                    Enterprise_Hierarchy.widget_type.value = 2;
                  },
                  icon: const Icon(Icons.arrow_back, size: 15),
                ),
                const Text("BRANCHES", style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                  ),
                  itemCount: individuals.length,
                  itemBuilder: (context, index) {
                    var org = individuals[index];
                    return GestureDetector(
                      onTap: () => pickFile(context, int.parse(org['Id']!)),
                      child: BranchCard(
                        name: org['Name']!,
                        id: org['Id']!,
                        email: org['email'] ?? "",
                        imageBytes: org['logo']! as Uint8List,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
