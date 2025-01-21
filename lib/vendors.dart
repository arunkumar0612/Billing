import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ssipl_billing/cards.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
// import 'package:dropdown_search/dropdown_search.dart';
import 'dart:ui';

class Vendor extends StatefulWidget {
  const Vendor({super.key});
  @override
  _VendorState createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  final List<Map<String, String>> products = [
    {"label": "Item 1", "image": "assets/images/car.jpg"},
    {"label": "Item 2", "image": "assets/images/car.jpg"},
    {"label": "Item 3", "image": "assets/images/car.jpg"},
    {"label": "Item 4", "image": "assets/images/car.jpg"},
    {"label": "Item 5", "image": "assets/images/car.jpg"},
    {"label": "Item 6", "image": "assets/images/car.jpg"},
    {"label": "Item 7", "image": "assets/images/car.jpg"},
    {"label": "Item 8", "image": "assets/images/car.jpg"},
    {"label": "Item 9", "image": "assets/images/car.jpg"},
    {"label": "Item 10", "image": "assets/images/car.jpg"},
    {"label": "Item 11", "image": "assets/images/car.jpg"},
    {"label": "Item 12", "image": "assets/images/car.jpg"},
    {"label": "Item 13", "image": "assets/images/car.jpg"},
    {"label": "Item 14", "image": "assets/images/car.jpg"},
    {"label": "Item 15", "image": "assets/images/car.jpg"},
    {"label": "Item 16", "image": "assets/images/car.jpg"},
    {"label": "Item 17", "image": "assets/images/car.jpg"},
    {"label": "Item 18", "image": "assets/images/car.jpg"},
    {"label": "Item 19", "image": "assets/images/car.jpg"},
    {"label": "Item 20", "image": "assets/images/car.jpg"},
  ];
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Khivraj Groups',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
        {
          'id': 'VST/SSIPL - 1008',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4', 'Invoice 5'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
    {
      'name': 'Nexa sales and  service',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
        {
          'id': 'VST/SSIPL - 1008',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4', 'Invoice 5'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
    {
      'name': 'Maruti Groups',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
        {
          'id': 'VST/SSIPL - 1008',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4', 'Invoice 5'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
    {
      'name': 'MTeenz',
      'process': [
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
    {
      'name': 'Olympia honda service',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
        {
          'id': 'VST/SSIPL - 1008',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4', 'Invoice 5'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
    {
      'name': 'Maharaja',
      'process': [
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
    {
      'name': 'KTM Sales',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
        {
          'id': 'VST/SSIPL - 1008',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4', 'Invoice 5'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
    {
      'name': 'True Values',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
        {
          'id': 'VST/SSIPL - 1008',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4', 'Invoice 5'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
    {
      'name': 'M1',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
      ]
    },
    {
      'name': 'M4',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
      ]
    },
    {
      'name': 'M5',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
      ]
    },
    {
      'name': 'M2',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
        {
          'id': 'VST/SSIPL - 1008',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4', 'Invoice 5'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
    {
      'name': 'M3',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
        {
          'id': 'VST/SSIPL - 1008',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4', 'Invoice 5'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
    {
      'name': 'DJH Groups',
      'process': [
        {
          'id': 'VST/SSIPL - 1001',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3'],
        },
        {
          'id': 'VST/SSIPL - 1006',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4'],
        },
        {
          'id': 'VST/SSIPL - 1008',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2', 'Invoice 3', 'Invoice 4', 'Invoice 5'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
        {
          'id': 'VST/SSIPL - 1010',
          'date': '16/03/2023',
          'daycounts': '21 days',
          'child': ['Invoice 1', 'Invoice 2'],
        },
      ]
    },
  ];
  // Adding a controller and isAdding flag for each item
  late List<bool> isAddingList;
  late List<TextEditingController> controllers;
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String VendorSearchQuery = '';
  @override
  void initState() {
    super.initState();
    // Initialize isAddingList and controllers based on the number of items
    isAddingList = List<bool>.filled(items.length, false);
    controllers = List<TextEditingController>.generate(items.length, (index) => TextEditingController());
  }

  int showcustomerprocess = 1;
  // List<Map<String, dynamic>> get filteredVendorList {
  //   if (VendorSearchQuery.isEmpty) {
  //     return items;
  //   } else {
  //     // ignore: avoid_types_as_parameter_names
  //     return items.where((Vendor) => Vendor.toLowerCase().contains(VendorSearchQuery.toLowerCase())).toList();
  //   }
  // }

  // List<String> VendorList = [
  //   'Vendor 1',
  //   'Vendor 2',
  //   'Vendor 3',
  //   'Vendor 4',
  //   'Vendor 5',
  //   'Vendor 6',
  //   'Vendor 7',
  //   'Vendor 8',
  //   'Vendor 9',
  //   'Vendor 10',
  //   'Vendor 11',
  //   'Vendor 12',
  //   'Vendor 13',
  //   'Vendor 14',
  //   'Vendor 15',
  //   'Vendor 16',
  //   'Vendor 17',
  //   'Vendor 18',
  //   'Vendor 19',
  //   'Vendor 20',
  //   'Vendor 21',
  //   'Vendor 22',
  //   'Vendor 23',
  //   'Vendor 24',
  //   'Vendor 25',
  //   'Vendor 26',
  //   'Vendor 27',
  //   'Vendor 28',
  //   'Vendor 29',
  //   'Vendor 30',
  //   'Vendor 31',
  //   'Vendor 32',
  //   'Vendor 33',
  //   'Vendor 34',
  //   'Vendor 35',
  //   'Vendor 36',
  //   'Vendor 37',
  //   'Vendor 38',
  //   'Vendor 39',
  //   'Vendor 40',
  // ];
  // ignore: unused_element
  void _generate_quotation(BuildContext context) async {
    Future.delayed(const Duration(seconds: 1), () {
      // Code to execute after 5 seconds delay
      // generateinvoice_popupState.update();
      generateinvoice_popup.callback();
      if (kDebugMode) {
        print('This runs after a 5 seconds delay.');
      }
    });
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(backgroundColor: Primary_colors.Light, content: generateinvoice_popup());
      },
    );
    // await quotationmain();
  }

  void _generate_invoice(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(backgroundColor: Primary_colors.Light, content: generateinvoice_popup());
      },
    );
  }

  void Add_vendor_popup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 127, 80, 246), // Light blue
                  Color.fromARGB(255, 53, 109, 248), // Darker blue

                  // Color.fromARGB(255, 97, 38, 245), // Light blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              // image: const DecorationImage(
              //   image: AssetImage('assets/images/popup1.png'), // Use AssetImage inside DecorationImage
              //   fit: BoxFit.cover, // Adjust the image fit
              // ),
            ),
            width: 500,
            height: 450,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Add Vendor',
                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text10),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: TextFormField(
                      style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        filled: true,
                        fillColor: const Color.fromARGB(37, 255, 255, 255),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                        hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color9),
                        hintText: 'Enter Name',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: TextFormField(
                      style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        filled: true,
                        fillColor: const Color.fromARGB(37, 255, 255, 255),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                        hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color9),
                        hintText: 'Enter Phone Number',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.phone, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: TextFormField(
                      style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        filled: true,
                        fillColor: const Color.fromARGB(37, 255, 255, 255),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                        hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color9),
                        hintText: 'Enter Email',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.email, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: TextFormField(
                      style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        filled: true,
                        fillColor: const Color.fromARGB(37, 255, 255, 255),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                        hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color9),
                        hintText: 'Enter GST Number',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.numbers, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: TextFormField(
                      style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        filled: true,
                        fillColor: const Color.fromARGB(37, 255, 255, 255),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.transparent)),
                        hintStyle: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color9),
                        hintText: 'Enter Address',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.location_city, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Colors.red, fontSize: Primary_font_size.Text7),
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      Container(
                        width: 70,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary_colors.Dark,
      body: Center(
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(height: 185, child: cardview()),
              const SizedBox(height: 20),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Primary_colors.Light),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Primary_colors.Color3,
                                borderRadius: BorderRadius.circular(15), // Ensure border radius for both states
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 16, right: 47),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Process ID',
                                        style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        'Vendor Name',
                                        style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Date',
                                        style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Days',
                                        style: TextStyle(color: Primary_colors.Color1, fontWeight: FontWeight.bold, fontSize: Primary_font_size.Text7),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              child: ListView.builder(
                                itemCount: items[showcustomerprocess]['process'].length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Primary_colors.Dark,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ExpansionTile(
                                          collapsedIconColor: const Color.fromARGB(255, 135, 132, 132),
                                          iconColor: Colors.red,
                                          collapsedBackgroundColor: Primary_colors.Dark,
                                          backgroundColor: Primary_colors.Dark,
                                          title: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  items[showcustomerprocess]['process'][index]['id'],
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  items[showcustomerprocess]['name'],
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  items[showcustomerprocess]['process'][index]['date'],
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  items[showcustomerprocess]['process'][index]['daycounts'],
                                                  style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                ),
                                              ),
                                            ],
                                          ),
                                          children: [
                                            SizedBox(
                                              height: ((items[showcustomerprocess]['process'][index]['child'].length * 80) + 90).toDouble(),
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: ListView.builder(
                                                  itemCount: items[showcustomerprocess]['process'][index]['child'].length + 1, // +1 for "Add Event" button
                                                  itemBuilder: (context, childIndex) {
                                                    if (childIndex < items[showcustomerprocess]['process'][index]['child'].length) {
                                                      return Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                padding: const EdgeInsets.all(8),
                                                                decoration: const BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: Colors.green,
                                                                ),
                                                                child: const Icon(
                                                                  Icons.event,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 2,
                                                                height: 40,
                                                                color: Colors.green,
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(width: 16),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                              child: Text(
                                                                items[showcustomerprocess]['process'][index]['child'][childIndex],
                                                                style: const TextStyle(fontSize: Primary_font_size.Text7, color: Primary_colors.Color1),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    } else {
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 0),
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets.all(8),
                                                                      decoration: const BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        color: Colors.blue,
                                                                      ),
                                                                      child: const Icon(
                                                                        Icons.event,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(width: 16),
                                                                if (!isAddingList[index])
                                                                  ElevatedButton(
                                                                    style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Primary_colors.Color3)),
                                                                    child: const Text(
                                                                      "Add Event",
                                                                      style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                                    ),
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        isAddingList[index] = true;
                                                                      });
                                                                    },
                                                                  )
                                                                else
                                                                  // Row(
                                                                  //   children: [
                                                                  //     DropdownMenu<String>(
                                                                  //       textStyle: const TextStyle(color: Primary_colors.Color1),
                                                                  //       width: 400,
                                                                  //       inputDecorationTheme: const InputDecorationTheme(
                                                                  //         contentPadding: EdgeInsets.only(left: 10, right: 5),
                                                                  //         filled: true,
                                                                  //         fillColor: Primary_colors.Dark,
                                                                  //         focusedBorder: OutlineInputBorder(
                                                                  //           borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                                                                  //           borderSide: BorderSide(
                                                                  //             color: Colors.black,
                                                                  //           ),
                                                                  //         ),
                                                                  //         enabledBorder: OutlineInputBorder(
                                                                  //             borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                                                                  //             borderSide: BorderSide(color: Colors.black)),
                                                                  //         border: OutlineInputBorder(),
                                                                  //         hintStyle: TextStyle(
                                                                  //           fontSize: 13,
                                                                  //           color: Color.fromARGB(255, 167, 165, 165),
                                                                  //         ),
                                                                  //       ),
                                                                  //       controller: controllers[index],
                                                                  //       // initialSelection: list.first,
                                                                  //       // onSelected: (String? value) {
                                                                  //       //   controllers[index].text = value!;
                                                                  //       // },
                                                                  //       dropdownMenuEntries: list.map<DropdownMenuEntry<String>>(
                                                                  //         (String value) {
                                                                  //           return DropdownMenuEntry<String>(value: value, label: value);
                                                                  //         },
                                                                  //       ).toList(),
                                                                  //     ),
                                                                  //     Container(
                                                                  //       height: 49,
                                                                  //       decoration: const BoxDecoration(
                                                                  //           border: Border(right: BorderSide(), top: BorderSide(), bottom: BorderSide()),
                                                                  //           color: Primary_colors.Dark,
                                                                  //           borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))),
                                                                  //       child: TextButton(
                                                                  //         onPressed: () {
                                                                  //           setState(() {
                                                                  //             if (controllers[index].text.isNotEmpty) {
                                                                  //               items[showcustomerprocess]['process'][index]['child'].add(controllers[index].text);
                                                                  //               controllers[index].clear();
                                                                  //             }
                                                                  //             isAddingList[index] = false;
                                                                  //           });
                                                                  //         },
                                                                  //         child: const Text(
                                                                  //           'Add',
                                                                  //           style: TextStyle(color: Colors.blue, fontSize: Primary_font_size.Text7),
                                                                  //         ),
                                                                  //       ),
                                                                  //     )
                                                                  //   ],
                                                                  // ),
                                                                  // if (isAddingList[index])
                                                                  //   IconButton(
                                                                  //     icon: const Icon(Icons.add),
                                                                  //   ),
                                                                  const SizedBox(width: 10),
                                                                const SizedBox(width: 10),
                                                                ElevatedButton(
                                                                  style: const ButtonStyle(
                                                                    backgroundColor: WidgetStatePropertyAll(Primary_colors.Color3),
                                                                  ),
                                                                  onPressed: () {},
                                                                  child: const Text(
                                                                    'Quotation',
                                                                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 10),
                                                                ElevatedButton(
                                                                  style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Primary_colors.Color3)),
                                                                  onPressed: () {},
                                                                  child: const Text(
                                                                    'Revised Quotation',
                                                                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 10),
                                                                ElevatedButton(
                                                                  style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Primary_colors.Color3)),
                                                                  onPressed: () {
                                                                    _generate_invoice(context);
                                                                  },
                                                                  child: const Text(
                                                                    'Generate Invoice',
                                                                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 10),
                                                                ElevatedButton(
                                                                  style: const ButtonStyle(
                                                                    backgroundColor: WidgetStatePropertyAll(Primary_colors.Color3),
                                                                  ),
                                                                  onPressed: () {},
                                                                  child: const Text(
                                                                    'Purchase Order',
                                                                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 10),
                                                                ElevatedButton(
                                                                  style: const ButtonStyle(
                                                                    backgroundColor: WidgetStatePropertyAll(Primary_colors.Color3),
                                                                  ),
                                                                  onPressed: () {},
                                                                  child: const Text(
                                                                    'Delivery Challan',
                                                                    style: TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 13, color: Colors.white),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(1),
                                      filled: true,
                                      fillColor: Primary_colors.Light,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.black)),
                                      hintStyle: const TextStyle(
                                        fontSize: Primary_font_size.Text7,
                                        color: Color.fromARGB(255, 167, 165, 165),
                                      ),
                                      hintText: 'Search Vendor from the list',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  size: 30,
                                  Icons.notifications,
                                  color: Colors.amber,
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  size: 30,
                                  Icons.filter_alt,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                onPressed: () {
                                  Add_vendor_popup(context);
                                },
                                icon: const Icon(
                                  size: 30,
                                  Icons.add,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final Vendor = items[index]['name'];
                                return _buildVendorCard(Vendor, index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVendorCard(String Vendor, int index) {
    return Card(
      color: showcustomerprocess == index ? Primary_colors.Color3 : Primary_colors.Light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      child: ListTile(
        leading: Icon(
          Icons.store,
          color: showcustomerprocess == index ? Colors.white : const Color.fromARGB(255, 143, 142, 142),
          size: 25,
        ),
        title: Text(
          Vendor,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7, fontWeight: FontWeight.w500),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 15,
        ),
        onTap: () {
          setState(
            () {
              showcustomerprocess = index;
            },
          );
          // Implement Vendor details or actions here
        },
      ),
    );
  }
}

class generateinvoice_popup extends StatefulWidget {
  const generateinvoice_popup({super.key});
  static late dynamic Function() callback;

  @override
  State<generateinvoice_popup> createState() => generateinvoice_popupState();
}

class generateinvoice_popupState extends State<generateinvoice_popup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  File _selectedPdf = File('\\\\192.168.0.198\\backup\\Hari\\invoice.pdf');
  static bool isloading = false;
  // Function to pick PDF
  TextEditingController file_path_Controller = TextEditingController();
  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedPdf = File(result.files.single.path!);
        if (kDebugMode) {
          print(File(result.files.single.path!));
        }
        file_path_Controller = TextEditingController(text: path.absolute(_selectedPdf.toString()));
      });
    }
  }

  // Function to show PDF in readable size
  void _showReadablePdf() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20), // Adjust padding to keep it from being full screen
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35, // 85% of screen width
          height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
          child: SfPdfViewer.file(_selectedPdf),
        ),
      ),
    );
  }

  Future<void> printPdf() async {
    if (kDebugMode) {
      print('Selected PDF Path: $_selectedPdf');
    }

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdfBytes = await _selectedPdf.readAsBytes();
          return pdfBytes;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error printing PDF: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    file_path_Controller = TextEditingController(text: path.absolute(_selectedPdf.toString()));
    isloading = false;
    generateinvoice_popup.callback = update;
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat the animation with reverse

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    // update();
  }

  void update() async {
    // await quotationmain();
    setState(
      () {
        isloading = true;
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    file_path_Controller.dispose(); // Dispose of the text controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 930,
      height: 600,
      child: Stack(
        children: [
          Row(
            children: [
              isloading
                  ? Expanded(
                      child: GestureDetector(
                        child: Stack(
                          children: [
                            SfPdfViewer.file(_selectedPdf),
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(255, 184, 184, 184).withOpacity(0.8), // Shadow color
                                        spreadRadius: 1, // Spread radius of the shadow
                                        blurRadius: 5, // Blur radius of the shadow
                                        offset: const Offset(0, 3), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: () {
                                      printPdf();
                                    },
                                    icon: const Icon(Icons.print, color: Color.fromARGB(255, 58, 58, 58)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        onDoubleTap: () {
                          _showReadablePdf();
                        },
                      ),
                    )
                  : Expanded(
                      child: Stack(
                        children: [
                          // Add your PDF content or placeholder here
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white, // Add background color if needed
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 51, 164, 234).withOpacity(0.9), // Shadow color with opacity
                                    spreadRadius: 5, // How much the shadow spreads
                                    blurRadius: 7, // How blurry the shadow looks
                                    offset: const Offset(0, 3), // Shadow position (x, y)
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // Adjust blur intensity
                                  child: Image.asset(
                                    'assets/images/img.png',
                                    fit: BoxFit.fill, // Scales the image
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Positioned(
                                top: (590) * _animation.value, // Adjust top position
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: 5, // Height of the scan line
                                    color: Colors.red.withOpacity(0.5), // Adjust opacity as needed
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Invoice',
                          style: TextStyle(fontSize: 20, color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'File Name             :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          path.basename(_selectedPdf.toString()),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Phone Number   :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13, color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(1),
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                                hintStyle: const TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                hintText: 'Phone number',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.phone, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Email ID                 :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13, color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(1),
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                                hintStyle: const TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                hintText: 'Enter Email',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.email, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Change File         :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       _pickPdf();
                        //     },
                        //     child: const Text('choose file'))
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              showCursor: true,
                              readOnly: true,
                              style: const TextStyle(fontSize: 13, color: Primary_colors.Color1),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(13),
                                labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Primary_colors.Color1),
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue),
                                    width: 80,
                                    child: TextButton(
                                      onPressed: () {
                                        _pickPdf();
                                      },
                                      child: const Text(
                                        'Choose',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.file_open, color: Colors.white),
                              ),
                              controller: file_path_Controller,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Custome Note    :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13, color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(1),
                                filled: true,
                                fillColor: Primary_colors.Dark,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                                hintStyle: const TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 167, 165, 165),
                                ),
                                hintText: 'Custome Notes',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.note_add, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Share File              :',
                          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 213, 211, 211), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                iconSize: 30,
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/images/whatsapp.png',
                                ),
                              ),
                              const SizedBox(width: 20),
                              IconButton(iconSize: 35, onPressed: () {}, icon: Image.asset('assets/images/gmail.png'))
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 80,
                      child: TextField(
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        maxLines: 5,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                          labelText: 'Enter your feedback',
                          labelStyle: const TextStyle(color: Color.fromARGB(255, 126, 126, 125), fontSize: 13),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );
  }
}
