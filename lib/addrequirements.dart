import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/button.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';

class addrequirement_page extends StatefulWidget {
  final String customer_type;
  const addrequirement_page({
    super.key,
    required this.customer_type,
  });
  @override
  _addrequirement_pageState createState() => _addrequirement_pageState();
}

class _addrequirement_pageState extends State<addrequirement_page> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> productlist = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextTab() {
    if (_tabController.index < _tabController.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  void _backTab() {
    if (_tabController.index > 0) {
      _tabController.animateTo(_tabController.index - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary_colors.Light,
      body: Column(
        children: [
          Container(
            color: Primary_colors.Dark,
            child: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: IgnorePointer(
                child: TabBar(
                  unselectedLabelStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                  labelStyle: const TextStyle(color: Color.fromARGB(255, 227, 77, 60), fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold),
                  controller: _tabController,
                  indicator: const BoxDecoration(),
                  tabs: const [
                    Tab(text: "Details"),
                    Tab(text: "Requirement"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [Add_details(), addrequirements()],
            ),
          ),
        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  Widget Add_details() {
    // final TextEditingController titleController = TextEditingController();
    // final TextEditingController clientaddressnameController = TextEditingController();
    // final TextEditingController clientaddressController = TextEditingController();
    // final TextEditingController billingaddressnameController = TextEditingController();
    // final TextEditingController billingaddressController = TextEditingController();
    // String? selectedValue; // Holds the currently selected value
    // List<String> customer_list = ['Option 1', 'Option 2', 'Option 3'];
    String? _selectedModelType;

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Add Enquiry Customer',
                      style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text10),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    widget.customer_type == 'Enquiry'
                        ? SizedBox(
                            width: 400,
                            height: 50,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13, color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(1),
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                                hintStyle: const TextStyle(
                                  fontSize: Primary_font_size.Text7,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                hintText: 'Enter Name',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.person, color: Colors.white),
                              ),
                            ),
                          )
                        : ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 400,
                            ),
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Primary_colors.Dark,
                              decoration: const InputDecoration(
                                  label: Text(
                                    'Customer Type',
                                    style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 177, 176, 176)),
                                  ),
                                  // hintText: 'Customer Type',hintStyle: TextStyle(),
                                  contentPadding: EdgeInsets.all(13),
                                  labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                                  filled: true,
                                  fillColor: Primary_colors.Dark,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.people,
                                    color: Colors.white,
                                  )),
                              value: _selectedModelType,
                              items: <String>[
                                'Option 1',
                                'Option 2',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(
                                  () {
                                    _selectedModelType = newValue;
                                  },
                                );
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Select customer type';
                                }
                                return null;
                              },
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(1),
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                          hintStyle: const TextStyle(
                            fontSize: Primary_font_size.Text7,
                            color: Color.fromARGB(255, 167, 165, 165),
                          ),
                          hintText: 'Enter Phone Number',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.phone, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(1),
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                          hintStyle: const TextStyle(
                            fontSize: Primary_font_size.Text7,
                            color: Color.fromARGB(255, 167, 165, 165),
                          ),
                          hintText: 'Enter Email',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.email, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(1),
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                          hintStyle: const TextStyle(
                            fontSize: Primary_font_size.Text7,
                            color: Color.fromARGB(255, 167, 165, 165),
                          ),
                          hintText: 'Enter GST Number',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.numbers, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(1),
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                          hintStyle: const TextStyle(
                            fontSize: Primary_font_size.Text7,
                            color: Color.fromARGB(255, 167, 165, 165),
                          ),
                          hintText: 'Enter Address',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.location_city, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Close',
                              style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        Container(
                          width: 70,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              _nextTab();
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  final _formKey_foraddrequirement = GlobalKey<FormState>();
  int length_foraddrequirement = 0; // Changed from dynamic to int
  int? editIndex_foraddrequirement; // Index of the camera being edited
  final TextEditingController descriptionController_foraddrequirement = TextEditingController();
  final TextEditingController quantityController_foraddrequirement = TextEditingController();
  List<Map<String, dynamic>> requirement_lists = [];

  void _add_requirementas() {
    if (_formKey_foraddrequirement.currentState?.validate() ?? false) {
      // Check if RTSP URL already exists
      bool exists = requirement_lists.any((requirements) => requirements['description'] == descriptionController_foraddrequirement.text);

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.blue, content: Text('This Requirement Name already exists.')),
        );
        return; // Exit the method without adding the camera
      }

      setState(() {
        requirement_lists.add({
          'description': descriptionController_foraddrequirement.text,
          'quantity': quantityController_foraddrequirement.text,
        });
        length_foraddrequirement = requirement_lists.length;
        _clear_requirementas();
      });
    }
  }

  void _update_requirementas() {
    if (_formKey_foraddrequirement.currentState?.validate() ?? false) {
      setState(() {
        requirement_lists[editIndex_foraddrequirement!] = {
          'description': descriptionController_foraddrequirement.text,
          'quantity': quantityController_foraddrequirement.text,
        };
        _clear_requirementas();
        editIndex_foraddrequirement = null;
        length_foraddrequirement = requirement_lists.length;
      });
    }
  }

  void _clear_requirementas() {
    setState(() {
      descriptionController_foraddrequirement.text = '';
      quantityController_foraddrequirement.text = "";
    });
  }

  void _edit_requirementas(int index) {
    Map<String, dynamic> service = requirement_lists[index];

    setState(() {
      descriptionController_foraddrequirement.text = service['description'] ?? '';
      quantityController_foraddrequirement.text = service['quantity'] ?? '';

      editIndex_foraddrequirement = index; // Set the index of the item being edited
    });

    // print('Edit------------------${selected_notify_Items}');
  }

  void _reset_requirementas() {
    editIndex_foraddrequirement = null;
    setState(() {
      _clear_requirementas();
    });
  }

  Widget addrequirements() {
    return Scaffold(
      backgroundColor: Primary_colors.Light,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey_foraddrequirement,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Add service',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 400,
                        child: Column(
                          children: [
                            TextFormField(
                              style: const TextStyle(fontSize: 13, color: Colors.white),
                              controller: descriptionController_foraddrequirement,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                // labelText: text,
                                hintText: 'Enter Desciption',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.title,
                                  color: Colors.white,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Desciption';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Textfield_1(
                        readonly: false,
                        text: 'Quantity',
                        controller: quantityController_foraddrequirement,
                        icon: Icons.production_quantity_limits,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter quantity';
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
                              // print('object');
                              editIndex_foraddrequirement == null ? _backTab() : _reset_requirementas(); // Reset editing state when going back
                            },
                          ),
                          const SizedBox(width: 30),
                          Button1(
                            colors: editIndex_foraddrequirement == null ? Colors.blue : Colors.orange,
                            text: editIndex_foraddrequirement == null ? 'Add service' : 'Update',
                            onPressed: editIndex_foraddrequirement == null ? _add_requirementas : _update_requirementas,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // if (length != 0) const SizedBox(width: 60),
                  if (length_foraddrequirement != 0)
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
                                  'Requirement List',
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
                                        child: servicelists_foraddrequirement(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        if (requirement_lists.isNotEmpty)
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

  Widget servicelists_foraddrequirement() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < length_foraddrequirement; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _edit_requirementas(i);
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
                            '${i + 1}. ${requirement_lists[i]['description']}', // Display camera type from map
                            style: const TextStyle(color: Primary_colors.Color1, fontSize: 13),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  requirement_lists.removeAt(i);
                                  length_foraddrequirement = requirement_lists.length;
                                });
                              },
                              icon: const Icon(Icons.close),
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
