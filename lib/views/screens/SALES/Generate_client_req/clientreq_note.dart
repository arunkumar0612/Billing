import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';
import '../../../../controllers/SALEScontrollers/ClientReq_actions.dart';
import '../../../../services/SALES/ClientReq_services/ClientreqNote_service.dart';

class ClientreqNote extends StatefulWidget with ClientreqNoteService {
  final String? customer_type;
  ClientreqNote({super.key, required this.customer_type});

  @override
  State<ClientreqNote> createState() => _ClientreqNoteState();
}

class _ClientreqNoteState extends State<ClientreqNote> {
  final ClientreqController clientreqController = Get.find<ClientreqController>();

  Widget Clientreq_noteLists() {
    return ListView.builder(
        itemCount: clientreqController.clientReqModel.clientReqNoteList.length,
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
                                clientreqController.clientReqModel.clientReqNoteList[index].notename, // Display camera type from map
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        clientreqController.removeFromNoteList(index);
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

  RecommendationTable() {
    return ListView.builder(
        itemCount: clientreqController.clientReqModel.clientReqRecommendationList.length,
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
                                clientreqController.clientReqModel.clientReqRecommendationList[index].key,
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        clientreqController.removeFromRecommendationList(index);
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
    return Obx(
      () {
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
                          key: clientreqController.clientReqModel.noteFormKey.value,
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
                                controller: clientreqController.clientReqModel.noteContentController.value,
                                dropdownMenuEntries: clientreqController.clientReqModel.noteContent.map<DropdownMenuEntry<String>>(
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
                                          colors: clientreqController.clientReqModel.noteEditIndex.value == null ? Colors.blue : Colors.orange,
                                          text: clientreqController.clientReqModel.noteEditIndex.value == null ? 'Add note' : 'Update',
                                          onPressed: () {
                                            clientreqController.clientReqModel.noteEditIndex.value == null ? widget.addNotes(context) : widget.updatenote();
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
                          'Recommendation',
                          style: TextStyle(color: Primary_colors.Color1),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () {
                            return BasicTextfield(
                              readonly: clientreqController.clientReqModel.Rec_HeadingController.value.text.isEmpty ? false : true,
                              text: 'Recommendation Heading',
                              controller: clientreqController.clientReqModel.Rec_HeadingController.value,
                              icon: Icons.title,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Recommendation heading';
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
                                        controller: clientreqController.clientReqModel.Rec_KeyController.value,
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
                                        controller: clientreqController.clientReqModel.Rec_ValueController.value,
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
                                      colors: clientreqController.clientReqModel.Rec_EditIndex.value == null ? Colors.blue : Colors.orange,
                                      text: clientreqController.clientReqModel.Rec_EditIndex.value == null ? 'Add' : 'Update',
                                      onPressed: () {
                                        clientreqController.clientReqModel.Rec_EditIndex.value == null ? widget.addtable_row(context) : widget.updatetable();
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
                  return clientreqController.clientReqModel.clientReqNoteList.isNotEmpty
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
                                    child: Clientreq_noteLists(),
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
                  return clientreqController.clientReqModel.clientReqRecommendationList.isNotEmpty
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  clientreqController.clientReqModel.Rec_HeadingController.value.text,
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
                                    child: RecommendationTable(),
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
                        text: clientreqController.clientReqModel.noteEditIndex.value == null ? 'Back' : 'Cancel',
                        onPressed: () {
                          clientreqController.clientReqModel.noteEditIndex.value == null ? clientreqController.backTab() : widget.resetEditingStateNote();
                        },
                      ),
                      Obx(() {
                        return Row(
                          children: [
                            if (clientreqController.clientReqModel.clientReqNoteList.isNotEmpty) const SizedBox(width: 10),
                            if (clientreqController.clientReqModel.clientReqNoteList.isNotEmpty || clientreqController.clientReqModel.clientReqRecommendationList.isNotEmpty)
                              Button1(
                                colors: Colors.green,
                                text: 'Submit',
                                onPressed: () async {
                                  if (clientreqController.clientReqModel.clientReqProductDetails.isNotEmpty && clientreqController.clientReqModel.clientNameController.value.text.isNotEmpty && clientreqController.clientReqModel.clientAddressController.value.text.isNotEmpty && clientreqController.clientReqModel.billingAddressNameController.value.text.isNotEmpty && clientreqController.clientReqModel.billingAddressController.value.text.isNotEmpty && clientreqController.clientReqModel.titleController.value.text.isNotEmpty) {
                                    // widget.Generate_clientReq(context);
                                    widget.postData(context, widget.customer_type);
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
      },
    );
  }
}
