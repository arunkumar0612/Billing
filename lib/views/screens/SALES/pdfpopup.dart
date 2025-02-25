import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/controllers/PDFpopup_actions.dart';
import 'package:ssipl_billing/themes/style.dart';
import 'package:ssipl_billing/views/components/button.dart';

mixin Pdfpopup {
  final PDFpopupController pdfpopup_controller = Get.find<PDFpopupController>();
  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/sporada.jpeg', height: 150),
        const Text("INVOICE", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 90,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Date", style: TextStyle(fontSize: 10)),
                  SizedBox(height: 15),
                  Text("Invoice no", style: TextStyle(fontSize: 10)),
                ],
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("  :  ", style: TextStyle(fontSize: 10)),
                  SizedBox(height: 15),
                  Text("  :  ", style: TextStyle(fontSize: 10)),
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
                  // Text("AA/SSIPL/250201", style: TextStyle(fontSize: 10)),
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
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 300,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 10, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.clientName.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "ABS Enterprises",
                            hintStyle: TextStyle(fontSize: 8, fontStyle: FontStyle.italic, color: Colors.grey),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 10, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.clientAddressName.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "123, Business Park Avenue, Sector 45, Downtown City, State - 560102, Country - USA",
                            hintStyle: TextStyle(fontSize: 8, fontStyle: FontStyle.italic, color: Colors.grey),
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
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 300,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 10, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.billingName.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "ABS Enterprises",
                            hintStyle: TextStyle(fontSize: 8, fontStyle: FontStyle.italic, color: Colors.grey),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 10, color: Colors.black),
                          controller: pdfpopup_controller.pdfModel.value.billingAddressName.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: "123, Business Park Avenue, Sector 45, Downtown City, State - 560102, Country - USA",
                            hintStyle: TextStyle(fontSize: 8, fontStyle: FontStyle.italic, color: Colors.grey),
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
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Table Header
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.green),
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 5),
              child: Row(
                children: tableHeaders.map((header) {
                  return SizedBox(
                    width: header == '✔' ? 50 : 82,
                    child: Text(header, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: header == "Total" ? TextAlign.end : TextAlign.center),
                  );
                }).toList(),
              ),
            ),

            // Table Rows
            Column(
              children: List.generate(controller.pdfModel.value.textControllers.length, (rowIndex) {
                return Container(
                  color: rowIndex % 2 == 0 ? Colors.green.shade50 : Colors.white,
                  padding: const EdgeInsets.only(right: 5),
                  child: Row(
                    children: [
                      // Checkbox Column
                      SizedBox(
                        width: 50,
                        child: Obx(
                          () => Checkbox(
                            // hoverColor: rowIndex % 2 == 0 ? Colors.green.shade50 : Colors.white,
                            activeColor: rowIndex % 2 == 0 ? Colors.green.shade50 : Colors.white,
                            checkColor: Primary_colors.Color3,
                            value: controller.pdfModel.value.checkboxValues[rowIndex],
                            onChanged: (value) {
                              controller.pdfModel.value.checkboxValues[rowIndex] = value!;
                            },
                          ),
                        ),
                      ),
                      // Data Columns
                      ...List.generate(tableHeaders.length - 1, (colIndex) {
                        bool isNumericField = [0, 2, 3, 4, 5].contains(colIndex);
                        bool isTotalField = colIndex == 6;

                        return SizedBox(
                          width: 82,
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
                              hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
                              contentPadding: const EdgeInsets.all(1),
                              border: const OutlineInputBorder(borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Primary_colors.Color3, width: 2), borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget collage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: gstTable()),
        const SizedBox(
          width: 50,
        ),
        amount_data()
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
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 80,
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    controller: pdfpopup_controller.pdfModel.value.subTotal.value,
                    decoration: const InputDecoration(
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
                  height: 20,
                  width: 80,
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    controller: pdfpopup_controller.pdfModel.value.CGST.value,
                    decoration: const InputDecoration(
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
                  height: 20,
                  width: 80,
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    controller: pdfpopup_controller.pdfModel.value.SGST.value,
                    decoration: const InputDecoration(
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
                  height: 20,
                  width: 80,
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    controller: pdfpopup_controller.pdfModel.value.roundOff.value,
                    decoration: const InputDecoration(
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
                    fontSize: 10,
                    color: pdfpopup_controller.pdfModel.value.roundoffDiff.value?.startsWith('-') == true ? Colors.red : Colors.green,
                  ),
                )
              ],
            ),
            const SizedBox(width: 6),
          ],
        ),
        const SizedBox(height: 20),
        Container(height: 1, width: 210, color: Colors.black),
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
            const SizedBox(width: 20),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("            ", style: TextStyle(fontSize: 12))],
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 80,
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
                ),
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 30),
        signatory(),
      ],
    );
  }

  Widget signatory() {
    return Container(
      height: 110,
      width: 220,
      decoration: BoxDecoration(border: Border.all()),
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: Text("Authorized Signatory", style: TextStyle(fontSize: 10)),
      ),
    );
  }

  Widget gstTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 90, width: 300, color: Colors.black),
        const SizedBox(height: 20),
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
        Obx(() => Column(
              children: List.generate(pdfpopup_controller.pdfModel.value.notecontent.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${index + 1}.", // Auto-incrementing S.No
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5), // Space between number and textfield
                      Flexible(
                        child: IntrinsicWidth(
                          // Ensures TextField takes only required width
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 50), // Set a reasonable min width
                            child: TextField(
                              maxLines: null,
                              controller: pdfpopup_controller.pdfModel.value.noteControllers[index],
                              onChanged: (value) {
                                pdfpopup_controller.update_noteCotent(value, index);
                              },
                              style: const TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                suffixIcon: pdfpopup_controller.pdfModel.value.noteControllers[index].text.isEmpty
                                    ? null
                                    : IconButton(
                                        icon: const Icon(Icons.delete, size: 14),
                                        onPressed: () {
                                          pdfpopup_controller.deleteNote(index);
                                        },
                                        color: const Color.fromARGB(193, 244, 67, 54),
                                      ),
                                hintText: "Payment terms : 100% along with PO....",
                                hintStyle: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
              }),
            )),
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
          style: TextStyle(fontSize: 10),
        ),
        SizedBox(height: 0),
        Text(
          "Telephone: +91-422-2312363, E-mail: sales@sporadasecure.com, Website: www.sporadasecure.com",
          style: TextStyle(fontSize: 10),
        ),
        SizedBox(height: 0),
        Text("CIN: U30007TZ2020PTC03414 | GSTIN: 33ABECS0625B1Z0", style: TextStyle(fontSize: 10)),
      ],
    );
  }

  void showA4StyledPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: AspectRatio(
          aspectRatio: 1 / 1.41, // A4 Aspect Ratio (210mm x 297mm)
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Obx(() {
                  return Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      header(),
                      addresses(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BasicButton(
                              text: "Add product",
                              colors: const Color.fromARGB(202, 33, 149, 243),
                              onPressed: () {
                                pdfpopup_controller.addRow();
                              }),
                          const SizedBox(width: 5),
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
                      contentTable(pdfpopup_controller),
                      const SizedBox(height: 20),
                      collage(),
                      const SizedBox(height: 120),
                      footer(),
                    ],
                  );
                })),
          ),
        ),
      ),
    );
  }
}
