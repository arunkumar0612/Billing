import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/CompGrid.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/Hierarchy.dart';

class BranchCard extends StatelessWidget {
  final String name;
  final String email;
  final String id;
  final Uint8List imageBytes;

  const BranchCard({
    super.key,
    required this.name,
    required this.email,
    required this.id,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Primary_colors.Color3,
            Color.fromARGB(255, 189, 189, 189),
            Primary_colors.Color7,
          ], // Example gradient colors
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // color: Primary_colors.Color9, // Background color
        borderRadius: BorderRadius.circular(12), // Rounded corners
        // border: Border.all(color: Primary_colors.Color9, width: 3), // Border added
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            // Enterprise_Hierarchy.widget_type.value = 1;
            // Get.off(() => CompanyGrid(
            //       Companys: const [],
            //       onTap: (BuildContext, int) {},
            //     ));
          },
          child: Card(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with Edit button
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // gradient: const LinearGradient(
                          //   colors: [
                          //     Color.fromARGB(255, 255, 255, 255),
                          //     Color.fromARGB(255, 189, 189, 189),
                          //     Primary_colors.Color7,
                          //   ], // Example gradient colors
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          // ),
                          // // color: Primary_colors.Color9, // Background color
                          borderRadius: BorderRadius.circular(12), // Rounded corners
                          // border: Border.all(color: Primary_colors.Color9, width: 3), // Border added
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            color: Colors.white,
                            child: imageBytes.isNotEmpty ? Image.memory(imageBytes, fit: BoxFit.contain) : const Center(child: Text("No Image Available")),
                          ),
                        ),
                      ),
                      // Positioned Edit Button
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Tooltip(
                          message: "Edit",
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white.withOpacity(0.0), // Semi-transparent background
                            child: IconButton(
                              icon: const Icon(Icons.edit_square, size: 15, color: Color.fromARGB(255, 110, 110, 110)),
                              onPressed: () {
                                // TODO: Implement edit action
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Edit button pressed")),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Details section
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "ANAMALLAIS AGENCIES STADIUM PVT LTD, 7B, Mettupalayam road,Kavundanpalayam Coimbatore- 641030",
                            style: TextStyle(fontSize: 8),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
