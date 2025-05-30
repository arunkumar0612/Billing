// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ViewLedger.dart';

import '../../../../THEMES/style.dart';

class Outward extends StatefulWidget {
  const Outward({super.key});

  @override
  State<Outward> createState() => _OutwardState();
}

class _OutwardState extends State<Outward> {
  final List<Map<String, dynamic>> Outward_list = [
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'Maharaja',
      'quantity': '500',
      'notes': 'Paid via card',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'Maruti',
      'quantity': '0',
      'notes': 'Paid via cash',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'Anamalais',
      'quantity': '200',
      'notes': 'Paid via cheque',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'Maharaja',
      'quantity': '0',
      'notes': 'Received via bank transfer',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Primary_colors.Color3, Primary_colors.Color3], // Example gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10), // Ensure border radius for smooth corners
          ),
          child: const Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'S.No',
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Date',
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Reference No',
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'particulars',
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Notes',
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'quantity',
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: const Color.fromARGB(94, 125, 125, 125),
            ),
            itemCount: Outward_list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Primary_colors.Light,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(
                                    color: Primary_colors.Color1,
                                    fontSize: Primary_font_size.Text7,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                Outward_list[index]['date'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          // Vertical line after 'Date' column

                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                Outward_list[index]['reference_no'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          // Vertical line after 'Reference No' column

                          Expanded(
                            flex: 3,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Outward_list[index]['particulars'],
                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                    ),
                                  ],
                                )),
                          ),
                          // Vertical line after 'particulars' column
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                Outward_list[index]['notes'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                Outward_list[index]['quantity'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          // Vertical line after 'quantity' column

                          // Vertical line after 'Credit' column

                          // Vertical line after 'Notes' column
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 37,
              child: Container(),
            ),
            Expanded(
              flex: 6,
              child: SizedBox(
                height: 5,
                child: CustomPaint(
                  painter: DottedLinePainter(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 80,
          child: Row(
            children: [
              Expanded(
                flex: 37,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Share Button
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(height: 35, 'assets/images/share.png'),
                          const SizedBox(
                            height: 6,
                          ),
                          const Text(
                            "Share",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 143, 143, 143),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 40), // Space between buttons

                    // Download Button
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(height: 40, 'assets/images/printer.png'),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Print",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 143, 143, 143),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40), // Space between buttons
                    // Download Button
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(height: 40, 'assets/images/pdfdownload.png'),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Download",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 143, 143, 143),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: SizedBox(
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Stack(
                          children: [
                            // Bottom shadow for the recessed effect
                            Text(
                              '389',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: Colors.white.withOpacity(0.2),
                                shadows: const [
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 2,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            // Top layer to give the 3D embossed effect
                            Text(
                              '389',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.8),
                                      const Color.fromARGB(255, 255, 223, 0),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(const Rect.fromLTWH(0, 0, 200, 100)),
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
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 37,
              child: Container(),
            ),
            Expanded(
              flex: 6,
              child: SizedBox(
                height: 5,
                child: CustomPaint(
                  painter: DottedLinePainter(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
