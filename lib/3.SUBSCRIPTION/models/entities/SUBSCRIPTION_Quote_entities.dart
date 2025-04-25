import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
import 'package:ssipl_billing/UTILS-/helpers/support_functions.dart';

class SUBSCRIPTION_QuoteRecommendation {
  final String key;
  final String value;

  SUBSCRIPTION_QuoteRecommendation({
    required this.key,
    required this.value,
  });

  factory SUBSCRIPTION_QuoteRecommendation.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_QuoteRecommendation(
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

// class SUBSCRIPTION_QuoteGSTtotals {
//   final double gst;
//   final double total;

//   SUBSCRIPTION_QuoteGSTtotals({
//     required this.gst,
//     required this.total,
//   });

//   factory SUBSCRIPTION_QuoteGSTtotals.fromJson(Map<String, dynamic> json) {
//     return SUBSCRIPTION_QuoteGSTtotals(gst: json['GST'], total: json['total']);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'GST': gst,
//       'total': total,
//     };
//   }
// }

class SubscriptionQuoteRequiredData {
  final String eventNumber;
  final int companyid;
  final String? title;
  final String? name;
  final String? emailId;
  final String? phoneNo;
  final String? address;
  final String? gst;
  final String? billingAddressName;
  final String? billingAddress;
  final List<SubscriptionItem> subscription;

  SubscriptionQuoteRequiredData({
    required this.eventNumber,
    required this.companyid,
    this.title,
    this.name,
    this.emailId,
    this.phoneNo,
    this.address,
    this.gst,
    this.billingAddressName,
    this.billingAddress,
    required this.subscription,
  });

  factory SubscriptionQuoteRequiredData.fromJson(CMDmResponse json) {
    return SubscriptionQuoteRequiredData(
      eventNumber: json.data['eventnumber'] as String,
      companyid: json.data['companyid'] as int,
      title: json.data['title'] as String?,
      name: json.data['client_addressname'] as String?,
      emailId: json.data['emailid'] as String?,
      phoneNo: json.data['contact_number'] as String?,
      address: json.data['client_address'] as String?,
      gst: json.data['gstnumber'] as String?,
      billingAddressName: json.data['billingaddress_name'] as String?,
      billingAddress: json.data['billing_address'] as String?,
      subscription: (json.data['subscription'] as List<dynamic>?)?.map((item) => SubscriptionItem.fromJson(item as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventnumber': eventNumber,
      'companyid': companyid,
      'title': title,
      'client_addressname': name,
      'emailid': emailId,
      'contact_number': phoneNo,
      'client_address': address,
      'gstnumber': gst,
      'billingaddress_name': billingAddressName,
      'billing_address': billingAddress,
      'subscription': subscription.map((item) => item.toJson()).toList(),
    };
  }
}

class SubscriptionItem {
  final int requirementId;
  final String siteName;
  final int cameraQuantity;
  final String address;
  final String notes;

  SubscriptionItem({
    required this.requirementId,
    required this.siteName,
    required this.cameraQuantity,
    required this.address,
    required this.notes,
  });

  factory SubscriptionItem.fromJson(Map<String, dynamic> json) {
    return SubscriptionItem(
      requirementId: json['requirement_id'] as int,
      siteName: json['sitename'] as String,
      cameraQuantity: json['camera_quantity'] as int,
      address: json['Address'] as String,
      notes: json['Notes'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requirement_id': requirementId,
      'sitename': siteName,
      'camera_quantity': cameraQuantity,
      'Address': address,
      'Notes': notes,
    };
  }
}

class SUBSCRIPTION_PostQuotation {
  int? processid;
  String? clientaddressname;
  String? clientaddress;
  String? billingaddressname;
  String? billingaddress;
  List<Site>? sitelist;
  List? notes;
  String? emailid;
  String? phoneno;
  String? ccemail;
  String? date;
  String? quotationgenid;
  int? messagetype;
  String? feedback;
  int? packageid;

  SUBSCRIPTION_PostQuotation({
    required this.processid,
    required this.clientaddressname,
    required this.clientaddress,
    required this.billingaddressname,
    required this.billingaddress,
    required this.sitelist,
    required this.notes,
    required this.emailid,
    required this.phoneno,
    required this.ccemail,
    required this.date,
    required this.quotationgenid,
    required this.messagetype,
    required this.feedback,
    required this.packageid,
  });

  factory SUBSCRIPTION_PostQuotation.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_PostQuotation(
      processid: json["processid"],
      clientaddressname: json["clientaddressname"],
      clientaddress: json["clientaddress"],
      billingaddressname: json["billingaddressname"],
      billingaddress: json["billingaddress"],
      sitelist: (json["sitelist"])?.map((item) => Site.fromJson(item)).toList(),
      notes: json["notes"],
      emailid: json["emailid"],
      phoneno: json["phoneno"],
      ccemail: json["ccemail"],
      date: json["date"],
      quotationgenid: json["quotationgenid"],
      messagetype: json["messagetype"],
      feedback: json["feedback"],
      packageid: json["packageid"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "processid": processid,
      "clientaddressname": clientaddressname,
      "clientaddress": clientaddress,
      "billingaddressname": billingaddressname,
      "billingaddress": billingaddress,
      "sitelist": sitelist?.map((item) => item.toJson()).toList(),
      "notes": notes,
      "emailid": emailid,
      "phoneno": phoneno,
      "ccemail": ccemail,
      "date": date,
      "quotationgenid": quotationgenid,
      "messagetype": messagetype,
      "feedback": feedback,
      "packageid": packageid,
    };
  }
}

class SUBSCRIPTION_Quote {
  final String date;
  final String quoteNo;
  final int gstPercent;
  final String GSTIN;
  final Address addressDetails;
  // final List<Map<String, dynamic>> package_Mapped_sites;
  final List<Package> packageMappedSites;
  final List<Site> siteData;
  final FinalCalculation finalCalc;
  final List<String> notes;
  SUBSCRIPTION_Quote({
    required this.date,
    required this.quoteNo,
    required this.gstPercent,
    required this.GSTIN,
    required this.addressDetails,
    // required this.package_Mapped_sites,
    required this.packageMappedSites,
    required this.siteData,
    required this.finalCalc,
    required this.notes,
  });

  // Convert JSON to Invoice object
  factory SUBSCRIPTION_Quote.fromJson(Map<String, dynamic> json, List<Site> sies) {
    List<Package> packages = (json['packageMappedSites'] as List<Package>).map((item) => Package.fromJson(item.toJson())).toList();
    List<int> amounts = packages.map((pkg) => int.parse(pkg.amount)).toList();
    // List<Map<String, dynamic>> siteList = List<Map<String, dynamic>>.from(json['siteData']);
    // List<Site> sites = Site.fromJson(siteList);
    // List<Site> sites = Site.fromJson(List<Map<String, dynamic>>.from(json['siteData']));

    return SUBSCRIPTION_Quote(
      date: json['date'] as String,
      quoteNo: json['quoteNo'] as String,
      gstPercent: json['gstPercent'] as int,
      GSTIN: json['GSTIN'] as String,
      addressDetails: Address.fromJson(json['addressDetails']),
      // package_Mapped_sites: json['package_Mapped_sites'],
      packageMappedSites: (json['packageMappedSites'] as List<Package>).map((item) => Package.fromJson(item.toJson())).toList(),
      siteData: sies,
      finalCalc: FinalCalculation.fromJson(
        sies,
        amounts,
        json['gstPercent'] as int,
        json['pendingAmount'] as double,
      ),
      notes: ['This is a sample note', 'This is another sample note'],
    );
  }

  // Convert Invoice object to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'invoiceNo': quoteNo,
      'gstPercent': gstPercent,
      'packageMappedSites': packageMappedSites.map((pkg) => pkg.toJson()).toList(), // Corrected Site List Serialization
      'finalCalc': finalCalc.toJson(), 'siteData': Site.toJsonList(siteData),
      'addressDetails': addressDetails.toJson(),
      'notes': notes,
    };
  }

  dynamic getIndex(int col, int siteIndex) {
    Package? findPackageBySiteName(String sitename) {
      for (var package in packageMappedSites) {
        for (var site in package.sites) {
          if (site.sitename == sitename) {
            return package; // Return the package name when the site is found
          }
        }
      }
      return null; // Return this if no package contains the site
    }

    switch (col) {
      case 0:
        return siteIndex.toString();
      case 1:
        return findPackageBySiteName(siteData[siteIndex].sitename)!.name;
      case 2:
        return siteData[siteIndex].sitename;
      case 3:
        return siteData[siteIndex].address;
      case 4:
        return findPackageBySiteName(siteData[siteIndex].sitename)!.cameracount.toString();
      case 5:
        return findPackageBySiteName(siteData[siteIndex].sitename)!.amount.toString();
      // case 5:
      //   return Price.toString();
      default:
        return "";
    }
  }
}

class Address {
  final String clientName;
  final String clientAddress;
  final String billingName;
  final String billingAddress;

  Address({required this.clientName, required this.clientAddress, required this.billingName, required this.billingAddress});

  // Convert JSON to Address object
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      clientName: json['clientName'] as String,
      clientAddress: json['clientAddress'] as String,
      billingName: json['billingName'] as String,
      billingAddress: json['billingAddress'] as String,
    );
  }

  // Convert Address object to JSON
  Map<String, dynamic> toJson() {
    return {'clientName': clientName, 'clientAddress': clientAddress, 'billingName': billingName, 'billingAddress': billingAddress};
  }
}

class Package {
  String name;
  String description;
  String cameracount;
  String amount;
  // String additionalCameras;
  String subscriptiontype;
  List<Site> sites;

