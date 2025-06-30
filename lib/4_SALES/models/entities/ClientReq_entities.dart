import 'package:ssipl_billing/4_SALES/models/entities/product_entities.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class ClientReq_recommendation {
  final String key;
  final String value;

  ClientReq_recommendation({
    required this.key,
    required this.value,
  });

  factory ClientReq_recommendation.fromJson(Map<String, dynamic> json) {
    return ClientReq_recommendation(
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

class Post_ClientRequirement {
  String? title;
  String? name;
  String? emailId;
  String? phoneNo;
  String? address;
  String? gst;
  String? billingAddressName;
  String? billingAddress;
  String? modeOfRequest;
  String? morReference;
  List<ClientreqProduct>? product;
  List? notes;
  String? date;
  int? companyID;
  List<int?> branchID;
  int? customer_type;

  Post_ClientRequirement({
    required this.title,
    required this.name,
    required this.emailId,
    required this.phoneNo,
    required this.address,
    required this.gst,
    required this.billingAddressName,
    required this.billingAddress,
    required this.modeOfRequest,
    required this.morReference,
    required this.product,
    required this.notes,
    required this.date,
    required this.companyID,
    required this.branchID,
    required this.customer_type,
  });

  factory Post_ClientRequirement.fromJson(
    String title,
    String name,
    String emailId,
    String phoneNo,
    String address,
    String gst,
    String billingAddressName,
    // String customerRequirementId,
    String billingAddress,
    String modeOfRequest,
    String morReference,
    List<ClientreqProduct> product,
    List notes,
    String date,
    int companyID,
    List<int?> branchID,
    int customer_type,
  ) {
    return Post_ClientRequirement(
        title: title,
        name: name,
        emailId: emailId,
        phoneNo: phoneNo,
        address: address,
        gst: gst,
        billingAddressName: billingAddressName,
        billingAddress: billingAddress,
        modeOfRequest: modeOfRequest,
        morReference: morReference,
        product: product,
        notes: notes,
        date: date,
        companyID: companyID,
        branchID: branchID,
        customer_type: customer_type);
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
      // "customerrequirementid": customerRequirementId,
      "billingaddress": billingAddress,
      "modeofrequest": modeOfRequest,
      "MORreference": morReference,
      "product": product?.map((item) => item.toJson()).toList(),
      "notes": notes,
      "date": date,
      "companyid": companyID,
      "branchid": branchID,
      "customer_type": customer_type
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
  String? emailid;
  String? client_addressname;
  String? client_address;
  String? billing_addressname;
  String? billing_address;
  String? contact_number;
  String? gst_number;

  Company(
      {required this.companyId,
      required this.companyName,
      required this.emailid,
      required this.client_addressname,
      required this.client_address,
      required this.billing_addressname,
      required this.billing_address,
      required this.contact_number,
      required this.gst_number});

  // Factory method to create an instance from JSON
  factory Company.fromJson(CMDlResponse json, i) {
    return Company(
      companyId: json.data[i]['companyid'],
      companyName: json.data[i]['companyname'],
      emailid: json.data[i]['emailid'],
      client_addressname: json.data[i]['client_addressname'],
      client_address: json.data[i]['client_address'],
      billing_addressname: json.data[i]['billing_addressname'],
      billing_address: json.data[i]['billing_address'],
      contact_number: json.data[i]['contactnumber'],
      gst_number: json.data[i]['gst_number'],
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      "companyid": companyId,
      "companyname": companyName,
      "emailid": emailid,
      "client_addressname": client_addressname,
      "client_address": client_address,
      "billing_addressname": billing_addressname,
      "billing_address": billing_address,
      "contact_number": contact_number,
      "gst_number": gst_number,
    };
  }
}

class Branch {
  int? Branch_id;
  String? Branch_name;
  String? Branch_code;
  String? client_addressname;
  String? client_address;
  String? billing_addressname;
  String? billing_address;
  String? emailid;
  String? contact_number;
  String? gst_number;

  Branch(
      {required this.Branch_id,
      required this.Branch_name,
      required this.Branch_code,
      required this.client_addressname,
      required this.client_address,
      required this.billing_addressname,
      required this.billing_address,
      required this.emailid,
      required this.contact_number,
      required this.gst_number});

  // Factory method to create an instance from JSON
  factory Branch.fromJson(CMDlResponse json, i) {
    return Branch(
      Branch_id: json.data[i]['Branch_id'],
      Branch_name: json.data[i]['Branch_name'],
      Branch_code: json.data[i]['Branch_code'],
      client_addressname: json.data[i]['client_addressname'],
      client_address: json.data[i]['client_address'],
      billing_addressname: json.data[i]['billing_addressname'],
      billing_address: json.data[i]['billing_address'],
      emailid: json.data[i]['emailid'],
      contact_number: json.data[i]['contact_number'],
      gst_number: json.data[i]['gst_number'],
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      "Branch_id": Branch_id,
      "Branch_name": Branch_name,
      "Branch_code": Branch_code,
      "client_addressname": client_addressname,
      "client_address": client_address,
      "billing_addressname": billing_addressname,
      "billing_address": billing_address,
      "emailid": emailid,
      "contact_number": contact_number,
      "gst_number": gst_number,
    };
  }
}
