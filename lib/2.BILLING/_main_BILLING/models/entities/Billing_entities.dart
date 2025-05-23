class SubscriptionInvoice {
  final int recurredBillId;
  final int subscriptionBillId;
  final List<int> siteIds;
  final String clientAddressName;
  final String clientAddress;
  final String billingAddressName;
  final String billingAddress;
  final String pdfData;
  final String invoiceNo;
  final int totalAmount;
  final String emailId;
  final String phoneNo;
  final String ccEmail;
  final DateTime date;
  final String gstNumber;
  final String? dueDate;
  final String hsnCode;
  final String planType;
  final String billMode;
  final int paymentStatus;
  final String pendingPayments;
  final String planName;
  final String voucher_number;
  int? overdueDays;
  List<OverdueHistory>? overdueHistory;

  SubscriptionInvoice({
    required this.recurredBillId,
    required this.subscriptionBillId,
    required this.siteIds,
    required this.clientAddressName,
    required this.clientAddress,
    required this.billingAddressName,
    required this.billingAddress,
    required this.pdfData,
    required this.invoiceNo,
    required this.totalAmount,
    required this.emailId,
    required this.phoneNo,
    required this.ccEmail,
    required this.date,
    required this.gstNumber,
    required this.dueDate,
    required this.hsnCode,
    required this.planType,
    required this.billMode,
    required this.paymentStatus,
    required this.pendingPayments,
    required this.planName,
    required this.voucher_number,
    this.overdueDays,
    this.overdueHistory,
  });

  factory SubscriptionInvoice.fromJson(Map<String, dynamic> json) {
    return SubscriptionInvoice(
      recurredBillId: json['recurredbillid'],
      subscriptionBillId: json['subscription_billid'],
      siteIds: List<int>.from(json['site_Ids']),
      clientAddressName: json['client_addressname'],
      clientAddress: json['client_address'],
      billingAddressName: json['billing_addressname'],
      billingAddress: json['billing_address'],
      pdfData: json['pdf_data'],
      invoiceNo: json['Invoice_no'],
      totalAmount: json['TotalAmount'],
      emailId: json['email_id'],
      phoneNo: json['phone_no'],
      ccEmail: json['ccemail'],
      date: DateTime.parse(json['date']),
      gstNumber: json['gstnumber'],
      dueDate: json['Due_date'],
      hsnCode: json['hsn_code'],
      planType: json['plantype'],
      billMode: json['billmode'],
      paymentStatus: json['payment_status'],
      pendingPayments: json['pendingPayments'],
      planName: json['plan_name'],
      voucher_number: json['voucher_number'] ?? "",
      overdueDays: json['Overdue_days'],
      overdueHistory: json['Overdue_history'] != null ? List<OverdueHistory>.from(json['Overdue_history'].map((e) => OverdueHistory.fromJson(e))) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recurredbillid': recurredBillId,
      'subscription_billid': subscriptionBillId,
      'site_Ids': siteIds,
      'client_addressname': clientAddressName,
      'client_address': clientAddress,
      'billing_addressname': billingAddressName,
      'billing_address': billingAddress,
      'pdf_data': pdfData,
      'Invoice_no': invoiceNo,
      'TotalAmount': totalAmount,
      'email_id': emailId,
      'phone_no': phoneNo,
      'ccemail': ccEmail,
      'date': date.toIso8601String(),
      'gstnumber': gstNumber,
      'Due_date': dueDate,
      'hsn_code': hsnCode,
      'plantype': planType,
      'billmode': billMode,
      'payment_status': paymentStatus,
      'pendingPayments': pendingPayments,
      'plan_name': planName,
      'voucher_number': voucher_number,
      'Overdue_days': overdueDays,
      'Overdue_history': overdueHistory?.map((e) => e.toJson()).toList(),
    };
  }
}

class OverdueHistory {
  final String date;
  final String feedback;

  OverdueHistory({required this.date, required this.feedback});

  factory OverdueHistory.fromJson(Map<String, dynamic> json) {
    return OverdueHistory(
      date: json['date'] ?? '',
      feedback: json['feedback'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'feedback': feedback,
    };
  }
}

class SalesInvoice {
  final int eventId;
  final String invoiceNumber;
  final String clientAddressName;
  final String clientAddress;
  final String billingAddressName;
  final String billingAddress;
  final String gstNumber;
  final String emailId;
  final String phoneNo;
  final String ccEmail;
  final double invoiceAmount;
  final int processId;
  final DateTime date;
  final int voucherId;
  final String voucherNumber;
  final String dueDate; // newly added
  final String hsnCode; // newly added
  final String planType; // newly added
  final String billMode; // newly added
  final int paymentStatus; // newly added
  final String pendingPayments; // newly added
  final String planName; // newly added

  SalesInvoice({
    required this.eventId,
    required this.invoiceNumber,
    required this.clientAddressName,
    required this.clientAddress,
    required this.billingAddressName,
    required this.billingAddress,
    required this.gstNumber,
    required this.emailId,
    required this.phoneNo,
    required this.ccEmail,
    required this.invoiceAmount,
    required this.processId,
    required this.date,
    required this.voucherId,
    required this.voucherNumber,
    required this.dueDate,
    required this.hsnCode,
    required this.planType,
    required this.billMode,
    required this.paymentStatus,
    required this.pendingPayments,
    required this.planName,
  });

