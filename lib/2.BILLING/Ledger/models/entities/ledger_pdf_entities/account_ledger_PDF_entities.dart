import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';

class ClientDetails {
  final String clientName;
  final String clientAddress;
  final String GSTIN;
  final String PAN;
  final DateTime fromDate;
  final DateTime toDate;

  ClientDetails({
    required this.clientName,
    required this.clientAddress,
    required this.GSTIN,
    required this.PAN,
    required this.fromDate,
    required this.toDate,
  });

  factory ClientDetails.fromJson(Map<String, dynamic> json) {
    return ClientDetails(
      clientName: json['clientName'],
      clientAddress: json['clientAddress'],
      GSTIN: json['GSTIN'],
      PAN: json['PAN'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'clientAddress': clientAddress,
      'GSTIN': GSTIN,
      'PAN': PAN,
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }
}

class PDF_AccountLedgerSummary {
  final ClientDetails? clientDetails;
  final AccountLedgerSummary ledgerDetails;

  PDF_AccountLedgerSummary({
    required this.clientDetails,
    required this.ledgerDetails,
  });

  factory PDF_AccountLedgerSummary.fromJson({required ClientDetails? clientDetails, required AccountLedgerSummary ledgerDetails}) {
    return PDF_AccountLedgerSummary(
      clientDetails: clientDetails,
      ledgerDetails: ledgerDetails,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientDetails': clientDetails?.toJson(),
      'ledgerDetails': ledgerDetails.toJson(),
    };
  }
}