  // Reactive states
  RxList<int> selectedIndices = <int>[].obs;
  RxBool showSiteList = false.obs;
  RxBool editingMode = false.obs;

  // Temp values for editing
  RxString tempName = ''.obs;
  RxString tempDescription = ''.obs;
  RxString tempcameracount = ''.obs;
  RxString tempAmount = ''.obs;
  // RxString tempAdditionalCameras = ''.obs;
  RxString tempShow = ''.obs;

  Package({
    required this.name,
    required this.description,
    required this.cameracount,
    required this.amount,
    // required this.additionalCameras,
    required this.subscriptiontype,
    required this.sites,
  }) {
    // Init reactive values
    selectedIndices = <int>[].obs;
    showSiteList = false.obs;
    editingMode = false.obs;

    tempName = name.obs;
    tempDescription = description.obs;
    tempcameracount = cameracount.obs;
    tempAmount = amount.obs;
    // tempAdditionalCameras = additionalCameras.obs;
    tempShow = subscriptiontype.obs;
  }

  // JSON methods
  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      name: json['name'] as String,
      description: json['description'] as String,
      cameracount: json['cameracount'] as String,
      amount: json['amount'] as String,
      // additionalCameras: json['additional_cameras'] as String,
      subscriptiontype: json['subscriptiontype'] as String,
      sites: Site.fromJson(List<Map<String, dynamic>>.from(json['sites'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'cameracount': cameracount,
      'amount': amount,
      // 'additional_cameras': additionalCameras,
      'subscriptiontype': subscriptiontype,
      'sites': sites.map((site) => site.toJson()).toList(),
    };
  }

  // Save changes from temp fields
  void saveChanges() {
    name = tempName.value;
    description = tempDescription.value;
    cameracount = tempcameracount.value;
    amount = tempAmount.value;
    // additionalCameras = tempAdditionalCameras.value;
    subscriptiontype = tempShow.value;
    editingMode.value = false;
  }

  // Cancel edit
  void cancelEditing() {
    tempName.value = name;
    tempDescription.value = description;
    tempcameracount.value = cameracount;
    tempAmount.value = amount;
    // tempAdditionalCameras.value = additionalCameras;
    tempShow.value = subscriptiontype;
    editingMode.value = false;
  }

  // Add/remove site helpers
  void addSite(Site site) => sites.add(site);
  void removeSite(int index) => sites.removeAt(index);

  // Toggle selection for site
  void toggleSiteSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }

