class GSTRecord {
  DateTime date;
  String voucherNo;
  String invoiceNo;
  String gstNo;
  String particulars;
  String gstType;
  String cgst;
  String sgst;
  String igst;
  String totalGst;
  String taxableValue;
  String grossAmount;

  GSTRecord({
    required this.date,
    required this.voucherNo,
    required this.invoiceNo,
    required this.gstNo,
    required this.particulars,
    required this.gstType,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.totalGst,
    required this.taxableValue,
    required this.grossAmount,
  });

  factory GSTRecord.fromJson(Map<String, dynamic> json) {
    return GSTRecord(
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      voucherNo: json['voucher_no'] ?? '',
      invoiceNo: json['invoice_no'] ?? '',
      gstNo: json['gst_no'] ?? '',
      particulars: json['particulars'] ?? '',
      gstType: json['gst_type'] ?? '',
      cgst: json['cgst'] ?? '',
      sgst: json['sgst'] ?? '',
      igst: json['igst'] ?? '',
      totalGst: json['total_gst'] ?? '',
      taxableValue: json['taxable_value'] ?? '',
      grossAmount: json['gross_amount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'voucher_no': voucherNo,
        'invoice_no': invoiceNo,
        'gst_no': gstNo,
        'particulars': particulars,
        'gst_type': gstType,
        'cgst': cgst,
        'sgst': sgst,
        'igst': igst,
        'total_gst': totalGst,
        'taxable_value': taxableValue,
        'gross_amount': grossAmount,
      };
}
