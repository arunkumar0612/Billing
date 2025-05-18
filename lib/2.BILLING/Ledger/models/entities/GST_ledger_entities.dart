class GSTSummaryModel {
  final List<GSTEntryModel> gstList;
  final double inputGst;
  final double outputGst;
  final double totalGst;

  GSTSummaryModel({
    required this.gstList,
    required this.inputGst,
    required this.outputGst,
    required this.totalGst,
  });

  factory GSTSummaryModel.fromJson(Map<String, dynamic> json) {
    return GSTSummaryModel(
      gstList: (json['gstlist'] as List<dynamic>).map((e) => GSTEntryModel.fromJson(e)).toList(),
      inputGst: (json['inputgst'] ?? 0).toDouble(),
      outputGst: (json['outputgst'] ?? 0).toDouble(),
      totalGst: (json['totalgst'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gstlist': gstList.map((e) => e.toJson()).toList(),
      'inputgst': inputGst,
      'outputgst': outputGst,
      'totalgst': totalGst,
    };
  }
}

class GSTEntryModel {
  final int gstLedgerId;
  final int voucherId;
  final String voucherNumber;
  final String clientName;
  final double igst;
  final double cgst;
  final double sgst;
  final String gstNumber;
  final String gstType;
  final DateTime date;
  final int gstFiled;
  final double totalAmount;
  final double subTotal;

  GSTEntryModel({
    required this.gstLedgerId,
    required this.voucherId,
    required this.voucherNumber,
    required this.clientName,
    required this.igst,
    required this.cgst,
    required this.sgst,
    required this.gstNumber,
    required this.gstType,
    required this.date,
    required this.gstFiled,
    required this.totalAmount,
    required this.subTotal,
  });

  factory GSTEntryModel.fromJson(Map<String, dynamic> json) {
    return GSTEntryModel(
      gstLedgerId: json['gstledger_id'] ?? 0,
      voucherId: json['voucher_id'] ?? 0,
      voucherNumber: json['voucher_number'] ?? '',
      clientName: json['client_name'] ?? '',
      igst: (json['IGST'] ?? 0).toDouble(),
      cgst: (json['CGST'] ?? 0).toDouble(),
      sgst: (json['SGST'] ?? 0).toDouble(),
      gstNumber: json['gst_number'] ?? '',
      gstType: json['gst_type'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      gstFiled: json['gst_filed'] ?? 0,
      totalAmount: (json['totalamount'] ?? 0).toDouble(),
      subTotal: (json['subtotal'] ?? 0).toDouble(),
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
      'gst_type': gstType,
      'date': date.toIso8601String(),
      'gst_filed': gstFiled,
      'totalamount': totalAmount,
      'subtotal': subTotal,
    };
  }
}
