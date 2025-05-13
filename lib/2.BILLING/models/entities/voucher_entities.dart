class Voucherdata {
  String? voucherId;
  String? clientName;
  String? invoiceId;
  String? productType;
  String? refNo;
  String? date;
  String? particulars;
  String? netAmount;
  String? gstAmount;
  String? total;
  String? note;

  Voucherdata({
    required this.voucherId,
    required this.clientName,
    required this.invoiceId,
    required this.productType,
    required this.refNo,
    required this.date,
    required this.particulars,
    required this.netAmount,
    required this.gstAmount,
    required this.total,
    required this.note,
  });

  // Factory method to create an instance from JSON
  factory Voucherdata.fromJson(Map<String, dynamic> json) {
    return Voucherdata(
      voucherId: json['voucher_id'],
      clientName: json['clientname'],
      invoiceId: json['invoice_id'],
      productType: json['product_type'],
      refNo: json['ref_no'],
      date: json['date'],
      particulars: json['particulars'],
      netAmount: json['net_amount'],
      gstAmount: json['gst_amount'],
      total: json['total'],
      note: json['note'],
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      "voucher_id": voucherId,
      "clientname": clientName,
      "invoice_id": invoiceId,
      "product_type": productType,
      "ref_no": refNo,
      "date": date,
      "particulars": particulars,
      "net_amount": netAmount,
      "gst_amount": gstAmount,
      "total": total,
      "note": note,
    };
  }
}
