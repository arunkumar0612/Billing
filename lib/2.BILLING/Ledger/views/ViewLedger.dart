// ignore_for_file: unused_field, deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';

import 'package:ssipl_billing/2.BILLING/Ledger/views/GST_ledgers/GST_ledger.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/account_ledgers/account_ledger.dart';

import '../../../../THEMES-/style.dart';

class ViewLedger extends StatefulWidget {
  const ViewLedger({super.key});

  @override
  State<ViewLedger> createState() => _ViewLedgerState();
}

class _ViewLedgerState extends State<ViewLedger> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? Selected_ledger_type = 'Account Ledger';

  List<String> ledger_type_list = ['Account Ledger', 'GST Ledger'];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Primary_colors.Dark,
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    // color: Primary_colors.Dark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white, // Set the color of the back icon to white
                          ),
                          onPressed: () {
                            // Navigate back to the previous page
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          child: Text(
                            Selected_ledger_type!,
                            style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text10),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: max(screenWidth - 1480, 200),
                                height: 40,
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 13, color: Colors.white),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(1),
                                    filled: true,
                                    fillColor: Primary_colors.Light,
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.transparent)),
                                    // enabledBorder: InputBorder.none, // Removes the enabled border
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
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: max(screenWidth - 1580, 150),
                                height: 40,
                                child: DropdownButtonFormField<String>(
                                    style: const TextStyle(fontSize: 13, color: Colors.white),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Adjust padding to center the hint
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
                                    value: Selected_ledger_type, // Bind your selected value here
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        Selected_ledger_type = newValue; // Update the selected value
                                      });
                                    },
                                    items: ledger_type_list.map<DropdownMenuItem<String>>(
                                      (String customer) {
                                        return DropdownMenuItem<String>(
                                          value: customer,
                                          child: Text(customer),
                                        );
                                      },
                                    ).toList()),
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState?.openEndDrawer();
                                },
                                icon: const Icon(
                                  Icons.filter_alt_outlined,
                                  color: Primary_colors.Color1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Selected_ledger_type == 'Account Ledger'
                    ? const Expanded(
                        child: AccountLedger(),
                      )
                    : const Expanded(
                        child: GSTLedger(),
                      ),

                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // }
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
