import 'package:flutter/foundation.dart';

import 'dart:typed_data';

class VendorsData {
  // Vendor/Company Info
  final int? vendorId;
  final String? vendorName;
  final String? address;
  final String? state;
  final String? pincode;
  final String? contactPersonName;
  final String? contactPersonDesignation;
  final String? contactPersonPhone;
  final String? email;

  // Business Info
  final String? businessType; // Manufacturer/Distributor/Service Provider/Others
  final String? yearOfEstablishment;
  final String? gstNumber;
  final String? panNumber;
  final double? annualTurnover;
  final String? productOrServiceList;
  final String? hsnOrSacCode;
  final String? productOrServiceDescription;

  // Bank Details & Uploads
  final String? isoCertification;
  final String? otherCertifications;
  final String? bankName;
  final String? branch;
  final String? accountNumber;
  final String? ifscCode;

  final Uint8List? registrationCertificate;
  final Uint8List? panUpload;
  final Uint8List? cancelledCheque;
  final Uint8List? vendorLogo;
  bool isSelected;
  VendorsData({
    this.vendorId,
    this.vendorName,
    this.address,
    this.state,
    this.pincode,
    this.contactPersonName,
    this.contactPersonDesignation,
    this.contactPersonPhone,
    this.email,
    this.businessType,
    this.yearOfEstablishment,
    this.gstNumber,
    this.panNumber,
    this.annualTurnover,
    this.productOrServiceList,
    this.hsnOrSacCode,
    this.productOrServiceDescription,
    this.isoCertification,
    this.otherCertifications,
    this.bankName,
    this.branch,
    this.accountNumber,
    this.ifscCode,
    this.registrationCertificate,
    this.panUpload,
    this.cancelledCheque,
    this.vendorLogo,
    this.isSelected = false,
  });

  factory VendorsData.fromJson(Map<String, dynamic> json) {
    return VendorsData(
      vendorId: json['Vendor_id'] ?? 0,
      vendorName: json['vendor_name'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      contactPersonName: json['contact_person_name'] ?? '',
      contactPersonDesignation: json['contact_person_designation'] ?? '',
      contactPersonPhone: json['contact_person_phone'] ?? '',
      email: json['email'] ?? '',
      businessType: json['business_type'] ?? '',
      yearOfEstablishment: json['year_of_establishment'] ?? '',
      gstNumber: json['gst_number'] ?? '',
      panNumber: json['pan_number'] ?? '',
      annualTurnover: json['annual_turnover'] ?? 0.0,
      productOrServiceList: json['product_or_service_list'] ?? '',
      hsnOrSacCode: json['hsn_or_sac_code'] ?? '',
      productOrServiceDescription: json['product_or_service_description'] ?? '',
      isoCertification: json['iso_certification'] ?? '',
      otherCertifications: json['other_certifications'] ?? '',
      bankName: json['bank_name'] ?? '',
      branch: json['branch'] ?? '',
      accountNumber: json['account_number'] ?? '',
      ifscCode: json['ifsc_code'] ?? '',
      registrationCertificate: json['registration_certificate'] != null && json['registration_certificate']['data'] != null ? Uint8List.fromList(List<int>.from(json['registration_certificate']['data'])) : null,
      panUpload: json['pan_upload'] != null && json['pan_upload']['data'] != null ? Uint8List.fromList(List<int>.from(json['pan_upload']['data'])) : null,
      cancelledCheque: json['cancelled_cheque'] != null && json['cancelled_cheque']['data'] != null ? Uint8List.fromList(List<int>.from(json['cancelled_cheque']['data'])) : null,
      vendorLogo: json['Vendor_Logo'] != null && json['Vendor_Logo']['data'] != null ? Uint8List.fromList(List<int>.from(json['Vendor_Logo']['data'])) : Uint8List(0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Vendor_id': vendorId,
      'vendor_name': vendorName,
      'address': address,
      'state': state,
      'pincode': pincode,
      'contact_person_name': contactPersonName,
      'contact_person_designation': contactPersonDesignation,
      'contact_person_phone': contactPersonPhone,
      'email': email,
      'business_type': businessType,
      'year_of_establishment': yearOfEstablishment,
      'gst_number': gstNumber,
      'pan_number': panNumber,
      'annual_turnover': annualTurnover,
      'product_or_service_list': productOrServiceList,
      'hsn_or_sac_code': hsnOrSacCode,
      'product_or_service_description': productOrServiceDescription,
      'iso_certification': isoCertification,
      'other_certifications': otherCertifications,
      'bank_name': bankName,
      'branch': branch,
      'account_number': accountNumber,
      'ifsc_code': ifscCode,
      'registration_certificate': registrationCertificate,
      'pan_upload': panUpload,
      'cancelled_cheque': cancelledCheque,
      'Vendor_Logo': vendorLogo ?? Uint8List(0),
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
