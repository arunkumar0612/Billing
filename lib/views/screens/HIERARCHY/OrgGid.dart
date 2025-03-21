import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/services/Hierarchy_services/hierarchy_service.dart';
import 'package:ssipl_billing/views/components/Loading.dart';
import 'package:ssipl_billing/views/components/Org_card.dart';
import 'package:http/http.dart' as http;

class OrganizationGrid extends StatefulWidget with HierarchyService {
  // static var organizations = <OrganizationData>[].obs;

  OrganizationGrid({super.key});

  @override
  _OrganizationGridState createState() => _OrganizationGridState();
}

class _OrganizationGridState extends State<OrganizationGrid> with SingleTickerProviderStateMixin {
  final HierarchyController hierarchyController = Get.find<HierarchyController>();
  // late AnimationController _controller;
  // late Animation<Offset> _slideAnimation;
  final loader = LoadingOverlay();
  @override
  void initState() {
    super.initState();
    hierarchyController.hierarchyModel.controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    hierarchyController.hierarchyModel.slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: hierarchyController.hierarchyModel.controller,
      curve: Curves.easeInCubic,
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) hierarchyController.hierarchyModel.controller.forward();
    });
    // Ensures fetchCompanyList() runs only after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.get_OrganizationList(context);
    });
  }

  // @override
  // void dispose() {
  //   hierarchyController.hierarchyModel.controller.dispose();
  //   super.dispose();
  // }

  // Future<void> fetchOrganizationList() async {
  //   try {
  //     loader.start(context);
  //     await Future.delayed(const Duration(milliseconds: 1000));
  //     OrganizationGrid.organizations.clear();
  //     final response = await http.post(
  //       Uri.parse("http://192.168.0.200:8080/admin/organization"),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({"sitetype": 0}),
  //     );

  //     if (response.statusCode == 200) {
  //       final decodedResponse = json.decode(response.body);
  //       if (decodedResponse['code'] == true) {
  //         Set<String> organizationIdSet = {};
  //         for (int i = 0; i < decodedResponse['data'].length; i++) {
  //           String organizationId = decodedResponse['data'][i]['Organization_id'].toString();
  //           if (!organizationIdSet.contains(organizationId)) {
  //             organizationIdSet.add(organizationId);

  //             Uint8List? fileBytes;
  //             if (decodedResponse['data'][i]['Organization_Logo'] != null && decodedResponse['data'][i]['Organization_Logo']['data'] != null) {
  //               try {
  //                 fileBytes = Uint8List.fromList(List<int>.from(decodedResponse['data'][i]['Organization_Logo']['data']));
  //               } catch (e) {
  //                 print("Error parsing logo bytes: $e");
  //               }
  //             }
  //             OrganizationGrid.organizations.add(OrganizationData.fromJson(decodedResponse['data'][i]));
  //           }
  //         }
  //       }
  //     }
  //     loader.stop();
  //   } catch (e) {
  //     print("Error fetching organization list: $e");
  //   }
  // }

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
        widget.get_OrganizationList(context);
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return Expanded(
            child: SlideTransition(
              position: hierarchyController.hierarchyModel.slideAnimation,
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                ),
                itemCount: hierarchyController.hierarchyModel.OrganizationList.value.Live.length,
                itemBuilder: (context, index) {
                  var org = hierarchyController.hierarchyModel.OrganizationList.value.Live[index];
                  return GestureDetector(
                    onTap: () {
                      pickFile(context, org.organizationId);
                    },
                    child: OrganizationCard(
                      name: org.organizationName,
                      id: org.organizationId.toString(),
                      email: org.email,
                      imageBytes: org.organizationLogo!,
                      index: index,
                      data: hierarchyController.hierarchyModel.CompanyList.value,
                      controller: hierarchyController,
                      isSelected: hierarchyController.hierarchyModel.OrganizationList.value.Live[index].isSelected,
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
