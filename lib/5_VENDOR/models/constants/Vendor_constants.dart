import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssipl_billing/5_VENDOR/models/entities/Vendor_entities.dart';

class VendorModel extends GetxController with GetSingleTickerProviderStateMixin {
 var vendorList = <Vendor>[
  Vendor(vendorId: 1, vendorName: 'John Doe', ccode: 'C001', subRequirementId: 'SUB1001'),
  Vendor(vendorId: 2, vendorName: 'Jane Smith', ccode: 'C002', subRequirementId: 'SUB1002'),
  Vendor(vendorId: 3, vendorName: 'Michael Johnson', ccode: 'C003', subRequirementId: 'SUB1003'),
  Vendor(vendorId: 4, vendorName: 'Emily Davis', ccode: 'C004', subRequirementId: 'SUB1004'),
  Vendor(vendorId: 5, vendorName: 'Chris Brown', ccode: 'C005', subRequirementId: 'SUB1005'),
  Vendor(vendorId: 6, vendorName: 'Olivia Wilson', ccode: 'C006', subRequirementId: 'SUB1006'),
  Vendor(vendorId: 7, vendorName: 'David Lee', ccode: 'C007', subRequirementId: 'SUB1007'),
  Vendor(vendorId: 8, vendorName: 'Sophia Martinez', ccode: 'C008', subRequirementId: 'SUB1008'),
  Vendor(vendorId: 9, vendorName: 'Daniel Anderson', ccode: 'C009', subRequirementId: 'SUB1009'),
  Vendor(vendorId: 10, vendorName: 'Emma Thomas', ccode: 'C010', subRequirementId: 'SUB1010'),
].obs;
 var processvendorList = <Processvendor>[
  Processvendor(
    vendorId: 1,
    vendorName: 'John Doe',
    vendor_phoneno: '9876543210',
    vendor_gstno: 'GSTIN001JD',
  ),
  Processvendor(
    vendorId: 2,
    vendorName: 'Jane Smith',
    vendor_phoneno: '9123456780',
    vendor_gstno: 'GSTIN002JS',
  ),
  Processvendor(
    vendorId: 3,
    vendorName: 'Michael Brown',
    vendor_phoneno: '9988776655',
    vendor_gstno: 'GSTIN003MB',
  ),
  Processvendor(
    vendorId: 4,
    vendorName: 'Emily Davis',
    vendor_phoneno: '9090909090',
    vendor_gstno: 'GSTIN004ED',
  ),
  Processvendor(
    vendorId: 5,
    vendorName: 'David Wilson',
    vendor_phoneno: '9001234567',
    vendor_gstno: 'GSTIN005DW',
  ),
  Processvendor(
    vendorId: 6,
    vendorName: 'Sophia Taylor',
    vendor_phoneno: '8904567890',
    vendor_gstno: 'GSTIN006ST',
  ),
  Processvendor(
    vendorId: 7,
    vendorName: 'Chris Martin',
    vendor_phoneno: '8800123456',
    vendor_gstno: 'GSTIN007CM',
  ),
  Processvendor(
    vendorId: 8,
    vendorName: 'Olivia Thomas',
    vendor_phoneno: '8700987654',
    vendor_gstno: 'GSTIN008OT',
  ),
  Processvendor(
    vendorId: 9,
    vendorName: 'Daniel Lee',
    vendor_phoneno: '8600765432',
    vendor_gstno: 'GSTIN009DL',
  ),
  Processvendor(
    vendorId: 10,
    vendorName: 'Emma Clark',
    vendor_phoneno: '8500345678',
    vendor_gstno: 'GSTIN010EC',
  ),
].obs;


var processList = <Process>[
  Process(
    processid: 1,
    title: 'Process A',
    vendor_name: 'John Doe',
    Process_date: '01 Jul 2025',
    age_in_days: 3,
    TimelineEvents: [
      TimelineEvent(
        pdfpath: 'assets/docs/doc1.pdf',
        feedback: TextEditingController(text: 'Initial feedback A1'),
        Eventname: 'Event Start',
        Eventid: 101,
        apporvedstatus: 1,
        internalStatus: 0,
        Allowed_process: Allowedprocess(
          rfq: true,
          invoice: false,
          quotation: true,
          debit_note: false,
          credit_note: false,
          delivery_challan: true,
          revised_quatation: false,
          get_approval: true,
        ),
      ),
    ],
  ),
  Process(
    processid: 2,
    title: 'Process B',
    vendor_name: 'Jane Smith',
    Process_date: '28 Jun 2025',
    age_in_days: 6,
    TimelineEvents: [
      TimelineEvent(
        pdfpath: 'assets/docs/doc2.pdf',
        feedback: TextEditingController(text: 'Follow-up feedback B1'),
        Eventname: 'Quotation Submitted',
        Eventid: 102,
        apporvedstatus: 0,
        internalStatus: 1,
        Allowed_process: Allowedprocess(
          rfq: true,
          invoice: true,
          quotation: false,
          debit_note: true,
          credit_note: false,
          delivery_challan: false,
          revised_quatation: false,
          get_approval: false,
        ),
      ),
      TimelineEvent(
        pdfpath: 'assets/docs/doc3.pdf',
        feedback: TextEditingController(text: 'Revised terms B2'),
        Eventname: 'Approval Pending',
        Eventid: 103,
        apporvedstatus: 0,
        internalStatus: 2,
        Allowed_process: Allowedprocess(
          rfq: false,
          invoice: false,
          quotation: true,
          debit_note: false,
          credit_note: true,
          delivery_challan: true,
          revised_quatation: true,
          get_approval: true,
        ),
      ),
    ],
  ),
  Process(
    processid: 3,
    title: 'Process C',
    vendor_name: 'David Johnson',
    Process_date: '25 Jun 2025',
    age_in_days: 9,
    TimelineEvents: [
      TimelineEvent(
        pdfpath: 'assets/docs/doc4.pdf',
        feedback: TextEditingController(text: 'Final confirmation C1'),
        Eventname: 'Invoice Generated',
        Eventid: 104,
        apporvedstatus: 1,
        internalStatus: 1,
        Allowed_process: Allowedprocess(
          rfq: false,
          invoice: true,
          quotation: false,
          debit_note: false,
          credit_note: false,
          delivery_challan: true,
          revised_quatation: false,
          get_approval: true,
        ),
      ),
    ],
  ),
].obs;

  final showvendorprocess = Rxn<int>();
  final vendorId = Rxn<int>();
  final pdfFile = Rxn<File>();

  final selectedIndices = <int>[].obs;
  final RxBool isAllSelected = false.obs;
  final type = 0.obs;
  final RxBool isprofilepage = false.obs;
  // var searchQuery = ''.obs;
  var searchQuery = "".obs;
  Rxn<Vendordata> vendordata = Rxn<Vendordata>(); // Nullable
  var vendorperiod = 'monthly'.obs;
  Rxn<Clientprofiledata> Clientprofile = Rxn<Clientprofiledata>(); // Nullable
  late AnimationController animationController;

  var whatsapp_selectionStatus = true.obs;
  var gmail_selectionStatus = true.obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final CCemailController = TextEditingController().obs;
  var feedbackController = TextEditingController().obs;
  // var filePathController = TextEditingController().obs;
  var CCemailToggle = false.obs;
}
