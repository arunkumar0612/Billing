import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:ssipl_billing/SALES/Generate_creditnote/generate_creditnote.dart';
import 'package:ssipl_billing/SALES/Generate_creditnote/creditnote_template.dart';
import 'package:ssipl_billing/Sales.dart';
import 'package:ssipl_billing/button.dart';
// import 'package:ssipl_billing/client.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';
import 'dart:io';

class creditnoteNote extends StatefulWidget {
  const creditnoteNote({super.key});

  @override
  State<creditnoteNote> createState() => _creditnoteNoteState();
}

class _creditnoteNoteState extends State<creditnoteNote> {
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
    creditnote_table_heading = TableHeadingController.text;
    // if (_notetable_formKey.currentState?.validate() ?? false) {
    // Check if note Name already exists
    bool exists = creditnote_recommendationList.any((note) => note['key'] == tablekey_Controller.text);
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
        creditnote_recommendationList.add({
          // 'notetype': selectedheadingType ?? '',
          // 'noteheading': selectedheadingType == 'With Heading' ? NoteHeadingController.text : '',
          'key': tablekey_Controller.text,
          'value': tablevalue_Controller.text,
        });
        notetablelength = creditnote_recommendationList.length;
        _cleartable_Fields();
      },
    );
    // }
  }

  void _updatenote() {
    if (_noteformKey.currentState?.validate() ?? false) {
      setState(
        () {
          creditnote_noteList[noteeditIndex!] = {
            // 'notetype': selectedheadingType ?? '',
            // 'noteheading': selectedheadingType == 'With Heading' ? NoteHeadingController.text : '',
            'notecontent': notecontentController.text,
          };
          _clearnoteFields();
          noteeditIndex = null;
          notelength = creditnote_noteList.length;
        },
      );
    }
  }

  void _updatetable() {
    // if (_notetable_formKey.currentState?.validate() ?? false) {
    creditnote_recommendationList[notetable_editIndex!] = {
      // 'notetype': selectedheadingType ?? '',
      // 'noteheading': selectedheadingType == 'With Heading' ? NoteHeadingController.text : '',
      'key': tablekey_Controller.text.toString(),
      'value': tablevalue_Controller.text.toString(),
    };
    _cleartable_Fields();
    notetable_editIndex = null;
    notetablelength = creditnote_recommendationList.length;
    setState(
      () {},
    );
    // }
  }

  void _editnote(int index) {
    Map<String, dynamic> note = creditnote_noteList[index];
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
    Map<String, dynamic> note = creditnote_recommendationList[index];
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

  // List<Map<String, dynamic>> creditnote_noteList = [];
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
      bool exists = creditnote_noteList.any((note) => note['notename'] == notecontentController.text);
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
          creditnote_noteList.add({
            // 'notetype': selectedheadingType ?? '',
            // 'noteheading': selectedheadingType == 'With Heading' ? NoteHeadingController.text : '',
            'notecontent': notecontentController.text,
          });
          notelength = creditnote_noteList.length;
          _clearnoteFields();
        },
      );
    }
  }

  Widget creditnote_noteLists() {
    return ListView.builder(
        itemCount: creditnote_noteList.length,
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
                                '${creditnote_noteList[index]['notecontent']}', // Display camera type from map
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          creditnote_noteList.removeAt(index);
                          notelength = creditnote_noteList.length;
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
        itemCount: creditnote_recommendationList.length,
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
                                '${creditnote_recommendationList[index]['key']}', // Display camera type from map
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          creditnote_recommendationList.removeAt(index);
                          notetablelength = creditnote_recommendationList.length;
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

  @override
  Widget build(BuildContext context) {
    creditnote_recommendationList.isEmpty ? TableHeadingController.clear() : null;

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
                        textStyle: const TextStyle(color: Primary_colors.Color1),
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
            if (creditnote_noteList.isNotEmpty)
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
                          child: creditnote_noteLists(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            const SizedBox(height: 10),
            if (creditnote_recommendationList.isNotEmpty && creditnote_table_heading != '')
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        creditnote_table_heading,
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
                      noteeditIndex == null ? Generate_creditnote.backTab() : _resetEditingStateNote(); // Reset editing state when going back
                    },
                  ),
                  if (creditnote_noteList.isNotEmpty) const SizedBox(width: 10),
                  if (creditnote_noteList.isNotEmpty || creditnote_recommendationList.isNotEmpty)
                    Button1(
                      colors: Colors.green,
                      text: 'Submit',
                      onPressed: () async {
                        if (creditnote_products.isNotEmpty && creditnote_gstTotals.isNotEmpty && creditnote_productDetails.isNotEmpty && creditnote_client_addr_name.isNotEmpty && creditnote_client_addr.isNotEmpty && creditnote_bill_addr_name.isNotEmpty && creditnote_bill_addr.isNotEmpty) {
                          final pdfData = await generate_creditnote(PdfPageFormat.a4, creditnote_products, creditnote_client_addr_name, creditnote_client_addr, creditnote_bill_addr_name, creditnote_bill_addr, creditnote_no, 9);
                          const filePath = 'E://Credit_note.pdf';
                          final file = File(filePath);
                          await file.writeAsBytes(pdfData);

                          Sales_Client.creditnote_Callback();
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
