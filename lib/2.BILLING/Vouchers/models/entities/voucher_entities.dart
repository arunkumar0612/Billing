class InvoicePaymentVoucher {
  String invoiceNumber;
  String voucherType;
  String emailId;
  String phoneNumber;
  String clientName;
  String clientAddress;
  double pendingAmount;
  int fullyCleared;
  int partiallyCleared;
  String gstNumber;
  double totalAmount;
  double subTotal;
  double igst;
  double cgst;
  double sgst;
  String voucherNumber;
  String invoiceType;
  String customerId;
  int tdsCalculation;
  double tdsCalculationAmount;
  DateTime date;
  List<Map<String, dynamic>>? paymentDetails;

  InvoicePaymentVoucher({
    required this.invoiceNumber,
    required this.voucherType,
    required this.emailId,
    required this.phoneNumber,
    required this.clientName,
    required this.clientAddress,
    required this.pendingAmount,
    required this.fullyCleared,
    required this.partiallyCleared,
    required this.gstNumber,
    required this.totalAmount,
    required this.subTotal,
    required this.igst,
    required this.cgst,
    required this.sgst,
    required this.voucherNumber,
    required this.invoiceType,
    required this.customerId,
    required this.tdsCalculation,
    required this.tdsCalculationAmount,
    required this.date,
    this.paymentDetails,
  });

  factory InvoicePaymentVoucher.fromJson(Map<String, dynamic> json) {
    return InvoicePaymentVoucher(
      invoiceNumber: json['invoice_number'] ?? '',
      voucherType: json['voucher_type'] ?? '',
      emailId: json['email_id'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      clientName: json['client_name'] ?? '',
      clientAddress: json['client_address'] ?? '',
      pendingAmount: (json['pending_amount'] ?? 0).toDouble(),
      fullyCleared: json['fully_cleared'] ?? 0,
      partiallyCleared: json['partially_cleared'] ?? 0,
      gstNumber: json['gstnumber'] ?? '',
      totalAmount: (json['Total_amount'] ?? 0).toDouble(),
      subTotal: (json['sub_total'] ?? 0).toDouble(),
      igst: (json['IGST'] ?? 0).toDouble(),
      cgst: (json['CGST'] ?? 0).toDouble(),
      sgst: (json['SGST'] ?? 0).toDouble(),
      voucherNumber: json['voucher_number'] ?? '',
      invoiceType: json['invoice_type'] ?? '',
      customerId: json['customer_id']?.toString() ?? '',
      tdsCalculation: json['tds_calculation'] ?? 0,
      tdsCalculationAmount: (json['tdscalculation_amount'] ?? 0).toDouble(),
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      paymentDetails: json['payment_details'] != null ? List<Map<String, dynamic>>.from(json['payment_details']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoice_number': invoiceNumber,
      'voucher_type': voucherType,
      'email_id': emailId,
      'phone_number': phoneNumber,
      'client_name': clientName,
      'client_address': clientAddress,
      'pending_amount': pendingAmount,
      'fully_cleared': fullyCleared,
      'partially_cleared': partiallyCleared,
      'gstnumber': gstNumber,
      'Total_amount': totalAmount,
      'sub_total': subTotal,
      'IGST': igst,
      'CGST': cgst,
      'SGST': sgst,
      'voucher_number': voucherNumber,
      'invoice_type': invoiceType,
      'customer_id': customerId,
      'tds_calculation': tdsCalculation,
      'tdscalculation_amount': tdsCalculationAmount,
      'date': date.toIso8601String(),
      'payment_details': paymentDetails,
    };
  }
}
