import 'package:ssipl_billing/5_VENDOR/models/entities/product_entities.dart';
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
  final String eventnumber;
  // final String? title;
  // final String? name;
  // final String? emailId;
  // final String? phoneNo;
  // final String? address;
  // final String? gst;
  // final String? billingAddressName;
  // final String? billingAddress;
  // final List<RRFQProduct> product;
  RequiredData({
    required this.eventnumber,
    // required this.title,
    // required this.name,
    // required this.emailId,
    // required this.phoneNo,
    // required this.address,
    // required this.gst,
    // required this.billingAddressName,
    // required this.billingAddress,
    // required this.product
  });

  factory RequiredData.fromJson(CMDmResponse json) {
    return RequiredData(
      eventnumber: json.data['rrfq_id'] as String,
      // title: json.data['title'] as String,
      // name: json.data['client_addressname'] as String,
      // emailId: json.data['emailid'] as String,
      // phoneNo: json.data['contact_number'] as String,
      // address: json.data['client_address'] as String,
      // gst: json.data['gstnumber'] as String,
      // billingAddressName: json.data['billingaddress_name'] as String,
      // billingAddress: json.data['billing_address'] as String,
      // product: (json.data['product'] as List<dynamic>)
      //     .map((e) => RRFQProduct.fromJson(e)) // ✅ Convert each item to RrfqProduct
      //     .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ID': eventnumber,
    };
  }
}

class Post_Rrfq {
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
