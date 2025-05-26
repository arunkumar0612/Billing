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

class AccountLedgerSummary {
  final List<AccountLedger> ledgerList;
  final double creditAmount;
  final double debitAmount;
  final double balanceAmount;
  final String? startdate;
  final String? enddate;

  AccountLedgerSummary({
    required this.ledgerList,
    required this.creditAmount,
    required this.debitAmount,
    required this.balanceAmount,
    required this.startdate,
    required this.enddate,
  });

  factory AccountLedgerSummary.fromJson(Map<String, dynamic> json) {
    return AccountLedgerSummary(
        ledgerList: (json['ledgerlist'] as List<dynamic>).map((e) => AccountLedger.fromJson(e)).toList(),
        creditAmount: (json['creditAmount'] ?? 0).toDouble(),
        debitAmount: (json['debitAmount'] ?? 0).toDouble(),
        balanceAmount: (json['balanceAmount'] ?? 0).toDouble(),
        startdate: (json['startdate'] ?? DateTime.now().toString()),
        enddate: (json['enddate'] ?? DateTime.now().toString()));
  }

  Map<String, dynamic> toJson() {
    return {
      'ledgerlist': ledgerList.map((e) => e.toJson()).toList(),
      'creditAmount': creditAmount,
      'debitAmount': debitAmount,
      'balanceAmount': balanceAmount,
      'startdate': startdate,
      'enddate': enddate,
    };
  }
}

class AccountLedger {
  final int clientLedgerId;
  final int voucherId;
  final String voucherNumber;
  final String clientName;
  final double tdsAmount;
  final String gstNumber;
  final String invoiceNumber;
  final String ledgerType;
  final DateTime updatedDate;
  final double debitAmount;
  final double creditAmount;
  final String description;
  final BillDetails billDetails;
  final double balance;
  final PaymentDetails? Payment_details;
  final String invoiceType;

  AccountLedger({
    required this.clientLedgerId,
    required this.voucherId,
    required this.voucherNumber,
    required this.clientName,
    required this.tdsAmount,
    required this.gstNumber,
    required this.invoiceNumber,
    required this.ledgerType,
    required this.updatedDate,
    required this.debitAmount,
    required this.creditAmount,
    required this.billDetails,
    required this.balance,
    required this.description,
    required this.Payment_details,
    required this.invoiceType,
  });

  factory AccountLedger.fromJson(Map<String, dynamic> json) {
    return AccountLedger(
      clientLedgerId: json['clientledger_id'] ?? 0,
      voucherId: json['voucher_id'] ?? 0,
      voucherNumber: json['voucher_number'] ?? '',
      clientName: json['client_name'] ?? '',
      tdsAmount: (json['tdsamount'] ?? 0).toDouble(),
      gstNumber: json['gst_number'] ?? '',
      invoiceNumber: json['invoicenumber'] ?? '',
      ledgerType: json['ledger_type'] ?? '',
      updatedDate: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      debitAmount: (json['debitamount'] ?? 0).toDouble(),
      creditAmount: (json['creditamount'] ?? 0).toDouble(),
      billDetails: BillDetails.fromJson(json['billdetails'] ?? {}),
      balance: (json['balance'] ?? 0).toDouble(),
      description: json['description'] ?? "-",
      Payment_details: json['Payment_details'] != null ? PaymentDetails.fromJson(json['Payment_details']) : null,
      invoiceType: json['invoice_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientledger_id': clientLedgerId,
      'voucher_id': voucherId,
      'voucher_number': voucherNumber,
      'client_name': clientName,
      'tdsamount': tdsAmount,
      'gst_number': gstNumber,
      'invoicenumber': invoiceNumber,
      'ledger_type': ledgerType,
      'date': updatedDate.toIso8601String(),
      'debitamount': debitAmount,
      'creditamount': creditAmount,
      'billdetails': billDetails.toJson(),
      'balance': balance,
      'description': description,
      'Payment_details': Payment_details?.toJson(),
      'invoice_type': invoiceType
    };
  }
}

class PaymentDetails {
  final DateTime date;
  final double amount;
  final String feedback;
  final double tdsAmount;
  final String? transactionDetails;

  PaymentDetails({
    required this.date,
    required this.amount,
    required this.feedback,
    required this.tdsAmount,
    required this.transactionDetails,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      amount: (json['amount'] ?? 0).toDouble(),
      feedback: json['feedback'] ?? '',
      tdsAmount: (json['tdsamount'] ?? 0).toDouble(),
      transactionDetails: json['transanctiondetails'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'amount': amount,
      'feedback': feedback,
      'tdsamount': tdsAmount,
      'transanctiondetails': transactionDetails,
    };
  }
}

class BillDetails {
  final GST gst;
  final double total;
  final double subtotal;
  final double totalGST;

  BillDetails({
    required this.gst,
    required this.total,
    required this.subtotal,
  }) : totalGST = gst.cgst + gst.sgst + gst.igst;

  factory BillDetails.fromJson(Map<String, dynamic> json) {
    final gst = GST.fromJson(json['gst'] ?? {});
    return BillDetails(
      gst: gst,
      total: (json['total'] ?? 0).toDouble(),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gst': gst.toJson(),
      'total': total,
      'subtotal': subtotal,
      'totalGST': totalGST,
    };
  }
}

class GST {
  final double cgst;
  final double igst;
  final double sgst;

  GST({
    required this.cgst,
    required this.igst,
    required this.sgst,
  });

  factory GST.fromJson(Map<String, dynamic> json) {
    return GST(
      cgst: json['CGST'].toDouble() ?? 0.0,
      igst: json['IGST'].toDouble() ?? 0.0,
      sgst: json['SGST'].toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CGST': cgst,
      'IGST': igst,
      'SGST': sgst,
    };
  }
}

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

  factory PDF_AccountLedgerSummary.fromJson({required ClientDetails? clientDetails, required AccountLedgerSummary ledgerDetails, required fromDate, required toDate}) {
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
