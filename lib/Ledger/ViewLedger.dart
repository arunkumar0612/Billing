// ignore_for_file: unused_field

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ssipl_billing/Ledger/accounting_ledgers/clientledger.dart';
import 'package:ssipl_billing/Ledger/accounting_ledgers/consolidated.dart';
import 'package:ssipl_billing/Ledger/accounting_ledgers/inputGST.dart';
import 'package:ssipl_billing/Ledger/accounting_ledgers/outputGST.dart';
import 'package:ssipl_billing/Ledger/accounting_ledgers/payableTDS.dart';
import 'package:ssipl_billing/Ledger/accounting_ledgers/receivableTDS.dart';
import 'package:ssipl_billing/Ledger/accounting_ledgers/vendorledger.dart';
import 'package:ssipl_billing/Ledger/inventory_ledgers/inward.dart';
import 'package:ssipl_billing/Ledger/inventory_ledgers/outward.dart';
import 'package:ssipl_billing/Ledger/inventory_ledgers/pettycase.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/vouchers/sales_voucher.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ViewLedger extends StatefulWidget {
  const ViewLedger({super.key});

  @override
  State<ViewLedger> createState() => _ViewLedgerState();
}

class _ViewLedgerState extends State<ViewLedger> {
  List<ValueItem> client_list = [
    const ValueItem(label: 'Option 1', value: '1'),
    const ValueItem(label: 'Option 2', value: '2'),
    const ValueItem(label: 'Option 3', value: '3'),
    const ValueItem(label: 'Option 4', value: '4'),
    const ValueItem(label: 'Option 5', value: '5'),
    const ValueItem(label: 'Option 6', value: '6')
  ];
  List<ValueItem> vendor_list = [
    const ValueItem(label: 'Option 1', value: '1'),
    const ValueItem(label: 'Option 2', value: '2'),
    const ValueItem(label: 'Option 3', value: '3'),
    const ValueItem(label: 'Option 4', value: '4'),
    const ValueItem(label: 'Option 5', value: '5'),
    const ValueItem(label: 'Option 6', value: '6')
  ];
  List<ValueItem> _selectedvendor = [];
  String? Selected_ledger_type = 'Client';
  List<String> amounttype_list = ['Debit', 'Credit', 'All'];
  String? Selected_amounte_type = 'All';
  List<String> accounting_ledger_type_list = ['Client', 'Vendor', 'Output GST', 'Input GST', 'Receivable TDS', 'Payable TDS', 'Consolidated'];
  List<String> Inventory_ledger_type_list = ['Petty Cash', 'Inward', 'Outward'];
  String selectedContent = "Consolidated Ledger"; // Default content
  String selectedMenu = "Accounting Ledger"; // Tracks the currently selected menu item
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  bool showFromCalendar = true;

