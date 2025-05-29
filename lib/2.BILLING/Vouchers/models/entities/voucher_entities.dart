import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class InvoicePaymentVoucher {
  int voucher_id;
  String invoiceNumber;
  String voucherType;
  String emailId;
  String phoneNumber;
  String clientName;
  String clientAddress;
  double pendingAmount;
  int fullyCleared;
  int partiallyCleared;
  String gstNumber;
  double totalAmount;
  double subTotal;
  double igst;
  double cgst;
  double sgst;
  String voucherNumber;
  String invoiceType;
  String customerId;
  int tdsCalculation;
  double tdsCalculationAmount;
  DateTime? date;
  List<TransactionDetail>? paymentDetails;

  /// ✅ Newly added fields
  DateTime? dueDate;
  int? overdueDays;
  List<OverdueHistory>? overdueHistory;

  InvoicePaymentVoucher({
    required this.voucher_id,
    required this.invoiceNumber,
    required this.voucherType,
    required this.emailId,
    required this.phoneNumber,
    required this.clientName,
    required this.clientAddress,
    required this.pendingAmount,
    required this.fullyCleared,
    required this.partiallyCleared,
    required this.gstNumber,
    required this.totalAmount,
    required this.subTotal,
    required this.igst,
    required this.cgst,
    required this.sgst,
    required this.voucherNumber,
    required this.invoiceType,
    required this.customerId,
    required this.tdsCalculation,
    required this.tdsCalculationAmount,
    required this.date,
    this.paymentDetails,
    this.dueDate,
    this.overdueDays,
    this.overdueHistory,
  });

  factory InvoicePaymentVoucher.fromJson(Map<String, dynamic> json) {
    return InvoicePaymentVoucher(
      voucher_id: json['voucher_id'] ?? 0,
      invoiceNumber: json['invoice_number'] ?? '',
      voucherType: json['voucher_type'] ?? '',
      emailId: json['email_id'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      clientName: json['client_name'] ?? '',
      clientAddress: json['client_address'] ?? '',
      pendingAmount: (json['pending_amount'] ?? 0).roundToDouble(),
      fullyCleared: json['fully_cleared'] ?? 0,
      partiallyCleared: json['partially_cleared'] ?? 0,
      gstNumber: json['gstnumber'] ?? '',
      totalAmount: (json['Total_amount'] ?? 0).roundToDouble(),
      subTotal: (json['sub_total'] ?? 0).roundToDouble(),
      igst: (json['IGST'] ?? 0).roundToDouble(),
      cgst: (json['CGST'] ?? 0).roundToDouble(),
      sgst: (json['SGST'] ?? 0).roundToDouble(),
      voucherNumber: json['voucher_number'] ?? '',
      invoiceType: json['invoice_type'] ?? '',
      customerId: json['customer_id']?.toString() ?? '',
      tdsCalculation: (json['tds_calculation'] ?? 0),
      tdsCalculationAmount: (json['tdscalculation_amount'] ?? 0).roundToDouble(),
      date: DateTime.tryParse(json['date'] ?? ''),

      /// ✅ Parse new fields
      dueDate: json['Due_date'] != null ? DateTime.tryParse(json['Due_date']) : null,
      overdueDays: json['Overdue_days'],
      overdueHistory: json['Overdue_history'] != null ? List<OverdueHistory>.from(json['Overdue_history'].map((e) => OverdueHistory.fromJson(e))) : null,
      paymentDetails: json['payment_details'] != null ? List<TransactionDetail>.from(json['payment_details'].map((item) => TransactionDetail.fromJson(item))) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucher_id': voucher_id,
      'invoice_number': invoiceNumber,
      'voucher_type': voucherType,
      'email_id': emailId,
      'phone_number': phoneNumber,
      'client_name': clientName,
      'client_address': clientAddress,
      'pending_amount': pendingAmount,
      'fully_cleared': fullyCleared,
      'partially_cleared': partiallyCleared,
      'gstnumber': gstNumber,
      'Total_amount': totalAmount,
      'sub_total': subTotal,
      'IGST': igst,
      'CGST': cgst,
      'SGST': sgst,
      'voucher_number': voucherNumber,
      'invoice_type': invoiceType,
      'customer_id': customerId,
      'tds_calculation': tdsCalculation,
      'tdscalculation_amount': tdsCalculationAmount,
      'date': date?.toIso8601String(),
      'due_date': dueDate?.toIso8601String(),
      'Overdue_days': overdueDays,
      'Overdue_history': overdueHistory?.map((e) => e.toJson()).toList(),
      'payment_details': paymentDetails?.map((e) => e.toJson()).toList(),
    };
  }
}

class OverdueHistory {
  final String date;
  final String feedback;

  OverdueHistory({required this.date, required this.feedback});

  factory OverdueHistory.fromJson(Map<String, dynamic> json) {
    return OverdueHistory(
      date: json['date'] ?? '',
      feedback: json['feedback'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'feedback': feedback,
    };
  }
}

class TransactionDetail {
  final DateTime date;
  final double amount;
  final String feedback;
  final int transactionId;
  final String transanctionDetails;

  TransactionDetail({
    required this.date,
    required this.amount,
    required this.feedback,
    required this.transactionId,
    required this.transanctionDetails,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    return TransactionDetail(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      amount: (json['amount'] ?? 0).toDouble(),
      feedback: json['feedback'] ?? '',
      transactionId: json['transactionid'] ?? 0,
      transanctionDetails: json['transanctiondetails'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'amount': amount,
      'feedback': feedback,
      'transactionid': transactionId,
      'transanctiondetails': transanctionDetails,
    };
  }
}

class ClearVoucher {
  final DateTime date;
  final int voucherId;
  final String voucherNumber;
  final String paymentStatus;
  final double igst;
  final double sgst;
  final double cgst;
  final double tds;
  final double grossAmount;
  final double subtotal;
  final double paidAmount;
  final String clientAddressName;
  final String clientAddress;
  final String invoiceNumber;
  final String emailId;
  final String phoneNo;
  final bool tdsStatus;
  final String invoiceType;
  final String gstNumber;
  final String feedback;
  final String transactionDetails;
  final DateTime invoiceDate;

  ClearVoucher({
    required this.date,
    required this.voucherId,
    required this.voucherNumber,
    required this.paymentStatus,
    required this.igst,
    required this.sgst,
    required this.cgst,
    required this.tds,
    required this.grossAmount,
    required this.subtotal,
    required this.paidAmount,
    required this.clientAddressName,
    required this.clientAddress,
    required this.invoiceNumber,
    required this.emailId,
    required this.phoneNo,
    required this.tdsStatus,
    required this.invoiceType,
    required this.gstNumber,
    required this.feedback,
    required this.transactionDetails,
    required this.invoiceDate,
  });

  factory ClearVoucher.fromJson(Map<String, dynamic> json) {
    return ClearVoucher(
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
        voucherId: json['voucherid'] ?? 0,
        voucherNumber: json['vouchernumber'] ?? '',
        paymentStatus: json['paymentstatus'] ?? '',
        igst: (json['IGST'] ?? 0).toDouble(),
        sgst: (json['SGST'] ?? 0).toDouble(),
        cgst: (json['CGST'] ?? 0).toDouble(),
        tds: (json['tds'] ?? 0).toDouble(),
        grossAmount: (json['grossamount'] ?? 0).toDouble(),
        subtotal: (json['subtotal'] ?? 0).toDouble(),
        paidAmount: (json['paidamount'] ?? 0).toDouble(),
        clientAddressName: json['clientaddressname'] ?? '',
        clientAddress: json['clientaddress'] ?? '',
        invoiceNumber: json['invoicenumber'] ?? '',
        emailId: json['emailid'] ?? '',
        phoneNo: json['phoneno'] ?? '',
        tdsStatus: json['tdsstatus'] ?? false,
        invoiceType: json['invoicetype'] ?? '',
        gstNumber: json['gstnumber'] ?? '',
        feedback: json['feedback'] ?? '',
        transactionDetails: json['transactiondetails'] ?? '',
        invoiceDate: DateTime.tryParse(json['invoicedate'] ?? '') ?? DateTime.now());
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'voucherid': voucherId,
      'vouchernumber': voucherNumber,
      'paymentstatus': paymentStatus,
      'IGST': igst,
      'SGST': sgst,
      'CGST': cgst,
      'tds': tds,
      'grossamount': grossAmount,
      'subtotal': subtotal,
      'paidamount': paidAmount,
      'clientaddressname': clientAddressName,
      'clientaddress': clientAddress,
      'invoicenumber': invoiceNumber,
      'emailid': emailId,
      'phoneno': phoneNo,
      'tdsstatus': tdsStatus,
      'invoicetype': invoiceType,
      'gstnumber': gstNumber,
      'feedback': feedback,
      'transactiondetails': transactionDetails,
      'invoicedate': invoiceDate,
    };
  }
}

class InvoiceDetails {
  final String invoiceNumber;
  final DateTime invoiceDate;

  InvoiceDetails({
    required this.invoiceNumber,
    required this.invoiceDate,
  });

  factory InvoiceDetails.fromMap(Map<String, dynamic> map) {
    return InvoiceDetails(invoiceNumber: map['invoicenumber'], invoiceDate: map['invoicedate']);
  }

  Map<String, dynamic> toMap() {
    return {
      'invoicenumber': invoiceNumber,
      'invoicedate': invoiceDate,
    };
  }
}

class Clear_ClubVoucher {
  final DateTime date;
  final double totalPaidAmount;
  final bool tdsStatus;
  final String paymentStatus;
  final String feedback;
  final String transactionDetails;
  final List<int> voucherIds;
  final List<String> voucherNumbers;
  final List<Map<String, dynamic>> voucherList;
  final List<String> invoiceNumbers;
  final String clientAddressName;
  final String clientAddress;
  final DateTime invoiceDate;
  final List<InvoiceDetails> invoicedetails;
  final double grossAmount;
  final SelectedInvoiceVoucherGroup selectedInvoiceGroup;

  Clear_ClubVoucher({
    required this.date,
    required this.totalPaidAmount,
    required this.tdsStatus,
    required this.paymentStatus,
    required this.feedback,
    required this.transactionDetails,
    required this.voucherIds,
    required this.voucherNumbers,
    required this.voucherList,
    required this.invoiceNumbers,
    required this.clientAddressName,
    required this.clientAddress,
    required this.invoiceDate,
    required this.invoicedetails,
    required this.grossAmount,
    required this.selectedInvoiceGroup,
  });

  factory Clear_ClubVoucher.fromJson(Map<String, dynamic> json) {
    return Clear_ClubVoucher(
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      totalPaidAmount: (json['totalpaidamount'] ?? 0).toDouble(),
      tdsStatus: json['tdsstatus'] ?? false,
      paymentStatus: json['paymentstatus'] ?? '',
      feedback: json['feedback'] ?? '',
      transactionDetails: json['transactiondetails'] ?? '',
      voucherIds: json['voucherids'] ?? '',
      voucherNumbers: json['vouchernumbers'] ?? '',
      voucherList: (json['voucherlist'] as List<dynamic>).map((item) => Map<String, dynamic>.from(item)).toList(),
      invoiceNumbers: json['invoicenumbers'] ?? '',
      clientAddressName: json['clientaddressname'] ?? '',
      clientAddress: json['clientaddress'] ?? '',
      invoiceDate: DateTime.tryParse(json['invoicedate'] ?? '') ?? DateTime.now(),
      invoicedetails: (json['invoicedetails'] as List<dynamic>?)?.map((item) => InvoiceDetails.fromMap(item)).toList() ?? [],
      grossAmount: (json['grossamount'] ?? 0).toDouble(),
      selectedInvoiceGroup: SelectedInvoiceVoucherGroup.fromJson(json['selectedinvoicegroup']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'totalpaidamount': totalPaidAmount,
      'tdsstatus': tdsStatus,
      'paymentstatus': paymentStatus,
      'feedback': feedback,
      'transactiondetails': transactionDetails,
      'voucherlist': voucherList,
      "voucherids": voucherIds,
      "vouchernumbers": voucherNumbers,
      'invoicenumbers': invoiceNumbers,
      'clientaddressname': clientAddressName,
      'clientaddress': clientAddress,
      'invoicedate': invoiceDate,
      'invoicedetails': invoicedetails.map((e) => e.toMap()).toList(),
      'grossamount': grossAmount,
      'selectedinvoicegroup': selectedInvoiceGroup,
    };
  }
}

class SelectedInvoiceVoucherGroup {
  List<InvoicePaymentVoucher> selectedVoucherList;
  double totalPendingAmount_withoutTDS;
  double totalPendingAmount_withTDS;
  double netAmount;
  double totalCGST;
  double totalSGST;
  double totalIGST;
  double totalTDS;

  SelectedInvoiceVoucherGroup({
    required this.selectedVoucherList,
    required this.totalPendingAmount_withoutTDS,
    required this.totalPendingAmount_withTDS,
    required this.netAmount,
    required this.totalCGST,
    required this.totalSGST,
    required this.totalIGST,
    required this.totalTDS,
  });

  factory SelectedInvoiceVoucherGroup.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['selected_voucher_list'] ?? [];
    List<InvoicePaymentVoucher> vouchers = list.map((e) => InvoicePaymentVoucher.fromJson(e)).toList();

    double pending_withoutTDS = vouchers.fold(0, (sum, v) => sum + v.pendingAmount);
    double pending_withTDS = vouchers.fold<double>(0.0, (sum, v) => sum + v.pendingAmount) - vouchers.fold<double>(0.0, (sum, v) => sum + v.tdsCalculationAmount);
    double netAmount = vouchers.fold(0, (sum, v) => sum + v.subTotal);
    double cgst = vouchers.fold(0, (sum, v) => sum + v.cgst);
    double sgst = vouchers.fold(0, (sum, v) => sum + v.sgst);
    double igst = vouchers.fold(0, (sum, v) => sum + v.igst);
    double tds = vouchers.fold(0, (sum, v) => sum + v.tdsCalculationAmount);

    return SelectedInvoiceVoucherGroup(
      selectedVoucherList: vouchers,
      totalPendingAmount_withoutTDS: pending_withoutTDS,
      totalPendingAmount_withTDS: pending_withTDS,
      netAmount: netAmount,
      totalCGST: cgst,
      totalSGST: sgst,
      totalIGST: igst,
      totalTDS: tds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selected_voucher_list': selectedVoucherList.map((e) => e.toJson()).toList(),
      'total_pending_amount_withoutTDS': totalPendingAmount_withoutTDS,
      'total_pending_amount_withTDS': totalPendingAmount_withTDS,
      'netAmount': netAmount,
      'total_CGST': totalCGST,
      'total_SGST': totalSGST,
      'total_IGST': totalIGST,
      'total_TDS': totalTDS,
    };
  }
}

class PDFfileData {
  final File data;

  PDFfileData({
    required this.data,
  });

  static Future<File> saveBytesToFile(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory(); // Get temporary directory
    final file = File('${tempDir.path}/temp.pdf'); // Define file path
    await file.writeAsBytes(bytes); // Write bytes to file
    return file;
  }

  static Future<PDFfileData> fromJson(CMDmResponse json) async {
    if (json.data['data'] is List<dynamic>) {
      Uint8List fileBytes = Uint8List.fromList(json.data['data'].cast<int>());
      File file = await saveBytesToFile(fileBytes);
      return PDFfileData(data: file);
    }
    throw TypeError();
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.path, // Convert File to path string for JSON
    };
  }
}

// Dummy timeline data model
class TimelineEntry {
  final String heading;
  final String subHeading;
  final String date;
  final String feedback;

  TimelineEntry({
    required this.heading,
    required this.subHeading,
    required this.date,
    required this.feedback,
  });
}

// Sample data list
final List<TimelineEntry> timelineData = [
  TimelineEntry(
    heading: 'Initial Contact',
    subHeading: 'Reached out via phone',
    date: '2025-05-21',
    feedback: 'Client was interested',
  ),
  TimelineEntry(
    heading: 'Follow-up',
    subHeading: 'Sent quotation',
    date: '2025-05-22',
    feedback: 'Waiting for response',
  ),
  TimelineEntry(
    heading: 'Final Review',
    subHeading: 'Negotiated pricing',
    date: '2025-05-23',
    feedback: 'Deal confirmed',
  ),
];
