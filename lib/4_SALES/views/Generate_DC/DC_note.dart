import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ssipl_billing/4_SALES/controllers/DC_actions.dart';
import 'package:ssipl_billing/4_SALES/services/DC_services/DC_Notes_service.dart';
import 'package:ssipl_billing/COMPONENTS-/button.dart';
import 'package:ssipl_billing/THEMES/style.dart';

class DcNote extends StatefulWidget with DcnotesService {
  DcNote({super.key});

  @override
  State<DcNote> createState() => _DcNoteState();
}

class _DcNoteState extends State<DcNote> {
  final DcController dcController = Get.find<DcController>();

  Widget Dc_noteLists() {
    return ListView.builder(
      itemCount: dcController.dcModel.Dc_noteList.length,
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
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
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
                                  dcController.dcModel.Dc_noteList[index], // Display camera type from map
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
        itemCount: dcController.dcModel.Dc_recommendationList.length,
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
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
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
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dcController.dcModel.Dc_recommendationList[index].key,
                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                                    ),
                                  ],
                                )),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        " -  ${dcController.dcModel.Dc_recommendationList[index].value}",
                                        style: const TextStyle(color: Primary_colors.Color1, fontSize: 10),
                                      ),
                                    ],
                                  )),
                            ),
                            // IconButton(
                            //   onPressed: () {
                            //     dcController.removeFromRecommendationList(index);
                            //   },
                            //   icon: const Icon(
                            //     Icons.close,
                            //     size: 15,
                            //   ),
                            // ),
                          ],
                        ),
                      )),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () {
                        return Form(
                          key: dcController.dcModel.noteformKey.value,
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
                                menuHeight: 350,
                                leadingIcon: const Icon(Icons.note_add, color: Primary_colors.Color1),
                                trailingIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color.fromARGB(255, 122, 121, 121),
                                ),
                                label: const Text(
                                  "Note",
                                  style: TextStyle(color: Color.fromARGB(255, 167, 165, 165), fontSize: Primary_font_size.Text7),
                                ),
                                textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
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
                                controller: dcController.dcModel.notecontentController.value,
                                dropdownMenuEntries: dcController.dcModel.noteSuggestion.map<DropdownMenuEntry<String>>(
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
                                  "Please ensure that all notes added here are accurate and relevant to the company's policy. Once submitted, these notes will be used for further processing and communication.",
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
                              // const SizedBox(height: 75),
                            ],
                          ),
                        );
                      },
                    ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const SizedBox(height: 50),
                    //     const Text(
                    //       'RECOMMENDATION',
                    //       style: TextStyle(color: Primary_colors.Color1),
                    //     ),
                    //     const SizedBox(height: 10),
                    //     Obx(
                    //       () {
                    //         return BasicTextfield(
                    //           digitsOnly: false,
                    //           width: 400,
                    //           readonly: dcController.dcModel.recommendationHeadingController.value.text.isEmpty ? false : true,
                    //           text: 'Recommendation Heading',
                    //           controller: dcController.dcModel.recommendationHeadingController.value,
                    //           icon: Icons.title,
                    //           validator: (value) {
                    //             if (value == null || value.isEmpty) {
                    //               return 'Please enter Recommendation heading';
                    //             }
                    //             return null;
                    //           },
                    //         );
                    //       },
                    //     ),
                    //     const SizedBox(height: 25),
                    //     Row(
                    //       children: [
                    //         SizedBox(
                    //           width: 190,
                    //           child: Column(
                    //             children: [
                    //               Obx(
                    //                 () {
                    //                   return BasicTextfield(
                    //                     digitsOnly: false,
                    //                     width: 190,
                    //                     readonly: false,
                    //                     text: 'Product name',
                    //                     controller: dcController.dcModel.recommendationKeyController.value,
                    //                     icon: Icons.production_quantity_limits,
                    //                     validator: (value) {
                    //                       if (value == null || value.isEmpty) {
                    //                         return 'Please enter a product name';
                    //                       }
                    //                       return null;
                    //                     },
                    //                   );
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         const SizedBox(width: 20),
                    //         SizedBox(
                    //           width: 190,
                    //           child: Column(
                    //             children: [
                    //               Obx(
                    //                 () {
                    //                   return BasicTextfield(
                    //                     digitsOnly: true,
                    //                     width: 190,
                    //                     readonly: false,
                    //                     text: 'Product value',
                    //                     controller: dcController.dcModel.recommendationValueController.value,
                    //                     icon: Icons.production_quantity_limits,
                    //                     validator: (value) {
                    //                       if (value == null || value.isEmpty) {
                    //                         return 'Please enter a product value';
                    //                       }
                    //                       return null;
                    //                     },
                    //                   );
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     const SizedBox(height: 25),
                    //     const SizedBox(
                    //       width: 410,
                    //       child: Text(
                    //         textAlign: TextAlign.center,
                    //         "Recommendations should be carefully selected based on the client's needs. Double-check all product names and quantities before adding them to avoid errors in future references.",
                    //         style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text6),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 30),
                    //     SizedBox(
                    //       width: 400,
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           Obx(
                    //             () {
                    //               return BasicButton(
                    //                   colors: dcController.dcModel.recommendation_editIndex.value == null ? Colors.blue : Colors.orange,
                    //                   text: dcController.dcModel.recommendation_editIndex.value == null ? 'Add Recommendation ' : 'Update Recommendation',
                    //                   onPressed: () {
                    //                     dcController.dcModel.recommendation_editIndex.value == null ? widget.addtable_row(context) : widget.updatetable();
                    //                   });
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                SizedBox(
                  height: 180,
                  child: Row(
                    children: [
                      Obx(() {
                        return dcController.dcModel.Dc_noteList.isNotEmpty
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
                                          child: Dc_noteLists(),
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
                        return dcController.dcModel.Dc_recommendationList.isNotEmpty
                            ? Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        dcController.dcModel.recommendationHeadingController.value.text,
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
                        text: dcController.dcModel.note_editIndex.value == null ? 'Back' : 'Cancel',
                        onPressed: () {
                          dcController.dcModel.note_editIndex.value == null ? dcController.backTab() : widget.resetEditingStateNote();
                        },
                      ),
                      Obx(() {
                        return Row(
                          children: [
                            if (dcController.dcModel.Dc_noteList.isNotEmpty) const SizedBox(width: 10),
                            if (dcController.dcModel.Dc_noteList.isNotEmpty)
                              dcController.dcModel.isLoading.value
                                  ? SizedBox(
                                      width: 125,
                                      child: Stack(
                                        children: [
                                          LinearPercentIndicator(
                                            lineHeight: 27,
                                            // width: 105,
                                            percent: dcController.dcModel.progress.value,
                                            barRadius: const Radius.circular(5),
                                            backgroundColor: const Color.fromARGB(255, 31, 38, 63),
                                            progressColor: Colors.blue,
                                            center: Text(
                                              "${(dcController.dcModel.progress.value * 100).toInt()}%",
                                              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (Rect bounds) {
                                                return const LinearGradient(
                                                  colors: [
                                                    Colors.blue,
                                                    Colors.transparent,
                                                    Primary_colors.Dark,
                                                  ],
                                                  stops: [
                                                    0.0,
                                                    0.5,
                                                    1.0,
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ).createShader(bounds);
                                              },
                                              child: LinearPercentIndicator(
                                                lineHeight: 30,
                                                // width: 105,
                                                percent: dcController.dcModel.progress.value,
                                                barRadius: const Radius.circular(5),
                                                backgroundColor: Primary_colors.Dark,
                                                progressColor: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: 125,
                                      // height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextButton(
                                        onPressed: () async {
                                          try {
                                            if (dcController.generate_Datavalidation()) {
                                              Get.snackbar("Error", "Any of the required fields is Empty!");
                                              return;
                                            }
                                            await Future.wait([
                                              dcController.startProgress(),
                                              widget.savePdfToCache(),
                                            ]);
                                            dcController.nextTab();
                                          } catch (e, stackTrace) {
                                            debugPrint("Error in Future.wait: $e");
                                            debugPrint(stackTrace.toString());
                                            Get.snackbar("Error", "Something went wrong. Please try again.");
                                          }
                                        },
                                        child: const Text("Generate", style: TextStyle(fontSize: 12, color: Colors.white)),
                                      )),
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
