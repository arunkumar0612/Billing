class TDSSummaryModel {
  final List<TDSEntryModel> tdsList;
  final double totalTds;
  final double totalPaid;
  final double netTdsBalance;
  final double totalReceivables;
  final double totalPayables;
  final double netTds;

  TDSSummaryModel({
    required this.tdsList,
    required this.totalTds,
    required this.totalPaid,
    required this.netTdsBalance,
    required this.totalReceivables,
    required this.totalPayables,
    required this.netTds,
  });

  factory TDSSummaryModel.fromJson(Map<String, dynamic> json) {
    return TDSSummaryModel(
      tdsList: (json['tdsledger'] as List<dynamic>).map((e) => TDSEntryModel.fromJson(e)).toList(),
      totalTds: (json['totalTds'] ?? 0).toDouble(),
      totalPaid: (json['totalPaid'] ?? 0).toDouble(),
      netTdsBalance: (json['netTdsBalance'] ?? 0).toDouble(),
      totalReceivables: (json['totalReceivables'] ?? 0).toDouble(),
      totalPayables: (json['totalPayables'] ?? 0).toDouble(),
      netTds: (json['netTds'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tdsledger': tdsList.map((e) => e.toJson()).toList(),
      'totalTds': totalTds,
      'totalPaid': totalPaid,
      'netTdsBalance': netTdsBalance,
      'totalReceivables': totalReceivables,
      'totalPayables': totalPayables,
      'netTds': netTds,
    };
  }
}

class TDSEntryModel {
  final int tdsLedgerId;
  final int voucherId;
  final String voucherNumber;
  final String invoice_number;
  final String clientName;
  final double creditAmount;
  final double debitAmount;
  final double igst;
  final double cgst;
  final double sgst;
  final double totalAmount;
  final double subtotal;
  final double tdsAmount;
  final String gstNumber;
  final String tdsType;
  final DateTime rowUpdatedDate;
  final int tdsFiled;
  final String? description;
  List<TransactionDetail>? paymentDetails;
  final double paidAmount;
  final double balance;
  final double runningBalance;
  final String invoiceType;

  TDSEntryModel({
    required this.tdsLedgerId,
    required this.voucherId,
    required this.voucherNumber,
    required this.invoice_number,
    required this.clientName,
    required this.creditAmount,
    required this.debitAmount,
    required this.igst,
    required this.cgst,
    required this.sgst,
    required this.totalAmount,
    required this.subtotal,
    required this.tdsAmount,
    required this.gstNumber,
    required this.tdsType,
    required this.rowUpdatedDate,
    required this.tdsFiled,
    this.description,
    this.paymentDetails,
    required this.paidAmount,
    required this.balance,
    required this.runningBalance,
    required this.invoiceType,
  });

  factory TDSEntryModel.fromJson(Map<String, dynamic> json) {
    return TDSEntryModel(
      tdsLedgerId: json['tdsledger_id'] ?? 0,
      voucherId: json['voucher_id'] ?? 0,
      voucherNumber: json['voucher_number'] ?? '',
      invoice_number: json['invoice_number'] ?? '',
      clientName: json['client_name'] ?? '',
      creditAmount: (json['creditAmount'] ?? 0).toDouble(),
      debitAmount: (json['debitAmount'] ?? 0).toDouble(),
      igst: (json['IGST'] ?? 0).toDouble(),
      cgst: (json['CGST'] ?? 0).toDouble(),
      sgst: (json['SGST'] ?? 0).toDouble(),
      totalAmount: (json['totalamount'] ?? 0).toDouble(),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      tdsAmount: (json['tdsamount'] ?? 0).toDouble(),
      gstNumber: json['gst_number'] ?? '',
      tdsType: json['tds_type'] ?? '',
      rowUpdatedDate: DateTime.parse(json['Row_updated_date'] ?? DateTime.now().toIso8601String()),
      tdsFiled: json['tds_filed'] ?? 0,
      description: json['description'],
      paymentDetails: json['payment_details'] != null ? List<TransactionDetail>.from((json['payment_details'] as List).map((item) => TransactionDetail.fromJson(item))) : null,
      paidAmount: (json['paidamount'] ?? 0).toDouble(),
      balance: (json['balance'] ?? 0).toDouble(),
      runningBalance: (json['runningbalance'] ?? 0).toDouble(),
      invoiceType: json['invoice_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tdsledger_id': tdsLedgerId,
      'voucher_id': voucherId,
      'voucher_number': voucherNumber,
      'invoice_number': invoice_number,
      'client_name': clientName,
      'creditAmount': creditAmount,
      'debitAmount': debitAmount,
      'IGST': igst,
      'CGST': cgst,
      'SGST': sgst,
      'totalamount': totalAmount,
      'subtotal': subtotal,
      'tdsamount': tdsAmount,
      'gst_number': gstNumber,
      'tds_type': tdsType,
      'Row_updated_date': rowUpdatedDate.toIso8601String(),
      'tds_filed': tdsFiled,
      'description': description,
      'payment_details': paymentDetails?.map((e) => e.toJson()).toList(),
      'paidamount': paidAmount,
      'balance': balance,
      'runningbalance': runningBalance,
      'invoice_type': invoiceType
    };
  }
}

class TransactionDetail {
  final DateTime date;
  final double amount;
  final String feedback;
  final int transactionId;
  final String transanctionDetails;

  TransactionDetail({
    required this.date,
    required this.amount,
    required this.feedback,
    required this.transactionId,
    required this.transanctionDetails,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    return TransactionDetail(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      amount: (json['amount'] ?? 0).toDouble(),
      feedback: json['feedback'] ?? '',
      transactionId: json['transactionid'] ?? 0,
      transanctionDetails: json['transanctiondetails'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'amount': amount,
      'feedback': feedback,
      'transactionid': transactionId,
      'transanctiondetails': transanctionDetails,
    };
  }
}

// class PaymentDetail {
//   final DateTime date;
//   final double amount;
//   final String feedback;
//   final double tdsAmount;
//   final String transactionDetails;

//   PaymentDetail({
//     required this.date,
//     required this.amount,
//     required this.feedback,
//     required this.tdsAmount,
//     required this.transactionDetails,
//   });

//   factory PaymentDetail.fromJson(Map<String, dynamic> json) {
//     return PaymentDetail(
//       date: DateTime.parse(json['date']),
//       amount: (json['amount'] ?? 0).toDouble(),
//       feedback: json['feedback'] ?? '',
//       tdsAmount: (json['tdsamount'] ?? 0).toDouble(),
//       transactionDetails: json['transanctiondetails'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'date': date.toIso8601String(),
//       'amount': amount,
//       'feedback': feedback,
//       'tdsamount': tdsAmount,
//       'transanctiondetails': transactionDetails,
//     };
//   }
// }
