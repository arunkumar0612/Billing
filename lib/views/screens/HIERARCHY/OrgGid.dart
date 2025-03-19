import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/models/entities/SALES/ClientReq_entities.dart';
import 'package:ssipl_billing/views/components/Loading.dart';
import 'package:ssipl_billing/views/components/Org_card.dart';
import 'package:http/http.dart' as http;

class OrganizationGrid extends StatefulWidget {
  static var organizations = <OrganizationData>[].obs;

  static double tween_side = 0;
  static double tween_up = 1.5;
  static int? selectedIndex = 0;
  const OrganizationGrid({super.key});

  @override
  _OrganizationGridState createState() => _OrganizationGridState();
}

class _OrganizationGridState extends State<OrganizationGrid> with SingleTickerProviderStateMixin {
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
      begin: Offset(OrganizationGrid.tween_side, OrganizationGrid.tween_up), // Slide from left
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
    loader.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    OrganizationGrid.tween_side = 0;
    OrganizationGrid.tween_up = 1.5;
    super.dispose();
  }

  Future<void> fetchOrganizationList() async {
    try {
      OrganizationGrid.organizations.clear();
      final response = await http.post(
        Uri.parse("http://192.168.0.200:8080/admin/organization"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"sitetype": 0}),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse['code'] == true) {
          Set<String> organizationIdSet = {};
          for (int i = 0; i < decodedResponse['data'].length; i++) {
            String organizationId = decodedResponse['data'][i]['Organization_id'].toString();
            if (!organizationIdSet.contains(organizationId)) {
              organizationIdSet.add(organizationId);

              Uint8List? fileBytes;
              if (decodedResponse['data'][i]['Organization_Logo'] != null && decodedResponse['data'][i]['Organization_Logo']['data'] != null) {
                try {
                  fileBytes = Uint8List.fromList(List<int>.from(decodedResponse['data'][i]['Organization_Logo']['data']));
                } catch (e) {
                  print("Error parsing logo bytes: $e");
                }
              }

              OrganizationGrid.organizations.add(OrganizationData.fromJson(decodedResponse['data'][i]));

              print(OrganizationGrid.organizations);
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching organization list: $e");
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
    return Obx(() {
      return

          // Expanded(
          //     child: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SlideTransition(
          //     position: _slideAnimation,
          //     child: GridView.count(
          //       crossAxisCount: 4,
          //       crossAxisSpacing: 30,
          //       mainAxisSpacing: 30,
          //       children: organizations.map<Widget>((org) {
          //         return GestureDetector(
          //           onTap: () => pickFile(context, int.parse(org['Id']!)),
          //           child: OrganizationCard(
          //             name: org['Name']!,
          //             id: org['Id']!,
          //             email: org['email']!,
          //             imageBytes: org['logo']! as Uint8List,
          //           ),
          //         );
          //       }).toList(),
          //     ),
          //   ),
          // ));

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
            itemCount: OrganizationGrid.organizations.length,
            itemBuilder: (context, index) {
              var org = OrganizationGrid.organizations[index];
              return GestureDetector(
                onTap: () {
                  pickFile(context, int.parse(org.id));
                },
                child: OrganizationCard(
                  name: org.name,
                  id: org.id,
                  email: org.email,
                  imageBytes: org.logo,
                  index: index,
                  // selectedIndex: OrganizationGrid.selectedIndex,
                  // orgList: organizations
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
