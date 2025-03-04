import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/models/entities/SALES/product_entities.dart';

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

class RfqGSTtotals {
  final double gst;
  final double total;

  RfqGSTtotals({
    required this.gst,
    required this.total,
  });

  factory RfqGSTtotals.fromJson(Map<String, dynamic> json) {
    return RfqGSTtotals(gst: json['GST'], total: json['total']);
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
  final List<RFQProduct> product;
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
          .map((e) => RFQProduct.fromJson(e)) // ✅ Convert each item to RfqProduct
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ID': eventnumber,
    };
  }
}

class Post_Rfq {
  String? title;
  int? processid;
  String? ClientAddressname;
  String? ClientAddress;
  String? emailId;
  String? phoneNo;
  String? gst;
  String? billingAddressName;
  String? billingAddress;
  List<RFQProduct>? product;
  List notes;
  String? date;
  String? rfqGenID;
  int? messageType;
  String? feedback;
  String? ccEmail;
  double? total_amount;

  Post_Rfq({
    required this.title,
    required this.processid,
    required this.ClientAddressname,
    required this.ClientAddress,
    required this.billingAddressName,
    required this.billingAddress,
    required this.emailId,
    required this.phoneNo,
    // required this.gst,
    required this.date,
    required this.product,
    required this.notes,
    required this.rfqGenID,
    required this.messageType,
    required this.feedback,
    required this.ccEmail,
    required this.total_amount,
  });

  factory Post_Rfq.fromJson({
    required String title,
    required int processid,
    required String ClientAddressname,
    required String ClientAddress,
    required String billingAddressName,
    required String billingAddress,
    required String emailId,
    required String phoneNo,
    // required String gst,
    required List<RFQProduct> product,
    required List notes,
    required String date,
    required String rfqGenID,
    required int messageType,
    required String feedback,
    required String ccEmail,
    required double total_amount,
  }) {
    return Post_Rfq(
        title: title,
        processid: processid,
        ClientAddressname: ClientAddressname,
        ClientAddress: ClientAddress,
        billingAddressName: billingAddressName,
        billingAddress: billingAddress,
        emailId: emailId,
        phoneNo: phoneNo,
        // gst: gst,
        product: product,
        notes: notes,
        date: date,
        rfqGenID: rfqGenID,
        messageType: messageType,
        feedback: feedback,
        ccEmail: ccEmail,
        total_amount: total_amount);
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
      // "gst_number": gst,
      "product": product?.map((item) => item.toJson()).toList(),
      "notes": notes,
      "date": date,
      "rfqgenid": rfqGenID,
      "messagetype": messageType,
      "feedback": feedback,
      "ccemail": ccEmail,
      "rfq_amount": total_amount
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

class VendorList {
  String vendorName;
  String vendorMail;
  String vendorPhoneNo;
  String vendorGstNo;
  String vendorAddress;
  String? logoPath;

  VendorList({
    required this.vendorName,
    required this.vendorMail,
    required this.vendorPhoneNo,
    required this.vendorGstNo,
    required this.vendorAddress,
    this.logoPath,
  });

  factory VendorList.fromJson(CMDlResponse json, i) {
    return VendorList(
      vendorName: json.data[i]['vendor_name'],
      vendorMail: json.data[i]['vendor_mail'],
      vendorPhoneNo: json.data[i]['vendor_phoneno'],
      vendorGstNo: json.data[i]['vendor_gstno'],
      vendorAddress: json.data[i]['vendor_address'],
      logoPath: json.data[i]['Logo_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendor_name': vendorName,
      'vendor_mail': vendorMail,
      'vendor_phoneno': vendorPhoneNo,
      'vendor_gstno': vendorGstNo,
      'vendor_address': vendorAddress,
      'Logo_path': logoPath,
    };
  }

  static List<VendorList> fromJsonList(List<dynamic> jsonList, i) {
    return jsonList.map((json) => VendorList.fromJson(json, i)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<VendorList> vendors) {
    return vendors.map((vendor) => vendor.toJson()).toList();
  }
}
