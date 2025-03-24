// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ssipl_billing/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/services/Hierarchy_services/hierarchy_service.dart';
import 'package:ssipl_billing/views/components/Indcard.dart';
import 'package:ssipl_billing/views/components/Loading.dart';

class BranchGrid extends StatefulWidget with HierarchyService {
  BranchGrid({super.key});

  @override
  _BranchGridState createState() => _BranchGridState();
}

class _BranchGridState extends State<BranchGrid> with SingleTickerProviderStateMixin {
  final HierarchyController hierarchyController = Get.find<HierarchyController>();
  // late AnimationController _controller;
  // late Animation<Offset> _slideAnimation;
  // var OrgID = "0".obs;
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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   widget.get_OrganizationList(context);
    //   widget.get_BranchList(context);
    // });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     widget.get_OrganizationList(context);
  //     widget.get_BranchList(context);
  //   });
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
        widget.get_BranchList(context);
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
                itemCount: hierarchyController.hierarchyModel.BranchList.value.Live.length,
                itemBuilder: (context, index) {
                  var Branch = hierarchyController.hierarchyModel.BranchList.value.Live[index];
                  return GestureDetector(
                    onTap: () {
                      pickFile(context, Branch.branchId);
                    },
                    child: BranchCard(
                      name: Branch.branchName,
                      id: Branch.branchId,
                      email: Branch.emailId,
                      imageBytes: Branch.branchLogo!,
                      index: index,
                      data: hierarchyController.hierarchyModel.BranchList.value,
                      controller: hierarchyController,
                      isSelected: hierarchyController.hierarchyModel.BranchList.value.Live[index].isSelected,
                      type: "LIVE",
                    ),
                  );
                },
              ),
            ),
          );
        }),
        const SizedBox(
          height: 60,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "DEMO",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 60,
        ),
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
                itemCount: hierarchyController.hierarchyModel.BranchList.value.Demo.length,
                itemBuilder: (context, index) {
                  var Branch = hierarchyController.hierarchyModel.BranchList.value.Demo[index];
                  return GestureDetector(
                    child: BranchCard(
                      name: Branch.branchName,
                      id: Branch.branchId,
                      email: Branch.emailId,
                      imageBytes: Branch.branchLogo!,
                      index: index,
                      data: hierarchyController.hierarchyModel.BranchList.value,
                      controller: hierarchyController,
                      isSelected: hierarchyController.hierarchyModel.BranchList.value.Live[index].isSelected,
                      type: "LIVE",
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
