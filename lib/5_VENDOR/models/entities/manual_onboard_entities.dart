class ManualOnboard {
  final String vendorName;
  final String address;
  final String state;
  final String pincode;
  final String contactPersonName;
  final String contactPersonDesignation;
  final String contactPersonPhone;
  final String email;
  final String businessType;
  final String yearOfEstablishment;
  final String gstNumber;
  final String panNumber;
  final double annualTurnover;
  final String productsServices;
  final String hsnSacCode;
  final String description;
  final String bankName;
  final String branchName;
  final String accountNumber;
  final String ifscCode;
  final String? isoCertification;
  final String? otherCertifications;
  // final File gstRegCertificate;
  // final File panCard;
  // final File cancelledCheque;

  ManualOnboard({
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
    // required this.gstRegCertificate,
    // required this.panCard,
    // required this.cancelledCheque
  });

  factory ManualOnboard.fromJson(Map<String, dynamic> json) {
    return ManualOnboard(
        vendorName: json['vendorname'],
        address: json['address'],
        state: json['state'],
        pincode: json['pincode'],
        contactPersonName: json['contactpersonname'],
        contactPersonDesignation: json['contactpersondesignation'],
        contactPersonPhone: json['contactpersonphone'],
        email: json['email'],
        businessType: json['businesstype'],
        yearOfEstablishment: json['yearofestablishment'],
        gstNumber: json['gstnumber'],
        panNumber: json['pannumber'],
        annualTurnover: json['annualturnover']?.toDouble() ?? 0.0,
        productsServices: json['productsservices'],
        hsnSacCode: json['hsnsaccode'],
        description: json['description'],
        bankName: json['bankname'],
        branchName: json['branchname'],
        accountNumber: json['accountnumber'],
        ifscCode: json['ifsccode'],
        isoCertification: json['isocertification'],
        otherCertifications: json['othercertifications']);
  }

  Map<String, dynamic> toJson() {
    return {
      "vendorname": vendorName,
      "address": address,
      "state": state,
      "pincode": pincode,
      "contactpersonname": contactPersonName,
      "contactpersondesignation": contactPersonDesignation,
      "contactpersonphone": contactPersonPhone,
      "email": email,
      "businesstype": businessType,
      "yearofestablishment": yearOfEstablishment,
      "gstnumber": gstNumber,
      "pannumber": panNumber,
      "annualturnover": annualTurnover,
      "productsservices": productsServices,
      "hsnsaccode": hsnSacCode,
      "description": description,
      "bankname": bankName,
      "branchname": branchName,
      "accountnumber": accountNumber,
      "ifsccode": ifscCode,
      "isocertification": isoCertification,
      'othercertifications': otherCertifications
    };
  }
}
