import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/SALEScontrollers/Credit_actions.dart';
import '../../../../services/SALES/Credit_services/CreditNotes_service.dart';

class CreditNote extends StatefulWidget with CreditnotesService {
  CreditNote({super.key});

  @override
  State<CreditNote> createState() => _CreditNoteState();
}

class _CreditNoteState extends State<CreditNote> {
  final CreditController creditController = Get.find<CreditController>();

  Widget Credit_noteLists() {
    return ListView.builder(
        itemCount: creditController.creditModel.Credit_noteList.length,
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
                                creditController.creditModel.Credit_noteList[index].notename, // Display camera type from map
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        creditController.removeFromNoteList(index);
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
        itemCount: creditController.creditModel.Credit_recommendationList.length,
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
                                creditController.creditModel.Credit_recommendationList[index].key,
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        creditController.removeFromRecommendationList(index);
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
                      key: creditController.creditModel.noteformKey.value,
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
                            controller: creditController.creditModel.notecontentController.value,
                            dropdownMenuEntries: creditController.creditModel.notecontent.map<DropdownMenuEntry<String>>(
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
                                    return Button1(
                                      colors: creditController.creditModel.note_editIndex.value == null ? Colors.blue : Colors.orange,
                                      text: creditController.creditModel.note_editIndex.value == null ? 'Add note' : 'Update',
                                      onPressed: () {
                                        creditController.creditModel.note_editIndex.value == null ? widget.addNotes(context) : widget.updatenote();
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
                        return Textfield_1(
                          readonly: false,
                          text: 'Table Heading',
                          controller: creditController.creditModel.recommendationHeadingController.value,
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
                                    controller: creditController.creditModel.recommendationKeyController.value,
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
                                    controller: creditController.creditModel.recommendationValueController.value,
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
                              return Button1(
                                  colors: creditController.creditModel.recommendation_editIndex.value == null ? Colors.blue : Colors.orange,
                                  text: creditController.creditModel.recommendation_editIndex.value == null ? 'Add' : 'Update',
                                  onPressed: () {
                                    creditController.creditModel.recommendation_editIndex.value == null ? widget.addtable_row(context) : widget.updatetable();
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
              return creditController.creditModel.Credit_noteList.isNotEmpty
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
                                child: Credit_noteLists(),
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
              return creditController.creditModel.Credit_recommendationList.isNotEmpty
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              creditController.creditModel.Credit_table_heading.value,
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
                  Button1(
                    colors: Colors.red,
                    text: creditController.creditModel.note_editIndex.value == null ? 'Back' : 'Cancel',
                    onPressed: () {
                      creditController.creditModel.note_editIndex.value == null ? creditController.backTab() : widget.resetEditingStateNote();
                    },
                  ),
                  Obx(() {
                    return Row(
                      children: [
                        if (creditController.creditModel.Credit_noteList.isNotEmpty) const SizedBox(width: 10),
                        if (creditController.creditModel.Credit_noteList.isNotEmpty || creditController.creditModel.Credit_recommendationList.isNotEmpty)
                          Button1(
                            colors: Colors.green,
                            text: 'Submit',
                            onPressed: () async {
                              if (creditController.creditModel.Credit_products.isNotEmpty && creditController.creditModel.clientAddressNameController.value.text.isNotEmpty && creditController.creditModel.clientAddressController.value.text.isNotEmpty && creditController.creditModel.billingAddressNameController.value.text.isNotEmpty && creditController.creditModel.billingAddressController.value.text.isNotEmpty) {
                                widget.Generate_Credit(context);
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
