// ignore_for_file: unused_field, deprecated_member_use
import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/account_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/controller/view_ledger_action.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/GST_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/account_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/services/view_ledger_service.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/GST_ledger.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/TDS_Ledger.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/account_ledger.dart';

import '../../../../THEMES/style.dart';

class ViewLedger extends StatefulWidget with Account_LedgerService, GST_LedgerService, View_LedgerService {
  ViewLedger({super.key});

  @override
  State<ViewLedger> createState() => _ViewLedgerState();
}

class _ViewLedgerState extends State<ViewLedger> {
  final View_LedgerController view_LedgerController = Get.find<View_LedgerController>();
  final Account_LedgerController account_LedgerController = Get.find<Account_LedgerController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    widget.Get_SUBcustomerList();
    widget.Get_SALEScustomerList();
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger' ? Account_ledger_filter() : _buildFilterDrawer(),
          )),
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

            Obx(
              () => SizedBox(
                child: view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select transaction Type',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildtransactionFilterChip('Show All'),
                              _buildtransactionFilterChip('Payable'),
                              _buildtransactionFilterChip('Receivable'),
                            ],
                          ),
                          const SizedBox(height: 35),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
            Obx(
              () => SizedBox(
                child: view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select payment Type',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildpaymenFilterChip('Show All'),
                              _buildpaymenFilterChip('Credit'),
                              _buildpaymenFilterChip('Debit'),
                            ],
                          ),
                          const SizedBox(height: 35),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
            Obx(
              () => SizedBox(
                child: view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'GST Ledger'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'GST ledger type',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => Wrap(
                              spacing: 8,
                              children: [
                                FilterChip(
                                  showCheckmark: false,
                                  label: const Text('Consolidate'),
                                  selected: view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Consolidate',
                                  onSelected: (_) {
                                    view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value = 'Consolidate';
                                  },
                                  backgroundColor: Primary_colors.Dark,
                                  selectedColor: Primary_colors.Dark,
                                  labelStyle: TextStyle(
                                    fontSize: Primary_font_size.Text7,
                                    color: view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Consolidate' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Consolidate' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                                    ),
                                  ),
                                ),
                                FilterChip(
                                  label: const Text('Input'),
                                  selected: view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Input',
                                  onSelected: (_) {
                                    view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value = 'Input';
                                  },
                                  backgroundColor: Primary_colors.Dark,
                                  showCheckmark: false,
                                  selectedColor: Primary_colors.Dark,
                                  labelStyle: TextStyle(
                                    fontSize: Primary_font_size.Text7,
                                    color: view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Input' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Input' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                                    ),
                                  ),
                                ),
                                FilterChip(
                                  label: const Text('Output'),
                                  selected: view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Output',
                                  onSelected: (_) {
                                    view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value = 'Output';
                                  },
                                  backgroundColor: Primary_colors.Dark,
                                  showCheckmark: false,
                                  selectedColor: Primary_colors.Dark,
                                  labelStyle: TextStyle(
                                    fontSize: Primary_font_size.Text7,
                                    color: view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Output' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Output' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 35),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Invoice type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Wrap(
                    spacing: 5,
                    children: [
                      FilterChip(
                        showCheckmark: false,
                        label: const Text('Show All'),
                        selected: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Show All',
                        onSelected: (_) {
                          view_LedgerController.view_LedgerModel.selectedinvoiceType.value = 'Show All';
                          view_LedgerController.view_LedgerModel.selectedsubcustomerID.value = 'None';
                        },
                        backgroundColor: Primary_colors.Dark,
                        selectedColor: Primary_colors.Dark,
                        labelStyle: TextStyle(
                          fontSize: Primary_font_size.Text7,
                          color: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                          ),
                        ),
                      ),
                      FilterChip(
                        label: const Text('Sales'),
                        selected: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Sales',
                        onSelected: (_) {
                          view_LedgerController.view_LedgerModel.selectedinvoiceType.value = 'Sales';
                        },
                        backgroundColor: Primary_colors.Dark,
                        showCheckmark: false,
                        selectedColor: Primary_colors.Dark,
                        labelStyle: TextStyle(
                          fontSize: Primary_font_size.Text7,
                          color: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Sales' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Sales' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                          ),
                        ),
                      ),
                      FilterChip(
                        label: const Text('Subscription'),
                        selected: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Subscription',
                        onSelected: (_) {
                          view_LedgerController.view_LedgerModel.selectedinvoiceType.value = 'Subscription';
                        },
                        backgroundColor: Primary_colors.Dark,
                        showCheckmark: false,
                        selectedColor: Primary_colors.Dark,
                        labelStyle: TextStyle(
                          fontSize: Primary_font_size.Text7,
                          color: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Subscription' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Subscription' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                          ),
                        ),
                      ),
                      FilterChip(
                        label: const Text('Vendor'),
                        selected: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Vendor',
                        onSelected: (_) {
                          view_LedgerController.view_LedgerModel.selectedinvoiceType.value = 'Vendor';
                        },
                        backgroundColor: Primary_colors.Dark,
                        showCheckmark: false,
                        selectedColor: Primary_colors.Dark,
                        labelStyle: TextStyle(
                          fontSize: Primary_font_size.Text7,
                          color: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Vendor' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Vendor' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Obx(
              () => SizedBox(
                child: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Sales' && view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          const Text(
                            'Select sales client',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () {
                              return SizedBox(
                                height: 35,
                                // width: 250,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 91, 90, 90),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DropdownSearch<String>(
                                          popupProps: PopupProps.menu(
                                            showSearchBox: true,
                                            searchFieldProps: TextFieldProps(
                                              decoration: InputDecoration(
                                                hintText: 'Search...',
                                                hintStyle: const TextStyle(fontSize: 12),
                                                prefixIcon: const Icon(Icons.search, size: 18),
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(6.0),
                                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                                ),
                                                isDense: true,
                                              ),
                                            ),
                                            menuProps: MenuProps(
                                              borderRadius: BorderRadius.circular(6.0),
                                              elevation: 3,
                                            ),
                                            constraints: const BoxConstraints.tightFor(height: 250), // Reduced popup height
                                          ),
                                          dropdownDecoratorProps: DropDownDecoratorProps(
                                            dropdownSearchDecoration: InputDecoration(
                                              iconColor: const Color.fromARGB(252, 162, 158, 158),
                                              // labelText: "Client",
                                              // labelStyle: TextStyle(
                                              //   color: Colors.grey.shade600,
                                              //   fontSize: 12,
                                              // ),
                                              floatingLabelStyle: TextStyle(
                                                color: Colors.blue.shade700,
                                                fontSize: 12,
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            baseStyle: const TextStyle(
                                              fontSize: 12, // Smaller font size
                                              color: Color.fromARGB(255, 138, 137, 137),
                                            ),
                                          ),
                                          items: view_LedgerController.view_LedgerModel.salesCustomerList.map((customer) {
                                            return customer.customerName;
                                          }).toList(),
                                          selectedItem: view_LedgerController.view_LedgerModel.selectedsalescustomer.value,
                                          onChanged: (value) {
                                            if (value != null) {
                                              view_LedgerController.view_LedgerModel.selectedsalescustomer.value = value;
                                              final customerList = view_LedgerController.view_LedgerModel.salesCustomerList;

                                              // Find the index of the selected customer
                                              final index = customerList.indexWhere((customer) => customer.customerName == value);
                                              view_LedgerController.view_LedgerModel.selectedsalescustomerID.value = view_LedgerController.view_LedgerModel.salesCustomerList[index].customerId;
                                              if (kDebugMode) {
                                                print('Selected customer ID: ${view_LedgerController.view_LedgerModel.selectedsalescustomerID.value}');
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      Obx(
                                        () => SizedBox(
                                          child: view_LedgerController.view_LedgerModel.selectedsalescustomer.value != 'None'
                                              ? IconButton(
                                                  onPressed: () {
                                                    view_LedgerController.view_LedgerModel.selectedsalescustomer.value = 'None';
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                    size: 18,
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
            Obx(
              () => SizedBox(
                  child: view_LedgerController.view_LedgerModel.selectedinvoiceType.value == 'Subscription' && view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 35),
                            const Text(
                              'Select subscription customer',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              () {
                                return SizedBox(
                                  height: 35,
                                  // width: 250,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(255, 91, 90, 90),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DropdownSearch<String>(
                                            popupProps: PopupProps.menu(
                                              showSearchBox: true,
                                              searchFieldProps: TextFieldProps(
                                                decoration: InputDecoration(
                                                  hintText: 'Search...',
                                                  hintStyle: const TextStyle(fontSize: 12),
                                                  prefixIcon: const Icon(Icons.search, size: 18),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6.0),
                                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                                  ),
                                                  isDense: true,
                                                ),
                                              ),
                                              menuProps: MenuProps(
                                                borderRadius: BorderRadius.circular(6.0),
                                                elevation: 3,
                                              ),
                                              constraints: const BoxConstraints.tightFor(height: 250), // Reduced popup height
                                            ),
                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                              dropdownSearchDecoration: InputDecoration(
                                                iconColor: const Color.fromARGB(252, 162, 158, 158),
                                                // labelText: "Client",
                                                // labelStyle: TextStyle(
                                                //   color: Colors.grey.shade600,
                                                //   fontSize: 12,
                                                // ),
                                                floatingLabelStyle: TextStyle(
                                                  color: Colors.blue.shade700,
                                                  fontSize: 12,
                                                ),
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                                border: InputBorder.none,
                                                isDense: true,
                                              ),
                                              baseStyle: const TextStyle(
                                                fontSize: 12, // Smaller font size
                                                color: Color.fromARGB(255, 138, 137, 137),
                                              ),
                                            ),
                                            items: view_LedgerController.view_LedgerModel.subCustomerList.map((customer) {
                                              return customer.customerName;
                                            }).toList(),
                                            selectedItem: view_LedgerController.view_LedgerModel.selectedsubcustomer.value,
                                            onChanged: (value) {
                                              if (value != null) {
                                                view_LedgerController.view_LedgerModel.selectedsubcustomer.value = value;
                                                final customerList = view_LedgerController.view_LedgerModel.subCustomerList;

                                                // Find the index of the selected customer
                                                final index = customerList.indexWhere((customer) => customer.customerName == value);
                                                view_LedgerController.view_LedgerModel.selectedsubcustomerID.value = view_LedgerController.view_LedgerModel.subCustomerList[index].customerId;
                                                // print('Selected customer ID: ${view_LedgerController.view_LedgerModel.selectedsubcustomerID.value}');
                                              }
                                            },
                                          ),
                                        ),
                                        Obx(
                                          () => SizedBox(
                                            child: view_LedgerController.view_LedgerModel.selectedsubcustomer.value != 'None'
                                                ? IconButton(
                                                    onPressed: () {
                                                      view_LedgerController.view_LedgerModel.selectedsubcustomer.value = 'None';
                                                      view_LedgerController.view_LedgerModel.selectedsubcustomerID.value = 'None';
                                                    },
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                      size: 18,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : const SizedBox()),
            ),
            const SizedBox(height: 35),
            // Add Month Dropdown here

            Obx(() {
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Select date',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                    ),
                    // const SizedBox(width: 8),
                    Obx(
                      () => SizedBox(
                          child: view_LedgerController.view_LedgerModel.startDateController.value.text.isNotEmpty || view_LedgerController.view_LedgerModel.endDateController.value.text.isNotEmpty
                              ? TextButton(
                                  onPressed: () {
                                    view_LedgerController.view_LedgerModel.selectedMonth.value = 'None';
                                    view_LedgerController.view_LedgerModel.startDateController.value.clear();
                                    view_LedgerController.view_LedgerModel.endDateController.value.clear();
                                  },
                                  child: const Text(
                                    'Clear',
                                    style: TextStyle(fontSize: Primary_font_size.Text7),
                                  ),
                                )
                              : const SizedBox()),
                    ),
                    const Spacer(),
                    Obx(() {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: 100, // Adjust width as needed
                        height: 30, // Adjust height as needed
                        child: DropdownButtonFormField<String>(
                          menuMaxHeight: 300,
                          value: view_LedgerController.view_LedgerModel.selectedMonth.value,
                          items: ['None', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            view_LedgerController.view_LedgerModel.selectedMonth.value = value!;
                            if (value != 'None') {
                              final monthIndex = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].indexOf(value) + 1;

                              final now = DateTime.now();
                              final year = now.year;
                              final firstDay = DateTime(year, monthIndex, 1);
                              final lastDay = monthIndex < 12 ? DateTime(year, monthIndex + 1, 0) : DateTime(year + 1, 1, 0);

                              String formatDate(DateTime date) {
                                return "${date.year.toString().padLeft(4, '0')}-"
                                    "${date.month.toString().padLeft(2, '0')}-"
                                    "${date.day.toString().padLeft(2, '0')}";
                              }

                              view_LedgerController.view_LedgerModel.startDateController.value.text = formatDate(firstDay);
                              view_LedgerController.view_LedgerModel.endDateController.value.text = formatDate(lastDay);
                            } else {
                              view_LedgerController.view_LedgerModel.startDateController.value.clear();
                              view_LedgerController.view_LedgerModel.endDateController.value.clear();
                            }
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: Primary_font_size.Text7,
                            color: Color.fromARGB(255, 154, 152, 152),
                          ),
                          dropdownColor: Primary_colors.Dark,
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 15),
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
                const SizedBox(height: 35),
                view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'GST Ledger'
                    ? Column(
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
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TDS Ledger Type',
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
              ]);
            }),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    widget.resetFilters();
                    Navigator.pop(context);
                    if (view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger') {
                      widget.get_Account_LedgerList();
                    }
                    if (view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'GST Ledger') {
                      widget.get_GST_LedgerList();
                      view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Consolidate' ? view_LedgerController.view_LedgerModel.showGSTsummary.value = true : false;
                    }
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
                  onPressed: () async {
                    if (view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'Account Ledger') {
                      widget.get_Account_LedgerList();
                    }
                    if (view_LedgerController.view_LedgerModel.selectedLedgerType.value == 'GST Ledger') {
                      widget.get_GST_LedgerList();
                      view_LedgerController.view_LedgerModel.selectedGSTLedgerType.value == 'Consolidate' ? view_LedgerController.view_LedgerModel.showGSTsummary.value = true : false;
                    }
                  },
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

  Widget _buildtransactionFilterChip(String label) {
    return Obx(() {
      final isSelected = view_LedgerController.view_LedgerModel.selectedtransactiontype.value == label;

      return ChoiceChip(
        label: Text(
          label == 'Show All' ? 'Show All   ' : label,
          style: TextStyle(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
        ),
        selected: isSelected,
        onSelected: (_) {
          view_LedgerController.view_LedgerModel.selectedtransactiontype.value = label;
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

  Widget _buildpaymenFilterChip(String label) {
    return Obx(() {
      final isSelected = view_LedgerController.view_LedgerModel.selectedPaymenttype.value == label;

      return ChoiceChip(
        label: Text(
          label == 'Show All' ? 'Show All   ' : label,
          style: TextStyle(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
        ),
        selected: isSelected,
        onSelected: (_) {
          view_LedgerController.view_LedgerModel.selectedPaymenttype.value = label;
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
