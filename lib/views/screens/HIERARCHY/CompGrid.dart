import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/services/Hierarchy_services/hierarchy_service.dart';
import 'package:ssipl_billing/views/components/Comp_card.dart';
import 'package:ssipl_billing/views/components/Loading.dart';

class CompanyGrid extends StatefulWidget with HierarchyService {
  // static var comapanies = <CompanyData>[].obs;
  static int? selectedIndex = 0;
  CompanyGrid({super.key});

  @override
  _CompanyGridState createState() => _CompanyGridState();
}

class _CompanyGridState extends State<CompanyGrid> with SingleTickerProviderStateMixin {
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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   widget.get_CompanyList(context);
    // });
  }

  // @override
  // void dispose() {
  //   hierarchyController.hierarchyModel.controller.dispose();
  //   super.dispose();
  // }

  // Future<void> fetchCompanyList() async {
  //   try {
  //     loader.start(context);
  //     await Future.delayed(const Duration(milliseconds: 2000));
  //     CompanyGrid.comapanies.clear();
  //     final Map<String, String> headers = {'Content-Type': 'application/json'};
  //     final requestBody = {"sitetype": 404, "organizationid": 0};

  //     final response = await http.post(
  //       Uri.parse("http://192.168.0.200:8080/admin/companylist"),
  //       headers: headers,
  //       body: json.encode(requestBody),
  //     );

  //     if (response.statusCode == 200) {
  //       final decodedResponse = json.decode(response.body);
  //       if (decodedResponse['code'] == true) {
  //         List<dynamic> data = decodedResponse['data'];

  //         Set<String> companyIdSet = {};
  //         for (int i = 0; i < decodedResponse['data'].length; i++) {
  //           String companyId = decodedResponse['data'][i]['Customer_id'].toString();

  //           if (!companyIdSet.contains(companyId)) {
  //             companyIdSet.add(companyId);

  //             Uint8List? fileBytes;
  //             if (decodedResponse['data'][i]['Customer_Logo'] != null && decodedResponse['data'][i]['Customer_Logo']['data'] != null) {
  //               try {
  //                 List<int> logoBytes = List<int>.from(decodedResponse['data'][i]['Customer_Logo']['data']);
  //                 fileBytes = Uint8List.fromList(logoBytes);
  //               } catch (e) {
  //                 print("Error parsing logo bytes: $e");
  //               }
  //             }
  //             CompanyGrid.comapanies.add(CompanyData.fromJson(decodedResponse['data'][i]));
  //           }
  //         }
  //       }
  //     }
  //     loader.stop();
  //   } catch (e) {
  //     print("Error fetching company list: $e");
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
      } else {
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
          widget.get_CompanyList(context);
        }
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: hierarchyController.hierarchyModel.cardCount.value,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                ),
                itemCount: hierarchyController.hierarchyModel.CompanyList.value.Live.length,
                itemBuilder: (context, index) {
                  var org = hierarchyController.hierarchyModel.CompanyList.value.Live[index];
                  return GestureDetector(
                    onTap: () => pickFile(context, int.parse(org.customerId.toString())),
                    child: CompanyCard(
                      name: org.customerName,
                      id: org.customerId,
                      email: org.email,
                      imageBytes: org.customerLogo ?? Uint8List(0),
                      index: index,
                      data: hierarchyController.hierarchyModel.CompanyList.value,
                      controller: hierarchyController,
                      isSelected: hierarchyController.hierarchyModel.CompanyList.value.Live[index].isSelected,
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
