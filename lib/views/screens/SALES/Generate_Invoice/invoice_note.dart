import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/Invoice_actions.dart';
import '../../../../services/SALES/Invoice_services/InvoiceNotes_service.dart';

class InvoiceNote extends StatefulWidget with InvoicenotesService {
  InvoiceNote({super.key});

  @override
  State<InvoiceNote> createState() => _InvoiceNoteState();
}

class _InvoiceNoteState extends State<InvoiceNote> {
  final InvoiceController invoiceController = Get.find<InvoiceController>();

  Widget Invoice_noteLists() {
    return ListView.builder(
        itemCount: invoiceController.invoiceModel.Invoice_noteList.length,
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
                                invoiceController.invoiceModel.Invoice_noteList[index].notename, // Display camera type from map
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        invoiceController.removeFromNoteList(index);
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
        itemCount: invoiceController.invoiceModel.Invoice_recommendationList.length,
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
                                invoiceController.invoiceModel.Invoice_recommendationList[index].key,
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        invoiceController.removeFromRecommendationList(index);
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
                      key: invoiceController.invoiceModel.noteformKey.value,
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
                            controller: invoiceController.invoiceModel.notecontentController.value,
                            dropdownMenuEntries: invoiceController.invoiceModel.notecontent.map<DropdownMenuEntry<String>>(
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
                                      colors: invoiceController.invoiceModel.note_editIndex.value == null ? Colors.blue : Colors.orange,
                                      text: invoiceController.invoiceModel.note_editIndex.value == null ? 'Add note' : 'Update',
                                      onPressed: () {
                                        invoiceController.invoiceModel.note_editIndex.value == null ? widget.addNotes(context) : widget.updatenote();
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
                          controller: invoiceController.invoiceModel.recommendationHeadingController.value,
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
                                    controller: invoiceController.invoiceModel.recommendationKeyController.value,
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
                                    controller: invoiceController.invoiceModel.recommendationValueController.value,
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
                                  colors: invoiceController.invoiceModel.recommendation_editIndex.value == null ? Colors.blue : Colors.orange,
                                  text: invoiceController.invoiceModel.recommendation_editIndex.value == null ? 'Add' : 'Update',
                                  onPressed: () {
                                    invoiceController.invoiceModel.recommendation_editIndex.value == null ? widget.addtable_row(context) : widget.updatetable();
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
              return invoiceController.invoiceModel.Invoice_noteList.isNotEmpty
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
                                child: Invoice_noteLists(),
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
              return invoiceController.invoiceModel.Invoice_recommendationList.isNotEmpty
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              invoiceController.invoiceModel.Invoice_table_heading.value,
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
                    text: invoiceController.invoiceModel.note_editIndex.value == null ? 'Back' : 'Cancel',
                    onPressed: () {
                      invoiceController.invoiceModel.note_editIndex.value == null ? invoiceController.backTab() : widget.resetEditingStateNote();
                    },
                  ),
                  Obx(() {
                    return Row(
                      children: [
                        if (invoiceController.invoiceModel.Invoice_noteList.isNotEmpty) const SizedBox(width: 10),
                        if (invoiceController.invoiceModel.Invoice_noteList.isNotEmpty || invoiceController.invoiceModel.Invoice_recommendationList.isNotEmpty)
                          Button1(
                            colors: Colors.green,
                            text: 'Submit',
                            onPressed: () async {
                              if (invoiceController.invoiceModel.Invoice_products.isNotEmpty && invoiceController.invoiceModel.clientAddressNameController.value.text.isNotEmpty && invoiceController.invoiceModel.clientAddressController.value.text.isNotEmpty && invoiceController.invoiceModel.billingAddressNameController.value.text.isNotEmpty && invoiceController.invoiceModel.billingAddressController.value.text.isNotEmpty && invoiceController.invoiceModel.TitleController.value.text.isNotEmpty) {
                                widget.Generate_Invoice(context);
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
