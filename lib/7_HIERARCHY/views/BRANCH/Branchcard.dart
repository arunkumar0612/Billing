// ignore_for_file: deprecated_member_use

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ssipl_billing/7_HIERARCHY/controllers/Hierarchy_actions.dart';
import 'package:ssipl_billing/7_HIERARCHY/models/entities/Hierarchy_entities.dart';
import 'package:ssipl_billing/7_HIERARCHY/services/hierarchy_service.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class BranchCard extends StatefulWidget with HierarchyService {
  final String name;
  final String email;
  final int id;
  final Uint8List imageBytes;
  final int index;
  final BranchResponse data;
  final HierarchyController controller;
  final bool isSelected;
  final String type;

  BranchCard(
      {super.key,
      required this.name,
      required this.email,
      required this.id,
      required this.imageBytes,
      required this.index,
      required this.data,
      required this.controller,
      required this.isSelected,
      required this.type});

  @override
  State<BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends State<BranchCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          0,
          _isHovered ? -10 : (widget.isSelected ? -8 : 0), // Pop up on hover
          0,
        ),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.isSelected ? Colors.redAccent : Primary_colors.Color3,
              const Color.fromARGB(255, 189, 189, 189),
              Primary_colors.Color7,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isSelected ? Colors.redAccent : Colors.transparent,
            width: widget.isSelected ? 2 : 1,
          ),
          boxShadow: widget.isSelected
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
          onTap: () {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.controller.onBranchSelected(widget.data, widget.index, widget.type);
            // });
          },
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
                              onPressed: () {
                                widget.pickFile(context, 'branch', widget.id);
                              },
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
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.type == "LIVE"
                                ? widget.controller.hierarchyModel.BranchList.value.Live[widget.index].clientAddress ?? ""
                                : widget.controller.hierarchyModel.BranchList.value.Demo[widget.index].clientAddress ?? "",
                            style: const TextStyle(fontSize: 8),
                            textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, // Truncate when resizing
                            maxLines: 1,
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