  // Equality & Copying
  @override
  bool operator ==(Object other) => identical(this, other) || other is Package && name == other.name && description == other.description;

  @override
  int get hashCode => name.hashCode ^ description.hashCode;

  Package copyWith({
    String? name,
    String? description,
    String? cameracount,
    String? amount,
    String? additionalCameras,
    String? show,
    List<Site>? sites,
  }) {
    return Package(
      name: name ?? this.name,
      description: description ?? this.description,
      cameracount: cameracount ?? this.cameracount,
      amount: amount ?? this.amount,
      // additionalCameras: additionalCameras ?? this.additionalCameras,
      subscriptiontype: show ?? subscriptiontype,
      sites: sites ?? List.from(this.sites),
    );
  }

  // Optional: validation placeholder
  bool isValid() {
    return name.isNotEmpty && cameracount.isNotEmpty && amount.isNotEmpty;
  }
}

class Site {
  static int _counter = 1;
  String serialNo;
  String sitename;
  String address;
  // String packageName;
  int cameraquantity;
  // int basicPrice;
  // int Price;
  // final String selectedPackage;
  // final PackageDetails? packageDetails;
  final String billingType;
  final String mailType;

  Site({
    required this.sitename,
    required this.address,
    // required this.packageName,
    required this.cameraquantity,
    // required this.basicPrice,
    // required this.Price,
    // required this.selectedPackage,
    // this.packageDetails,
    required this.billingType,
    required this.mailType,
  }) : serialNo = (_counter++).toString();

