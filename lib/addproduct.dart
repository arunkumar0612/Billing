import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/button.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';

class AddnotePage extends StatefulWidget {
  const AddnotePage({super.key});

  @override
  AddnotePageState createState() {
    return AddnotePageState();
  }
}

class AddnotePageState extends State<AddnotePage> {
  final _noteformKey = GlobalKey<FormState>();
  int notelength = 0;
  int? noteeditIndex;
  final TextEditingController HeadingController = TextEditingController();
  final TextEditingController notecontentController = TextEditingController();
  String? selectedheadingType;
  List<String> noteType = [
    'With Heading',
    'Without Heading',
  ];
  List<Map<String, dynamic>> noteList = [];

  @override
  void initState() {
    super.initState();
  }

  void _addNotes() {
    if (_noteformKey.currentState?.validate() ?? false) {
      // Check if note Name already exists
      bool exists = noteList.any((note) => note['notename'] == notecontentController.text);
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
          noteList.add({
            'notetype': selectedheadingType ?? '',
            'noteheading': selectedheadingType == 'With Heading' ? HeadingController.text : '',
            'notecontent': notecontentController.text,
          });
          notelength = noteList.length;
          _clearFields();
        },
      );
    }
  }

  void _updatenote() {
    if (_noteformKey.currentState?.validate() ?? false) {
      setState(
        () {
          noteList[noteeditIndex!] = {
            'notetype': selectedheadingType ?? '',
            'noteheading': selectedheadingType == 'With Heading' ? HeadingController.text : '',
            'notecontent': notecontentController.text,
          };
          _clearFields();
          noteeditIndex = null;
          notelength = noteList.length;
        },
      );
    }
  }

  void _clearFields() {
    setState(
      () {
        HeadingController.clear();
        notecontentController.clear();
        selectedheadingType = null;
      },
    );
  }

  void _editnote(int index) {
    Map<String, dynamic> note = noteList[index];
    setState(
      () {
        HeadingController.text = note['noteheading'] ?? '';
        notecontentController.text = note['notecontent'] ?? '';

        selectedheadingType = note['notetype'];
        noteeditIndex = index; // Set the index of the item being edited
      },
    );
  }

  void _resetEditingStateNote() {
    setState(
      () {
        _clearFields();
        noteeditIndex = null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary_colors.Light,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _noteformKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'Add note',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 400,
                      child: DropdownButtonFormField<String>(
                        menuMaxHeight: 300,
                        value: selectedheadingType,
                        style: const TextStyle(color: Primary_colors.Color1, fontSize: 13),
                        dropdownColor: Primary_colors.Dark,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 167, 165, 165),
                          ),
                          labelText: 'Select Note Type',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.type_specimen,
                            color: Colors.white,
                          ),
                        ),
                        items: noteType.map(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedheadingType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Select note Type';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    if (selectedheadingType == 'With Heading')
                      Textfield_1(
                        readonly: false,
                        text: 'Note Heading',
                        controller: HeadingController,
                        icon: Icons.title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Note Heading';
                          }
                          return null;
                        },
                      ),
                    if (selectedheadingType == 'With Heading') const SizedBox(height: 25),
                    Textfield_1(
                      readonly: false,
                      text: 'Note Content',
                      controller: notecontentController,
                      icon: Icons.note_alt_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Note Content';
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
                            _resetEditingStateNote(); // Reset editing state when going back
                          },
                        ),
                        const SizedBox(width: 30),
                        Button1(
                          colors: noteeditIndex == null ? Colors.blue : Colors.orange,
                          text: noteeditIndex == null ? 'Add note' : 'Update',
                          onPressed: noteeditIndex == null ? _addNotes : _updatenote,
                        ),
                      ],
                    ),
                  ],
                ),
                if (notelength != 0)
                  Column(
                    children: [
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
                                'note List',
                                style: TextStyle(fontSize: 17, color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: selectedheadingType == 'With Heading' ? 195 : 120,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: noteLists(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      if (noteList.isNotEmpty)
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
    );
  }

  Widget noteLists() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < noteList.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _editnote(i);
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
                            '${i + 1}. ${noteList[i]['notecontent']}', // Display camera type from map
                            style: const TextStyle(color: Primary_colors.Color1, fontSize: 13),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  noteList.removeAt(i);
                                  notelength = noteList.length;
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
