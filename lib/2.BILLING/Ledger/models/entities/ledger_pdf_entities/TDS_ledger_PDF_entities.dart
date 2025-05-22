import 'package:intl/intl.dart';

class SummaryDetails {
  final String category;
  final String CTDS;
  final String STDS;
  final String ITDS;
  final String totalTDS;

  SummaryDetails({
    required this.category,
    required this.CTDS,
    required this.STDS,
    required this.ITDS,
    required this.totalTDS,
  });

  factory SummaryDetails.fromJson(Map<String, dynamic> json) {
    return SummaryDetails(
      category: json['category'],
      CTDS: json['CTDS'] ?? '0',
      STDS: json['STDS'] ?? '0',
      ITDS: json['ITDS'] ?? '0',
      totalTDS: json['totalTDS'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {'category': category, 'CTDS': CTDS, 'STDS': STDS, 'ITDS': ITDS, 'totalTDS': totalTDS};
  }
}

class TDSlogDetails {
  final DateTime logDate;
  final String invoiceNo;
  final String particulars;
  final String TDStype;
  final String taxValue;
  final String CTDS;
  final String STDS;
  final String ITDS;
  final String totalTDS;
  final String grossAmount;

  TDSlogDetails({
    required this.logDate,
    required this.invoiceNo,
    required this.particulars,
    required this.TDStype,
    required this.taxValue,
    required this.CTDS,
    required this.STDS,
    required this.ITDS,
    required this.totalTDS,
    required this.grossAmount,
  });

  factory TDSlogDetails.fromJson(Map<String, dynamic> json) {
    return TDSlogDetails(
      logDate: DateFormat('dd-MM-yyyy').parse(json['logDate']),
      invoiceNo: json['invoiceNo'],
      particulars: json['particulars'],
      TDStype: json['TDStype'],
      taxValue: json['taxValue'],
      CTDS: json['CTDS'] ?? '0',
      STDS: json['STDS'] ?? '0',
      ITDS: json['ITDS'] ?? '0',
      totalTDS: json['totalTDS'] ?? '0',
      grossAmount: json['grossAmount'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logDate': DateFormat('dd-MM-yyyy').format(logDate),
      'invoiceNo': invoiceNo,
      'particulars': particulars,
      'TDStype': TDStype,
      'taxValue': taxValue,
      'CTDS': CTDS,
      'STDS': STDS,
      'ITDS': ITDS,
      'totalTDS': totalTDS,
      'grossAmount': grossAmount
    };
  }
}

class TDSledger {
  final DateTime fromDate;
  final DateTime toDate;
  final List<SummaryDetails> summaryDetails;
  final List<TDSlogDetails> tdsLogDetails;

  TDSledger({
    required this.fromDate,
    required this.toDate,
    required this.summaryDetails,
    required this.tdsLogDetails,
  });

  factory TDSledger.fromJson(Map<String, dynamic> json) {
    return TDSledger(
      fromDate: DateFormat('dd-MM-yyyy').parse(json['fromDate']),
      toDate: DateFormat('dd-MM-yyyy').parse(json['toDate']),
      summaryDetails: (json['summaryDetails'] as List<dynamic>?)?.map((item) => SummaryDetails.fromJson(item)).toList() ?? [],
      tdsLogDetails: (json['TDSlogDetails'] as List<dynamic>?)?.map((item) => TDSlogDetails.fromJson(item)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromDate': DateFormat('dd-MM-yyyy').format(fromDate),
      'toDate': DateFormat('dd-MM-yyyy').format(toDate),
      'summaryDetails': summaryDetails.map((e) => e.toJson()).toList(),
      'TDSlogDetails': tdsLogDetails.map((ledger) => ledger.toJson()).toList(),
    };
  }
}
