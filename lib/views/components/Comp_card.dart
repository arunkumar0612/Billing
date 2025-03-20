import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/Loading.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/CompGrid.dart';
import 'package:ssipl_billing/views/screens/HIERARCHY/Hierarchy.dart';

class CompanyCard extends StatefulWidget {
  final String name;
  final String email;
  final String id;
  final Uint8List imageBytes;
  final int index;

  const CompanyCard({super.key, required this.name, required this.email, required this.id, required this.imageBytes, required this.index});

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  bool _isHovered = false;

  void onSelected() {
    for (var org in CompanyGrid.comapanies) {
      org.isSelected = false;
    }
    CompanyGrid.comapanies[widget.index].isSelected = true;
    CompanyGrid.comapanies.refresh();
  }

  void onDirected() async {
    final loader = LoadingOverlay();
    await loader.start(context);
    Enterprise_Hierarchy.widget_type.value = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isSelected = CompanyGrid.comapanies[widget.index].isSelected;

      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(
            0,
            _isHovered ? -10 : (isSelected ? -8 : 0), // Pop up on hover
            0,
          ),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                isSelected ? Colors.redAccent : Primary_colors.Color3,
                const Color.fromARGB(255, 189, 189, 189),
                Primary_colors.Color7,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.redAccent : Colors.transparent,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : _isHovered
                    ? [
                        BoxShadow(
                          color: Primary_colors.Color3.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
          ),
          child: GestureDetector(
            onTap: onSelected,
            child: Card(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
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
                              child: widget.imageBytes.isNotEmpty ? Image.memory(widget.imageBytes, fit: BoxFit.contain) : const Center(child: Text("No Image Available")),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Tooltip(
                            message: "Edit",
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white.withOpacity(0.0),
                              child: IconButton(
                                icon: const Icon(Icons.edit_square, size: 15, color: Color.fromARGB(255, 110, 110, 110)),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                              widget.name,
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
    });
  }
}