  final DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;
  final FocusNode _fromFocusNode = FocusNode();
  final FocusNode _toFocusNode = FocusNode();
  void _onDateSelected(DateTime selectedDate, String calendarType) {
    setState(() {
      _selectedDate = selectedDate;
      if (calendarType == 'from') {
        _fromDateController.text = selectedDate.toIso8601String().split('T').first;
        showFromCalendar = false;
        _toFocusNode.requestFocus();
      } else {
        _toDateController.text = selectedDate.toIso8601String().split('T').first;
        showFromCalendar = true;
        _fromFocusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Primary_colors.Dark,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Primary_colors.Light,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
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
                                  selectedContent,
                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text12),
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
                                          fillColor: Primary_colors.Dark,
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
                                          fillColor: Primary_colors.Dark,
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
                                        items: selectedMenu == "Accounting Ledger"
                                            ? accounting_ledger_type_list.map<DropdownMenuItem<String>>(
                                                (String customer) {
                                                  return DropdownMenuItem<String>(
                                                    value: customer,
                                                    child: Text(customer),
                                                  );
                                                },
                                              ).toList()
                                            : Inventory_ledger_type_list.map<DropdownMenuItem<String>>(
                                                (String customer) {
                                                  return DropdownMenuItem<String>(
                                                    value: customer,
                                                    child: Text(customer),
                                                  );
                                                },
                                              ).toList(),
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
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Client')
                        const Expanded(
                          child: Client_ledger(),
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Vendor')
                        const Expanded(
                          child: Vendorledger(),
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Output GST')
                        const Expanded(
                          child: outputGST(),
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Input GST')
                        const Expanded(
                          child: inputGST(),
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Receivable TDS')
                        const Expanded(
                          child: receivableTDS(),
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Payable TDS')
                        const Expanded(
                          child: payableTDS(),
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Consolidated')
                        const Expanded(
                          child: consolidated(),
                        ),
                      if (selectedMenu == 'Inventory Ledger' && Selected_ledger_type == 'Petty Cash')
                        const Expanded(
                          child: pettyCase(),
                        ),
                      if (selectedMenu == 'Inventory Ledger' && Selected_ledger_type == 'Inward')
                        const Expanded(
                          child: Inward(),
                        ),
                      if (selectedMenu == 'Inventory Ledger' && Selected_ledger_type == 'Outward')
                        const Expanded(
                          child: Outward(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 300,
            // color: Primary_colors.Color3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  // padding: EdgeInsets.zero,
                  children: [
                    ExpansionTile(
                      tilePadding: const EdgeInsets.all(0),
                      collapsedIconColor: Primary_colors.Color1, iconColor: Primary_colors.Color3,
                      // leading: Icon(Icons.dashboard, color: selectedMenu == "Dashboard" || selectedMenu == "Settings" ? Colors.blue : Primary_colors.Color1),
                      title: Text(
                        "Ledger",
                        style: TextStyle(
                          fontSize: Primary_font_size.Text10,
                          color: selectedMenu == "Accounting Ledger" || selectedMenu == "Inventory Ledger" ? Primary_colors.Color3 : Primary_colors.Color1,
                        ),
                      ),
                      children: [
                        ListTile(
                          // leading: icon != null ? Icon(icon, color: isSelected ? Colors.blue : Primary_colors.Color1) : null,
                          title: Text(
                            "          Accounting Ledger",
                            style: TextStyle(color: selectedMenu == "Accounting Ledger" ? Primary_colors.Color8 : Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                          ),
                          // tileColor: selectedMenu == "Accounting Ledger" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                          hoverColor: Colors.blue.withOpacity(0.05),
                          onTap: () {
                            setState(() {
                              selectedMenu = "Accounting Ledger";
                              selectedContent = "Accounting Ledger";
                              Selected_ledger_type = 'Client';
                            });
                          },
                        ),
                        ListTile(
                          // leading: icon != null ? Icon(icon, color: isSelected ? Colors.blue : Primary_colors.Color1) : null,
                          title: Text(
                            "          Inventory Ledger",
                            style: TextStyle(
                              fontSize: Primary_font_size.Text7,
                              color: selectedMenu == "Inventory Ledger" ? Primary_colors.Color8 : Primary_colors.Color1,
                              fontWeight: selectedMenu == "Inventory Ledger" ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          // tileColor: selectedMenu == "Inventory Ledger" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                          hoverColor: Colors.blue.withOpacity(0.05),
                          onTap: () {
                            setState(
                              () {
                                selectedMenu = "Inventory Ledger";
                                selectedContent = "Inventory Ledger";
                                Selected_ledger_type = 'Petty Cash';
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.all(0),
                      collapsedIconColor: Primary_colors.Color1, iconColor: Primary_colors.Color3,
                      // leading: Icon(Icons.account_circle, color: selectedMenu == "Create voucher" || selectedMenu == "View voucher" ? Colors.blue : Primary_colors.Color1),
                      title: Text(
                        "Voucher",
                        style: TextStyle(fontSize: Primary_font_size.Text10, color: selectedMenu == "Create voucher" || selectedMenu == "View voucher" ? Primary_colors.Color3 : Primary_colors.Color1),
                      ),
                      children: [
                        ListTile(
                          // leading: icon != null ? Icon(icon, color: isSelected ? Colors.blue : Primary_colors.Color1) : null,
                          title: Text(
                            "          Create voucher",
                            style: TextStyle(
                              fontSize: Primary_font_size.Text7,
                              color: selectedMenu == "Create voucher" ? Primary_colors.Color8 : Primary_colors.Color1,
                              // fontWeight: selectedMenu == "Create voucher" ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          // tileColor: selectedMenu == "Create voucher" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                          hoverColor: Colors.blue.withOpacity(0.05),
                          onTap: () {
                            // setState(() {
                            //   selectedMenu = "Create voucher";
                            //   selectedContent = "Create voucher";
                            // });
                            showCustomBottomSheet();
                          },
                        ),
                        ListTile(
                          // leading: icon != null ? Icon(icon, color: isSelected ? Colors.blue : Primary_colors.Color1) : null,
                          title: Text(
                            "          View voucher",
                            style: TextStyle(
                                color: selectedMenu == "View voucher" ? Primary_colors.Color8 : Primary_colors.Color1,
                                // fontWeight: selectedMenu == "View voucher" ? FontWeight.bold : FontWeight.normal,
                                fontSize: Primary_font_size.Text7),
                          ),
                          // tileColor: selectedMenu == "View voucher" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                          hoverColor: Colors.blue.withOpacity(0.05),
                          onTap: () {
                            setState(() {
                              selectedMenu = "View voucher";
                              selectedContent = "View voucher";
                            });
                          },
                        ),
                      ],
                    ),
                    // Divider(),
                    // // Static Menu Item 1

                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      // leading: Icon(Icons.notifications, color: selectedMenu == "Notifications" ? Colors.blue : Primary_colors.Color1),
                      title: Text(
                        "Balance sheet",
                        style: TextStyle(
                          fontSize: Primary_font_size.Text10,
                          color: selectedMenu == "Balance sheet" ? Primary_colors.Color3 : Primary_colors.Color1,
                          fontWeight: selectedMenu == "Balance sheet" ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      // tileColor: selectedMenu == "Balance sheet" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                      hoverColor: Colors.blue.withOpacity(0.05),
                      onTap: () {
                        setState(() {
                          selectedMenu = "Balance sheet";
                          selectedContent = "Balance sheet";
                        });
                      },
                    ),
                    // Static Menu Item 2

                    // ListTile(
                    //   leading: Icon(Icons.info, color: selectedMenu == "Notifications" ? Colors.blue : Primary_colors.Color1),
                    //   title: Text(
                    //     "About",
                    //     style: TextStyle(
                    //       color: selectedMenu == "About" ? Colors.blue : Primary_colors.Color1,
                    //       fontWeight: selectedMenu == "About" ? FontWeight.bold : FontWeight.normal,
                    //     ),
                    //   ),
                    //   tileColor: selectedMenu == "About" ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                    //   hoverColor: Colors.blue.withOpacity(0.05),
                    //   onTap: () {
                    //     setState(() {
                    //       selectedMenu = "About";
                    //       selectedContent = "About Page Content";
                    //     });
                    //   },
                    // ),
                  ],
                ),
                const Divider(
                  height: 1,
                  color: Color.fromARGB(255, 169, 167, 167),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Row(
                  children: [
                    Icon(Icons.filter_alt_outlined),
                    Text(
                      'Filter',
                      style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text12),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      if ((selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Client') || (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Vendor'))
                        const SizedBox(
                          height: 30,
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Client')
                        const Text(
                          'Using Client name',
                          style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8),
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Client')
                        const SizedBox(
                          height: 15,
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Client')
                        MultiSelectDropDown(
                          searchBackgroundColor: Primary_colors.Color1,
                          hint: 'Select Client',
                          selectedOptionTextColor: Primary_colors.Color1,
                          dropdownBorderRadius: 10,
                          dropdownBackgroundColor: Primary_colors.Color3,
                          selectedOptionBackgroundColor: Primary_colors.Color3,
                          optionsBackgroundColor: Primary_colors.Color3,
                          padding: const EdgeInsets.all(10),
                          dropdownMargin: 0,
                          searchEnabled: true,
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 102, 102, 102),
                          ),
                          inputDecoration: BoxDecoration(color: Primary_colors.Light, borderRadius: BorderRadius.circular(20)),
                          onOptionSelected: (options) {
                            setState(() {});
                          },
                          options: client_list,
                          maxItems: client_list.length,
                          selectionType: SelectionType.multi,
                          chipConfig: const ChipConfig(
                            deleteIconColor: Color.fromARGB(255, 105, 105, 105),
                            backgroundColor: Primary_colors.Light,
                            wrapType: WrapType.scroll,
                          ),
                          dropdownHeight: 300,
                          optionTextStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                          selectedOptionIcon: const Icon(Icons.check_circle),
                          clearIcon: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Vendor')
                        const Text(
                          'Using Vendor name',
                          style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8),
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Vendor')
                        const SizedBox(
                          height: 15,
                        ),
                      if (selectedMenu == 'Accounting Ledger' && Selected_ledger_type == 'Vendor')
                        MultiSelectDropDown(
                          searchBackgroundColor: Primary_colors.Color1,
                          hint: 'Select Client',
                          selectedOptionTextColor: Primary_colors.Color1,
                          dropdownBorderRadius: 10,
                          dropdownBackgroundColor: Primary_colors.Color3,
                          selectedOptionBackgroundColor: Primary_colors.Color3,
                          optionsBackgroundColor: Primary_colors.Color3,
                          padding: const EdgeInsets.all(10),
                          dropdownMargin: 0,
                          searchEnabled: true,
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 102, 102, 102),
                          ),
                          inputDecoration: BoxDecoration(color: Primary_colors.Light, borderRadius: BorderRadius.circular(20)),
                          onOptionSelected: (options) {
                            setState(() {
                              _selectedvendor = options;
                            });
                          },
                          options: vendor_list,
                          maxItems: vendor_list.length,
                          selectionType: SelectionType.multi,
                          chipConfig: const ChipConfig(
                            deleteIconColor: Color.fromARGB(255, 105, 105, 105),
                            backgroundColor: Primary_colors.Light,
                            wrapType: WrapType.scroll,
                          ),
                          dropdownHeight: 300,
                          optionTextStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                          selectedOptionIcon: const Icon(Icons.check_circle),
                          clearIcon: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Using Amount',
                        style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        // height: 40,
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
                            value: Selected_amounte_type, // Bind your selected value here
                            onChanged: (String? newValue) {
                              setState(() {
                                Selected_amounte_type = newValue; // Update the selected value
                              });
                            },
                            items: amounttype_list.map<DropdownMenuItem<String>>(
                              (String customer) {
                                return DropdownMenuItem<String>(
                                  value: customer,
                                  child: Text(customer),
                                );
                              },
                            ).toList()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Using Date',
                        style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text8),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Primary_colors.Light,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: SizedBox(
                                  height: 40,
                                  child: TextField(
                                    controller: _fromDateController,
                                    focusNode: _fromFocusNode,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(left: 20),
                                      filled: true,
                                      fillColor: Primary_colors.Dark,
                                      labelText: 'From',
                                      labelStyle: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                    style: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                    onTap: () {
                                      setState(() {
                                        showFromCalendar = true;
                                      });
                                    },
                                  ),
                                )),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: TextField(
                                      focusNode: _toFocusNode,
                                      controller: _toDateController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(left: 20),
                                        filled: true,
                                        fillColor: Primary_colors.Dark,
                                        labelText: 'To',
                                        labelStyle: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                      ),
                                      style: const TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                      onTap: () {
                                        setState(
                                          () {
                                            showFromCalendar = false;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: showFromCalendar,
                              child: TableCalendar(
                                headerStyle: const HeaderStyle(formatButtonVisible: false, titleTextStyle: TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1)),
                                focusedDay: _focusedDate,
                                firstDay: DateTime(2000),
                                lastDay: DateTime(2100),
                                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                                onDaySelected: (selectedDay, focusedDay) {
                                  _onDateSelected(selectedDay, 'from');
                                },
                                calendarStyle: const CalendarStyle(
                                  todayTextStyle: TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                  todayDecoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  selectedDecoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  defaultTextStyle: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !showFromCalendar,
                              child: TableCalendar(
                                headerStyle: const HeaderStyle(formatButtonVisible: false, titleTextStyle: TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1)),
                                focusedDay: _focusedDate,
                                firstDay: DateTime(2000),
                                lastDay: DateTime(2100),
                                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                                onDaySelected: (selectedDay, focusedDay) {
                                  _onDateSelected(selectedDay, 'to');
                                },
                                calendarStyle: const CalendarStyle(
                                  todayTextStyle: TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                  todayDecoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  selectedDecoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  defaultTextStyle: TextStyle(color: Colors.white, fontSize: Primary_font_size.Text7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCustomBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return const SalesVoucher();
      },
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
