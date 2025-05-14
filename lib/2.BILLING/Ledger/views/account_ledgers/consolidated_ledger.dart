// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ssipl_billing/2.BILLING/Ledger/views/ViewLedger.dart';

import '../../../../THEMES-/style.dart';

class consolidated extends StatefulWidget {
  const consolidated({super.key});

  @override
  State<consolidated> createState() => _consolidatedState();
}

class _consolidatedState extends State<consolidated> {
  final List<Map<String, dynamic>> consolidated_list = [
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Anamalais Toyota',
      'type': 'Output',
      'description': 'Purchased Camera',
      'transaction_details': 'NEFT BankTransfer- IOB',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
        {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Hello World Computers',
      'type': 'Output',
      'description': 'Purchased 10 computers',
      'transaction_details': 'NEFT BankTransfer- HDFC',
      'debit': '4500',
      'credit': '0',
      'balance': '9000',
    },
    {
      'date': '2024-12-01',
      'voucher_no': 'VH-3435',
      'invoice_no': '12345',
      'name': 'Maharaj Motors',
      'type': 'Output',
      'description': 'Subscription Purchased',
      'transaction_details': 'Google Pay- Id: YUU39302032',
      'debit': '0',
      'credit': '6767',
      'balance': '1000',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 60,
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
                     
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7, ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Date',
                       textAlign: TextAlign.center,
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Voucher No',
                       textAlign: TextAlign.center,
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                 Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Invoice No',
                       textAlign: TextAlign.center,
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Name',
                       textAlign: TextAlign.center,
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Type',
                       textAlign: TextAlign.center,
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Description',
                       textAlign: TextAlign.center,
                      style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Transaction Details',
                       textAlign: TextAlign.left,
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
                       textAlign: TextAlign.left,
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
                       textAlign: TextAlign.left,
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
                       textAlign: TextAlign.left,
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
            itemCount: consolidated_list.length,
            itemBuilder: (context, index) {
              return index %2==0 ? Padding(
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
                                consolidated_list[index]['date'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          // Vertical line after 'Date' column

                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                consolidated_list[index]['voucher_no'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          // Vertical line after 'Reference No' column

                          Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      consolidated_list[index]['invoice_no'],
                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                    ),
                                  ],
                                )),
                          ),
                          // Vertical line after 'clientname' column
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                consolidated_list[index]['name'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                consolidated_list[index]['type'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          // Vertical line after 'Debit' column

                          Expanded(
                                  flex: 3,
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            consolidated_list[index]['description'],
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
                           Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                 consolidated_list[index]['transaction_details'],
                                style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
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
                                          consolidated_list[index]['debit'],
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
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:const EdgeInsets.all(10),
                              child: Text(
                                 consolidated_list[index]['credit'],
                                style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:const EdgeInsets.all(10),
                              child: Text(
                                 consolidated_list[index]['balance'],
                                style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ) :
              Padding(
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
                                consolidated_list[index]['date'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          // Vertical line after 'Date' column

                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                consolidated_list[index]['voucher_no'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          // Vertical line after 'Reference No' column

                          Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      consolidated_list[index]['invoice_no'],
                                      style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                    ),
                                  ],
                                )),
                          ),
                          // Vertical line after 'clientname' column
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                consolidated_list[index]['name'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                consolidated_list[index]['type'],
                                style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                          // Vertical line after 'Debit' column

                          Expanded(
                                  flex: 3,
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            consolidated_list[index]['description'],
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
                           Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                 consolidated_list[index]['transaction_details'],
                                style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
                         Expanded(
                            flex: 2,
                            child: Padding(
                              padding:const EdgeInsets.all(10),
                              child: Text(
                                 consolidated_list[index]['credit'],
                                style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
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
                                          consolidated_list[index]['credit'],
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
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:const EdgeInsets.all(10),
                              child: Text(
                                 consolidated_list[index]['balance'],
                                style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                              ),
                            ),
                          ),
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