  static List<Site> fromJson(List<Map<String, dynamic>> jsonList) {
    _counter = 1;
    return jsonList.map((json) {
      return Site(
        sitename: json['sitename'] as String,
        address: json['siteaddress'] as String,
        // packageName: json['packageName'] as String,
        cameraquantity: json['cameraquantity'] as int,
        // basicPrice: json['basicPrice'] as int,
        // Price: json['specialPrice'] as int,
        // selectedPackage: json['selectedPackage'] as String,
        // packageDetails: json['packageDetails'] != null ? PackageDetails.fromJson(json['packageDetails']) : null,
        billingType: json['billingType'] as String,
        mailType: json['mailType'] as String,
      );
    }).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<Site> sites) {
    return sites.map((site) => site.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'serialNo': serialNo,
      'sitename': sitename,
      'siteaddress': address,
      // 'packageName': packageName,
      'cameraquantity': cameraquantity,
      // 'basicPrice': basicPrice,
      // 'specialPrice': Price,
      // 'selectedPackage': selectedPackage,
      // 'packageDetails': packageDetails?.toJson(),
      "billingType": billingType,
      "mailType": mailType,
    };
  }

  dynamic getIndex(int col) {
    switch (col) {
      case 0:
        return serialNo;
      // case 1:
      //   return packageName;
      case 1:
        return sitename;
      case 2:
        return address;
      case 3:
        return cameraquantity.toString();
      // case 5:
      //   return basicPrice.toString();
      // case 5:
      //   return Price.toString();
      default:
        return "";
    }
  }
}

class FinalCalculation {
  final double subtotal;
  final double igst;
  final double cgst;
  final double sgst;
  final String roundOff;
  final String differene;
  final double total;
  final double? pendingAmount;
  final double grandTotal;

  FinalCalculation({
    required this.subtotal,
    required this.igst,
    required this.cgst,
    required this.sgst,
    required this.roundOff,
    required this.differene,
    required this.total,
    required this.pendingAmount,
    required this.grandTotal,
  });

