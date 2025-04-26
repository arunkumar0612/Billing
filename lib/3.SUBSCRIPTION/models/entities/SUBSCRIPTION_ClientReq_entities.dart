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

class SUBSCRIPTION_Post_ClientRequirement {
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
  List<SUBSCRIPTION_ClientreqSites>? site;
  List? notes;
  String? date;
  int? companyid;
  // int? companyID;
  // List<int?> branchID;
  // int? customer_type;

  SUBSCRIPTION_Post_ClientRequirement({
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
    required this.site,
    required this.notes,
    required this.date,
    required this.companyid,
    // required this.companyID,
    // required this.branchID,
    // required this.customer_type,
  });

  factory SUBSCRIPTION_Post_ClientRequirement.fromJson(
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
    List<SUBSCRIPTION_ClientreqSites> site,
    List notes,
    String date,
    int? companyid,
    // int companyID,
    // List<int?> branchID,
    // int customer_type,
  ) {
    return SUBSCRIPTION_Post_ClientRequirement(
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
        site: site,
        notes: notes,
        date: date,
        companyid: companyid
        // companyID: companyID,
        // branchID: branchID,
        // customer_type: customer_type
        );
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
      "site": site?.map((item) => item.toJson()).toList(),
      "notes": notes,
      "date": date,
      "companyid": companyid,
      // "companyid": companyID,
      // "branchid": branchID,
      // "customer_type": customer_type
    };
  }
}

class SUBSCRIPTION_ClientreqSites {
  const SUBSCRIPTION_ClientreqSites(
    this.sno,
    this.siteName,
    this.cameraquantity,
    this.siteAddress,
  );

  final String sno;
  final String siteName;
  final int cameraquantity;
  final String siteAddress;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno;
      case 1:
        return siteName;

      case 2:
        return cameraquantity.toString();
      case 3:
        return siteAddress;
    }
    return '';
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      "sno": sno,
      "sitename": siteName,
      "cameraquantity": cameraquantity,
      "address": siteAddress,
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
      contact_number: json.data[i]['contact_number'],
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
