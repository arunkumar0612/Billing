import 'package:ssipl_billing/5_VENDOR/models/entities/product_entities.dart';
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
  // final String? title;
  // final String? name;
  // final String? emailId;
  // final String? phoneNo;
  // final String? address;
  // final String? gst;
  // final String? billingAddressName;
  // final String? billingAddress;
  // final List<RFQProduct> product;
  RequiredData({
    required this.eventnumber,
    // required this.title,
    // required this.name,
    // required this.emailId,
    // required this.phoneNo,
    // required this.address,
    // required this.gst,
    // required this.billingAddressName,
    // required this.billingAddress,
    // required this.product
  });

  factory RequiredData.fromJson(CMDmResponse json) {
    return RequiredData(
      eventnumber: json.data['rfq_id'] as String,
      // title: json.data['title'] as String,
      // name: json.data['client_addressname'] as String,
      // emailId: json.data['emailid'] as String,
      // phoneNo: json.data['contact_number'] as String,
      // address: json.data['client_address'] as String,
      // gst: json.data['gstnumber'] as String,
      // billingAddressName: json.data['billingaddress_name'] as String,
      // billingAddress: json.data['billing_address'] as String,
      // product: (json.data['product'] as List<dynamic>)
      //     .map((e) => RFQProduct.fromJson(e)) // ✅ Convert each item to RfqProduct
      //     .toList(),
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

  int? vendorID;
  String? vendorName;
  String? vendorAddress;
  String? GSTIN;
  String? PAN;
  String? Contact_person;
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

  Post_Rfq({
    required this.title,
    required this.vendorID,
    required this.vendorName,
    required this.vendorAddress,
    required this.GSTIN,
    required this.PAN,
    required this.Contact_person,
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
  });

  factory Post_Rfq.fromJson({
    required String title,
    required int vendorID,
    required String vendorName,
    required String vendorAddress,
    required String GSTIN,
    required String PAN,
    required String Contact_person,
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
  }) {
    return Post_Rfq(
      title: title,
      GSTIN: GSTIN,
      PAN: PAN,
      Contact_person: Contact_person,
      vendorID: vendorID,
      vendorName: vendorName,
      vendorAddress: vendorAddress,

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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vendorname": vendorName,
      "vendorid": vendorID,
      "GSTIN": GSTIN,
      "PAN": PAN,
      "Contact_person": Contact_person,
      "vendoraddress": vendorAddress,
      "product": product?.map((item) => item.toJson()).toList(),
      "notes": notes,
      "messagetype": messageType,
      "feedback": feedback,
      "title": title,

      "emailid": emailId,
      "phoneno": phoneNo,
      // "gst_number": gst,
      "date": date,
      "rfqgenid": rfqGenID,
      "ccemail": ccEmail,
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

/// Represents a Vendor entity with details like contact, bank, and certification information.
class VendorList {
  int vendorId;
  String vendorName;
  String address;
  String state;
  String pincode;
  String contactPersonName;
  String contactPersonDesignation;
  String contactPersonPhone;
  String email;
  String businessType;
  int yearOfEstablishment;
  String gstNumber;
  String panNumber;
  String annualTurnover;
  String productsServices;
  String hsnSacCode;
  String description;
  String bankName;
  String branchName;
  String accountNumber;
  String ifscCode;
  String? isoCertification;
  String? otherCertifications;
  String registrationCertificatePath;
  String panUploadPath;
  String cancelledChequePath;
  String createdAt;
  String updatedAt;
  String logoPath;

  VendorList({
    required this.vendorId,
    required this.vendorName,
    required this.address,
    required this.state,
    required this.pincode,
    required this.contactPersonName,
    required this.contactPersonDesignation,
    required this.contactPersonPhone,
    required this.email,
    required this.businessType,
    required this.yearOfEstablishment,
    required this.gstNumber,
    required this.panNumber,
    required this.annualTurnover,
    required this.productsServices,
    required this.hsnSacCode,
    required this.description,
    required this.bankName,
    required this.branchName,
    required this.accountNumber,
    required this.ifscCode,
    this.isoCertification,
    this.otherCertifications,
    required this.registrationCertificatePath,
    required this.panUploadPath,
    required this.cancelledChequePath,
    required this.createdAt,
    required this.updatedAt,
    required this.logoPath,
  });

  /// Creates a Vendor object from a JSON map.
  factory VendorList.fromJson(Map<String, dynamic> json) {
    return VendorList(
      vendorId: json['vendorid'],
      vendorName: json['vendor_name'],
      address: json['address'],
      state: json['state'],
      pincode: json['pincode'],
      contactPersonName: json['contact_person_name'],
      contactPersonDesignation: json['contact_person_designation'],
      contactPersonPhone: json['contact_person_phone'],
      email: json['email'],
      businessType: json['business_type'],
      yearOfEstablishment: json['year_of_establishment'],
      gstNumber: json['gst_number'],
      panNumber: json['pan_number'],
      annualTurnover: json['annual_turnover'],
      productsServices: json['products_services'],
      hsnSacCode: json['hsn_sac_code'],
      description: json['description'],
      bankName: json['bank_name'],
      branchName: json['branch_name'],
      accountNumber: json['account_number'],
      ifscCode: json['ifsc_code'],
      isoCertification: json['iso_certification'],
      otherCertifications: json['other_certifications'],
      registrationCertificatePath: json['registration_certificate_path'],
      panUploadPath: json['pan_upload_path'],
      cancelledChequePath: json['cancelled_cheque_path'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      logoPath: json['logo_path'],
    );
  }

  /// Converts the Vendor object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'vendorid': vendorId,
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
      'products_services': productsServices,
      'hsn_sac_code': hsnSacCode,
      'description': description,
      'bank_name': bankName,
      'branch_name': branchName,
      'account_number': accountNumber,
      'ifsc_code': ifscCode,
      'iso_certification': isoCertification,
      'other_certifications': otherCertifications,
      'registration_certificate_path': registrationCertificatePath,
      'pan_upload_path': panUploadPath,
      'cancelled_cheque_path': cancelledChequePath,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'logo_path': logoPath,
    };
  }
}

/// Represents a product or service offered by a vendor.
class VendorProduct_suggestions {
  int id;
  int vendorId;
  String productName;
  String gstPercent;
  String hsn;
  String lastKnownPrice;

  VendorProduct_suggestions({
    required this.id,
    required this.vendorId,
    required this.productName,
    required this.gstPercent,
    required this.hsn,
    required this.lastKnownPrice,
  });

  /// Creates a VendorProduct object from a JSON map.
  factory VendorProduct_suggestions.fromJson(Map<String, dynamic> json) {
    return VendorProduct_suggestions(
      id: json['id'],
      vendorId: json['vendorid'],
      productName: json['productname'],
      gstPercent: json['gstpercent'],
      hsn: json['hsn'],
      lastKnownPrice: json['lastknown_price'],
    );
  }

  /// Converts the VendorProduct object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorid': vendorId,
      'productname': productName,
      'gstpercent': gstPercent,
      'hsn': hsn,
      'lastknown_price': lastKnownPrice,
    };
  }
}
