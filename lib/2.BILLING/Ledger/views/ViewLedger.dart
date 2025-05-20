// ignore_for_file: unused_field, deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/view_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/GST_ledger.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/account_ledger.dart';

import '../../../../THEMES-/style.dart';

class ViewLedger extends StatefulWidget with View_LedgerService {
  ViewLedger({super.key});

  @override
  State<ViewLedger> createState() => _ViewLedgerState();
}

class _ViewLedgerState extends State<ViewLedger> {
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _buildFilterDrawer(),
      backgroundColor: Primary_colors.Dark,
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 5),
                        Obx(() => Text(
                              view_LedgerController.view_LedgerModel.selectedLedgerType.value,
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text10),
                            )),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: min(constraints.maxWidth * 0.3, 200),
                                    height: 40,
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(1),
                                        filled: true,
                                        fillColor: Primary_colors.Light,
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
                                        hintStyle: const TextStyle(
                                          fontSize: Primary_font_size.Text7,
                                          color: Color.fromARGB(255, 167, 165, 165),
                                        ),
                                        hintText: 'Search from ledger',
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Obx(() => SizedBox(
                                        width: min(constraints.maxWidth * 0.30, 200),
                                        height: 40,
                                        child: DropdownButtonFormField<String>(
                                          style: const TextStyle(fontSize: 13, color: Colors.white),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                            filled: true,
                                            fillColor: Primary_colors.Light,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(color: Colors.transparent),
                                            ),
                                            label: const Text(
                                              'Select type',
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 162, 162, 162),
                                                fontSize: Primary_font_size.Text7,
                                              ),
                                            ),
                                          ),
                                          dropdownColor: Primary_colors.Dark,
                                          value: view_LedgerController.view_LedgerModel.selectedLedgerType.value,
                                          onChanged: (String? newValue) {
                                            view_LedgerController.view_LedgerModel.selectedLedgerType.value = newValue!;
                                          },
                                          items: view_LedgerController.view_LedgerModel.ledgerTypeList.map<DropdownMenuItem<String>>((String customer) {
                                            return DropdownMenuItem<String>(
                                              value: customer,
                                              child: Text(customer),
                                            );
                                          }).toList(),
                                        ),
                                      )),
                                  const SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                                    icon: const Icon(
                                      Icons.filter_alt_outlined,
                                      color: Primary_colors.Color1,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger' ? Expanded(child: AccountLedger()) : Expanded(child: GSTLedger());
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDrawer() {
    return Drawer(
      backgroundColor: Primary_colors.Light,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Ledgers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Primary_colors.Color3,
              ),
            ),
            const Divider(
              height: 30,
              thickness: 1,
              color: Color.fromARGB(255, 97, 97, 97),
            ),
            const SizedBox(height: 35),
            const Text(
              'Quick Date Filters',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildDateFilterChip('Consolidate'),
                _buildDateFilterChip('Client'),
                _buildDateFilterChip('Vendor'),
              ],
            ),
            const SizedBox(height: 35),
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Custom Date Range',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: TextFormField(
                            style: const TextStyle(
                              color: Color.fromARGB(255, 154, 152, 152),
                              fontSize: Primary_font_size.Text7,
                            ),
                            controller: view_LedgerController.view_LedgerModel.startDateController.value,
                            readOnly: true,
                            onTap: () => widget.selectDate(context, view_LedgerController.view_LedgerModel.startDateController.value),
                            decoration: InputDecoration(
                              labelText: 'From',
                              labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 154, 152, 152),
                                fontSize: Primary_font_size.Text7,
                              ),
                              suffixIcon: const Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: Color.fromARGB(255, 85, 84, 84),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: TextFormField(
                            style: const TextStyle(
                              color: Color.fromARGB(255, 154, 152, 152),
                              fontSize: Primary_font_size.Text7,
                            ),
                            controller: view_LedgerController.view_LedgerModel.endDateController.value,
                            readOnly: true,
                            onTap: () => widget.selectDate(context, view_LedgerController.view_LedgerModel.endDateController.value),
                            decoration: InputDecoration(
                              labelText: 'To',
                              labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 154, 152, 152),
                                fontSize: Primary_font_size.Text7,
                              ),
                              suffixIcon: const Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: Color.fromARGB(255, 85, 84, 84),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  )
                ],
              );
            }),
            Obx(() {
              return Center(
                child: view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger'
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Account Ledger Type',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(255, 85, 84, 84)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: view_LedgerController.view_LedgerModel.selectedAccountLedgerType.value,
                                items: ['Consolidate', 'Client', 'Vendor'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  view_LedgerController.view_LedgerModel.selectedAccountLedgerType.value = value!;
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 154, 152, 152)),
                                dropdownColor: Primary_colors.Dark,
                              ),
                            );
                          }),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'GST Ledger Type',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(255, 85, 84, 84)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value,
                                items: ['Consolidate', 'Input', 'Output'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value = value!;
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 154, 152, 152)),
                                dropdownColor: Primary_colors.Dark,
                              ),
                            );
                          }),
                        ],
                      ),
              );
            }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    widget.resetFilters();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Primary_colors.Color3),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'RESET',
                    style: TextStyle(color: Primary_colors.Color3),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Primary_colors.Color3,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'APPLY',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFilterChip(String label) {
    return Obx(() {
      final isSelected = view_LedgerController.view_LedgerModel.selectedQuickFilter.value == label;

      return ChoiceChip(
        label: Text(
          label == 'Show All' ? 'Show All   ' : label,
          style: TextStyle(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
        ),
        selected: isSelected,
        onSelected: (_) {
          view_LedgerController.view_LedgerModel.selectedQuickFilter.value = label;
          if (label == 'Custom range') {
            view_LedgerController.view_LedgerModel.showCustomDateRange.value = true;
          }
        },
        backgroundColor: Primary_colors.Dark,
        selectedColor: Primary_colors.Dark,
        labelStyle: TextStyle(
          color: isSelected ? Primary_colors.Color3 : Colors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
          ),
        ),
      );
    });
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 149, 148, 148)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 5;
    double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
