import 'dart:convert';
import 'dart:typed_data';
import 'package:ssipl_billing/models/entities/Response_entities.dart';

class OrganizationsData {
  final int? organizationId;
  final String? email;
  final String? organizationName;
  final String? orgCode;
  final Uint8List? organizationLogo;
  final String? address;
  final String? siteType;
  final String? contactPerson;
  final String? contactNo;
  bool isSelected;

  OrganizationsData({
    this.organizationId,
    this.email,
    this.organizationName,
    this.orgCode,
    this.organizationLogo,
    this.address,
    this.siteType,
    this.contactPerson,
    this.contactNo,
    this.isSelected = false,
  });

  factory OrganizationsData.fromJson(Map<String, dynamic> json) {
    return OrganizationsData(
      organizationId: json['Organization_id'] as int? ?? 0,
      email: json['Email_id'] as String? ?? "",
      organizationName: json['Organization_Name'] as String? ?? "",
      orgCode: json['orgcode'] as String? ?? "",
      organizationLogo: json['Organization_Logo'] != null && json['Organization_Logo']['data'] != null ? Uint8List.fromList(List<int>.from(json['Organization_Logo']['data'])) : Uint8List(0),
      address: json['Address'] as String? ?? "",
      siteType: json['site_type'] as String? ?? "",
      contactPerson: json['contactperson'] as String? ?? "",
      contactNo: json['contactno'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Organization_id': organizationId,
      'Email_id': email,
      'Organization_Name': organizationName,
      'orgcode': orgCode,
      'Organization_Logo': organizationLogo ?? Uint8List(0),
      'Address': address,
      'site_type': siteType,
      'contactperson': contactPerson,
      'contactno': contactNo,
    };
  }
}

class OrganizationResponse {
  final List<OrganizationsData> Live;
  final List<OrganizationsData> Demo;

  OrganizationResponse({
    required this.Live,
    required this.Demo,
  });

