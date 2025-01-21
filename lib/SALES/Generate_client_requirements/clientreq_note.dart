import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/SALES/Generate_client_requirements/clientreq_details.dart';
import 'package:ssipl_billing/SALES/Generate_client_requirements/clientreq_products.dart';
import 'package:ssipl_billing/SALES/Generate_client_requirements/generate_clientreq.dart';
import 'package:ssipl_billing/SALES/Generate_client_requirements/clientreq_template.dart';
import 'package:ssipl_billing/SALES/Generate_client_requirements/view_clientreq_send.dart';
// import 'package:ssipl_billing/Sales.dart';
import 'package:ssipl_billing/button.dart';
// import 'package:ssipl_billing/Sales/client.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';
import 'dart:io';
// import 'package:ssipl_billing/view_send_pdf.dart';

class clientreqNote extends StatefulWidget {
  const clientreqNote({super.key});
  static List<Map<String, dynamic>> clientreq_noteList = [];
  static List<Map<String, dynamic>> clientreq_recommendationList = [];
  @override
  State<clientreqNote> createState() => _clientreqNoteState();
}

class _clientreqNoteState extends State<clientreqNote> {
  final _noteformKey = GlobalKey<FormState>();
  // final _notetable_formKey = GlobalKey<FormState>();
  int notelength = 0;
  int notetablelength = 0;

  int? noteeditIndex;
  int? notetable_editIndex;
  // final TextEditingController NoteHeadingController = TextEditingController();
  final TextEditingController notecontentController = TextEditingController();
  final TextEditingController TableHeadingController = TextEditingController();
  final TextEditingController tablekey_Controller = TextEditingController();
  final TextEditingController tablevalue_Controller = TextEditingController();
  String? selectedheadingType;
  // List<String> noteType = [
  //   'With Heading',
  //   'Without Heading',
  // ];
  List<String> notecontent = <String>[
    'Delivery within 30 working days from the date of issuing the PO.',
    'Payment terms : 100% along with PO.',
    'Client needs to provide Ethernet cable and UPS power supply to the point where the device is proposed to install.',
  ];

