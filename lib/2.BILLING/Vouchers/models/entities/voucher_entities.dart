class InvoicePaymentVoucher {
  int voucher_id;
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
  List<TransactionDetail>? paymentDetails;

  InvoicePaymentVoucher({
    required this.voucher_id,
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
      voucher_id: json['voucher_id'] ?? 0,
      invoiceNumber: json['invoice_number'] ?? '',
      voucherType: json['voucher_type'] ?? '',
      emailId: json['email_id'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      clientName: json['client_name'] ?? '',
      clientAddress: json['client_address'] ?? '',
      pendingAmount: (json['pending_amount'] ?? 0).roundToDouble(),
      fullyCleared: json['fully_cleared'] ?? 0,
      partiallyCleared: json['partially_cleared'] ?? 0,
      gstNumber: json['gstnumber'] ?? '',
      totalAmount: (json['Total_amount'] ?? 0).roundToDouble(),
      subTotal: (json['sub_total'] ?? 0).roundToDouble(),
      igst: (json['IGST'] ?? 0).roundToDouble(),
      cgst: (json['CGST'] ?? 0).roundToDouble(),
      sgst: (json['SGST'] ?? 0).roundToDouble(),
      voucherNumber: json['voucher_number'] ?? '',
      invoiceType: json['invoice_type'] ?? '',
      customerId: json['customer_id']?.toString() ?? '',
      tdsCalculation: (json['tds_calculation'] ?? 0),
      tdsCalculationAmount: (json['tdscalculation_amount'] ?? 0).roundToDouble(),
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      paymentDetails: json['payment_details'] != null ? List<TransactionDetail>.from((json['payment_details'] as List).map((item) => TransactionDetail.fromJson(item))) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucher_id': voucher_id,
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
      'payment_details': paymentDetails?.map((e) => e.toJson()).toList(),
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

class ClearVoucher {
  final DateTime date;
  final int voucherId;
  final String voucherNumber;
  final String paymentStatus;
  final double igst;
  final double sgst;
  final double cgst;
  final double tds;
  final double grossAmount;
  final double subtotal;
  final double paidAmount;
  final String clientAddressName;
  final String clientAddress;
  final String invoiceNumber;
  final String emailId;
  final String phoneNo;
  final bool tdsStatus;
  final String invoiceType;
  final String gstNumber;
  final String feedback;
  final String transactionDetails;

  ClearVoucher({
    required this.date,
    required this.voucherId,
    required this.voucherNumber,
    required this.paymentStatus,
    required this.igst,
    required this.sgst,
    required this.cgst,
    required this.tds,
    required this.grossAmount,
    required this.subtotal,
    required this.paidAmount,
    required this.clientAddressName,
    required this.clientAddress,
    required this.invoiceNumber,
    required this.emailId,
    required this.phoneNo,
    required this.tdsStatus,
    required this.invoiceType,
    required this.gstNumber,
    required this.feedback,
    required this.transactionDetails,
  });

  factory ClearVoucher.fromJson(Map<String, dynamic> json) {
    return ClearVoucher(
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      voucherId: json['voucherid'] ?? 0,
      voucherNumber: json['vouchernumber'] ?? '',
      paymentStatus: json['paymentstatus'] ?? '',
      igst: (json['IGST'] ?? 0).toDouble(),
      sgst: (json['SGST'] ?? 0).toDouble(),
      cgst: (json['CGST'] ?? 0).toDouble(),
      tds: (json['tds'] ?? 0).toDouble(),
      grossAmount: (json['grossamount'] ?? 0).toDouble(),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      paidAmount: (json['paidamount'] ?? 0).toDouble(),
      clientAddressName: json['clientaddressname'] ?? '',
      clientAddress: json['clientaddress'] ?? '',
      invoiceNumber: json['invoicenumber'] ?? '',
      emailId: json['emailid'] ?? '',
      phoneNo: json['phoneno'] ?? '',
      tdsStatus: json['tdsstatus'] ?? false,
      invoiceType: json['invoicetype'] ?? '',
      gstNumber: json['gstnumber'] ?? '',
      feedback: json['feedback'] ?? '',
      transactionDetails: json['transactiondetails'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'voucherid': voucherId,
      'vouchernumber': voucherNumber,
      'paymentstatus': paymentStatus,
      'IGST': igst,
      'SGST': sgst,
      'CGST': cgst,
      'tds': tds,
      'grossamount': grossAmount,
      'subtotal': subtotal,
      'paidamount': paidAmount,
      'clientaddressname': clientAddressName,
      'clientaddress': clientAddress,
      'invoicenumber': invoiceNumber,
      'emailid': emailId,
      'phoneno': phoneNo,
      'tdsstatus': tdsStatus,
      'invoicetype': invoiceType,
      'gstnumber': gstNumber,
      'feedback': feedback,
      'transactiondetails': transactionDetails,
    };
  }
}
