import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/SUBSCRIPTIONcontrollers/SUBSCRIPTION_ClientReq_actions.dart';
import 'package:ssipl_billing/services/SUBSCRIPTION/ClientReq_services/SUBSCRIPTION_ClientreqNote_service.dart';
// import 'package:ssipl_billing/views/components/Loading.dart';
import 'package:ssipl_billing/views/components/button.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/textfield.dart';

class SUBSCRIPTION_ClientreqNote extends StatefulWidget with SUBSCRIPTION_ClientreqNoteService {
  final String? customer_type;
  SUBSCRIPTION_ClientreqNote({super.key, required this.customer_type});

  @override
  State<SUBSCRIPTION_ClientreqNote> createState() => _SUBSCRIPTION_ClientreqNoteState();
}

class _SUBSCRIPTION_ClientreqNoteState extends State<SUBSCRIPTION_ClientreqNote> {
  final SUBSCRIPTION_ClientreqController clientreqController = Get.find<SUBSCRIPTION_ClientreqController>();

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
                              clientreqController.clientReqModel.clientReqNoteList[index], // Display camera type from map
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
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
              ),
            ),
          ),
        );
      },
    );
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () {
                        return Form(
                          key: clientreqController.clientReqModel.noteFormKey.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50),
                              const Text(
                                'NOTE',
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
                                  enabledBorder:
                                      OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)), borderSide: BorderSide(color: Colors.black)),
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
                              const SizedBox(height: 25),
                              const SizedBox(
                                width: 380,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Please ensure that all notes added here are accurate and relevant to the client's requirements. Once submitted, these notes will be used for further processing and communication.",
                                  style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text6),
                                ),
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
                              // const SizedBox(height: 75),
                            ],
                          ),
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        const Text(
                          'RECOMMENDATION',
                          style: TextStyle(color: Primary_colors.Color1),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () {
                            return BasicTextfield(
                              digitsOnly: false,
                              width: 400,
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
                                      return BasicTextfield(
                                        digitsOnly: false,
                                        width: 190,
                                        readonly: false,
                                        text: 'Site name',
                                        controller: clientreqController.clientReqModel.Rec_KeyController.value,
                                        icon: Icons.home,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a site name';
                                          }
                                          return null;
                                        },
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
                                      return BasicTextfield(
                                        digitsOnly: true,
                                        width: 190,
                                        readonly: false,
                                        text: 'Camera value',
                                        controller: clientreqController.clientReqModel.Rec_ValueController.value,
                                        icon: Icons.production_quantity_limits,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a site value';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const SizedBox(
                          width: 410,
                          child: Text(
                            textAlign: TextAlign.center,
                            "Recommendations should be carefully selected based on the client's needs. Double-check all site names and quantities before adding them to avoid errors in future references.",
                            style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text6),
                          ),
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
                                      colors: clientreqController.clientReqModel.Rec_EditIndex.value == null ? Colors.blue : Colors.orange,
                                      text: clientreqController.clientReqModel.Rec_EditIndex.value == null ? 'Add Recommendation ' : 'Update Recommendation',
                                      onPressed: () {
                                        clientreqController.clientReqModel.Rec_EditIndex.value == null ? widget.addtable_row(context) : widget.updatetable();
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 180,
                  child: Row(
                    children: [
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
                      const SizedBox(width: 10),
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
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BasicButton(
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
                              BasicButton(
                                colors: Colors.green,
                                text: 'Submit',
                                onPressed: () async {
                                  // showLoading(context, () => widget.postData(context, widget.customer_type));
                                  widget.postData(context, widget.customer_type);
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
