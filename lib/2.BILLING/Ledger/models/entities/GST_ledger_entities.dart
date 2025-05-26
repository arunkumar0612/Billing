// import 'dart:convert';

class GSTSummaryModel {
  final List<GSTEntryModel> gstList;
  final double inputGst;
  final double outputGst;
  final double totalGst;
  final double? inputSgst;
  final double? outputSgst;
  final double? totalSgst;
  final double? inputCgst;
  final double? outputCgst;
  final double? totalCgst;
  final double? inputIgst;
  final double? outputIgst;
  final double? totalIgst;
  final String? startdate;
  final String? enddate;

  GSTSummaryModel({
    required this.gstList,
    required this.inputGst,
    required this.outputGst,
    required this.totalGst,
    this.inputSgst,
    this.outputSgst,
    this.totalSgst,
    this.inputCgst,
    this.outputCgst,
    this.totalCgst,
    this.inputIgst,
    this.outputIgst,
    this.totalIgst,
    required this.startdate,
    required this.enddate,
  });

  factory GSTSummaryModel.fromJson(Map<String, dynamic> json) {
    return GSTSummaryModel(
        gstList: (json['gstlist'] as List<dynamic>).map((e) => GSTEntryModel.fromJson(e)).toList(),
        inputGst: (json['inputgst'] ?? 0).toDouble(),
        outputGst: (json['outputgst'] ?? 0).toDouble(),
        totalGst: (json['totalgst'] ?? 0).toDouble(),
        inputSgst: (json['inputsgst'] as num?)?.toDouble(),
        outputSgst: (json['outputsgst'] as num?)?.toDouble(),
        totalSgst: (json['totalsgst'] as num?)?.toDouble(),
        inputCgst: (json['inputcgst'] as num?)?.toDouble(),
        outputCgst: (json['outputcgst'] as num?)?.toDouble(),
        totalCgst: (json['totalcgst'] as num?)?.toDouble(),
        inputIgst: (json['inputigst'] as num?)?.toDouble(),
        outputIgst: (json['outputigst'] as num?)?.toDouble(),
        totalIgst: (json['totaligst'] as num?)?.toDouble(),
        startdate: (json['startdate'] ?? DateTime.now().toString()),
        enddate: (json['enddate'] ?? DateTime.now().toString()));
  }

  Map<String, dynamic> toJson() {
    return {
      'gstlist': gstList.map((e) => e.toJson()).toList(),
      'inputgst': inputGst,
      'outputgst': outputGst,
      'totalgst': totalGst,
      'inputsgst': inputSgst,
      'outputsgst': outputSgst,
      'totalsgst': totalSgst,
      'inputcgst': inputCgst,
      'outputcgst': outputCgst,
      'totalcgst': totalCgst,
      'inputigst': inputIgst,
      'outputigst': outputIgst,
      'totaligst': totalIgst,
      'startdate': startdate,
      'enddate': enddate,
    };
  }
}

class GSTEntryModel {
  final int gstLedgerId;
  final int voucherId;
  final String voucherNumber;
  final String invoice_number;
  final String clientName;
  final double igst;
  final double cgst;
  final double sgst;
  final String gstNumber;
  final double totalGst;
  final String gstType;
  final DateTime date;
  final int gstFiled;
  final double totalAmount;
  final double subTotal;
  final String? description;
  final List<PaymentDetail>? paymentDetails;
  final String invoiceType;

  GSTEntryModel({
    required this.gstLedgerId,
    required this.voucherId,
    required this.voucherNumber,
    required this.invoice_number,
    required this.clientName,
    required this.igst,
    required this.cgst,
    required this.sgst,
    required this.gstNumber,
    required this.totalGst,
    required this.gstType,
    required this.date,
    required this.gstFiled,
    required this.totalAmount,
    required this.subTotal,
    this.description,
    this.paymentDetails,
    required this.invoiceType,
  });

  factory GSTEntryModel.fromJson(Map<String, dynamic> json) {
    return GSTEntryModel(
      gstLedgerId: json['gstledger_id'] ?? 0,
      voucherId: json['voucher_id'] ?? 0,
      voucherNumber: json['voucher_number'] ?? '',
      invoice_number: json['invoice_number'] ?? '',
      clientName: json['client_name'] ?? '',
      igst: (json['IGST'] ?? 0).toDouble(),
      cgst: (json['CGST'] ?? 0).toDouble(),
      sgst: (json['SGST'] ?? 0).toDouble(),
      gstNumber: json['gst_number'] ?? '',
      totalGst: (json['totalgst'] ?? 0).toDouble(),
      gstType: json['gst_type'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      gstFiled: json['gst_filed'] ?? 0,
      totalAmount: (json['totalamount'] ?? 0).toDouble(),
      subTotal: (json['subtotal'] ?? 0).toDouble(),
      description: json['description'],
      paymentDetails: (json['payment_details'] as List<dynamic>?)?.map((e) => PaymentDetail.fromJson(e)).toList(),
      invoiceType: json['invoice_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gstledger_id': gstLedgerId,
      'voucher_id': voucherId,
      'voucher_number': voucherNumber,
      'client_name': clientName,
      'IGST': igst,
      'CGST': cgst,
      'SGST': sgst,
      'gst_number': gstNumber,
      'totalgst': totalGst,
      'gst_type': gstType,
      'date': date.toIso8601String(),
      'gst_filed': gstFiled,
      'totalamount': totalAmount,
      'subtotal': subTotal,
      'description': description,
      'payment_details': paymentDetails?.map((e) => e.toJson()).toList(),
      'invoice_type': invoiceType
    };
  }
}

class PaymentDetail {
  final DateTime date;
  final double amount;
  final String feedback;
  final double tdsAmount;
  final String transactionDetails;

  PaymentDetail({
    required this.date,
    required this.amount,
    required this.feedback,
    required this.tdsAmount,
    required this.transactionDetails,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      date: DateTime.parse(json['date']),
      amount: (json['amount'] ?? 0).toDouble(),
      feedback: json['feedback'] ?? '',
      tdsAmount: (json['tdsamount'] ?? 0).toDouble(),
      transactionDetails: json['transanctiondetails'] ?? '',
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

// class PDF_GSTledgerSummary {
//   final DateTime fromDate;
//   final DateTime toDate;
//   final GSTSummaryModel summaryDetails;

//   PDF_GSTledgerSummary({
//     required this.fromDate,
//     required this.toDate,
//     required this.summaryDetails,

//   });

//   factory PDF_GSTledgerSummary.fromJson({required GSTSummaryModel summaryDetails}) {
//   return PDF_GSTledgerSummary(
//     summaryDetails: summaryDetails,

//   );
// }

//   Map<String, dynamic> toJson() {
//     return {
//       'fromDate': fromDate,
//       'toDate': toDate,
//       'gstlist':  summaryDetails.toJson(),
    
//   };
// }
// }

