import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ssipl_billing/common_modules/style.dart'; // Assuming style.dart defines Primary_colors and Primary_font_size

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
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
  Future<void> _selectStartDateTime(BuildContext context) async {
    DateTime initialDate = selectedStartDateTime ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (pickedTime != null) {
        setState(() {
          selectedStartDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  // Function to handle end date time selection
  Future<void> _selectEndDateTime(BuildContext context) async {
    DateTime initialDate = selectedEndDateTime ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (pickedTime != null) {
        setState(() {
          selectedEndDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          // Left Sidebar: Date and Client selectors
          Container(
            width: 150,
            decoration: BoxDecoration(
              color: Primary_colors.Light,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildSidebarItem(
                  title: 'Date Filter',
                  isSelected: isDateFilterSelected,
                  onTap: () => setState(() => isDateFilterSelected = true),
                ),
                const SizedBox(height: 20),
                _buildSidebarItem(
                  title: 'Client Filter',
                  isSelected: !isDateFilterSelected,
                  onTap: () => setState(() => isDateFilterSelected = false),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Right Section: Date or Client checkboxes
          Expanded(
            child: isDateFilterSelected ? _buildDateFilterList() : _buildClientFilterList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Primary_colors.Color1,
            fontWeight: FontWeight.bold,
            fontSize: Primary_font_size.Text10,
          ),
        ),
      ),
    );
  }

  Widget _buildDateFilterList() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Row(
          children: [
            Row(
              children: [
                Radio<bool>(
                  activeColor: const Color.fromARGB(255, 105, 212, 109), // Active color (green)
                  value: true,
                  groupValue: isUsingDays,
                  onChanged: (value) {
                    setState(() {
                      isUsingDays = true;
                      isUsingSpecificDate = false;
                    });
                  },
                  // Add the inactive color logic here
                  visualDensity: VisualDensity.compact,
                  toggleable: true, // Makes the radio button togglable, enabling inactive state handling
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color.fromARGB(255, 105, 212, 109); // Active color (green)
                      } else {
                        return Colors.grey; // Inactive color (red)
                      }
                    },
                  ),
                ),
                const Text('Using Days', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                Radio<bool>(
                  activeColor: const Color.fromARGB(255, 105, 212, 109),
                  value: true,
                  groupValue: isUsingSpecificDate,
                  onChanged: (value) {
                    setState(() {
                      isUsingSpecificDate = true;
                      isUsingDays = false;
                    });
                  },
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color.fromARGB(255, 105, 212, 109); // Active color (green)
                      } else {
                        return Colors.grey; // Inactive color (red)
                      }
                    },
                  ),
                ),
                const Text('Specific Date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (isUsingDays)
          Expanded(
            child: ListView.builder(
              itemCount: dateOptions.length,
              itemBuilder: (context, index) {
                return RadioListTile<int>(
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.blue; // Active color (green)
                      } else {
                        return Colors.grey; // Inactive color (red)
                      }
                    },
                  ),
                  title: Text(
                    dateOptions[index],
                    style: const TextStyle(
                      color: Primary_colors.Color1,
                      fontSize: Primary_font_size.Text7,
                    ),
                  ),
                  value: index,
                  groupValue: selectedDateOptionIndex,
                  onChanged: (value) {
                    setState(() {
                      selectedDateOptionIndex = value;
                    });
                  },
                );
              },
            ),
          ),
        if (isUsingSpecificDate)
          Column(
            children: [
              const SizedBox(height: 20),
              _buildDateTimeField('Start Date and Time', selectedStartDateTime, _selectStartDateTime),
              const SizedBox(height: 30),
              _buildDateTimeField('End Date and Time', selectedEndDateTime, _selectEndDateTime),
            ],
          ),
      ],
    );
  }

  Widget _buildDateTimeField(String hintText, DateTime? dateTime, Function(BuildContext) onTap) {
    return SizedBox(
      width: 400,
      height: 40,
      child: TextFormField(
        style: const TextStyle(fontSize: 13, color: Colors.white),
        readOnly: true,
        onTap: () => onTap(context),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(1),
          filled: true,
          fillColor: Primary_colors.Light,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 167, 165, 165)),
          hintText: dateTime != null ? DateFormat('yyyy-MM-dd HH:mm').format(dateTime) : hintText,
          prefixIcon: const Icon(Icons.calendar_today, size: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildClientFilterList() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Expanded(
          child: ListView.builder(
            itemCount: clientOptions.length,
            itemBuilder: (context, index) {
              return Theme(
                data: Theme.of(context).copyWith(
                  checkboxTheme: CheckboxThemeData(
                    checkColor: WidgetStateProperty.all(Colors.white), // Check color when active
                    fillColor: WidgetStateProperty.resolveWith<Color>(
                      (states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.blue; // Active color
                        }
                        return Colors.grey; // Inactive color
                      },
                    ),
                  ),
                ),
                child: CheckboxListTile(
                  title: Text(
                    clientOptions[index],
                    style: const TextStyle(
                      color: Primary_colors.Color1,
                      fontSize: Primary_font_size.Text7,
                    ),
                  ),
                  value: selectedClientOptions[index],
                  onChanged: (value) {
                    setState(
                      () {
                        selectedClientOptions[index] = value!;
                      },
                    );
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
