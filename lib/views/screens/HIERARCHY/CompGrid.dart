import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:ssipl_billing/views/components/Comp_card.dart';
import 'package:ssipl_billing/views/components/Loading.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/Hierarchy.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/OrgGid.dart';

class CompanyGrid extends StatefulWidget {
  static double tween = -1.5;
  const CompanyGrid({super.key});

  @override
  _CompanyGridState createState() => _CompanyGridState();
}

class _CompanyGridState extends State<CompanyGrid> with SingleTickerProviderStateMixin {
  var companys = <Map<String, dynamic>>[].obs;
  var organizations = <Map<String, dynamic>>[].obs;
  var OrgID = "0".obs;
  File? pickedFile;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  final loader = LoadingOverlay();
  @override
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(CompanyGrid.tween, 0), // Slide from left
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void apiCall() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // await loader.start(context);

    // await Future.wait([
    //   // Future.delayed(const Duration(milliseconds: 1000)),
    //   // fetchCompanyList(),
    //   fetchOrganizationList(),
    // ]);
    loader.stop();
  }

  // Future<void> fetchOrganizationList() async {
  //   try {
  //     organizations.clear();
  //     final Map<String, String> headers = {'Content-Type': 'application/json'};
  //     final requestBody = {"sitetype": 0};

  //     final response = await http.post(
  //       Uri.parse("http://192.168.0.200:8080/admin/organization"),
  //       headers: headers,
  //       body: json.encode(requestBody),
  //     );

  //     if (response.statusCode == 200) {
  //       final decodedResponse = json.decode(response.body);
  //       if (decodedResponse['code'] == true) {
  //         List<dynamic> data = decodedResponse['data'];

  //         Set<String> organizationIdSet = {};
  //         for (var org in data) {
  //           String organizationId = org['Organization_id'].toString();

  //           if (!organizationIdSet.contains(organizationId)) {
  //             organizationIdSet.add(organizationId);

  //             Uint8List? fileBytes;
  //             if (org['Organization_Logo'] != null && org['Organization_Logo']['data'] != null) {
  //               try {
  //                 List<int> logoBytes = List<int>.from(org['Organization_Logo']['data']);
  //                 fileBytes = Uint8List.fromList(logoBytes);
  //               } catch (e) {
  //                 print("Error parsing logo bytes: $e");
  //               }
  //             }

  //             Uint8List placeholderImage = Uint8List.fromList([]);

  //             Map<String, dynamic> orgMap = {
  //               'Id': organizationId,
  //               'Name': org['Organization_Name'],
  //               'email': org['Email_id'],
  //               'logo': fileBytes ?? placeholderImage,
  //             };

  //             organizations.add(orgMap);
  //           }
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print("Error fetching organization list: $e");
  //   }
  // }

  Future<void> fetchCompanyList() async {
    try {
      companys.clear();
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      final requestBody = {"sitetype": 404, "organizationid": OrgID.value};

      final response = await http.post(
        Uri.parse("http://192.168.0.200:8080/admin/companylist"),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse['code'] == true) {
          List<dynamic> data = decodedResponse['data'];

          Set<String> companyIdSet = {};
          for (var comp in data) {
            String companyId = comp['Customer_id'].toString();

            if (!companyIdSet.contains(companyId)) {
              companyIdSet.add(companyId);

              Uint8List? fileBytes;
              if (comp['Customer_Logo'] != null && comp['Customer_Logo']['data'] != null) {
                try {
                  List<int> logoBytes = List<int>.from(comp['Customer_Logo']['data']);
                  fileBytes = Uint8List.fromList(logoBytes);
                } catch (e) {
                  print("Error parsing logo bytes: $e");
                }
              }

              Uint8List placeholderImage = Uint8List.fromList([]);

              Map<String, dynamic> compMap = {
                'Id': companyId,
                'Name': comp['Customer_name'],
                'email': comp['Email_id'],
                'logo': fileBytes ?? placeholderImage,
              };

              companys.add(compMap);
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching company list: $e");
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

        pickedFile = null;
      } else {
        pickedFile = file;
        uploadImage(file, 'company', id);
        return true;
      }
    }
    return false;
  }

  Future<void> uploadImage(File file, String logoType, int id) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      List<int> fileBytes = await file.readAsBytes();
      final requestBody = {"logotype": logoType, "id": id, "image": fileBytes};

      final response = await http.post(
        Uri.parse("http://192.168.0.200:8081/admin/uploadlogo"),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse['code'] == true) {
          fetchCompanyList();
        }
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchCompanyList();
    // fetchOrganizationList();
    return Obx(() {
      return Expanded(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    loader.start(context);
                    OrganizationGrid.tween_side = 1.5;
                    OrganizationGrid.tween_up = 0;
                    Enterprise_Hierarchy.widget_type.value = 1;
                  },
                  icon: const Icon(Icons.arrow_back, size: 15),
                ),
                const Text("COMPANYS", style: TextStyle(color: Colors.white, fontSize: 12)),
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
                  itemCount: companys.length,
                  itemBuilder: (context, index) {
                    var org = companys[index];
                    return GestureDetector(
                      onTap: () => pickFile(context, int.parse(org['Id']!)),
                      child: CompanyCard(
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
