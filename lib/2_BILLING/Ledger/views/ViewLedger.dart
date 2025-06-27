// ignore_for_file: unused_field, deprecated_member_use
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/GST_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/TDS_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/services/GST_ledger_service.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/services/TDS_ledger_service.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/services/account_ledger_service.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/services/view_ledger_service.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/views/GST_ledger.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/views/TDS_Ledger.dart';
import 'package:ssipl_billing/2_BILLING/Ledger/views/account_ledger.dart';

import '../../../../THEMES/style.dart';

class ViewLedger extends StatefulWidget with Account_LedgerService, GST_LedgerService, TDS_LedgerService, View_LedgerService {
  ViewLedger({super.key});

  @override
  State<ViewLedger> createState() => _ViewLedgerState();
}

class _ViewLedgerState extends State<ViewLedger> {
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final Account_LedgerController account_LedgerController = Get.find<Account_LedgerController>();
  final GST_LedgerController gst_LedgerController = Get.find<GST_LedgerController>();
  final TDS_LedgerController tds_LedgerController = Get.find<TDS_LedgerController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    widget.Get_SUBcustomerList();
    widget.Get_SALEScustomerList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        backgroundColor: Primary_colors.Light,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(16))),
        width: 350,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger'
                ? Account_ledger_filter()
                : view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'GST Ledger'
                    ? GST_ledger_filter()
                    : TDS_ledger_filter(),
          ),
        ),
      ),
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
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: Obx(
                              () => SizedBox(
                                height: 20,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger'
                                        ? account_ledger_selectedfilter()
                                        : view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'GST Ledger'
                                            ? gst_ledger_selectedfilter()
                                            : SizedBox()),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                      width: 400,
                                      height: 40,
                                      child: TextFormField(
                                        controller: account_LedgerController.account_LedgerModel.searchController.value,
                                        onChanged: (value) => widget.applySearchFilter(value),
                                        style: const TextStyle(fontSize: 13, color: Colors.white),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.all(1),
                                          filled: true,
                                          fillColor: Primary_colors.Light,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          hintStyle: const TextStyle(
                                            fontSize: Primary_font_size.Text7,
                                            color: Color.fromARGB(255, 167, 165, 165),
                                          ),
                                          hintText: 'Search customer',
                                          prefixIcon: const Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                  const SizedBox(width: 20),
                                  Obx(
                                    () => SizedBox(
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
                                        items: view_LedgerController.view_LedgerModel.ledgerTypeList.map<DropdownMenuItem<String>>(
                                          (String customer) {
                                            return DropdownMenuItem<String>(
                                              value: customer,
                                              child: Text(customer),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () {
                                      if (view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger') {
                                        widget.reassignaccount_LedgerFilters();
                                      }
                                      if (view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'GST Ledger') {
                                        widget.reassigngst_LedgerFilters();
                                      }
                                      if (view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'TDS Ledger') {
                                        widget.reassigntds_LedgerFilters();
                                      }
                                      _scaffoldKey.currentState?.openEndDrawer();
                                    },
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
                  return view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger'
                      ? Expanded(child: AccountLedger())
                      : view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'GST Ledger'
                          ? Expanded(child: GSTLedger())
                          : Expanded(child: TDSLedger());
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget account_ledger_selectedfilter() {
    return Row(
      children: [
        if (account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.transactiontype.value != 'Show All')
          _buildselectedFiltersChip(
            account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.transactiontype.value,
            onRemove: () async {
              account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.transactiontype.value = 'Show All';
              await widget.get_Account_LedgerList();
            },
          ),
        if (account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value != 'Show All')
          Row(
            children: [
              const SizedBox(width: 5),
              _buildselectedFiltersChip(
                account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value,
                onRemove: () async {
                  account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value = 'Show All';
                  account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
                  account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
                  account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedcustomerid.value = 'None';
                  await widget.get_Account_LedgerList();
                },
              ),
            ],
          ),
        if (account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value != 'Show All')
          Row(
            children: [
              if (account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value == 'Sales' &&
                  account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsalescustomername.value != 'None')
                Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildselectedFiltersChip(
                      account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsalescustomername.value,
                      onRemove: () async {
                        account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
                        account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedcustomerid.value = '';
                        await widget.get_Account_LedgerList();
                      },
                    ),
                  ],
                ),
              if (account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.invoicetype.value == 'Subscription' &&
                  account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value != 'None')
                Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildselectedFiltersChip(
                      account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value,
                      onRemove: () async {
                        account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
                        account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.selectedcustomerid.value = '';
                        await widget.get_Account_LedgerList();
                      },
                    ),
                  ],
                ),
            ],
          ),
        if (account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.paymenttype.value != 'Show All')
          Row(
            children: [
              const SizedBox(width: 5),
              _buildselectedFiltersChip(
                account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.paymenttype.value,
                onRemove: () async {
                  account_LedgerController.account_LedgerModel.account_LedgerSelectedFilter.value.paymenttype.value = 'Show All';
                  await widget.get_Account_LedgerList();
                },
              ),
            ],
          ),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget gst_ledger_selectedfilter() {
    return Row(
      children: [
        if (gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value != 'Consolidate')
          _buildselectedFiltersChip(
            gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value,
            onRemove: () async {
              gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.GSTtype.value = 'Consolidate';
              await widget.get_GST_LedgerList();
            },
          ),
        if (gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value != 'Show All')
          Row(
            children: [
              const SizedBox(width: 5),
              _buildselectedFiltersChip(
                gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value,
                onRemove: () async {
                  gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value = 'Show All';
                  gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
                  gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
                  gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value = 'None';
                  await widget.get_GST_LedgerList();
                },
              ),
            ],
          ),
        if (gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value != 'Show All')
          Row(
            children: [
              if (gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value == 'Sales' &&
                  gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsalescustomername.value != 'None')
                Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildselectedFiltersChip(
                      gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsalescustomername.value,
                      onRemove: () async {
                        gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
                        gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value = '';
                        await widget.get_GST_LedgerList();
                      },
                    ),
                  ],
                ),
              if (gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.invoicetype.value == 'Subscription' &&
                  gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value != 'None')
                Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildselectedFiltersChip(
                      gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value,
                      onRemove: () async {
                        gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
                        gst_LedgerController.gst_LedgerModel.gst_LedgerSelectedFilter.value.selectedcustomerid.value = '';
                        await widget.get_GST_LedgerList();
                      },
                    ),
                  ],
                ),
            ],
          ),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget tds_ledger_selectedfilter() {
    return Row(
      children: [
        if (tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value != 'Show All')
          _buildselectedFiltersChip(
            tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value,
            onRemove: () async {
              tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.TDStype.value = 'Consolidate';
              await widget.get_TDS_LedgerList();
            },
          ),
        if (tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value != 'Show All')
          Row(
            children: [
              const SizedBox(width: 5),
              _buildselectedFiltersChip(
                tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value,
                onRemove: () async {
                  tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value = 'Show All';
                  tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
                  tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
                  tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value = 'None';
                  await widget.get_TDS_LedgerList();
                },
              ),
            ],
          ),
        if (tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value != 'Show All')
          Row(
            children: [
              if (tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value == 'Sales' &&
                  tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsalescustomername.value != 'None')
                Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildselectedFiltersChip(
                      tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsalescustomername.value,
                      onRemove: () async {
                        tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsalescustomername.value = 'None';
                        tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value = '';
                        await widget.get_TDS_LedgerList();
                      },
                    ),
                  ],
                ),
              if (tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.invoicetype.value == 'Subscription' &&
                  tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value != 'None')
                Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildselectedFiltersChip(
                      tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value,
                      onRemove: () async {
                        tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedsubscriptioncustomername.value = 'None';
                        tds_LedgerController.tds_LedgerModel.tds_LedgerSelectedFilter.value.selectedcustomerid.value = '';
                        await widget.get_TDS_LedgerList();
                      },
                    ),
                  ],
                ),
            ],
          ),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget _buildselectedFiltersChip(String label, {required VoidCallback onRemove}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 203, 207, 252),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Primary_colors.Color3),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(color: Color.fromARGB(255, 15, 20, 88), fontSize: Primary_font_size.Text8),
          ),
          const SizedBox(width: 4),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                onRemove();
              },
              child: const Icon(Icons.cancel_sharp, size: 16, color: Colors.red),
            ),
          ),
        ],
      ),
    );
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
