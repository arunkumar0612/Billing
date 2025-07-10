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

class RrfqGSTtotals {
  final double gst;
  final double total;

  RrfqGSTtotals({
    required this.gst,
    required this.total,
  });

  factory RrfqGSTtotals.fromJson(Map<String, dynamic> json) {
    return RrfqGSTtotals(gst: json['GST'], total: json['total']);
  }

  Map<String, dynamic> toJson() {
    return {
      'GST': gst,
      'total': total,
    };
  }
}

class RequiredData {
  final String rrfqId;
  final VendorRfqDetails vendorRfqDetails;

  RequiredData({
    required this.rrfqId,
    required this.vendorRfqDetails,
  });

  factory RequiredData.fromJson(Map<String, dynamic> json) {
    return RequiredData(
      rrfqId: json['rrfq_id'],
      vendorRfqDetails: VendorRfqDetails.fromJson(json['vendor_rfq_details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rrfq_id': rrfqId,
      'vendor_rfq_details': vendorRfqDetails.toJson(),
    };
  }
}

class VendorRfqDetails {
  final int id;
  final String rfqGenId;
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
  final String rfqDate;
  final List<String> notes;
  final List<RRFQProduct> products;

  VendorRfqDetails({
    required this.id,
    required this.rfqGenId,
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
    required this.rfqDate,
    required this.notes,
    required this.products,
  });

  factory VendorRfqDetails.fromJson(Map<String, dynamic> json) {
    return VendorRfqDetails(
      id: json['id'],
      rfqGenId: json['rfqgenid'],
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
      rfqDate: json['rfq_date'],
      notes: List<String>.from(json['notes']),
      products: (json['products'] as List).map((e) => RRFQProduct.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rfqgenid': rfqGenId,
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
      'rfq_date': rfqDate,
      'notes': notes,
      'products': products.map((e) => e.toJson()).toList(),
    };
  }
}

class Post_Rrfq {
  int? processid;
  int? vendorID;
  String? vendorName;
  String? vendorAddress;
  String? GSTIN;
  String? PAN;
  String? Contact_person;
  String? emailId;
  String? phoneNo;
  String? gst;
  String? billingAddressName;
  String? billingAddress;
  List<RRFQProduct>? product;
  List notes;
  String? date;
  String? rrfqGenID;
  int? messageType;
  String? feedback;
  String? ccEmail;

  Post_Rrfq({
    required this.processid,
    required this.vendorID,
    required this.vendorName,
    required this.vendorAddress,
    required this.GSTIN,
    required this.PAN,
    required this.Contact_person,
    required this.emailId,
    required this.phoneNo,
    // required this.gst,
    required this.date,
    required this.product,
    required this.notes,
    required this.rrfqGenID,
    required this.messageType,
    required this.feedback,
    required this.ccEmail,
  });

  factory Post_Rrfq.fromJson({
    required int processid,
    required int vendorID,
    required String vendorName,
    required String vendorAddress,
    required String GSTIN,
    required String PAN,
    required String Contact_person,
    required String emailId,
    required String phoneNo,
    // required String gst,
    required List<RRFQProduct> product,
    required List notes,
    required String date,
    required String rrfqGenID,
    required int messageType,
    required String feedback,
    required String ccEmail,
  }) {
    return Post_Rrfq(
      processid: processid,

      GSTIN: GSTIN,
      PAN: PAN,
      Contact_person: Contact_person,
      vendorID: vendorID,
      vendorName: vendorName,
      vendorAddress: vendorAddress,

      emailId: emailId,
      phoneNo: phoneNo,
      // gst: gst,
      product: product,
      notes: notes,
      date: date,
      rrfqGenID: rrfqGenID,
      messageType: messageType,
      feedback: feedback,
      ccEmail: ccEmail,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "processid": processid,
      "vendorname": vendorName,
      "vendorid": vendorID,
      "GSTIN": GSTIN,
      "PAN": PAN,
      "Contact_person": Contact_person,
      "vendoraddress": vendorAddress,
      "product": product?.map((item) => item.toJson()).toList(),
      "notes": notes,
      "messagetype": messageType,
      "feedback": feedback,

      "emailid": emailId,
      "phoneno": phoneNo,
      // "gst_number": gst,
      "date": date,
      "rrfqgenid": rrfqGenID,
      "ccemail": ccEmail,
    };
  }
}

class ProductSuggestion {
  final String productName;
  final String productHsn;
  final double productPrice;
  final double productGst;

  ProductSuggestion({
    required this.productName,
    required this.productHsn,
    required this.productPrice,
    required this.productGst,
  });

  /// Factory method to convert JSON to Product object
  factory ProductSuggestion.fromJson(Map<String, dynamic> json) {
    return ProductSuggestion(
      productName: json['product_name'] as String,
      productHsn: json['product_hsn'].toString(), // Ensure String type
      productPrice: (json['product_price'] as num).toDouble(),
      productGst: (json['product_gst'] as num).toDouble(),
    );
  }

  /// Method to convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'product_hsn': productHsn,
      'product_price': productPrice,
      'product_gst': productGst,
    };
  }
}

/// Represents a product or service offered by a vendor.
class VendorProduct_suggestions {
  int id;
  int vendorId;
  String productName;
  String gstPercent;
  String hsn;
  String lastKnownPrice;

  VendorProduct_suggestions({
    required this.id,
    required this.vendorId,
    required this.productName,
    required this.gstPercent,
    required this.hsn,
    required this.lastKnownPrice,
  });

  /// Creates a VendorProduct object from a JSON map.
  factory VendorProduct_suggestions.fromJson(Map<String, dynamic> json) {
    return VendorProduct_suggestions(
      id: json['id'],
      vendorId: json['vendorid'],
      productName: json['productname'],
      gstPercent: json['gstpercent'],
      hsn: json['hsn'],
      lastKnownPrice: json['lastknown_price'],
    );
  }

  /// Converts the VendorProduct object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorid': vendorId,
      'productname': productName,
      'gstpercent': gstPercent,
      'hsn': hsn,
      'lastknown_price': lastKnownPrice,
    };
  }
}