  factory FinalCalculation.fromJson(List<Site> sites, List<int> prices, int gstPercent, double? pendingAmount) {
    double subtotal = 0;

    for (int i = 0; i < sites.length; i++) {
      subtotal += prices[i];
    }

    double igst = (subtotal * gstPercent) / 100;
    double cgst = (subtotal * (gstPercent / 2)) / 100;
    double sgst = (subtotal * (gstPercent / 2)) / 100;
    double total = subtotal + cgst + sgst;
    double grandTotal = pendingAmount != null ? total + pendingAmount : total;

    return FinalCalculation(
      subtotal: subtotal,
      igst: igst,
      cgst: cgst,
      sgst: sgst,
      roundOff: formatCurrencyRoundedPaisa(total),
      differene:
          '${((double.parse(formatCurrencyRoundedPaisa(total).replaceAll(',', '')) - total) >= 0 ? '+' : '')}${(double.parse(formatCurrencyRoundedPaisa(total).replaceAll(',', '')) - total).toStringAsFixed(2)}',
      total: total,
      pendingAmount: pendingAmount,
      grandTotal: grandTotal,
    );
  }

  Map<String, dynamic> toJson() {
    return {'subtotal': subtotal, 'IGST': igst, 'CGST': cgst, 'SGST': sgst, 'roundOff': roundOff, 'difference': differene, 'total': total, 'pendingAmount': pendingAmount, 'grandTotal': grandTotal};
  }
}

class CompanyBasedPackages {
  final int? subscriptionId;
  final String? subscriptionName;
  // final int? noOfDevices;
  final int? noOfCameras;
  final int? addlCameras;
  // final dynamic addlPatrol;
  // final dynamic patrolHours;
  // final dynamic validMonths;
  // final dynamic validYears;
  // final dynamic validDays;
  // final dynamic noOfAnalytics;
  // final dynamic cloudStorage;
  final int? amount;
  final String? productDesc;

  CompanyBasedPackages({
    this.subscriptionId,
    this.subscriptionName,
    // this.noOfDevices,
    this.noOfCameras,
    this.addlCameras,
    // this.addlPatrol,
    // this.patrolHours,
    // this.validMonths,
    // this.validYears,
    // this.validDays,
    // this.noOfAnalytics,
    // this.cloudStorage,
    this.amount,
    this.productDesc,
  });

  factory CompanyBasedPackages.fromJson(Map<String, dynamic> json) {
    return CompanyBasedPackages(
      subscriptionId: json['Subscription_ID'],
      subscriptionName: json['Subscription_Name'],
      // noOfDevices: json['No_of_Devices'],
      noOfCameras: json['No_of_Cameras'],
      addlCameras: json['Addl_cameras'],
      // addlPatrol: json['Addl_patrol'],
      // patrolHours: json['Patrol_hours'],
      // validMonths: json['Valid_Months'],
      // validYears: json['Valid_Years'],
      // validDays: json['Valid_Days'],
      // noOfAnalytics: json['No_of_Analytics'],
      // cloudStorage: json['Cloud_Storage'],
      amount: json['Amount'],
      productDesc: json['product_desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Subscription_ID': subscriptionId,
      'Subscription_Name': subscriptionName,
      // 'No_of_Devices': noOfDevices,
      'No_of_Cameras': noOfCameras,
      'Addl_cameras': addlCameras,
      // 'Addl_patrol': addlPatrol,
      // 'Patrol_hours': patrolHours,
      // 'Valid_Months': validMonths,
      // 'Valid_Years': validYears,
      // 'Valid_Days': validDays,
      // 'No_of_Analytics': noOfAnalytics,
      // 'Cloud_Storage': cloudStorage,
      'Amount': amount,
      'product_desc': productDesc,
    };
  }

  static List<CompanyBasedPackages> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => CompanyBasedPackages.fromJson(item)).toList();
  }
}

