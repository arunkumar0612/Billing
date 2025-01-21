import 'package:flutter/material.dart';
import 'package:ssipl_billing/Ledger/ViewLedger.dart';
import 'package:ssipl_billing/common_modules/style.dart';

class Vendorledger extends StatefulWidget {
  const Vendorledger({super.key});

  @override
  State<Vendorledger> createState() => _VendorledgerState();
}

class _VendorledgerState extends State<Vendorledger> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> vendorledger_list = [
      {
        'date': '2024-12-01',
        'reference_no': '12345',
        'particulars': 'Purchase of goods',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via card',
      },
      {
        'date': '2024-12-02',
        'reference_no': '12346',
        'particulars': 'Sale of goods',
        'debit': '0',
        'credit': '300',
        'notes': 'Paid via cash',
      },
      {
        'date': '2024-12-03',
        'reference_no': '12347',
        'particulars': 'Office supplies',
        'debit': '200',
        'credit': '0',
        'notes': 'Paid via cheque',
      },
      {
        'date': '2024-12-04',
        'reference_no': '12348',
        'particulars': 'Service income',
        'debit': '0',
        'credit': '450',
        'notes': 'Received via bank transfer',
      },
      {
        'date': '2024-12-05',
        'reference_no': '12349',
        'particulars': 'Rent payment',
        'debit': '1000',
        'credit': '0',
        'notes': 'Paid via online banking',
      },
      {
        'date': '2024-12-06',
        'reference_no': '12350',
        'particulars': 'Consulting fees',
        'debit': '0',
        'credit': '600',
        'notes': 'Paid via cheque',
      },
      {
        'date': '2024-12-07',
        'reference_no': '12351',
        'particulars': 'Product refund',
        'debit': '200',
        'credit': '0',
        'notes': 'Refunded to customer',
      },
      {
        'date': '2024-12-08',
        'reference_no': '12352',
        'particulars': 'Electricity bill payment',
        'debit': '150',
        'credit': '0',
        'notes': 'Paid via card',
      },
      {
        'date': '2024-12-09',
        'reference_no': '12353',
        'particulars': 'Sale of equipment',
        'debit': '0',
        'credit': '1200',
        'notes': 'Received via cash',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
      {
        'date': '2024-12-10',
        'reference_no': '12354',
        'particulars': 'Loan repayment',
        'debit': '500',
        'credit': '0',
        'notes': 'Paid via bank transfer',
      },
    ];
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
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Balance',
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
            itemCount: vendorledger_list.length,
            itemBuilder: (context, index) {
              return index % 2 == 0
                  ? Padding(
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
                                      vendorledger_list[index]['date'],
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
                                      vendorledger_list[index]['reference_no'],
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
                                            vendorledger_list[index]['particulars'],
                                            style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                          ),
                                        ],
                                      )),
                                ),
                                // Vertical line after 'Particulars' column
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      vendorledger_list[index]['notes'],
                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      vendorledger_list[index]['debit'],
                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                    ),
                                  ),
                                ),
                                // Vertical line after 'Debit' column

                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vendorledger_list[index]['credit'],
                                          style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                        ),
                                        const SizedBox(height: 2),
                                        const Text(
                                          'Net : 5533',
                                          style: TextStyle(color: Primary_colors.Color6, fontSize: Primary_font_size.Text5),
                                        ),
                                        const SizedBox(height: 2),
                                        const Text(
                                          'GST : 500',
                                          style: TextStyle(color: Primary_colors.Color6, fontSize: Primary_font_size.Text5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Vertical line after 'Credit' column
                                const Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      '8233',
                                      style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                    ),
                                  ),
                                ),

                                // Vertical line after 'Notes' column
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
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
                                    decoration: const BoxDecoration(
                                        // border: Border(
                                        //   right: BorderSide(color: Primary_colors.Color1, width: 0.2),
                                        // ),
                                        ),
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
                                      vendorledger_list[index]['date'],
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
                                      vendorledger_list[index]['reference_no'],
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
                                            vendorledger_list[index]['particulars'],
                                            style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                          ),
                                          const SizedBox(height: 2),
                                          const Text(
                                            'GST : Paid',
                                            style: TextStyle(color: Primary_colors.Color7, fontSize: Primary_font_size.Text5),
                                          ),
                                          const SizedBox(height: 2),
                                          const Text(
                                            'TDS : Deducted',
                                            style: TextStyle(color: Primary_colors.Color7, fontSize: Primary_font_size.Text5),
                                          ),
                                        ],
                                      )),
                                ),
                                // Vertical line after 'Particulars' column
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      vendorledger_list[index]['notes'],
                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vendorledger_list[index]['debit'],
                                          style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                        ),
                                        const SizedBox(height: 2),
                                        const Text(
                                          'Net : +5533',
                                          style: TextStyle(color: Color.fromARGB(255, 129, 244, 132), fontSize: Primary_font_size.Text5),
                                        ),
                                        const SizedBox(height: 2),
                                        const Tooltip(
                                          message: "KHV/INGST/241215",
                                          child: Text(
                                            'GST : +500',
                                            style: TextStyle(color: Color.fromARGB(255, 129, 244, 132), fontSize: Primary_font_size.Text5),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        const Tooltip(
                                          message: "KHV/INTDS/948484",
                                          child: Text(
                                            'TDS : -500',
                                            style: TextStyle(color: Color.fromARGB(255, 248, 110, 94), fontSize: Primary_font_size.Text5),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // Vertical line after 'Debit' column

                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      vendorledger_list[index]['credit'],
                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                    ),
                                  ),
                                ),
                                // Vertical line after 'Credit' column
                                const Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      '8233',
                                      style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                    ),
                                  ),
                                ),

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
              flex: 12,
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
                flex: 12,
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
                      Expanded(
                        flex: 2,
                        child: Stack(
                          children: [
                            // Bottom shadow for the recessed effect
                            Text(
                              '- Rs.2389',
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
                              '- Rs.2389',
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
              flex: 12,
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
