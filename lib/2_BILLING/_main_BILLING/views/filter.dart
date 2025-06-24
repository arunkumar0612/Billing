import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:ssipl_billing/2_BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2_BILLING/_main_BILLING/services/billing_services.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

import '../../../THEMES/style.dart'; // Assuming style.dart defines Primary_colors and Primary_font_size

class FilterScreen extends StatefulWidget with main_BillingService {
  FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Primary_colors.Light,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      width: 150,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter the invoice',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Primary_colors.Color3),
              ),
              const Divider(height: 30, thickness: 1, color: Color.fromARGB(255, 97, 97, 97)),
              if (mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Subscription')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 35),
                    // Quick Date Filters
                    const Text(
                      'Plan type',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Obx(
                          () => _buildmainBilling_typeFilterChip('Show All'),
                        ),
                        Obx(
                          () => _buildmainBilling_typeFilterChip('Prepaid'),
                        ),
                        Obx(
                          () => _buildmainBilling_typeFilterChip('Postpaid'),
                        )
                      ],
                    ),
                  ],
                ),

              // Product Type Filter

              Obx(
                () => SizedBox(
                  child: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Sales'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 35),
                            const Text(
                              'Select sales client',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                            ),
                            const SizedBox(height: 10),
                            Obx(() {
                              return SizedBox(
                                height: 35,
                                // width: 250,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color.fromARGB(255, 91, 90, 90), width: 1.0),
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
                                            menuProps: MenuProps(borderRadius: BorderRadius.circular(6.0), elevation: 3),
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
                                              floatingLabelStyle: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            baseStyle: const TextStyle(
                                              fontSize: 12, // Smaller font size
                                              color: Color.fromARGB(255, 138, 137, 137),
                                            ),
                                          ),
                                          items: mainBilling_Controller.billingModel.salesCustomerList.map((customer) {
                                            return customer.customerName;
                                          }).toList(),
                                          selectedItem: mainBilling_Controller.billingModel.selectedsalescustomer.value,
                                          onChanged: (value) {
                                            if (value != null) {
                                              mainBilling_Controller.billingModel.selectedsalescustomer.value = value;
                                              final customerList = mainBilling_Controller.billingModel.salesCustomerList;

                                              // Find the index of the selected customer
                                              final index = customerList.indexWhere((customer) => customer.customerName == value);
                                              mainBilling_Controller.billingModel.selectedcustomerID.value = mainBilling_Controller.billingModel.salesCustomerList[index].customerId;
                                              if (kDebugMode) {
                                                print('Selected customer ID: ${mainBilling_Controller.billingModel.selectedcustomerID.value}');
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      Obx(
                                        () => SizedBox(
                                          child: mainBilling_Controller.billingModel.selectedsalescustomer.value != 'None'
                                              ? IconButton(
                                                  onPressed: () {
                                                    mainBilling_Controller.billingModel.selectedsalescustomer.value = 'None';
                                                  },
                                                  icon: const Icon(Icons.close, color: Colors.red, size: 18),
                                                )
                                              : const SizedBox(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
              Obx(
                () => SizedBox(
                  child: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Subscription'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 35),
                            const Text(
                              'Select subscription customer',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
                            ),
                            const SizedBox(height: 10),
                            Obx(() {
                              return SizedBox(
                                height: 35,
                                // width: 250,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color.fromARGB(255, 91, 90, 90), width: 1.0),
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
                                            menuProps: MenuProps(borderRadius: BorderRadius.circular(6.0), elevation: 3),
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
                                              floatingLabelStyle: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            baseStyle: const TextStyle(
                                              fontSize: 12, // Smaller font size
                                              color: Color.fromARGB(255, 138, 137, 137),
                                            ),
                                          ),
                                          items: mainBilling_Controller.billingModel.subCustomerList.map((customer) {
                                            return customer.customerName;
                                          }).toList(),
                                          selectedItem: mainBilling_Controller.billingModel.selectedsubcustomer.value,
                                          onChanged: (value) {
                                            if (value != null) {
                                              mainBilling_Controller.billingModel.selectedsubcustomer.value = value;
                                              final customerList = mainBilling_Controller.billingModel.subCustomerList;

                                              // Find the index of the selected customer
                                              final index = customerList.indexWhere((customer) => customer.customerName == value);
                                              mainBilling_Controller.billingModel.selectedcustomerID.value = mainBilling_Controller.billingModel.subCustomerList[index].customerId;

                                              // print('Selected customer ID: ${mainBilling_Controller.billingModel.selectedsubcustomerID.value}');
                                              // widget.get_mainBilling_List();
                                            }
                                          },
                                        ),
                                      ),
                                      Obx(
                                        () => SizedBox(
                                          child: mainBilling_Controller.billingModel.selectedsubcustomer.value != 'None'
                                              ? IconButton(
                                                  onPressed: () {
                                                    mainBilling_Controller.billingModel.selectedsubcustomer.value = 'None';
                                                    mainBilling_Controller.billingModel.selectedcustomerID.value = 'None';

                                                    widget.get_SubscriptionInvoiceList();
                                                    widget.get_SalesInvoiceList();
                                                  },
                                                  icon: const Icon(Icons.close, color: Colors.red, size: 18),
                                                )
                                              : const SizedBox(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
              const SizedBox(height: 35),

              // Status Filter
              const Text(
                'Payment status',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192)),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 85, 84, 84)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: mainBilling_Controller.billingModel.selectedpaymentstatus.value,
                    isDense: true, // Reduces the vertical height
                    items: mainBilling_Controller.billingModel.paymentstatusList.map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      mainBilling_Controller.billingModel.selectedpaymentstatus.value = value!;
                      // widget.get_mainBilling_List();
                    },
                    decoration: const InputDecoration(
                      isDense: true, // Makes the field more compact
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Smaller padding
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 154, 152, 152)),
                    dropdownColor: Primary_colors.Dark,
                  ),
                ),
              ),

              const SizedBox(height: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          child: mainBilling_Controller.billingModel.startDateController.value.text.isNotEmpty || mainBilling_Controller.billingModel.endDateController.value.text.isNotEmpty
                              ? TextButton(
                                  onPressed: () {
                                    mainBilling_Controller.billingModel.selectedMonth.value = 'None';
                                    mainBilling_Controller.billingModel.startDateController.value.clear();
                                    mainBilling_Controller.billingModel.endDateController.value.clear();
                                    mainBilling_Controller.billingModel.selectedMonth.refresh();
                                    mainBilling_Controller.billingModel.startDateController.refresh();
                                    mainBilling_Controller.billingModel.endDateController.refresh();
                                    // widget.get_mainBilling_List();
                                  },
                                  child: const Text('Clear', style: TextStyle(fontSize: Primary_font_size.Text7)),
                                )
                              : const SizedBox(),
                        ),
                      ),
                      const Spacer(),
                      Obx(
                        () {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            width: 100, // Adjust width as needed
                            height: 30, // Adjust height as needed
                            child: DropdownButtonFormField<String>(
                              menuMaxHeight: 300,
                              value: mainBilling_Controller.billingModel.selectedMonth.value,
                              items: ['None', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].map((String value) {
                                return DropdownMenuItem<String>(value: value, child: Text(value));
                              }).toList(),
                              onChanged: (value) {
                                mainBilling_Controller.billingModel.selectedMonth.value = value!;
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

                                  mainBilling_Controller.billingModel.startDateController.value.text = formatDate(firstDay);
                                  mainBilling_Controller.billingModel.endDateController.value.text = formatDate(lastDay);
                                  mainBilling_Controller.billingModel.startDateController.refresh();
                                  mainBilling_Controller.billingModel.endDateController.refresh();
                                  // widget.get_mainBilling_List();
                                } else {
                                  mainBilling_Controller.billingModel.startDateController.value.clear();
                                  mainBilling_Controller.billingModel.endDateController.value.clear();
                                  mainBilling_Controller.billingModel.startDateController.refresh();
                                  mainBilling_Controller.billingModel.endDateController.refresh();
                                  // widget.get_mainBilling_List();
                                }
                              },
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 8),
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              ),
                              style: const TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 154, 152, 152)),
                              dropdownColor: Primary_colors.Dark,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 35,
                            child: TextFormField(
                              style: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                              controller: mainBilling_Controller.billingModel.startDateController.value,
                              readOnly: true,
                              onTap: () async {
                                await select_previousDates(context, mainBilling_Controller.billingModel.startDateController.value);
                                // await widget.get_mainBilling_List();
                                mainBilling_Controller.billingModel.startDateController.refresh();
                              },
                              decoration: InputDecoration(
                                labelText: 'From',
                                labelStyle: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                                suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Color.fromARGB(255, 85, 84, 84)),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                              style: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                              controller: mainBilling_Controller.billingModel.endDateController.value,
                              readOnly: true,
                              onTap: () async {
                                await select_previousDates(context, mainBilling_Controller.billingModel.endDateController.value);
                                mainBilling_Controller.billingModel.endDateController.refresh();
                                // await widget.get_mainBilling_List();
                              },
                              decoration: InputDecoration(
                                labelText: 'To',
                                labelStyle: const TextStyle(color: Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
                                suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Color.fromARGB(255, 85, 84, 84)),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                  ),
                  const SizedBox(height: 35),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      widget.resetmainbilling_Filters();
                      widget.get_SubscriptionInvoiceList();
                      widget.get_SalesInvoiceList();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Primary_colors.Color3),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('RESET', style: TextStyle(color: Primary_colors.Color3)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      widget.assignmainbilling_Filters();
                      widget.get_SubscriptionInvoiceList();
                      widget.get_SalesInvoiceList();
                      Navigator.pop(context);
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
          )),
    );
  }

  Widget _buildmainBilling_typeFilterChip(String label) {
    final isSelected = mainBilling_Controller.billingModel.selectedplantype.value == label;

    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
      ),
      selected: isSelected,
      onSelected: (_) {
        mainBilling_Controller.billingModel.selectedplantype.value = label;
        // widget.get_mainBilling_List();
      },
      backgroundColor: Primary_colors.Dark,
      selectedColor: Primary_colors.Dark,
      labelStyle: TextStyle(color: isSelected ? Primary_colors.Color3 : Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84)),
      ),
    );
  }
}
