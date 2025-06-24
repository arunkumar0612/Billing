import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/COMPONENTS-/Basic_DialogBox.dart';

import '../../../../../THEMES/style.dart';
import '../../../COMPONENTS-/button.dart';
import '../../../COMPONENTS-/textfield.dart';

class addservice_page extends StatefulWidget {
  const addservice_page({super.key});
  @override
  addservice_pageState createState() {
    return addservice_pageState();
  }
}

class addservice_pageState extends State<addservice_page> {
  final _formKey = GlobalKey<FormState>();
  int length = 0; // Changed from dynamic to int
  int? editIndex; // Index of the camera being edited
  final TextEditingController nameController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  List<Map<String, dynamic>> servicelist = [];
  @override
  void initState() {
    super.initState();
  }

  /// Adds a new service to the `servicelist` if the form is valid and the name is unique.
  ///
  /// Functionality:
  /// - Validates the form using `_formKey`.
  /// - Checks if a service with the same name (`servicename`) already exists.
  ///   - If it exists, shows an error snackbar and aborts addition.
  /// - If not, adds a new map with `servicename` and `servicecost` to `servicelist`.
  /// - Updates the list length and clears the input fields.
  ///
  /// Use Case:
  /// Used in a form where users dynamically add service entries to a list with validation
  /// and duplicate checking.
  void _addservice() {
    if (_formKey.currentState?.validate() ?? false) {
      // Check if RTSP URL already exists
      bool exists = servicelist.any((service) => service['servicename'] == nameController.text);

      if (exists) {
        Error_SnackBar(context, 'This service Name already exists.');

        return; // Exit the method without adding the camera
      }

      setState(() {
        servicelist.add({
          'servicename': nameController.text,
          'servicecost': costController.text,
        });
        length = servicelist.length;
        _clearFields();
      });
    }
  }

  /// Updates an existing service entry in the `servicelist` at the specified `editIndex`.
  ///
  /// Functionality:
  /// - Validates the form using `_formKey`.
  /// - If valid, updates the map at `servicelist[editIndex]` with new values from
  ///   `nameController` and `costController`.
  /// - Clears the input fields using `_clearFields()`.
  /// - Resets `editIndex` to null.
  /// - Updates the `length` to reflect the current size of `servicelist`.
  ///
  /// Use Case:
  /// Called when editing a previously added service in the list, allowing users
  /// to modify name and cost values.
  void _updateCamera() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        servicelist[editIndex!] = {
          'servicename': nameController.text,
          'servicecost': costController.text,
        };
        _clearFields();
        editIndex = null;
        length = servicelist.length;
      });
    }
  }

  void _clearFields() {
    setState(() {
      nameController.clear();
      costController.clear();
    });
  }

  void _editCamera(int index) {
    Map<String, dynamic> service = servicelist[index];

    setState(() {
      nameController.text = service['servicename'] ?? '';
      costController.text = service['servicecost'] ?? '';

      editIndex = index; // Set the index of the item being edited
    });

    // print('Edit------------------${selected_notify_Items}');
  }

  void _resetEditingState() {
    setState(() {
      _clearFields();
      editIndex = null;
    });
  }

  /// Builds the main UI layout for the "Add Service" screen using a `Scaffold`.
  ///
  /// Structure:
  /// - The layout uses a `Row` to divide the screen into two sections:
  ///   1. **Left Panel** (Service Entry Form):
  ///      - Title and form fields to input a new service name and cost.
  ///      - Includes validation for both fields.
  ///      - Two buttons:
  ///        - "Back": Resets editing state.
  ///        - "Add Service" or "Update": Based on `editIndex`, adds or updates a service.
  ///   2. **Right Panel** (Service List):
  ///      - Displays a scrollable container with the list of added services.
  ///      - Visible only when at least one service exists (`length != 0`).
  ///      - Includes a "Submit" button for final action (e.g., saving to backend).
  ///
  /// Notes:
  /// - The form uses `GlobalKey<FormState>` (`_formKey`) for validation.
  /// - Responsive UI using padding, spacing, and scrollable containers.
  /// - Controls like `BasicTextfield` and `BasicButton` are reused custom widgets.
  /// - Uses `editIndex` to toggle between adding and editing mode.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary_colors.Light,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Add service',
                        style: TextStyle(fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                      ),
                      const SizedBox(height: 25),
                      BasicTextfield(
                        digitsOnly: false,
                        width: 400,
                        readonly: false,
                        text: 'service name',
                        controller: nameController,
                        icon: Icons.electrical_services_sharp,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter service name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      BasicTextfield(
                        digitsOnly: false,
                        width: 400,
                        readonly: false,
                        text: 'service Cost',
                        controller: costController,
                        icon: Icons.currency_rupee,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter service cost';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BasicButton(
                            colors: Colors.red,
                            text: 'Back',
                            onPressed: () {
                              _resetEditingState(); // Reset editing state when going back
                            },
                          ),
                          const SizedBox(width: 30),
                          BasicButton(
                            colors: editIndex == null ? Colors.blue : Colors.orange,
                            text: editIndex == null ? 'Add service' : 'Update',
                            onPressed: editIndex == null ? _addservice : _updateCamera,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // if (length != 0) const SizedBox(width: 60),
                  if (length != 0)
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Primary_colors.Dark,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 15),
                            child: Column(
                              children: [
                                const Text(
                                  'Service List',
                                  style: TextStyle(fontSize: 17, color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 175,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: servicelists(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        if (servicelist.isNotEmpty)
                          BasicButton(
                            colors: Colors.green,
                            text: 'Submit',
                            onPressed: () {
                              if (kDebugMode) {
                                print('Addded');
                              }
                            },
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a vertical list of service items with edit and delete options.
  ///
  /// Functionality:
  /// - Iterates through the `servicelist` using a `for` loop based on `length`.
  /// - For each service:
  ///   - Displays a styled container showing the service name with an index.
  ///   - Includes an `IconButton` (close icon) to remove the service from the list.
  ///   - Entire row is wrapped in a `GestureDetector` to allow editing when tapped (`_editCamera(i)`).
  ///
  /// Layout:
  /// - Each service item is displayed inside a `Container` with padding and styling.
  /// - Uses a `Column` to stack service entries vertically.
  /// - Adds spacing (`SizedBox`) between each service item for readability.
  ///
  /// Behavior:
  /// - When a service is tapped, it triggers edit mode.
  /// - When the close icon is pressed, that service entry is removed and the list is updated.
  ///
  /// Use Case:
  /// Used for managing a dynamic list of services in a form or settings screen.
  Widget servicelists() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _editCamera(i);
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Primary_colors.Light),
                  height: 40,
                  width: 300,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${i + 1}. ${servicelist[i]['servicename']}', // Display camera type from map
                            style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  servicelist.removeAt(i);
                                  length = servicelist.length;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
      ],
    );
  }
}
