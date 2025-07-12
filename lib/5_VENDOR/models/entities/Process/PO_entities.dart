import 'package:ssipl_billing/5_VENDOR/models/entities/Process/product_entities.dart';

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

class PurchaseOrderResponse {
  final String poId;
  final PurchaseOrderDetails poDetails;

  PurchaseOrderResponse({
    required this.poId,
    required this.poDetails,
  });

  factory PurchaseOrderResponse.fromJson(Map<String, dynamic> data) {
    // final data = json['data'] ?? {};
    return PurchaseOrderResponse(
      poId: data['po_id'],
      poDetails: PurchaseOrderDetails.fromJson(data['po_details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'po_id': poId,
        'po_details': poDetails.toJson(),
      }
    };
  }
}

class PurchaseOrderDetails {
  // final int id;
  final int vendorId;
  final String vendorName;
  final String gstin;
  final String pan;
  final String contactPerson;
  final String vendorAddress;
  final String title;
  final String emailId;
  final String phoneNo;
  final String ccEmail;
  final int messageType;
  final String feedback;
  final List<String> notes;
  // final List<POProduct> products;

  PurchaseOrderDetails({
    // required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.gstin,
    required this.pan,
    required this.contactPerson,
    required this.vendorAddress,
    required this.title,
    required this.emailId,
    required this.phoneNo,
    required this.ccEmail,
    required this.messageType,
    required this.feedback,
    required this.notes,
    // required this.products,
  });

  factory PurchaseOrderDetails.fromJson(Map<String, dynamic> json) {
    return PurchaseOrderDetails(
      // id: json['id'],
      vendorId: json['vendor_id'],
      vendorName: json['vendor_name'],
      gstin: json['gstin'],
      pan: json['pan'],
      contactPerson: json['contact_person'],
      vendorAddress: json['vendor_address'],
      title: json['title'],
      emailId: json['email_id'],
      phoneNo: json['phone_no'],
      ccEmail: json['cc_email'],
      messageType: json['message_type'],
      feedback: json['feedback'],
      notes: List<String>.from(json['notes'] ?? []),
      // products: (json['products'] as List).map((e) => POProduct.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'vendor_id': vendorId,
      'vendor_name': vendorName,
      'gstin': gstin,
      'pan': pan,
      'contact_person': contactPerson,
      'vendor_address': vendorAddress,
      'title': title,
      'email_id': emailId,
      'phone_no': phoneNo,
      'cc_email': ccEmail,
      'message_type': messageType,
      'feedback': feedback,
      'notes': notes,
      // 'products': products.map((e) => e.toJson()).toList(),
    };
  }
}

class ProductSuggestion {
  final String productName;
  final String productHsn;
  final double productGst;
  final double lastKnownPrice;

  ProductSuggestion({
    required this.productName,
    required this.productHsn,
    required this.productGst,
    required this.lastKnownPrice,
  });

  /// Factory method to convert JSON to ProductSuggestion object
  factory ProductSuggestion.fromJson(Map<String, dynamic> json) {
    return ProductSuggestion(
      productName: json['productname'] ?? '',
      productHsn: json['hsn']?.toString() ?? '',
      productGst: double.tryParse(json['gstpercent'].toString()) ?? 0.0,
      lastKnownPrice: double.tryParse(json['lastknown_price'].toString()) ?? 0.0,
    );
  }

  /// Method to convert ProductSuggestion object to JSON
  Map<String, dynamic> toJson() {
    return {
      'productname': productName,
      'hsn': productHsn,
      'gstpercent': productGst,
      'lastknown_price': lastKnownPrice,
    };
  }
}

class Post_PO {
  int? processid;
  int? vendorID;
  String? contactPersonname;
  String? PAN;
  String? emailId;
  String? phoneNo;
  String? gst;
  String? vendorAddress;
  String? vendorName;
  String? pan;
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
    required this.processid,
    required this.vendorID,
    required this.contactPersonname,
    required this.vendorAddress,
    required this.vendorName,
    required this.pan,
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
    required int processid,
    required int vendorID,
    required String contactPersonname,
    required String vendorAddress,
    required String vendorName,
    required String pan,
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
        processid: processid,
        vendorID: vendorID,
        contactPersonname: contactPersonname,
        vendorAddress: vendorAddress,
        vendorName: vendorName,
        pan: pan,
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
      "processid": processid,
      "vendorID": vendorID,
      "contactPerson": contactPersonname,
      "vendorAddress": vendorAddress,
      "vendorName": vendorName,
      'pan': pan,
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
