class AccountLedger {
  DateTime date;
  String voucherNo;
  String invoiceNo;
  String gstNo;
  String clientName;
  String ledgerType;
  Description description;
  String transactionDetails;
  AmountDetails debit;
  AmountDetails credit;
  double balance;

  AccountLedger({
    required this.date,
    required this.voucherNo,
    required this.invoiceNo,
    required this.gstNo,
    required this.clientName,
    required this.ledgerType,
    required this.description,
    required this.transactionDetails,
    required this.debit,
    required this.credit,
    required this.balance,
  });

  factory AccountLedger.fromJson(Map<String, dynamic> json) {
    return AccountLedger(
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      voucherNo: json['voucher_no'] ?? '',
      invoiceNo: json['invoice_no'] ?? '',
      gstNo: json['gst_no'] ?? '',
      clientName: json['client_name'] ?? '',
      ledgerType: json['ledger_type'] ?? '',
      description: Description.fromJson(json['description'] ?? {}),
      transactionDetails: json['transaction_details'] ?? '',
      debit: AmountDetails.fromJson(json['debit'] ?? {}),
      credit: AmountDetails.fromJson(json['credit'] ?? {}),
      balance: (json['balance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'voucher_no': voucherNo,
        'invoice_no': invoiceNo,
        'gst_no': gstNo,
        'client_name': clientName,
        'ledger_type': ledgerType,
        'description': description.toJson(),
        'transaction_details': transactionDetails,
        'debit': debit.toJson(),
        'credit': credit.toJson(),
        'balance': balance,
      };
}

class Description {
  String content;
  double gst;
  double tds;

  Description({
    required this.content,
    required this.gst,
    required this.tds,
  });

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      content: json['content'] ?? '',
      gst: (json['gst'] ?? 0).toDouble(),
      tds: (json['tds'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'gst': gst,
        'tds': tds,
      };
}

class AmountDetails {
  double totalAmount;
  double netAmount;
  double gstAmount;
  double tdsAmount;

  AmountDetails({
    required this.totalAmount,
    required this.netAmount,
    required this.gstAmount,
    required this.tdsAmount,
  });

  factory AmountDetails.fromJson(Map<String, dynamic> json) {
    return AmountDetails(
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      netAmount: (json['net_amount'] ?? 0).toDouble(),
      gstAmount: (json['gst_amount'] ?? 0).toDouble(),
      tdsAmount: (json['tds_amount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'total_amount': totalAmount,
        'net_amount': netAmount,
        'gst_amount': gstAmount,
        'tds_amount': tdsAmount,
      };
}
