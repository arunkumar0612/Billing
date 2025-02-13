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
  String? title;
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
  int? companyID;
  int? branchID;

  AddSales({
    required this.title,
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
    required this.companyID,
    required this.branchID,
  });

  factory AddSales.fromJson(String title, String name, String emailId, String phoneNo, String address, String gst, String billingAddressName, String customerRequirementId, String billingAddress, String modeOfRequest, String morReference, List<ClientreqProduct> product, List<Note> notes, String date, int companyID, int branchID) {
    return AddSales(title: title, name: name, emailId: emailId, phoneNo: phoneNo, address: address, gst: gst, billingAddressName: billingAddressName, customerRequirementId: customerRequirementId, billingAddress: billingAddress, modeOfRequest: modeOfRequest, morReference: morReference, product: product, notes: notes, date: date, companyID: companyID, branchID: branchID);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
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
      "companyid": companyID,
      "branchid": branchID
    };
  }
}

class Organization {
  int? organizationId;
  String? organizationName;
  String? orgCode;

  Organization({
    required this.organizationId,
    required this.organizationName,
    this.orgCode,
  });

  factory Organization.fromJson(CMDlResponse json, i) {
    return Organization(
      organizationId: json.data[i]['Organization_id'],
      organizationName: json.data[i]['Organization_name'],
      orgCode: json.data[i]['orgcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Organization_id": organizationId,
      "Organization_name": organizationName,
      "orgcode": orgCode,
    };
  }
}

class Company {
  int? companyId;
  String? companyName;
  String? emailId;

  Company({
    required this.companyId,
    required this.companyName,
    required this.emailId,
  });

  // Factory method to create an instance from JSON
  factory Company.fromJson(CMDlResponse json, i) {
    return Company(
      companyId: json.data[i]['companyid'],
      companyName: json.data[i]['companyname'],
      emailId: json.data[i]['Email_id'],
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      "companyid": companyId,
      "companyname": companyName,
      "Email_id": emailId,
    };
  }
}

class Branch {
  int? Branch_id;
  String? Branch_name;
  String? Branch_code;

  Branch({
    required this.Branch_id,
    required this.Branch_name,
    required this.Branch_code,
  });

  // Factory method to create an instance from JSON
  factory Branch.fromJson(CMDlResponse json, i) {
    return Branch(
      Branch_id: json.data[i]['Branch_id'],
      Branch_name: json.data[i]['Branch_name'],
      Branch_code: json.data[i]['Branch_code'],
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      "Branch_id": Branch_id,
      "Branch_name": Branch_name,
      "Branch_code": Branch_code,
    };
  }
}
