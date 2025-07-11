import 'package:ssipl_billing/5_VENDOR/models/entities/Process/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class Recommendation {
  final String key;
  final String value;

  Recommendation({
    required this.key,
    required this.value,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      key: json['key'] as String,
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}

// class Note {
//   final String notename;

//   Note({required this.notename});

//   factory Note.fromJson(Map<String, dynamic> json) {
//     return Note(
//       notename: json['notename'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'notename': notename,
//     };
//   }
// }

class POGSTtotals {
  final double gst;
  final double total;

  POGSTtotals({
    required this.gst,
    required this.total,
  });

  factory POGSTtotals.fromJson(Map<String, dynamic> json) {
    return POGSTtotals(gst: json['GST'], total: json['total']);
  }

  Map<String, dynamic> toJson() {
    return {
      'GST': gst,
      'total': total,
    };
  }
}

class RequiredData {
  final String eventnumber;
  final String? title;
  final String? name;
  final String? emailId;
  final String? phoneNo;
  final String? address;
  final String? gst;
  final String? billingAddressName;
  final String? billingAddress;
  final List<POProduct> product;
  RequiredData(
      {required this.eventnumber,
      required this.title,
      required this.name,
      required this.emailId,
      required this.phoneNo,
      required this.address,
      required this.gst,
      required this.billingAddressName,
      required this.billingAddress,
      required this.product});

  factory RequiredData.fromJson(CMDmResponse json) {
    return RequiredData(
      eventnumber: json.data['eventnumber'] as String,
      title: json.data['title'] as String,
      name: json.data['client_addressname'] as String,
      emailId: json.data['emailid'] as String,
      phoneNo: json.data['contact_number'] as String,
      address: json.data['client_address'] as String,
      gst: json.data['gstnumber'] as String,
      billingAddressName: json.data['billingaddress_name'] as String,
      billingAddress: json.data['billing_address'] as String,
      product: (json.data['product'] as List<dynamic>)
          .map((e) => POProduct.fromJson(e)) // ✅ Convert each item to POProduct
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ID': eventnumber,
    };
  }
}

class Post_PO {
  String? title;
  int? processid;
  String? ClientAddressname;
  String? ClientAddress;
  String? emailId;
  String? phoneNo;
  String? gst;
  String? billingAddressName;
  String? billingAddress;
  List<POProduct>? product;
  List notes;
  String? date;
  String? poGenID;
  int? messageType;
  String? feedback;
  String? ccEmail;
  double? total_amount;
  Map<String, dynamic> billdetails;

  Post_PO({
    required this.title,
    required this.processid,
    required this.ClientAddressname,
    required this.ClientAddress,
    required this.billingAddressName,
    required this.billingAddress,
    required this.emailId,
    required this.phoneNo,
    required this.gst,
    required this.date,
    required this.product,
    required this.notes,
    required this.poGenID,
    required this.messageType,
    required this.feedback,
    required this.ccEmail,
    required this.total_amount,
    required this.billdetails,
  });

  factory Post_PO.fromJson({
    required String title,
    required int processid,
    required String ClientAddressname,
    required String ClientAddress,
    required String billingAddressName,
    required String billingAddress,
    required String emailId,
    required String phoneNo,
    required String gst,
    required List<POProduct> product,
    required List notes,
    required String date,
    required String poGenID,
    required int messageType,
    required String feedback,
    required String ccEmail,
    required double total_amount,
    required Map<String, dynamic> billdetails,
  }) {
    return Post_PO(
        title: title,
        processid: processid,
        ClientAddressname: ClientAddressname,
        ClientAddress: ClientAddress,
        billingAddressName: billingAddressName,
        billingAddress: billingAddress,
        emailId: emailId,
        phoneNo: phoneNo,
        gst: gst,
        product: product,
        notes: notes,
        date: date,
        poGenID: poGenID,
        messageType: messageType,
        feedback: feedback,
        ccEmail: ccEmail,
        total_amount: total_amount,
        billdetails: billdetails);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "processid": processid,
      "clientaddressname": ClientAddressname,
      "clientaddress": ClientAddress,
      "billingaddressname": billingAddressName,
      "billingaddress": billingAddress,
      "emailid": emailId,
      "phoneno": phoneNo,
      "gst_number": gst,
      "product": product?.map((item) => item.toJson()).toList(),
      "notes": notes,
      "date": date,
      "pogenid": poGenID,
      "messagetype": messageType,
      "feedback": feedback,
      "ccemail": ccEmail,
      "po_amount": total_amount,
      "billdetails": billdetails
    };
  }
}

class GST {
  double IGST;
  double CGST;
  double SGST;

  GST({required this.IGST, required this.CGST, required this.SGST});

  factory GST.fromJson(Map<String, dynamic> json) {
    return GST(
      IGST: json['IGST'] ?? 0.0,
      CGST: json['CGST'] ?? 0.0,
      SGST: json['SGST'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IGST': IGST,
      'CGST': CGST,
      'SGST': SGST,
    };
  }
}

class BillDetails {
  double total;
  double subtotal;
  GST gst;
  double tdsamount;

  BillDetails({
    required this.total,
    required this.subtotal,
    required this.gst,
    required this.tdsamount,
  });

  factory BillDetails.fromJson(Map<String, dynamic> json) {
    return BillDetails(total: json['total'] ?? 0.0, subtotal: json['subtotal'] ?? 0.0, gst: GST.fromJson(json['gst'] ?? {}), tdsamount: json['tdsamount'] ?? 0.0);
  }

  Map<String, dynamic> toJson() {
    return {'total': total, 'subtotal': subtotal, 'gst': gst.toJson(), 'tdsamount': tdsamount};
  }
}
