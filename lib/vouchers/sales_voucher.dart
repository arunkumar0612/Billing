import 'dart:io';

import 'package:dashed_rect/dashed_rect.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ssipl_billing/common_modules/style.dart';

class SalesVoucher extends StatefulWidget {
  const SalesVoucher({super.key});

  @override
  State<SalesVoucher> createState() => _SalesVoucherState();
}

class _SalesVoucherState extends State<SalesVoucher> {
  final TextEditingController _dateController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0]; // Format as yyyy-MM-dd
      });
    }
  }

  String? fileName;
  File? selectedFile;

  Future<void> pickFile() async {
    // Open file picker and select a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Get the picked file
      setState(() {
        selectedFile = File(result.files.single.path!);
        fileName = result.files.single.name;
      });

      // Here you can handle the file upload logic
      // For example, you can send the file to a server or save it locally
    }
  }

  @override
  Widget build(BuildContext context) {
    String? extension = fileName?.split('.').last.toLowerCase();
    return Container(
      height: 500,
      decoration: const BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage('assets/images/popup1.png'), // Use AssetImage inside DecorationImage
        //   fit: BoxFit.cover, // Adjust the image fit
        // ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 117, 66, 245), // Light blue

            Color.fromARGB(255, 33, 94, 248), // Darker blue
            Color.fromARGB(255, 100, 42, 247), // Light blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create Sales Voucher',
                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text15),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 30,
                          runSpacing: 50,
                          children: [
                            // Date Field
                            SizedBox(
                              width: 400,
                              height: 50,
                              child: TextFormField(
                                style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(1),
                                  filled: true,
                                  fillColor: const Color.fromARGB(37, 255, 255, 255),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                                  hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                  hintText: 'Enter Client Name',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.people, color: Primary_colors.Color1),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              height: 50,
                              child: TextFormField(
                                controller: _dateController,
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(1),
                                  filled: true,
                                  fillColor: const Color.fromARGB(37, 255, 255, 255),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Colors.transparent),
                                  ),
                                  hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                  hintText: 'Enter Date',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.calendar_today, color: Primary_colors.Color1),
                                ),
                              ),
                            ),
                            // Reference Number Field
                            SizedBox(
                              width: 400,
                              height: 50,
                              child: TextFormField(
                                style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(1),
                                  filled: true,
                                  fillColor: const Color.fromARGB(37, 255, 255, 255),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                                  hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                  hintText: 'Enter Reference No',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.receipt, color: Primary_colors.Color1),
                                ),
                              ),
                            ),
                            // Particulars Field
                            SizedBox(
                              width: 400,
                              height: 50,
                              child: TextFormField(
                                style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(1),
                                  filled: true,
                                  fillColor: const Color.fromARGB(37, 255, 255, 255),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                                  hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                  hintText: 'Enter Particulars',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.description, color: Primary_colors.Color1),
                                ),
                              ),
                            ),
                            // Notes Field
                            SizedBox(
                              width: 400,
                              height: 50,
                              child: TextFormField(
                                style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(1),
                                  filled: true,
                                  fillColor: const Color.fromARGB(37, 255, 255, 255),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                                  hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                  hintText: 'Enter Notes',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.note, color: Primary_colors.Color1),
                                ),
                              ),
                            ),
                            // Total, Net, and GST Fields
                            SizedBox(
                              width: 400,
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(1),
                                        filled: true,
                                        fillColor: const Color.fromARGB(37, 255, 255, 255),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                                        hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                        hintText: 'Net',
                                        border: const OutlineInputBorder(),
                                        prefixIcon: const Icon(Icons.calculate, color: Primary_colors.Color1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(1),
                                        filled: true,
                                        fillColor: const Color.fromARGB(37, 255, 255, 255),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                                        hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                        hintText: 'GST',
                                        border: const OutlineInputBorder(),
                                        prefixIcon: const Icon(Icons.percent, color: Primary_colors.Color1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(1),
                                        filled: true,
                                        fillColor: const Color.fromARGB(37, 255, 255, 255),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                                        hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                        hintText: 'Total',
                                        border: const OutlineInputBorder(),
                                        prefixIcon: const Icon(Icons.attach_money, color: Primary_colors.Color1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Upload invoice',
                              style: TextStyle(fontSize: Primary_font_size.Text10, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                            ),
                            const SizedBox(height: 24),
                            GestureDetector(
                              onTap: pickFile,
                              child: SizedBox(
                                width: 300,
                                height: 250,
                                child: DashedRect(
                                  color: Primary_colors.Color1,
                                  strokeWidth: 2.0,
                                  gap: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: selectedFile != null
                                          ? SizedBox(
                                              height: 150,
                                              width: 150,
                                              // color: Colors.blue,
                                              child: extension == 'pdf'
                                                  ? Image.asset('assets/images/pdfdownload.png', fit: BoxFit.cover)
                                                  : extension == 'docx' || extension == 'doc'
                                                      ? Image.asset('assets/images/word.png', fit: BoxFit.cover)
                                                      : extension == 'png' || extension == 'jpg' || extension == 'jpeg'
                                                          ? Image.file(
                                                              selectedFile!,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : const Center(
                                                              child: Text(
                                                                'File type not supported',
                                                                style: TextStyle(color: Colors.white),
                                                              ),
                                                            ),
                                            )
                                          : const Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.cloud_upload_outlined, size: 100, color: Color.fromARGB(255, 184, 184, 184)),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Click here to pick file',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(255, 182, 181, 181),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              fileName ?? 'No file selected',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 180, 179, 179),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 35,
                        decoration: BoxDecoration(color: Primary_colors.Color1, borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Colors.red, fontSize: Primary_font_size.Text10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      Container(
                        width: 120,
                        height: 35,
                        decoration: BoxDecoration(color: Primary_colors.Color1, borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.green, fontSize: Primary_font_size.Text7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Notes on Sales Voucher',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 207, 207, 207)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '1. Purpose: A sales voucher records details of sales transactions.',
                    style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '2. Date: Represents the date of the transaction; ensure accuracy.',
                    style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '3. Reference Number: Unique identifier for tracking and auditing.',
                    style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '4. Particulars: Describes items, products, or services sold.',
                    style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '5. Notes Section: Includes additional remarks or instructions.',
                    style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '6. Total Amount: Gross amount before deductions or taxes.',
                    style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '7. Net Amount: Final amount after deductions or discounts.',
                    style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '8. GST: Tax amount based on the transaction value; ensure accuracy.',
                    style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '9. Accuracy: Verify all details before finalizing the voucher.',
                    style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '10. Retention: Maintain sales vouchers securely for records and audits.',
                    style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