class PostSubQuote {
  final int companyid;
  final int processId;
  final String clientAddressName;
  final String clientAddress;
  final String billingAddress;
  final String billingAddressName;
  final List<Package> packageDetails;
  final List<String> notes;
  final String emailId;
  final String phoneNo;
  final String ccEmail;
  final String date;
  final String quotationGenId;
  final int messageType;
  final int gstPercent;
  final String gstNumber;
  final String feedback;

  PostSubQuote({
    required this.companyid,
    required this.processId,
    required this.clientAddressName,
    required this.clientAddress,
    required this.billingAddress,
    required this.billingAddressName,
    required this.packageDetails,
    required this.notes,
    required this.emailId,
    required this.phoneNo,
    required this.ccEmail,
    required this.date,
    required this.quotationGenId,
    required this.messageType,
    required this.gstPercent,
    required this.gstNumber,
    required this.feedback,
  });

  factory PostSubQuote.fromJson(Map<String, dynamic> json) {
    return PostSubQuote(
      companyid: json['companyid'],
      processId: json['processid'],
      clientAddressName: json['clientaddressname'],
      clientAddress: json['clientaddress'],
      billingAddress: json['billingaddress'],
      billingAddressName: json['billingaddressname'],
      packageDetails: (json['packagedetails'] as List<Package>).map((item) => Package.fromJson(item.toJson())).toList(),
      notes: (json['notes'] as List).map((item) => item.toString()).toList(),
      emailId: json['emailid'],
      phoneNo: json['phoneno'],
      ccEmail: json['ccemail'],
      date: json['date'],
      quotationGenId: json['quotationgenid'],
      messageType: json['messagetype'],
      gstPercent: json['gstpercent'],
      gstNumber: json['gst_number'],
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyid': companyid,
      'processid': processId,
      'clientaddressname': clientAddressName,
      'clientaddress': clientAddress,
      'billingaddress': billingAddress,
      'billingaddressname': billingAddressName,
      'packagedetails': packageDetails.map((pkg) => pkg.toJson()).toList(),
      'notes': notes,
      'emailid': emailId,
      'phoneno': phoneNo,
      'ccemail': ccEmail,
      'date': date,
      'quotationgenid': quotationGenId,
      'messagetype': messageType,
      'gstpercent': gstPercent,
      'gst_number': gstNumber,
      'feedback': feedback,
    };
  }
}

// class PackageDetails {
//   final String name;
//   final String description;
//   final int cameracount ;
//   final int amount;
//   final String subscriptionType;
//   final List<Site> sites;
//   final String subscriptionId;

//   PackageDetails({
//     required this.name,
//     required this.description,
//     required this.cameracount ,
//     required this.amount,
//     required this.subscriptionType,
//     required this.sites,
//     required this.subscriptionId,
//   });

//   factory PackageDetails.fromJson(Map<String, dynamic> json) {
//     return PackageDetails(
//       name: json['name'],
//       description: json['description'],
//       cameracount : json['cameracount'],
//       amount: json['amount'],
//       subscriptionType: json['subscriptiontype'],
//       sites: (json['sites'] as List).map((s) => Site.fromJson(s)).toList(),
//       subscriptionId: json['subscriptionid'].toString(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'description': description,
//       'cameracount': cameracount ,
//       'amount': amount,
//       'subscriptiontype': subscriptionType,
//       'sites': sites.map((s) => s.toJson()).toList(),
//       'subscriptionid': subscriptionId,
//     };
//   }
// }

// class Site {
//   final String siteName;
//   final int cameraQuantity;
//   final String siteAddress;

//   Site({
//     required this.siteName,
//     required this.cameraQuantity,
//     required this.siteAddress,
//   });

//   factory Site.fromJson(Map<String, dynamic> json) {
//     return Site(
//       siteName: json['sitename'],
//       cameraQuantity: json['cameraquantity'],
//       siteAddress: json['siteaddress'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'sitename': siteName,
//       'cameraquantity': cameraQuantity,
//       'siteaddress': siteAddress,
//     };
//   }
// }
