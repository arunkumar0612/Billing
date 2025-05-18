
import 'package:intl/intl.dart';

class SummaryDetails {

  final String category;
  final String CGST;
  final String SGST;
  final String IGST;
  final String totalGST;
 
  SummaryDetails({
    required this.category,
    required this.CGST,
    required this.SGST,
    required this.IGST,
    required this.totalGST,
  });

  factory SummaryDetails.fromJson(Map<String, dynamic> json) {
    return SummaryDetails(
      category: json['category'],
      CGST: json['CGST']?? '0',
      SGST: json['SGST']?? '0',
      IGST: json['IGST']?? '0',
      totalGST: json['totalGST']?? '0',
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'CGST': CGST,
      'SGST': SGST,
      'IGST': IGST,
      'totalGST': totalGST
    };
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
      logDate:DateFormat('dd-MM-yyyy').parse(json['logDate']),
      invoiceNo: json['invoiceNo'],
      particulars: json['particulars'],
      GSTtype: json['GSTtype'],
      taxValue: json['taxValue'],
      CGST: json['CGST']?? '0',
      SGST: json['SGST']?? '0',
      IGST: json['IGST'] ?? '0',
      totalGST: json['totalGST'] ?? '0',
      grossAmount: json['grossAmount']?? '0',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logDate':DateFormat('dd-MM-yyyy').format(logDate),
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

class GSTledger {
  final DateTime fromDate;
  final DateTime toDate;
  final List<SummaryDetails> summaryDetails;
  final List<GSTlogDetails> gstLogDetails;

  GSTledger({
    required this.fromDate,
    required this.toDate,
    required this.summaryDetails,
    required this.gstLogDetails,
  });

  factory GSTledger.fromJson(Map<String, dynamic> json) {
  return GSTledger(
    fromDate: DateFormat('dd-MM-yyyy').parse(json['fromDate']),
    toDate: DateFormat('dd-MM-yyyy').parse(json['toDate']),
    summaryDetails: (json['summaryDetails'] as List<dynamic>?)?.map((item) => SummaryDetails.fromJson(item)).toList() ??[],
    gstLogDetails: (json['GSTlogDetails'] as List<dynamic>?)?.map((item) => GSTlogDetails.fromJson(item)).toList() ??[],
  );
}


  Map<String, dynamic> toJson() {
    return {
      'fromDate':DateFormat('dd-MM-yyyy').format(fromDate),
      'toDate':   DateFormat('dd-MM-yyyy').format(toDate),
      'summaryDetails': summaryDetails.map((e)=> e.toJson()).toList() , 
      'GSTlogDetails': gstLogDetails.map((ledger) => ledger.toJson()).toList(),
    };
  }
}
