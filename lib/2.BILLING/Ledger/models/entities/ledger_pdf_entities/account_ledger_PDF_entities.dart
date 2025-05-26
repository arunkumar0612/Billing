import 'dart:convert';

import 'package:ssipl_billing/2.BILLING/Ledger/models/entities/account_ledger_entities.dart';

class ClientDetails {
  final String clientName;
  final String clientAddress;
  final String GSTIN;
  final String PAN;
  

  ClientDetails({
    required this.clientName,
    required this.clientAddress,
    required this.GSTIN,
    required this.PAN,
   
  });

  factory ClientDetails.fromJson(Map<String, dynamic> json) {
    return ClientDetails(
      clientName: json['clientName'],
      clientAddress: json['clientAddress'],
      GSTIN: json['GSTIN'],
      PAN: json['PAN'],
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'clientAddress': clientAddress,
      'GSTIN': GSTIN,
      'PAN': PAN,
      
    };
  }
}

class PDF_AccountLedgerSummary {
  final ClientDetails? clientDetails;
  final AccountLedgerSummary ledgerDetails;
  final DateTime fromDate;
  final DateTime toDate;
  

  PDF_AccountLedgerSummary({
    required this.clientDetails,
    required this.ledgerDetails,
     required this.fromDate,
    required this.toDate,
  });

  factory PDF_AccountLedgerSummary.fromJson(
    {required ClientDetails? clientDetails, required AccountLedgerSummary ledgerDetails, required fromDate, required toDate}){
    return PDF_AccountLedgerSummary(
      clientDetails: clientDetails,
      ledgerDetails: ledgerDetails,
      fromDate: fromDate,
      toDate: toDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientDetails': clientDetails?.toJson(),
      'ledgerDetails': ledgerDetails.toJson(),
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }
}
