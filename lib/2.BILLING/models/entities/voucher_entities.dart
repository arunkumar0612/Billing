import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

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

class Voucher_List {
  final List<Voucher_data> VoucherList;

  Voucher_List({required this.VoucherList});

  /// Convert from CMDmResponse
  factory Voucher_List.fromCMDlResponse(CMDlResponse response) {
    var data = response.data;
    List<Voucher_data> temp = [];
    for (int i = 0; i < data.length; i++) {
      temp.add(Voucher_data.fromJson(data[i]));
    }
    return Voucher_List(VoucherList: temp);
  }
}

class Voucher_data {
  String? invoice_number;
  String? voucher_type;
  String? name;
  String? email_id;
  String? phone_number;
  String? client_name;
  String? client_address;
  int? pending_amount;
  int? fully_cleared;
  int? partial_cleared;
  int? gstnumber;
  double? Total_amount;
  double? sub_total;
  double? IGST;
  double? SGST;
  String? voucher_number;
  String? invoice_type;

  Voucher_data(
      {this.invoice_number,
      this.voucher_type,
      this.name,
      this.email_id,
      this.phone_number,
      this.client_name,
      this.client_address,
      this.pending_amount,
      this.fully_cleared,
      this.partial_cleared,
      this.gstnumber,
      this.Total_amount,
      this.sub_total,
      this.IGST,
      this.SGST,
      this.voucher_number,
      this.invoice_type});

  factory Voucher_data.fromJson(Map<String, dynamic> json) {
    return Voucher_data(
      invoice_number: json['invoice_number'],
      voucher_type: json['voucher_type'],
      name: json['name'],
      email_id: json['email_id'],
      phone_number: json['phone_number'],
      client_name: json['client_name'],
      client_address: json['client_address'],
      pending_amount: json['pending_amount'],
      fully_cleared: json['fully_cleared'],
      partial_cleared: json['partial_cleared'],
      gstnumber: json['gstnumber'],
      Total_amount: json['Total_amount'],
      sub_total: json['sub_total'],
      IGST: json['IGST'],
      SGST: json['SGST'],
      voucher_number: json['voucher_number'],
      invoice_type: json['invoice_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoice_number': invoice_number,
      'voucher_type': voucher_type,
      'name': name,
      'email_id': email_id,
      'phone_number': phone_number,
      'client_name': client_name,
      'client_address': client_address,
      'pending_amount': pending_amount,
      'fully_cleared': fully_cleared,
      'partial_cleared': partial_cleared,
      'gstnumber': gstnumber,
      'Total_amount': Total_amount,
      'sub_total': sub_total,
      'IGST': IGST,
      'SGST': SGST,
      'voucher_number': voucher_number,
      'invoice_type': invoice_type,
    };
  }

  static List<Voucher_data> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Voucher_data.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<Voucher_data> vouchers) {
    return vouchers.map((sub) => sub.toJson()).toList();
  }
}