  factory SalesInvoice.fromJson(Map<String, dynamic> json) {
    return SalesInvoice(
        eventId: json['event_id'] as int,
        invoiceNumber: json['invoicenumber'] as String,
        clientAddressName: json['client_addressname'] as String,
        clientAddress: json['client_address'] as String,
        billingAddressName: json['billing_addressname'] as String,
        billingAddress: json['billing_address'] as String,
        gstNumber: json['gstnumber'] as String,
        emailId: json['email_id'] as String,
        phoneNo: json['phone_no'] as String,
        ccEmail: json['ccemail'] as String,
        invoiceAmount: (json['invoice_amount'] as num).toDouble(),
        processId: json['processid'] as int,
        date: DateTime.parse(json['date']),
        voucherId: json['voucher_id'] as int,
        voucherNumber: json['voucher_number'] as String,
        dueDate: json['Due_date'],
        hsnCode: json['hsn_code'],
        planType: json['plantype'],
        billMode: json['billmode'],
        paymentStatus: json['payment_status'],
        pendingPayments: json['pendingPayments'],
        planName: json['plan_name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'invoicenumber': invoiceNumber,
      'client_addressname': clientAddressName,
      'client_address': clientAddress,
      'billing_addressname': billingAddressName,
      'billing_address': billingAddress,
      'gstnumber': gstNumber,
      'email_id': emailId,
      'phone_no': phoneNo,
      'ccemail': ccEmail,
      'invoice_amount': invoiceAmount,
      'processid': processId,
      'date': date.toIso8601String(),
      'voucher_id': voucherId,
      'voucher_number': voucherNumber,
      'Due_date': dueDate,
      'hsn_code': hsnCode,
      'plantype': planType,
      'billmode': billMode,
      'payment_status': paymentStatus,
      'pendingPayments': pendingPayments,
      'plan_name': planName
    };
  }
}
// newly created

class VendorInvoice {
  final int eventId;
  final String invoiceNumber;
  final String clientAddressName;
  final String clientAddress;
  final String billingAddressName;
  final String billingAddress;
  final String gstNumber;
  final String emailId;
  final String phoneNo;
  final String ccEmail;
  final double invoiceAmount;
  final int processId;
  final DateTime date;
  final int voucherId;
  final String voucherNumber;
  final String dueDate;
  final String hsnCode;
  final String planType;
  final String billMode;
  final int paymentStatus;
  final String pendingPayments;
  final String planName;

  VendorInvoice({
    required this.eventId,
    required this.invoiceNumber,
    required this.clientAddressName,
    required this.clientAddress,
    required this.billingAddressName,
    required this.billingAddress,
    required this.gstNumber,
    required this.emailId,
    required this.phoneNo,
    required this.ccEmail,
    required this.invoiceAmount,
    required this.processId,
    required this.date,
    required this.voucherId,
    required this.voucherNumber,
    required this.dueDate,
    required this.hsnCode,
    required this.planType,
    required this.billMode,
    required this.paymentStatus,
    required this.pendingPayments,
    required this.planName,
  });

  factory VendorInvoice.fromJson(Map<String, dynamic> json) {
    return VendorInvoice(
        eventId: json['event_id'] as int,
        invoiceNumber: json['invoicenumber'] as String,
        clientAddressName: json['client_addressname'] as String,
        clientAddress: json['client_address'] as String,
        billingAddressName: json['billing_addressname'] as String,
        billingAddress: json['billing_address'] as String,
        gstNumber: json['gstnumber'] as String,
        emailId: json['email_id'] as String,
        phoneNo: json['phone_no'] as String,
        ccEmail: json['ccemail'] as String,
        invoiceAmount: (json['invoice_amount'] as num).toDouble(),
        processId: json['processid'] as int,
        date: DateTime.parse(json['date']),
        voucherId: json['voucher_id'] as int,
        voucherNumber: json['voucher_number'] as String,
        dueDate: json['Due_date'],
        hsnCode: json['hsn_code'],
        planType: json['plantype'],
        billMode: json['billMode'],
        paymentStatus: json['payment_status'],
        pendingPayments: json['pendingPayments'],
        planName: json['plan_name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'invoicenumber': invoiceNumber,
      'client_addressname': clientAddressName,
      'client_address': clientAddress,
      'billing_addressname': billingAddressName,
      'billing_address': billingAddress,
      'gstnumber': gstNumber,
      'email_id': emailId,
      'phone_no': phoneNo,
      'ccemail': ccEmail,
      'invoice_amount': invoiceAmount,
      'processid': processId,
      'date': date.toIso8601String(),
      'voucher_id': voucherId,
      'voucher_number': voucherNumber,
      'Due_date': dueDate,
      'hsn_code': hsnCode,
      'plantype': planType,
      'billmode': billMode,
      'payment_status': paymentStatus,
      'pendingPayments': pendingPayments,
      'plan_name': planName
    };
  }
}
