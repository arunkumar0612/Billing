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
  List<Product>? product;
  List<Note>? notes;
  int? messageType;
  double? invoiceAmount;
  String? date;

  AddSales({
    this.name,
    this.emailId,
    this.phoneNo,
    this.address,
    this.gst,
    this.billingAddressName,
    this.customerRequirementId,
    this.billingAddress,
    this.modeOfRequest,
    this.morReference,
    this.product,
    this.notes,
    this.messageType,
    this.invoiceAmount,
    this.date,
  });

  factory AddSales.fromJson(Map<String, dynamic> json) {
    return AddSales(
      name: json['name'],
      emailId: json['emailid'],
      phoneNo: json['phoneno'],
      address: json['address'],
      gst: json['gst'],
      billingAddressName: json['billingaddressname'],
      customerRequirementId: json['customerrequirementid'],
      billingAddress: json['billingaddress'],
      modeOfRequest: json['modeofrequest'],
      morReference: json['MORreference'],
      product: (json['product'] as List<dynamic>?)?.map((item) => Product.fromJson(item)).toList(),
      notes: (json['notes'] as List<dynamic>?)?.map((item) => Note.fromJson(item)).toList(),
      messageType: json['messagetype'],
      invoiceAmount: (json['invoiceamount'] as num?)?.toDouble(),
      date: json['date'],
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
      "messagetype": messageType,
      "invoiceamount": invoiceAmount,
      "date": date,
    };
  }
}

class Product {
  String? productName;
  int? productQuantity;

  Product({this.productName, this.productQuantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['productname'],
      productQuantity: json['productquantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productname": productName,
      "productquantity": productQuantity,
    };
  }
}

class NoteList {
  String? note;

  NoteList({this.note});

  factory NoteList.fromJson(Map<String, dynamic> json) {
    return NoteList(
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "note": note,
    };
  }
}
