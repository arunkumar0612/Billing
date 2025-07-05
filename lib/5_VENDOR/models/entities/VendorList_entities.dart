import 'package:flutter/foundation.dart';

class VendorsData {
  final int? vendorId;
  final String? vendorName;
  final String? vendorCode;
  final String? clientAddressName;
  final String? clientAddress;
  final String? gstNumber;
  final String? emailId;
  final String? contactNumber;
  final String? contact_person;
  final String? billingAddress;
  final String? billingAddressName;
  final String? siteType;
  final Uint8List? vendorLogo;
  final int? subscriptionId;
  final String? billingPlan;
  final String? billMode;
  final String? fromDate;
  final String? toDate;
  final int? amount;
  final int? billingPeriod;
  bool isSelected;

  VendorsData({
    this.vendorId,
    this.vendorName,
    this.vendorCode,
    this.clientAddressName,
    this.clientAddress,
    this.gstNumber,
    this.emailId,
    this.contactNumber,
    this.contact_person,
    this.billingAddress,
    this.billingAddressName,
    this.siteType,
    this.vendorLogo,
    this.subscriptionId,
    this.billingPlan,
    this.billMode,
    this.fromDate,
    this.toDate,
    this.amount,
    this.billingPeriod,
    this.isSelected = false,
  });

  factory VendorsData.fromJson(Map<String, dynamic> json) {
    return VendorsData(
      vendorId: json['Vendor_id'] ?? 0,
      vendorName: json['Vendor_name'] ?? '',
      vendorCode: json['Vendor_code'] ?? '',
      clientAddressName: json['client_addressname'] ?? '',
      clientAddress: json['clientaddress'] ?? '',
      gstNumber: json['gst_number'] ?? '',
      emailId: json['emailid'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      contact_person: json['contact_person'] ?? '',
      billingAddress: json['billing_address'] ?? '',
      billingAddressName: json['billing_addressname'] ?? '',
      siteType: json['site_type'] ?? '',
      vendorLogo: json['Vendor_Logo'] != null && json['Vendor_Logo']['data'] != null ? Uint8List.fromList(List<int>.from(json['Vendor_Logo']['data'])) : Uint8List(0),
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
      'Vendor_id': vendorId,
      'Vendor_name': vendorName,
      'Vendor_code': vendorCode,
      'client_addressname': clientAddressName,
      'clientaddress': clientAddress,
      'gst_number': gstNumber,
      'emailid': emailId,
      'contact_number': contactNumber,
      'contact_person': contact_person,
      'billing_address': billingAddress,
      'billing_addressname': billingAddressName,
      'site_type': siteType,
      'Vendor_Logo': vendorLogo ?? Uint8List(0),
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

// class VendorResponse {
//   final List<VendorsData> Live;

//   VendorResponse({
//     required this.Live,
//   });

//   factory VendorResponse.fromCMDmResponse(CMDmResponse response) {
//     Map<String, dynamic> data = response.data;
//     var data1 = response.data['Live'][0];

//     data1.forEach((key, value) {
//       if (key != 'Vendor_Logo') {
//         if (kDebugMode) {
//           print('$key: $value');
//         }
//       }
//     });

//     return VendorResponse(
//       Live: (data['Live'] as List?)?.map((e) => VendorsData.fromJson(e)).toList() ?? [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {};
//   }
// }
