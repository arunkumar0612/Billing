import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/button.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';

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

  void _addservice() {
    if (_formKey.currentState?.validate() ?? false) {
      // Check if RTSP URL already exists
      bool exists = servicelist.any((service) => service['servicename'] == nameController.text);

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.blue, content: Text('This service Name already exists.')),
        );
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
                      Textfield_1(
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
                      Textfield_1(
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
                          Button1(
                            colors: Colors.red,
                            text: 'Back',
                            onPressed: () {
                              _resetEditingState(); // Reset editing state when going back
                            },
                          ),
                          const SizedBox(width: 30),
                          Button1(
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
                          Button1(
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