  factory OrganizationResponse.fromCMDmResponse(CMDmResponse response) {
    var data = response.data['Live'][0];

    data.forEach((key, value) {
      if (key != 'Organization_Logo') {
        print('$key: $value');
      }
    });

    return OrganizationResponse(
      Live: (response.data['Live'] as List<dynamic>?)?.map((item) => OrganizationsData.fromJson(item as Map<String, dynamic>)).toList() ?? [],
      Demo: (response.data['Demo'] as List<dynamic>?)?.map((item) => OrganizationsData.fromJson(item as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Live': Live.map((e) => e.toJson()).toList(),
      'Demo': Demo.map((e) => e.toJson()).toList(),
    };
  }
}

class CompanysData {
  final int? customerId;
  final int? organizationId;
  final String? customerName;
  final String? ccode;
  final String? email;
  final Uint8List? customerLogo;
  final String? address;
  final String? billingAddress;
  final String? siteType;
  final String? contactPerson;
  final String? contactPersonNo;
  final String? customerCIN;
  final String? customerPAN;
  final String? customerCode;
  final int? customerType;
  bool isSelected;

  CompanysData({
    this.customerId,
    this.organizationId,
    this.customerName,
    this.ccode,
    this.email,
    this.customerLogo,
    this.address,
    this.billingAddress,
    this.siteType,
    this.contactPerson,
    this.contactPersonNo,
    this.customerCIN,
    this.customerPAN,
    this.customerCode,
    this.customerType,
    this.isSelected = false,
  });

  factory CompanysData.fromJson(Map<String, dynamic> json) {
    return CompanysData(
      customerId: json['Customer_id'] as int? ?? 0,
      organizationId: json['Organization_id'] as int? ?? 0,
      customerName: json['Customer_name'] as String? ?? "",
      ccode: json['ccode'] as String? ?? "",
      email: json['Email_id'] as String? ?? "",
      customerLogo: json['Customer_Logo'] != null && json['Customer_Logo']['data'] != null ? Uint8List.fromList(List<int>.from(json['Customer_Logo']['data'])) : Uint8List(0),
      address: json['address'] as String? ?? "",
      billingAddress: json['billing_address'] as String? ?? "",
      siteType: json['site_type'] as String? ?? "",
      contactPerson: json['contactperson'] as String? ?? "",
      contactPersonNo: json['contactpersonno'] as String? ?? "",
      customerCIN: json['customer_cin'] as String? ?? "",
      customerPAN: json['customer_pan'] as String? ?? "",
      customerCode: json['customercode'] as String? ?? "",
      customerType: json['customer_type'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Customer_id': customerId,
      'Organization_id': organizationId,
      'Customer_name': customerName,
      'ccode': ccode,
      'Email_id': email,
      'Customer_Logo': customerLogo ?? Uint8List(0),
      'address': address,
      'billing_address': billingAddress,
      'site_type': siteType,
      'contactperson': contactPerson,
      'contactpersonno': contactPersonNo,
      'customer_cin': customerCIN,
      'customer_pan': customerPAN,
      'customercode': customerCode,
      'customer_type': customerType,
    };
  }
}

class CompanyResponse {
  final List<CompanysData> Live;
  final List<CompanysData> Demo;

  CompanyResponse({
    required this.Live,
    required this.Demo,
  });

  /// Convert from JSON
  factory CompanyResponse.fromJson(Map<String, dynamic> json) {
    return CompanyResponse(
      Live: (json['Live'] as List<dynamic>? ?? []).map((e) => CompanysData.fromJson(e as Map<String, dynamic>)).toList(),
      Demo: (json['Demo'] as List<dynamic>? ?? []).map((e) => CompanysData.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  /// Convert from CMDmResponse
  factory CompanyResponse.fromCMDmResponse(CMDmResponse response) {
    var data = response.data['Live'][0];

    data.forEach((key, value) {
      if (key != 'Customer_Logo') {
        print('$key: $value');
      }
    });

    return CompanyResponse.fromJson(response.data);
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'Live': Live.map((e) => e.toJson()).toList(),
      'Demo': Demo.map((e) => e.toJson()).toList(),
    };
  }
}

class BranchsData {
  final int? branchId;
  final String? branchName;
  final String? branchCode;
  final String? clientAddressName;
  final String? clientAddress;
  final String? gstNumber;
  final String? emailId;
  final String? contactNumber;
  final String? billingAddress;
  final String? billingAddressName;
  final String? siteType;
  final Uint8List? branchLogo;
  final int? subscriptionId;
  final String? billingPlan;
  final String? billMode;
  final String? fromDate;
  final String? toDate;
  final int? amount;
  final int? billingPeriod;
  bool isSelected;

  BranchsData({
    this.branchId,
    this.branchName,
    this.branchCode,
    this.clientAddressName,
    this.clientAddress,
    this.gstNumber,
    this.emailId,
    this.contactNumber,
    this.billingAddress,
    this.billingAddressName,
    this.siteType,
    this.branchLogo,
    this.subscriptionId,
    this.billingPlan,
    this.billMode,
    this.fromDate,
    this.toDate,
    this.amount,
    this.billingPeriod,
    this.isSelected = false,
  });

  factory BranchsData.fromJson(Map<String, dynamic> json) {
    return BranchsData(
      branchId: json['Branch_id'] ?? 0,
      branchName: json['Branch_name'] ?? '',
      branchCode: json['Branch_code'] ?? '',
      clientAddressName: json['client_addressname'] ?? '',
      clientAddress: json['clientaddress'] ?? '',
      gstNumber: json['gst_number'] ?? '',
      emailId: json['emailid'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      billingAddress: json['billing_address'] ?? '',
      billingAddressName: json['billing_addressname'] ?? '',
      siteType: json['site_type'] ?? '',
      branchLogo: json['Branch_Logo'] != null && json['Branch_Logo']['data'] != null ? Uint8List.fromList(List<int>.from(json['Branch_Logo']['data'])) : Uint8List(0),
      subscriptionId: json['Subscription_ID'] ?? 0,
      billingPlan: json['billing_plan'] ?? '',
      billMode: json['Bill_mode'] ?? '',
      fromDate: json['from_date'] ?? '',
      toDate: json['to_date'] ?? '',
      amount: json['Amount'] ?? 0,
      billingPeriod: json['billingperiod'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Branch_id': branchId,
      'Branch_name': branchName,
      'Branch_code': branchCode,
      'client_addressname': clientAddressName,
      'clientaddress': clientAddress,
      'gst_number': gstNumber,
      'emailid': emailId,
      'contact_number': contactNumber,
      'billing_address': billingAddress,
      'billing_addressname': billingAddressName,
      'site_type': siteType,
      'Branch_Logo': branchLogo ?? Uint8List(0),
      'Subscription_ID': subscriptionId,
      'billing_plan': billingPlan,
      'Bill_mode': billMode,
      'from_date': fromDate,
      'to_date': toDate,
      'Amount': amount,
      'billingperiod': billingPeriod,
    };
  }
}

class BranchResponse {
  final List<BranchsData> Live;
  final List<BranchsData> Demo;

  BranchResponse({
    required this.Live,
    required this.Demo,
  });

  factory BranchResponse.fromCMDmResponse(CMDmResponse response) {
    Map<String, dynamic> data = response.data;
    var data1 = response.data['Live'][0];

    data1.forEach((key, value) {
      if (key != 'Branch_Logo') {
        print('$key: $value');
      }
    });

    return BranchResponse(
      Live: (data['Live'] as List?)?.map((e) => BranchsData.fromJson(e)).toList() ?? [],
      Demo: (data['Demo'] as List?)?.map((e) => BranchsData.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Live': Live.map((e) => e.toJson()).toList(),
      'Demo': Demo.map((e) => e.toJson()).toList(),
    };
  }
}

class BranchLogoUpload {
  final String logotype;
  final int id;
  final Uint8List image;

  BranchLogoUpload({
    required this.logotype,
    required this.id,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "logotype": logotype,
      "id": id,
      "image": base64Encode(image), // Convert Uint8List to Base64 string
    };
  }

  factory BranchLogoUpload.fromJson(Map<String, dynamic> json) {
    return BranchLogoUpload(
      logotype: json["logotype"],
      id: json["id"],
      image: base64Decode(json["image"]), // Convert Base64 string back to Uint8List
    );
  }
}
