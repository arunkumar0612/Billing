// class ProductDetail {
//   String productName;
//   int productQuantity;

//   ProductDetail({required this.productName, required this.productQuantity});

//   // Convert ProductDetail to Map (useful for JSON serialization if needed)
//   Map<String, dynamic> toMap() {
//     return {
//       'productName': productName,
//       'productQuantity': productQuantity,
//     };
//   }

//   // Factory method to create ProductDetail from Map
//   factory ProductDetail.fromMap(Map<String, dynamic> map) {
//     return ProductDetail(
//       productName: map['productName'] ?? '',
//       productQuantity: map['productQuantity'] ?? 0,
//     );
//   }
// }

import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/models/entities/SALES/product_entities.dart';
import 'package:ssipl_billing/views/screens/SALES/Generate_client_req/clientreq_products.dart';

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

class Note {
  final String notename;

  Note({required this.notename});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      notename: json['notename'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notename': notename,
    };
  }
}

class MORpath {
  final String path;

  MORpath({required this.path});

  factory MORpath.fromJson(CMDmResponse json) {
    return MORpath(
      path: json.data['path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
    };
  }
}

class EnqID {
  final String ID;

  EnqID({required this.ID});

  factory EnqID.fromJson(CMDmResponse json) {
    return EnqID(
      ID: json.data['requirementid'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
    };
  }
}

class AddSales {
  String? name;
  String? emailId;
  String? phoneNo;
  String? address;
  String? gst;
  String? billingAddressName;
  String? customerRequirementId;
  String? billingAddress;
  String? modeOfRequest;
  String? morReference;
  List<ClientreqProduct>? product;
  List<Note>? notes;
  int? messageType;
  double? invoiceAmount;
  String? date;

  AddSales({
    required this.name,
    required this.emailId,
    required this.phoneNo,
    required this.address,
    required this.gst,
    required this.billingAddressName,
    required this.customerRequirementId,
    required this.billingAddress,
    required this.modeOfRequest,
    required this.morReference,
    required this.product,
    required this.notes,
    required this.date,
  });

  factory AddSales.fromJson(
    String name,
    String emailId,
    String phoneNo,
    String address,
    String gst,
    String billingAddressName,
    String customerRequirementId,
    String billingAddress,
    String modeOfRequest,
    String morReference,
    List<ClientreqProduct> product,
    List<Note> notes,
    String date,
  ) {
    return AddSales(
      name: name,
      emailId: emailId,
      phoneNo: phoneNo,
      address: address,
      gst: gst,
      billingAddressName: billingAddressName,
      customerRequirementId: customerRequirementId,
      billingAddress: billingAddress,
      modeOfRequest: modeOfRequest,
      morReference: morReference,
      product: product,
      notes: notes,
      date: date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "emailid": emailId,
      "phoneno": phoneNo,
      "address": address,
      "gst": gst,
      "billingaddressname": billingAddressName,
      "customerrequirementid": customerRequirementId,
      "billingaddress": billingAddress,
      "modeofrequest": modeOfRequest,
      "MORreference": morReference,
      "product": product?.map((item) => item.toJson()).toList(),
      "notes": notes?.map((item) => item.toJson()).toList(),
      "date": date,
    };
  }
}

// class Product {
//   String? productName;
//   int? productQuantity;

//   Product({this.productName, this.productQuantity});

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       productName: json['productname'],
//       productQuantity: json['productquantity'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "productname": productName,
//       "productquantity": productQuantity,
//     };
//   }
// }

// class NoteList {
//   String? note;

//   NoteList({this.note});

//   factory NoteList.fromJson(Map<String, dynamic> json) {
//     return NoteList(
//       note: json['note'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "note": note,
//     };
//   }
// }
