import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/controllers/Billing_actions.dart';
import 'package:ssipl_billing/2.BILLING/_main_BILLING/services/billing_services.dart';

import '../../../THEMES/style.dart'; // Assuming style.dart defines Primary_colors and Primary_font_size

class FilterScreen extends StatefulWidget with main_BillingService {
  FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final MainBilling_Controller mainBilling_Controller = Get.find<MainBilling_Controller>();

  bool isUsingDays = true;
  bool isUsingSpecificDate = false;
  bool isDateFilterSelected = true;
  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;

  // Date List options
  final List<String> dateOptions = [
    'Last Hour',
    'Last Day',
    'Last Week',
    'Last Month',
    'Last 3 Months',
  ];

  // Keep track of the selected date option (only one can be selected)
  int? selectedDateOptionIndex;

  // Client List options
  final List<String> clientOptions = [
    'Maharaja',
    'Khivraj',
    'Anamalais',
    'Honda',
  ];
  final List<bool> selectedClientOptions = [false, false, false, false];

  // Function to handle start date time selection
  // Future<void> _selectStartDateTime(BuildContext context) async {
  //   DateTime initialDate = selectedStartDateTime ?? DateTime.now();

  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: initialDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );

  //   if (pickedDate != null) {
  //     final TimeOfDay? pickedTime = await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.fromDateTime(initialDate),
  //     );
  //     if (pickedTime != null) {
  //       setState(() {
  //         selectedStartDateTime = DateTime(
  //           pickedDate.year,
  //           pickedDate.month,
  //           pickedDate.day,
  //           pickedTime.hour,
  //           pickedTime.minute,
  //         );
  //       });
  //     }
  //   }
  // }

  // // Function to handle end date time selection
  // Future<void> _selectEndDateTime(BuildContext context) async {
  //   DateTime initialDate = selectedEndDateTime ?? DateTime.now();

  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: initialDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );

  //   if (pickedDate != null) {
  //     final TimeOfDay? pickedTime = await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.fromDateTime(initialDate),
  //     );

  //     if (pickedTime != null) {
  //       setState(() {
  //         selectedEndDateTime = DateTime(
  //           pickedDate.year,
  //           pickedDate.month,
  //           pickedDate.day,
  //           pickedTime.hour,
  //           pickedTime.minute,
  //         );
  //       });
  //     }
  //   }
  // }

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
              'Filter Vouchers',
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
            // Quick Date Filters
            const Text('Quick Date Filters', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192))),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Obx(
                  () => _buildDateFilterChip('Show All'),
                ),
                Obx(() => _buildDateFilterChip('Last 1 hour  ')),
                Obx(() => _buildDateFilterChip('Last 24 hours')),
                Obx(() => _buildDateFilterChip('Last week')),
                Obx(() => _buildDateFilterChip('Last month')),
                Obx(() => _buildDateFilterChip('Custom range')),
              ],
            ),
            const SizedBox(height: 35),

            // Custom Date Range (visible when custom range is selected)
            Obx(() => mainBilling_Controller.billingModel.showCustomDateRange.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Custom Date Range', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192))),
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
                                controller: mainBilling_Controller.billingModel.startDateController.value,
                                readOnly: true,
                                onTap: () => widget.select_nextDates(context, mainBilling_Controller.billingModel.startDateController.value),
                                decoration: InputDecoration(
                                  labelText: 'From',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 154, 152, 152),
                                    fontSize: Primary_font_size.Text7,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                    color: const Color.fromARGB(255, 85, 84, 84),
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
                                  disabledBorder: OutlineInputBorder(
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
                                controller: mainBilling_Controller.billingModel.endDateController.value,
                                readOnly: true,
                                onTap: () => widget.select_nextDates(context, mainBilling_Controller.billingModel.endDateController.value),
                                decoration: InputDecoration(
                                  labelText: 'To',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 154, 152, 152),
                                    fontSize: Primary_font_size.Text7,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                    color: const Color.fromARGB(255, 85, 84, 84),
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
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromARGB(255, 85, 84, 84)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox()),
            Obx(() => SizedBox(height: mainBilling_Controller.billingModel.showCustomDateRange.value ? 35 : 0)),
            // Product Type Filter
            const Text('Invoice Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192))),
            const SizedBox(height: 8),
            Obx(
              () => Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    showCheckmark: false,
                    label: const Text('Show All'),
                    selected: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Show All',
                    onSelected: (_) {
                      mainBilling_Controller.billingModel.selectedInvoiceType.value = 'Show All';
                    },
                    backgroundColor: Primary_colors.Dark,
                    selectedColor: Primary_colors.Dark,
                    labelStyle: TextStyle(
                      fontSize: Primary_font_size.Text7,
                      color: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Show All' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                      ),
                    ),
                  ),
                  FilterChip(
                    label: const Text('Prepaid'),
                    selected: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Prepaid',
                    onSelected: (_) {
                      mainBilling_Controller.billingModel.selectedInvoiceType.value = 'Prepaid';
                    },
                    backgroundColor: Primary_colors.Dark,
                    showCheckmark: false,
                    selectedColor: Primary_colors.Dark,
                    labelStyle: TextStyle(
                      fontSize: Primary_font_size.Text7,
                      color: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Prepaid' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Prepaid' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                      ),
                    ),
                  ),
                  FilterChip(
                    label: const Text('Postpaid'),
                    selected: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Postpaid',
                    onSelected: (_) {
                      mainBilling_Controller.billingModel.selectedInvoiceType.value = 'Postpaid';
                    },
                    backgroundColor: Primary_colors.Dark,
                    showCheckmark: false,
                    selectedColor: Primary_colors.Dark,
                    labelStyle: TextStyle(
                      fontSize: Primary_font_size.Text7,
                      color: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Postpaid' ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: mainBilling_Controller.billingModel.selectedInvoiceType.value == 'Postpaid' ? Primary_colors.Color3 : const Color.fromARGB(255, 85, 84, 84),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),

            // Status Filter
            const Text('Payment Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192))),
            const SizedBox(height: 8),
            Container(
              // width: 3,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 85, 84, 84)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                value: mainBilling_Controller.billingModel.selectedPaymentStatus.value,
                items: ['Show All', 'Paid', 'Pending', 'Unpaid'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  mainBilling_Controller.billingModel.selectedPaymentStatus.value = value!;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: Primary_font_size.Text7, color: const Color.fromARGB(255, 154, 152, 152)),
                dropdownColor: Primary_colors.Dark,
              ),
            ),

            const SizedBox(height: 35),

            // Status Filter
            const Text('Package Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text8, color: Color.fromARGB(255, 194, 192, 192))),
            const SizedBox(height: 8),
            Container(
              // width: 3,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 85, 84, 84)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                menuMaxHeight: 200,
                value: mainBilling_Controller.billingModel.selectedPackageName.value,
                items: ['Show All', 'Secure-360', 'Package A', 'Package B', 'Package C', 'Package D', 'Package E'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  mainBilling_Controller.billingModel.selectedPackageName.value = value!;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: Primary_font_size.Text7, color: const Color.fromARGB(255, 154, 152, 152)),
                dropdownColor: Primary_colors.Dark,
              ),
            ),

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
                  onPressed: () {
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
        ),
      ),
    );
  }

  Widget _buildDateFilterChip(
    String label,
  ) {
    final isSelected = mainBilling_Controller.billingModel.selectedQuickFilter.value == label;

    return ChoiceChip(
      label: Text(
        label == 'Show All' ? 'Show All   ' : label,
        style: TextStyle(color: isSelected ? Primary_colors.Color3 : const Color.fromARGB(255, 154, 152, 152), fontSize: Primary_font_size.Text7),
      ),
      selected: isSelected,
      onSelected: (_) {
        mainBilling_Controller.billingModel.selectedQuickFilter.value = label;
        if (label == 'Custom range') {
          mainBilling_Controller.billingModel.showCustomDateRange.value = true;
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
  }
}

// Widget _buildSidebarItem({
//   required String title,
//   required bool isSelected,
//   required VoidCallback onTap,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.blue : Colors.transparent,
//         borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
//       ),
//       child: Text(
//         title,
//         style: TextStyle(
//           color: isSelected ? Colors.white : Primary_colors.Color1,
//           fontWeight: FontWeight.bold,
//           fontSize: Primary_font_size.Text10,
//         ),
//       ),
//     ),
//   );
// }

  // Widget _buildDateFilterList() {
  //   return Column(
  //     children: [
  //       const SizedBox(height: 30),
  //       Row(
  //         children: [
  //           Row(
  //             children: [
  //               Radio<bool>(
  //                 activeColor: const Color.fromARGB(255, 105, 212, 109), // Active color (green)
  //                 value: true,
  //                 groupValue: isUsingDays,
  //                 onChanged: (value) {
  //                   setState(() {
  //                     isUsingDays = true;
  //                     isUsingSpecificDate = false;
  //                   });
  //                 },
  //                 // Add the inactive color logic here
  //                 visualDensity: VisualDensity.compact,
  //                 toggleable: true, // Makes the radio button togglable, enabling inactive state handling
  //                 fillColor: WidgetStateProperty.resolveWith<Color>(
  //                   (states) {
  //                     if (states.contains(WidgetState.selected)) {
  //                       return const Color.fromARGB(255, 105, 212, 109); // Active color (green)
  //                     } else {
  //                       return Colors.grey; // Inactive color (red)
  //                     }
  //                   },
  //                 ),
  //               ),
  //               const Text('Using Days', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  //             ],
  //           ),
  //           const SizedBox(width: 10),
  //           Row(
  //             children: [
  //               Radio<bool>(
  //                 activeColor: const Color.fromARGB(255, 105, 212, 109),
  //                 value: true,
  //                 groupValue: isUsingSpecificDate,
  //                 onChanged: (value) {
  //                   setState(() {
  //                     isUsingSpecificDate = true;
  //                     isUsingDays = false;
  //                   });
  //                 },
  //                 fillColor: WidgetStateProperty.resolveWith<Color>(
  //                   (states) {
  //                     if (states.contains(WidgetState.selected)) {
  //                       return const Color.fromARGB(255, 105, 212, 109); // Active color (green)
  //                     } else {
  //                       return Colors.grey; // Inactive color (red)
  //                     }
  //                   },
  //                 ),
  //               ),
  //               const Text('Specific Date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  //             ],
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 10),
  //       if (isUsingDays)
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: dateOptions.length,
  //             itemBuilder: (context, index) {
  //               return RadioListTile<int>(
  //                 fillColor: WidgetStateProperty.resolveWith<Color>(
  //                   (states) {
  //                     if (states.contains(WidgetState.selected)) {
  //                       return Colors.blue; // Active color (green)
  //                     } else {
  //                       return Colors.grey; // Inactive color (red)
  //                     }
  //                   },
  //                 ),
  //                 title: Text(
  //                   dateOptions[index],
  //                   style: const TextStyle(
  //                     color: Primary_colors.Color1,
  //                     fontSize: Primary_font_size.Text7,
  //                   ),
  //                 ),
  //                 value: index,
  //                 groupValue: selectedDateOptionIndex,
  //                 onChanged: (value) {
  //                   setState(() {
  //                     selectedDateOptionIndex = value;
  //                   });
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //       if (isUsingSpecificDate)
  //         Column(
  //           children: [
  //             const SizedBox(height: 20),
  //             _buildDateTimeField('Start Date and Time', selectedStartDateTime, _selectStartDateTime),
  //             const SizedBox(height: 30),
  //             _buildDateTimeField('End Date and Time', selectedEndDateTime, _selectEndDateTime),
  //           ],
  //         ),
  //     ],
  //   );
  // }

  // Widget _buildDateTimeField(String hintText, DateTime? dateTime, Function(BuildContext) onTap) {
  //   return SizedBox(
  //     width: 400,
  //     height: 40,
  //     child: TextFormField(
  //       style: const TextStyle(fontSize: 13, color: Colors.white),
  //       readOnly: true,
  //       onTap: () => onTap(context),
  //       decoration: InputDecoration(
  //         contentPadding: const EdgeInsets.all(1),
  //         filled: true,
  //         fillColor: Primary_colors.Light,
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //           borderSide: BorderSide.none,
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //           borderSide: BorderSide.none,
  //         ),
  //         hintStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 167, 165, 165)),
  //         hintText: dateTime != null ? DateFormat('yyyy-MM-dd HH:mm').format(dateTime) : hintText,
  //         prefixIcon: const Icon(Icons.calendar_today, size: 20, color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildClientFilterList() {
  //   return Column(
  //     children: [
  //       const SizedBox(height: 30),
  //       Expanded(
  //         child: ListView.builder(
  //           itemCount: clientOptions.length,
  //           itemBuilder: (context, index) {
  //             return Theme(
  //               data: Theme.of(context).copyWith(
  //                 checkboxTheme: CheckboxThemeData(
  //                   checkColor: WidgetStateProperty.all(Colors.white), // Check color when active
  //                   fillColor: WidgetStateProperty.resolveWith<Color>(
  //                     (states) {
  //                       if (states.contains(WidgetState.selected)) {
  //                         return Colors.blue; // Active color
  //                       }
  //                       return Colors.grey; // Inactive color
  //                     },
  //                   ),
  //                 ),
  //               ),
  //               child: CheckboxListTile(
  //                 title: Text(
  //                   clientOptions[index],
  //                   style: const TextStyle(
  //                     color: Primary_colors.Color1,
  //                     fontSize: Primary_font_size.Text7,
  //                   ),
  //                 ),
  //                 value: selectedClientOptions[index],
  //                 onChanged: (value) {
  //                   setState(
  //                     () {
  //                       selectedClientOptions[index] = value!;
  //                     },
  //                   );
  //                 },
  //                 controlAffinity: ListTileControlAffinity.leading,
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
// }
