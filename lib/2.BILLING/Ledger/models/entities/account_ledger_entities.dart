// class AccountLedger {
//   DateTime date;
//   String voucherNo;
//   String invoiceNo;
//   String gstNo;
//   String clientName;
//   String ledgerType;
//   Description description;
//   String transactionDetails;
//   AmountDetails debit;
//   AmountDetails credit;
//   double balance;

//   AccountLedger({
//     required this.date,
//     required this.voucherNo,
//     required this.invoiceNo,
//     required this.gstNo,
//     required this.clientName,
//     required this.ledgerType,
//     required this.description,
//     required this.transactionDetails,
//     required this.debit,
//     required this.credit,
//     required this.balance,
//   });

//   factory AccountLedger.fromJson(Map<String, dynamic> json) {
//     return AccountLedger(
//       date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
//       voucherNo: json['voucher_no'] ?? '',
//       invoiceNo: json['invoice_no'] ?? '',
//       gstNo: json['gst_no'] ?? '',
//       clientName: json['client_name'] ?? '',
//       ledgerType: json['ledger_type'] ?? '',
//       description: Description.fromJson(json['description'] ?? {}),
//       transactionDetails: json['transaction_details'] ?? '',
//       debit: AmountDetails.fromJson(json['debit'] ?? {}),
//       credit: AmountDetails.fromJson(json['credit'] ?? {}),
//       balance: (json['balance'] ?? 0).toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'date': date.toIso8601String(),
//         'voucher_no': voucherNo,
//         'invoice_no': invoiceNo,
//         'gst_no': gstNo,
//         'client_name': clientName,
//         'ledger_type': ledgerType,
//         'description': description.toJson(),
//         'transaction_details': transactionDetails,
//         'debit': debit.toJson(),
//         'credit': credit.toJson(),
//         'balance': balance,
//       };
// }

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

  AccountLedgerSummary({
    required this.ledgerList,
    required this.creditAmount,
    required this.debitAmount,
    required this.balanceAmount,
  });

  factory AccountLedgerSummary.fromJson(Map<String, dynamic> json) {
    return AccountLedgerSummary(
      ledgerList: (json['ledgerlist'] as List<dynamic>).map((e) => AccountLedger.fromJson(e)).toList(),
      creditAmount: (json['creditAmount'] ?? 0).toDouble(),
      debitAmount: (json['debitAmount'] ?? 0).toDouble(),
      balanceAmount: (json['balanceAmount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ledgerlist': ledgerList.map((e) => e.toJson()).toList(),
      'creditAmount': creditAmount,
      'debitAmount': debitAmount,
      'balanceAmount': balanceAmount,
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
      updatedDate: DateTime.parse(json['date)'] ?? DateTime.now().toIso8601String()),
      debitAmount: (json['debitamount'] ?? 0).toDouble(),
      creditAmount: (json['creditamount'] ?? 0).toDouble(),
      billDetails: BillDetails.fromJson(json['billdetails'] ?? {}),
      balance: (json['balance'] ?? 0).toDouble(),
      description: json['description'] ?? "-",
      Payment_details: json['Payment_details'] != null ? PaymentDetails.fromJson(json['Payment_details']) : null,
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
      total: json['total'].toDouble() ?? 0.0,
      subtotal: json['subtotal'].toDouble() ?? 0.0,
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
