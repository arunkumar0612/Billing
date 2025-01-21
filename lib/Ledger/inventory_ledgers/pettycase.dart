import 'package:flutter/material.dart';
import 'package:ssipl_billing/Ledger/ViewLedger.dart';
import 'package:ssipl_billing/common_modules/style.dart';

class pettyCase extends StatefulWidget {
  const pettyCase({super.key});

  @override
  State<pettyCase> createState() => _pettyCaseState();
}

class _pettyCaseState extends State<pettyCase> {
  final List<Map<String, dynamic>> pettyCase_list = [
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'For EB bill',
      'debit': '500',
      'credit': '0',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'For Milk',
      'debit': '0',
      'credit': '300',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'For Snacks',
      'debit': '200',
      'credit': '0',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'For Eb bill',
      'debit': '0',
      'credit': '450',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'For EB bill',
      'debit': '500',
      'credit': '0',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'For Milk',
      'debit': '0',
      'credit': '300',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'For Snacks',
      'debit': '200',
      'credit': '0',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'For Eb bill',
      'debit': '0',
      'credit': '450',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'For EB bill',
      'debit': '500',
      'credit': '0',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'For Milk',
      'debit': '0',
      'credit': '300',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'For Snacks',
      'debit': '200',
      'credit': '0',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'For Eb bill',
      'debit': '0',
      'credit': '450',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'For EB bill',
      'debit': '500',
      'credit': '0',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'For Milk',
      'debit': '0',
      'credit': '300',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'For Snacks',
      'debit': '200',
      'credit': '0',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'For Eb bill',
      'debit': '0',
      'credit': '450',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'For EB bill',
      'debit': '500',
      'credit': '0',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'For Milk',
      'debit': '0',
      'credit': '300',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'For Snacks',
      'debit': '200',
      'credit': '0',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'For Eb bill',
      'debit': '0',
      'credit': '450',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'For EB bill',
      'debit': '500',
      'credit': '0',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'For Milk',
      'debit': '0',
      'credit': '300',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'For Snacks',
      'debit': '200',
      'credit': '0',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'For Eb bill',
      'debit': '0',
      'credit': '450',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'For EB bill',
      'debit': '500',
      'credit': '0',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'For Milk',
      'debit': '0',
      'credit': '300',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'For Snacks',
      'debit': '200',
      'credit': '0',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'For Eb bill',
      'debit': '0',
      'credit': '450',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'For EB bill',
      'debit': '500',
      'credit': '0',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'For Milk',
      'debit': '0',
      'credit': '300',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'For Snacks',
      'debit': '200',
      'credit': '0',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'For Eb bill',
      'debit': '0',
      'credit': '450',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'For EB bill',
      'debit': '500',
      'credit': '0',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'For Milk',
      'debit': '0',
      'credit': '300',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'For Snacks',
      'debit': '200',
      'credit': '0',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'For Eb bill',
      'debit': '0',
      'credit': '450',
    },
    {
      'date': '2024-12-01',
      'reference_no': '12345',
      'particulars': 'For EB bill',
      'debit': '500',
      'credit': '0',
    },
    {
      'date': '2024-12-02',
      'reference_no': '12346',
      'particulars': 'For Milk',
      'debit': '0',
      'credit': '300',
    },
    {
      'date': '2024-12-03',
      'reference_no': '12347',
      'particulars': 'For Snacks',
      'debit': '200',
      'credit': '0',
    },
    {
      'date': '2024-12-04',
      'reference_no': '12348',
      'particulars': 'For Eb bill',
      'debit': '0',
      'credit': '450',
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
                      'Particulars',
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Debit',
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Credit',
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
            itemCount: pettyCase_list.length,
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
                                pettyCase_list[index]['date'],
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
                                pettyCase_list[index]['reference_no'],
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
                                    pettyCase_list[index]['particulars'],
                                    style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Vertical line after 'particulars' column

                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                pettyCase_list[index]['debit'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          // Vertical line after 'Debit' column
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                pettyCase_list[index]['credit'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),

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
              flex: 11,
              child: Container(),
            ),
            Expanded(
              flex: 5,
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
                flex: 11,
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
                flex: 5,
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
                              'Rs. 2389',
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
                              'Rs. 2389',
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
                      Expanded(
                        flex: 2,
                        child: Stack(
                          children: [
                            // Bottom shadow for the recessed effect
                            Text(
                              'Rs. 2389',
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
                              'Rs. 2389',
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
              flex: 11,
              child: Container(),
            ),
            Expanded(
              flex: 5,
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
