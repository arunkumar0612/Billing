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

class LedgerDetails {
  final String date;
  final String voucherNo;
  final String description;
  final String debit;
  final String credit;
  final String balance;
  final String invoiceNo;

  LedgerDetails({
    required this.date,
    required this.voucherNo,
    required this.description,
    required this.debit,
    required this.credit,
    required this.balance,
    required this.invoiceNo,
  });

  factory LedgerDetails.fromJson(Map<String, dynamic> json) {
    return LedgerDetails(
      date: json['date'],
      voucherNo: json['voucherNo'],
      description: json['description'],
      debit: json['debit'],
      credit: json['credit'],
      balance: json['balance'],
      invoiceNo: json['invoiceNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'voucherNo': voucherNo,
      'description': description,
      'debit': debit,
      'credit': credit,
      'balance': balance,
      'invoiceNo': invoiceNo
    };
  }
}

class ClientLedger {
  final ClientDetails clientDetails;
  final List<LedgerDetails> ledgerDetails;

  ClientLedger({
    required this.clientDetails,
    required this.ledgerDetails,
  });

  factory ClientLedger.fromJson(Map<String, dynamic> json) {
    return ClientLedger(
      clientDetails: ClientDetails.fromJson(json['clientDetails']),
      ledgerDetails:json['ledgerDetails'] 
         
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientDetails': clientDetails.toJson(),
      'ledgerDetails': ledgerDetails.map((ledger) => ledger.toJson()).toList(),
    };
  }
}