  void _addtable_row() {
    clientreqDetails.clientreq_table_heading = TableHeadingController.text;
    // if (_notetable_formKey.currentState?.validate() ?? false) {
    // Check if note Name already exists
    bool exists = clientreqNote.clientreq_recommendationList.any((note) => note['key'] == tablekey_Controller.text);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('This note Name already exists.'),
        ),
      );
      return; // Exit the method without adding the note
    }
    setState(
      () {
        clientreqNote.clientreq_recommendationList.add({
          // 'notetype': selectedheadingType ?? '',
          // 'noteheading': selectedheadingType == 'With Heading' ? NoteHeadingController.text : '',
          'key': tablekey_Controller.text,
          'value': tablevalue_Controller.text,
        });
        notetablelength = clientreqNote.clientreq_recommendationList.length;
        _cleartable_Fields();
      },
    );
    // }
  }

  void _updatenote() {
    if (_noteformKey.currentState?.validate() ?? false) {
      setState(
        () {
          clientreqNote.clientreq_noteList[noteeditIndex!] = {
            // 'notetype': selectedheadingType ?? '',
            // 'noteheading': selectedheadingType == 'With Heading' ? NoteHeadingController.text : '',
            'notecontent': notecontentController.text,
          };
          _clearnoteFields();
          noteeditIndex = null;
          notelength = clientreqNote.clientreq_noteList.length;
        },
      );
    }
  }

  void _updatetable() {
    // if (_notetable_formKey.currentState?.validate() ?? false) {
    clientreqNote.clientreq_recommendationList[notetable_editIndex!] = {
      // 'notetype': selectedheadingType ?? '',
      // 'noteheading': selectedheadingType == 'With Heading' ? NoteHeadingController.text : '',
      'key': tablekey_Controller.text.toString(),
      'value': tablevalue_Controller.text.toString(),
    };
    _cleartable_Fields();
    notetable_editIndex = null;
    notetablelength = clientreqNote.clientreq_recommendationList.length;
    setState(
      () {},
    );
    // }
  }

  void _editnote(int index) {
    Map<String, dynamic> note = clientreqNote.clientreq_noteList[index];
    setState(
      () {
        // NoteHeadingController.text = note['noteheading'] ?? '';
        notecontentController.text = note['notecontent'] ?? '';

        // selectedheadingType = note['notetype'];
        noteeditIndex = index; // Set the index of the item being edited
      },
    );
  }

  void _editnotetable(int index) {
    Map<String, dynamic> note = clientreqNote.clientreq_recommendationList[index];
    setState(
      () {
        // NoteHeadingController.text = note['noteheading'] ?? '';
        tablekey_Controller.text = note['key'].toString();
        tablevalue_Controller.text = note['value'].toString();

        // selectedheadingType = note['notetype'];
        notetable_editIndex = index; // Set the index of the item being edited
      },
    );
  }

  void _resetEditingStateNote() {
    setState(
      () {
        _clearnoteFields();
        _cleartable_Fields();
        noteeditIndex = null;
        notetable_editIndex = null;
      },
    );
  }

  // List<Map<String, dynamic>> clientreq_noteList = [];
  void _clearnoteFields() {
    setState(
      () {
        // NoteHeadingController.clear();
        notecontentController.clear();
        // selectedheadingType = null;
      },
    );
  }

  void _cleartable_Fields() {
    setState(
      () {
        // NoteHeadingController.clear();
        tablekey_Controller.clear();
        tablevalue_Controller.clear();
        // selectedheadingType = null;
      },
    );
  }

  void _addNotes() {
    if (_noteformKey.currentState?.validate() ?? false) {
      // Check if note Name already exists
      bool exists = clientreqNote.clientreq_noteList.any((note) => note['notename'] == notecontentController.text);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This note Name already exists.'),
          ),
        );
        return; // Exit the method without adding the note
      }
      setState(
        () {
          clientreqNote.clientreq_noteList.add({
            // 'notetype': selectedheadingType ?? '',
            // 'noteheading': selectedheadingType == 'With Heading' ? NoteHeadingController.text : '',
            'notecontent': notecontentController.text,
          });
          notelength = clientreqNote.clientreq_noteList.length;
          _clearnoteFields();
        },
      );
    }
  }

  Widget clientreq_noteLists() {
    return ListView.builder(
        itemCount: clientreqNote.clientreq_noteList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _editnote(index);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              ),
              width: 550,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                        )),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${clientreqNote.clientreq_noteList[index]['notecontent']}', // Display camera type from map
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          clientreqNote.clientreq_noteList.removeAt(index);
                          notelength = clientreqNote.clientreq_noteList.length;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        });
  }

  Widget noteTable() {
    return ListView.builder(
        itemCount: clientreqNote.clientreq_recommendationList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _editnotetable(index);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              ),
              width: 550,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                        )),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${clientreqNote.clientreq_recommendationList[index]['key']}', // Display camera type from map
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          clientreqNote.clientreq_recommendationList.removeAt(index);
                          notetablelength = clientreqNote.clientreq_recommendationList.length;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        });
  }

  dynamic generate_client_requirement() async {
    // bool confirmed = await GenerateInvoice_dialougebox();

    // if (confirmed) {
    // Proceed only if the dialog was confirmed

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Primary_colors.Light,
          content: view_clientreq_send_popup(
            type: 'E://Client_requirement.pdf',
          ),
        );
      },
    );
    // }
  }

  @override
  Widget build(BuildContext context) {
    clientreqNote.clientreq_recommendationList.isEmpty ? TableHeadingController.clear() : null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _noteformKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Note',
                        style: TextStyle(color: Primary_colors.Color1),
                      ),
                      const SizedBox(height: 10),
                      DropdownMenu<String>(
                        trailingIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: Color.fromARGB(255, 122, 121, 121),
                        ),
                        label: const Text(
                          "Note",
                          style: TextStyle(color: Color.fromARGB(255, 167, 165, 165), fontSize: Primary_font_size.Text7),
                        ),
                        textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: 12),
                        width: 400,
                        inputDecorationTheme: const InputDecorationTheme(
                          contentPadding: EdgeInsets.only(left: 10, right: 5),
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)), borderSide: BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 167, 165, 165),
                          ),
                        ),
                        controller: notecontentController,
                        dropdownMenuEntries: notecontent.map<DropdownMenuEntry<String>>(
                          (String value) {
                            return DropdownMenuEntry<String>(value: value, label: value);
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 400,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Button1(
                              colors: noteeditIndex == null ? Colors.blue : Colors.orange,
                              text: noteeditIndex == null ? 'Add note' : 'Update',
                              onPressed: noteeditIndex == null ? _addNotes : _updatenote,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 75),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Table',
                      style: TextStyle(color: Primary_colors.Color1),
                    ),
                    const SizedBox(height: 10),
                    Textfield_1(
                      readonly: TableHeadingController.text.isEmpty ? false : true,
                      text: 'Table Heading',
                      controller: TableHeadingController,
                      icon: Icons.title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Table heading';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        SizedBox(
                          width: 190,
                          child: Column(
                            children: [
                              TextFormField(
                                style: const TextStyle(fontSize: 13, color: Colors.white),
                                controller: tablekey_Controller,
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
                                  hintText: "Product name",
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 167, 165, 165),
                                  ),

                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.production_quantity_limits,
                                    color: Colors.white,
                                  ),
                                ),
                                // validator: validator,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 190,
                          child: Column(
                            children: [
                              TextFormField(
                                style: const TextStyle(fontSize: 13, color: Colors.white),
                                controller: tablevalue_Controller,
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
                                  hintText: "Product Quantity",
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 167, 165, 165),
                                  ),
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.production_quantity_limits,
                                    color: Colors.white,
                                  ),
                                ),
                                // validator: validator,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 400,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Button1(
                            colors: notetable_editIndex == null ? Colors.blue : Colors.orange,
                            text: notetable_editIndex == null ? 'Add' : 'Update',
                            onPressed: notetable_editIndex == null ? _addtable_row : _updatetable,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            // const SizedBox(height: 10),
            if (clientreqNote.clientreq_noteList.isNotEmpty)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Note List',
                        style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 119, 199, 253), fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Dark),
                        // width: 420,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: clientreq_noteLists(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            const SizedBox(height: 10),
            if (clientreqNote.clientreq_recommendationList.isNotEmpty)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        clientreqDetails.clientreq_table_heading,
                        style: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 119, 199, 253), fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Dark),
                        // width: 420,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: noteTable(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            const SizedBox(height: 15),
            SizedBox(
              width: 400,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button1(
                    colors: Colors.red,
                    text: noteeditIndex == null ? 'Back' : 'Cancel',
                    onPressed: () {
                      noteeditIndex == null ? Generate_clientreq.backTab() : _resetEditingStateNote(); // Reset editing state when going back
                    },
                  ),
                  if (clientreqNote.clientreq_noteList.isNotEmpty) const SizedBox(width: 10),
                  if (clientreqNote.clientreq_noteList.isNotEmpty || clientreqNote.clientreq_recommendationList.isNotEmpty)
                    Button1(
                      colors: Colors.green,
                      text: 'Submit',
                      onPressed: () async {
                        if (clientreqProducts.clientreq_productDetails.isNotEmpty &&
                            clientreqProducts.clientreq_productDetails.isNotEmpty &&
                            clientreqDetails.clientnameController.text.isNotEmpty &&
                            clientreqDetails.clientaddressController.text.isNotEmpty &&
                            clientreqDetails.billingaddressnameController.text.isNotEmpty &&
                            clientreqDetails.billingaddressController.text.isNotEmpty) {
                          final pdfData = await generate_clientreq(
                              PdfPageFormat.a4,
                              clientreqProducts.clientreq_productDetails,
                              clientreqDetails.clientnameController.text,
                              clientreqDetails.clientaddressController.text,
                              clientreqDetails.billingaddressnameController.text,
                              clientreqDetails.billingaddressController.text,
                              clientreqDetails.clientreq_no,
                              clientreqDetailsState.pickedFile!.files.single.path);
                          const filePath = 'E://Client_requirement.pdf';
                          final file = File(filePath);
                          await file.writeAsBytes(pdfData);

                          // Sales_Client.clientreq_Callback();
                          generate_client_requirement();
                          // Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.blue,
                              content: Text('Please fill all the required fields'),
                            ),
                          );
                          return;
                        }
                      },
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
