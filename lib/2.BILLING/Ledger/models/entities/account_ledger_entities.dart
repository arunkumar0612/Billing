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

class AccountLedger {
  final int clientLedgerId;
  final int voucherId;
  final String voucherNumber;
  final String clientName;
  final double igst;
  final double cgst;
  final double sgst;
  final double totalAmount;
  final double subTotal;
  final double tdsAmount;
  final String gstNumber;
  final String invoiceNumber;
  final String ledgerType;
  final DateTime updatedDate;
  final double debitAmount;
  final double creditAmount;
  final Map<String, dynamic> billDetails;
  final double netAmount;

  AccountLedger({
    required this.clientLedgerId,
    required this.voucherId,
    required this.voucherNumber,
    required this.clientName,
    required this.igst,
    required this.cgst,
    required this.sgst,
    required this.totalAmount,
    required this.subTotal,
    required this.tdsAmount,
    required this.gstNumber,
    required this.invoiceNumber,
    required this.ledgerType,
    required this.updatedDate,
    required this.debitAmount,
    required this.creditAmount,
    required this.billDetails,
    required this.netAmount,
  });

  factory AccountLedger.fromJson(Map<String, dynamic> json) {
    return AccountLedger(
      clientLedgerId: json['clientledger_id'] ?? 0,
      voucherId: json['voucher_id'] ?? 0,
      voucherNumber: json['voucher_number'] ?? '',
      clientName: json['client_name'] ?? '',
      igst: (json['IGST'] ?? 0).toDouble(),
      cgst: (json['CGST'] ?? 0).toDouble(),
      sgst: (json['SGST'] ?? 0).toDouble(),
      totalAmount: (json['totalamount'] ?? 0).toDouble(),
      subTotal: (json['subtotal'] ?? 0).toDouble(),
      tdsAmount: (json['tdsamount'] ?? 0).toDouble(),
      gstNumber: json['gst_number'] ?? '',
      invoiceNumber: json['invoicenumber'] ?? '',
      ledgerType: json['ledger_type'] ?? '',
      updatedDate: DateTime.parse(json['DATE(Row_updated_date)'] ?? DateTime.now().toIso8601String()),
      debitAmount: (json['debitamount'] ?? 0).toDouble(),
      creditAmount: (json['creditamount'] ?? 0).toDouble(),
      billDetails: Map<String, dynamic>.from(json['billdetails'] ?? {}),
      netAmount: (json['netamount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientledger_id': clientLedgerId,
      'voucher_id': voucherId,
      'voucher_number': voucherNumber,
      'client_name': clientName,
      'IGST': igst,
      'CGST': cgst,
      'SGST': sgst,
      'totalamount': totalAmount,
      'subtotal': subTotal,
      'tdsamount': tdsAmount,
      'gst_number': gstNumber,
      'invoicenumber': invoiceNumber,
      'ledger_type': ledgerType,
      'DATE(Row_updated_date)': updatedDate.toIso8601String(),
      'debitamount': debitAmount,
      'creditamount': creditAmount,
      'billdetails': billDetails,
      'netamount': netAmount,
    };
  }
}
