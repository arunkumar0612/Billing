import 'package:intl/intl.dart';
// import 'package:ssipl_billing/2_BILLING/Ledger/models/entities/GST_ledger_entities.dart';

class GSTsummaryDetails {
  final String category;
  final String CGST;
  final String SGST;
  final String IGST;
  final String totalGST;

  GSTsummaryDetails({
    required this.category,
    required this.CGST,
    required this.SGST,
    required this.IGST,
    required this.totalGST,
  });

  factory GSTsummaryDetails.fromJson(Map<String, dynamic> json) {
    return GSTsummaryDetails(
      category: json['category'],
      CGST: json['CGST'] ?? '0',
      SGST: json['SGST'] ?? '0',
      IGST: json['IGST'] ?? '0',
      totalGST: json['totalGST'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {'category': category, 'CGST': CGST, 'SGST': SGST, 'IGST': IGST, 'totalGST': totalGST};
  }
}

class GSTlogDetails {
  final DateTime logDate;
  final String invoiceNo;
  final String particulars;
  final String GSTtype;
  final String taxValue;
  final String CGST;
  final String SGST;
  final String IGST;
  final String totalGST;
  final String grossAmount;

  GSTlogDetails({
    required this.logDate,
    required this.invoiceNo,
    required this.particulars,
    required this.GSTtype,
    required this.taxValue,
    required this.CGST,
    required this.SGST,
    required this.IGST,
    required this.totalGST,
    required this.grossAmount,
  });

  factory GSTlogDetails.fromJson(Map<String, dynamic> json) {
    return GSTlogDetails(
      logDate: DateFormat('dd-MM-yyyy').parse(json['logDate']),
      invoiceNo: json['invoiceNo'],
      particulars: json['particulars'],
      GSTtype: json['GSTtype'],
      taxValue: json['taxValue'],
      CGST: json['CGST'] ?? '0',
      SGST: json['SGST'] ?? '0',
      IGST: json['IGST'] ?? '0',
      totalGST: json['totalGST'] ?? '0',
      grossAmount: json['grossAmount'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logDate': DateFormat('dd-MM-yyyy').format(logDate),
      'invoiceNo': invoiceNo,
      'particulars': particulars,
      'GSTtype': GSTtype,
      'taxValue': taxValue,
      'CGST': CGST,
      'SGST': SGST,
      'IGST': IGST,
      'totalGST': totalGST,
      'grossAmount': grossAmount
    };
  }
}
