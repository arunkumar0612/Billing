import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/PDFpopup_actions.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/button.dart';

mixin Pdfpopup {
  final PDFpopupController pdfpopup_controller = Get.find<PDFpopupController>();
  void showA4StyledPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: AspectRatio(
          aspectRatio: 1 / 1.41, // A4 Aspect Ratio (210mm x 297mm)
          child: Container(
            height: 950,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Obx(
              () {
                return SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          header(),
                          addresses(),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BasicButton(
                                  text: "Add product",
                                  colors: const Color.fromARGB(202, 33, 149, 243),
                                  onPressed: () {
                                    pdfpopup_controller.addRow();
                                  }),
                              if (pdfpopup_controller.pdfModel.value.checkboxValues.contains(true)) const SizedBox(width: 5),
                              if (pdfpopup_controller.pdfModel.value.checkboxValues.contains(true))
                                BasicButton(
                                    text: "Delete",
                                    colors: const Color.fromARGB(204, 244, 67, 54),
                                    onPressed: () {
                                      pdfpopup_controller.deleteRow();
                                    }),
                            ],
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: pdfpopup_controller.pdfModel.value.textControllers.length > 3 ? 200 : pdfpopup_controller.pdfModel.value.textControllers.length * 40 + 40,
                            child: contentTable(pdfpopup_controller),
                          ),
                          const SizedBox(height: 20),
                          collage(),
                          const SizedBox(height: 20),
                        ],
                      ),
                      footer(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/sporada.jpeg', height: 150),
        const Text("INVOICE", style: TextStyle(fontSize: Primary_font_size.SubHeading, fontWeight: FontWeight.bold)),
        SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Date", style: TextStyle(fontSize: Primary_font_size.Text7)),
                  SizedBox(height: 15),
                  Text(
                    "Invoice no",
                    style: TextStyle(fontSize: Primary_font_size.Text7),
                  ),
                ],
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("  :  ", style: TextStyle(fontSize: Primary_font_size.Text7)),
                  SizedBox(height: 15),
                  Text("  :  ", style: TextStyle(fontSize: Primary_font_size.Text7)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    width: 80,
                    child: TextFormField(
                      style: const TextStyle(fontSize: Primary_font_size.Text5, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.date.value,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        labelStyle: TextStyle(
                          fontSize: Primary_font_size.Text7,
                          color: Color.fromARGB(255, 167, 165, 165),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 20,
                    width: 80,
                    child: TextFormField(
                      style: const TextStyle(fontSize: Primary_font_size.Text5, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.invoiceNo.value,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        labelStyle: TextStyle(
                          fontSize: Primary_font_size.Text7,
                          color: Color.fromARGB(255, 167, 165, 165),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                    ),
                  ),
                  // Text("AA/SSIPL/250201", style: TextStyle(fontSize: Primary_font_size.Text7)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget addresses() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                // width: 270,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "CLIENT ADDRESS",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 90,

                // width: 270,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.clientName.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "ABS Enterprises",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text4, fontStyle: FontStyle.italic, color: Color.fromARGB(255, 58, 58, 58)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.clientAddressName.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "123, Business Park Avenue, Sector 45, Downtown City, State - 560102, Country - USA",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text4, fontStyle: FontStyle.italic, color: Color.fromARGB(255, 58, 58, 58)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                // width: 270,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "BILLING ADDRESS",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 90,

                // width: 270,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.billingName.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "ABS Enterprises",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text4, fontStyle: FontStyle.italic, color: Color.fromARGB(255, 58, 58, 58)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.billingAddressName.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "123, Business Park Avenue, Sector 45, Downtown City, State - 560102, Country - USA",
                            hintStyle: TextStyle(fontSize: Primary_font_size.Text4, fontStyle: FontStyle.italic, color: Color.fromARGB(255, 58, 58, 58)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget contentTable(PDFpopupController controller) {
    const tableHeaders = ['✔', 'S.No', 'Description', 'HSN', 'GST', 'Price', 'Quantity', 'Total'];

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table Header
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: tableHeaders.map((header) {
                return Expanded(
                  child: Text(
                    header,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, overflow: TextOverflow.ellipsis),
                    textAlign: header == tableHeaders.last ? TextAlign.end : TextAlign.center,
                  ),
                );
              }).toList(),
            ),
          ),
          // Table Rows
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: List.generate(controller.pdfModel.value.textControllers.length, (rowIndex) {
                return Container(
                    height: 40,
                    color: rowIndex % 2 == 0 ? Colors.green.shade50 : Colors.white,
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      children: [
                        // Checkbox Column
                        Expanded(
                          child: SizedBox(
                            width: 50,
                            child: Obx(
                              () => Checkbox(
                                activeColor: rowIndex % 2 == 0 ? Colors.green.shade50 : Colors.white,
                                checkColor: Primary_colors.Color3,
                                value: controller.pdfModel.value.checkboxValues[rowIndex],
                                onChanged: (value) {
                                  controller.pdfModel.value.checkboxValues[rowIndex] = value!;
                                },
                              ),
                            ),
                          ),
                        ),
                        // Data Columns with Expanded
                        ...List.generate(tableHeaders.length - 1, (colIndex) {
                          bool isNumericField = [0, 2, 3, 4, 5].contains(colIndex);
                          bool isTotalField = colIndex == 6;

                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: TextFormField(
                                controller: controller.pdfModel.value.textControllers[rowIndex][colIndex],
                                textAlign: isTotalField ? TextAlign.end : TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                                onChanged: (value) {
                                  if (!isTotalField) {
                                    controller.updateCell(rowIndex, colIndex, value);
                                  }
                                },
                                readOnly: isTotalField,
                                inputFormatters: isNumericField ? [FilteringTextInputFormatter.digitsOnly] : null,
                                keyboardType: isNumericField ? TextInputType.number : TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter ${tableHeaders[colIndex + 1]}",
                                  hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.grey),
                                  contentPadding: const EdgeInsets.all(1),
                                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Primary_colors.Color3, width: 2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ));
              }),
            ),
          ))
        ],
      ),
    );
  }

  Widget collage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: gstTable()),
        const SizedBox(width: 60),
        SizedBox(
          width: 220,
          child: amount_data(),
        )
      ],
    );
  }

  Widget amount_data() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sub total", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("CGST", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("SGST", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("Round off", style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(width: 10),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("  :  ", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("  :  ", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("  :  ", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Text("  :  ", style: TextStyle(fontSize: 12)),
              ],
            ),
            // const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // height: 20,
                    // width: 80,
                    child: TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.subTotal.value,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        hintText: "0.0",
                        hintStyle: TextStyle(),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    // height: 20,
                    child: TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.CGST.value,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        hintText: "0.0",
                        hintStyle: TextStyle(),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    // height: 20,
                    child: TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.SGST.value,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),

                        hintText: "0.0",
                        hintStyle: TextStyle(),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    // height: 20,
                    child: TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      controller: pdfpopup_controller.pdfModel.value.roundOff.value,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        hintText: "0.0",
                        hintStyle: TextStyle(),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                      ),
                    ),
                  ),
                  Text(
                    " ${pdfpopup_controller.pdfModel.value.roundoffDiff.value ?? ""}   ",
                    style: TextStyle(
                      fontSize: Primary_font_size.Text7,
                      color: pdfpopup_controller.pdfModel.value.roundoffDiff.value?.startsWith('-') == true ? Colors.red : Colors.green,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(height: 1, color: Colors.black),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Total", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 56, 61, 136)))],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("            ", style: TextStyle(fontSize: 12))],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 20,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: TextFormField(
                          readOnly: true,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 56, 61, 136), fontWeight: FontWeight.bold),
                          controller: pdfpopup_controller.pdfModel.value.Total.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(),
                            // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),

                            hintText: "0.0",
                            hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 56, 61, 136)),
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        signatory(),
      ],
    );
  }

  Widget signatory() {
    return Container(
      height: 90,
      width: 220,
      decoration: BoxDecoration(border: Border.all()),
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: Text("Authorized Signatory", style: TextStyle(fontSize: Primary_font_size.Text7, color: Color.fromARGB(255, 127, 126, 126))),
      ),
    );
  }

  Widget gstTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 151, 150, 150))),
            height: 90,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                'Texable Value',
                                style: TextStyle(
                                  fontSize: Primary_font_size.Text8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                    child: const Text(
                                      textAlign: TextAlign.center,
                                      'CGST',
                                      style: TextStyle(fontSize: Primary_font_size.Text8, overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: double.infinity,
                                          decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                          child: const Text(
                                            textAlign: TextAlign.center,
                                            '%',
                                            style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 2,
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            'amount',
                                            style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                                // border: Border(right: BorderSide()),
                                ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                    child: const Text(
                                      textAlign: TextAlign.center,
                                      'SGST',
                                      style: TextStyle(fontSize: Primary_font_size.Text8, overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: double.infinity,
                                          decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                          child: const Text(
                                            textAlign: TextAlign.center,
                                            '%',
                                            style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 2,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          'amount',
                                          style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: double.infinity,
                        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              '15,00,000',
                              style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150))),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                        child: const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              textAlign: TextAlign.center,
                                              '9.0',
                                              style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            '15,00,000',
                                            style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                              // border: Border(right: BorderSide()),
                              ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(255, 151, 150, 150)))),
                                        child: const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              textAlign: TextAlign.center,
                                              '9.0',
                                              style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            '15,00,000',
                                            style: TextStyle(fontSize: Primary_font_size.Text7, overflow: TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        const SizedBox(height: 45),
        notes(),
      ],
    );
  }

  Widget notes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("NOTES", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add, size: 18, color: Colors.blue),
              onPressed: () {
                pdfpopup_controller.pdfModel.value.notecontent.add(""); // Add empty note
                pdfpopup_controller.pdfModel.value.noteControllers.add(TextEditingController()); // Add controller
                pdfpopup_controller.pdfModel.refresh();
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Obx(
          () => Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(5), color: Colors.green.shade50),
            width: 400,
            height: 90,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  pdfpopup_controller.pdfModel.value.notecontent.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${index + 1}.", // Auto-incrementing S.No
                            style: const TextStyle(fontSize: Primary_font_size.Text7, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5), // Space between number and textfield
                          Flexible(
                            child: IntrinsicWidth(
                              // Ensures TextField takes only required width
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(minWidth: 50), // Set a reasonable min width
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  maxLines: null,
                                  controller: pdfpopup_controller.pdfModel.value.noteControllers[index],
                                  onChanged: (value) {
                                    pdfpopup_controller.update_noteCotent(value, index);
                                  },
                                  style: const TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      child: const Icon(
                                        Icons.delete,
                                        size: 14,
                                        color: const Color.fromARGB(193, 244, 67, 54),
                                      ),
                                      onTap: () {
                                        pdfpopup_controller.deleteNote(index);
                                      },
                                    ),
                                    hintText: "Payment terms : 100% along with PO....",
                                    hintStyle: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                    contentPadding: const EdgeInsets.all(0),
                                    border: const OutlineInputBorder(borderSide: BorderSide.none),
                                    // focusedBorder: OutlineInputBorder(
                                    //   borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                                    //   borderRadius: BorderRadius.circular(5),
                                    // ),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget footer() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "SPORADA SECURE INDIA PRIVATE LIMITED",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2),
        Text(
          "687/7, 3rd Floor, Sakthivel Towers, Trichy road, Ramanathapuram, Coimbatore- 641045",
          style: TextStyle(fontSize: Primary_font_size.Text7),
        ),
        SizedBox(height: 0),
        Text(
          "Telephone: +91-422-2312363, E-mail: sales@sporadasecure.com, Website: www.sporadasecure.com",
          style: TextStyle(fontSize: Primary_font_size.Text7),
        ),
        SizedBox(height: 0),
        Text("CIN: U30007TZ2020PTC03414 | GSTIN: 33ABECS0625B1Z0", style: TextStyle(fontSize: Primary_font_size.Text7)),
      ],
    );
  }
}
