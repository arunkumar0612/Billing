import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/services/SALES/DC_services/DCnotes_service.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/SALEScontrollers/DC_actions.dart';

class Delivery_challanNote extends StatefulWidget with DcnotesService {
  Delivery_challanNote({super.key});

  @override
  State<Delivery_challanNote> createState() => _Delivery_challanNoteState();
}

class _Delivery_challanNoteState extends State<Delivery_challanNote> {
  final DCController dcController = Get.find<DCController>();

  Widget Delivery_challan_noteLists() {
    return ListView.builder(
        itemCount: dcController.dcModel.Delivery_challan_noteList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              widget.editnote(index);
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
                                dcController.dcModel.Delivery_challan_noteList[index].notename, // Display camera type from map
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        dcController.removeFromNoteList(index);
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
        itemCount: dcController.dcModel.Delivery_challan_recommendationList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              widget.editnotetable(index);
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
                                dcController.dcModel.Delivery_challan_recommendationList[index].key,
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        dcController.removeFromRecommendationList(index);
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
                Obx(
                  () {
                    return Form(
                      key: dcController.dcModel.noteformKey.value,
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
                            controller: dcController.dcModel.notecontentController.value,
                            dropdownMenuEntries: dcController.dcModel.notecontent.map<DropdownMenuEntry<String>>(
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
                                Obx(
                                  () {
                                    return BasicButton(
                                      colors: dcController.dcModel.note_editIndex.value == null ? Colors.blue : Colors.orange,
                                      text: dcController.dcModel.note_editIndex.value == null ? 'Add note' : 'Update',
                                      onPressed: () {
                                        dcController.dcModel.note_editIndex.value == null ? widget.addNotes(context) : widget.updatenote();
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 75),
                        ],
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Table',
                      style: TextStyle(color: Primary_colors.Color1),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () {
                        return BasicTextfield(
                          digitsOnly: false,
                          width: 400,
                          readonly: false,
                          text: 'Table Heading',
                          controller: dcController.dcModel.recommendationHeadingController.value,
                          icon: Icons.title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Table heading';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        SizedBox(
                          width: 190,
                          child: Column(
                            children: [
                              Obx(
                                () {
                                  return TextFormField(
                                    style: const TextStyle(fontSize: 13, color: Colors.white),
                                    controller: dcController.dcModel.recommendationKeyController.value,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Primary_colors.Dark,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
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
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 190,
                          child: Column(
                            children: [
                              Obx(
                                () {
                                  return TextFormField(
                                    style: const TextStyle(fontSize: 13, color: Colors.white),
                                    controller: dcController.dcModel.recommendationValueController.value,
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
                                  );
                                },
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
                          Obx(
                            () {
                              return BasicButton(
                                  colors: dcController.dcModel.recommendation_editIndex.value == null ? Colors.blue : Colors.orange,
                                  text: dcController.dcModel.recommendation_editIndex.value == null ? 'Add' : 'Update',
                                  onPressed: () {
                                    dcController.dcModel.recommendation_editIndex.value == null ? widget.addtable_row(context) : widget.updatetable();
                                  });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Obx(() {
              return dcController.dcModel.Delivery_challan_noteList.isNotEmpty
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Note List',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 119, 199, 253),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Primary_colors.Dark,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Delivery_challan_noteLists(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink();
            }),
            const SizedBox(height: 10),
            Obx(() {
              return dcController.dcModel.Delivery_challan_recommendationList.isNotEmpty
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              dcController.dcModel.Delivery_challan_table_heading.value,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 119, 199, 253),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Primary_colors.Dark,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: noteTable(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink();
            }),
            const SizedBox(height: 15),
            SizedBox(
              width: 400,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BasicButton(
                    colors: Colors.red,
                    text: dcController.dcModel.note_editIndex.value == null ? 'Back' : 'Cancel',
                    onPressed: () {
                      dcController.dcModel.note_editIndex.value == null ? dcController.backTab() : widget.resetEditingStateNote();
                    },
                  ),
                  Obx(() {
                    return Row(
                      children: [
                        if (dcController.dcModel.Delivery_challan_noteList.isNotEmpty) const SizedBox(width: 10),
                        if (dcController.dcModel.Delivery_challan_noteList.isNotEmpty || dcController.dcModel.Delivery_challan_recommendationList.isNotEmpty)
                          BasicButton(
                            colors: Colors.green,
                            text: 'Submit',
                            onPressed: () async {
                              if (dcController.dcModel.Delivery_challan_products.isNotEmpty && dcController.dcModel.clientAddressNameController.value.text.isNotEmpty && dcController.dcModel.clientAddressController.value.text.isNotEmpty && dcController.dcModel.billingAddressNameController.value.text.isNotEmpty && dcController.dcModel.billingAddressController.value.text.isNotEmpty && dcController.dcModel.TitleController.value.text.isNotEmpty) {
                                widget.generate_DC(context);
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
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
