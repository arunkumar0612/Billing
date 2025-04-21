import 'package:ssipl_billing/4.SALES/models/entities/product_entities.dart';
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

class DcGSTtotals {
  final double gst;
  final double total;

  DcGSTtotals({
    required this.gst,
    required this.total,
  });

  factory DcGSTtotals.fromJson(Map<String, dynamic> json) {
    return DcGSTtotals(gst: json['GST'], total: json['total']);
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
  final List<DcProduct> product;
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
          .asMap()
          .entries
          .map((entry) => DcProduct.fromJson(entry.value, entry.key + 1)) // `sno = index + 1`
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ID': eventnumber,
    };
  }
}

class Post_Dc {
  String? title;
  int? processid;
  String? ClientAddressname;
  String? ClientAddress;
  String? emailId;
  String? phoneNo;
  String? gst;
  String? billingAddressName;
  String? billingAddress;
  List<DcProduct>? product;
  List notes;
  String? date;
  String? dcGenID;
  int? messageType;
  String? feedback;
  String? ccEmail;
  String? productFeedback;

  Post_Dc({
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
    required this.dcGenID,
    required this.messageType,
    required this.feedback,
    required this.ccEmail,
    required this.productFeedback,
  });

  factory Post_Dc.fromJson({
    required String title,
    required int processid,
    required String ClientAddressname,
    required String ClientAddress,
    required String billingAddressName,
    required String billingAddress,
    required String emailId,
    required String phoneNo,
    required String gst,
    required List<DcProduct> product,
    required List notes,
    required String date,
    required String dcGenID,
    required int messageType,
    required String feedback,
    required String ccEmail,
    required String? productFeedback,
  }) {
    return Post_Dc(
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
        dcGenID: dcGenID,
        messageType: messageType,
        feedback: feedback,
        ccEmail: ccEmail,
        productFeedback: productFeedback);
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
      "dcgenid": dcGenID,
      "messagetype": messageType,
      "feedback": feedback,
      "ccemail": ccEmail,
      "productfeedback": productFeedback
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
