import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Sites_entities.dart';
import 'package:ssipl_billing/utils/helpers/support_functions.dart';

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

class SUBSCRIPTION_QuoteGSTtotals {
  final double gst;
  final double total;

  SUBSCRIPTION_QuoteGSTtotals({
    required this.gst,
    required this.total,
  });

  factory SUBSCRIPTION_QuoteGSTtotals.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_QuoteGSTtotals(gst: json['GST'], total: json['total']);
  }

  Map<String, dynamic> toJson() {
    return {
      'GST': gst,
      'total': total,
    };
  }
}

class SubscriptionQuoteRequiredData {
  final String eventNumber;
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
  List<SUBSCRIPTION_QuoteSite>? sitelist;
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
      sitelist: (json["sitelist"] as List?)?.map((item) => SUBSCRIPTION_QuoteSite.fromJson(item)).toList(),
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
  final Address addressDetails;

  final List<Site> siteData;
  final FinalCalculation finalCalc;
  final List<String> notes;
  SUBSCRIPTION_Quote({
    required this.date,
    required this.quoteNo,
    required this.gstPercent,
    required this.addressDetails,
    required this.siteData,
    required this.finalCalc,
    required this.notes,
  });

  // Convert JSON to Invoice object
  factory SUBSCRIPTION_Quote.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_Quote(
      date: json['date'] as String,
      quoteNo: json['quoteNo'] as String,
      gstPercent: json['gstPercent'] as int,
      addressDetails: Address.fromJson(json['addressDetails']),
      siteData: Site.fromJson(List<Map<String, dynamic>>.from(json['siteData'])),
      finalCalc: FinalCalculation.fromJson(Site.fromJson(List<Map<String, dynamic>>.from(json['siteData'])), json['gstPercent'] as int),
      notes: ['This is a sample note', 'This is another sample note'],
    );
  }

  // Convert Invoice object to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'invoiceNo': quoteNo,
      'gstPercent': gstPercent,
      'siteData': Site.toJsonList(siteData), // Corrected Site List Serialization
      'finalCalc': finalCalc.toJson(),
      'addressDetails': addressDetails.toJson(),
      'notes': notes,
    };
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

class Site {
  static int _counter = 1; // Static counter to auto-increment serial numbers
  String serialNo;
  String siteName;
  String address;
  String packageName;
  int camCount;
  int basicPrice;
  int specialPrice;

  Site({required this.siteName, required this.address, required this.packageName, required this.camCount, required this.basicPrice, required this.specialPrice})
      : serialNo = (_counter++).toString(); // Auto-increment serial number

  // Convert List of JSON Maps to List of Site objects
  static List<Site> fromJson(List<Map<String, dynamic>> jsonList) {
    _counter = 1; // Reset counter before parsing a new list

    return jsonList.map((json) {
      return Site(
        siteName: json['siteName'] as String, // Fix key casing
        address: json['address'] as String,
        packageName: json['packageName'] as String,
        camCount: json['camCount'] as int,
        basicPrice: json['basicPrice'] as int,
        specialPrice: json['specialPrice'] as int,
      );
    }).toList();
  }

  // Convert List of Site objects to JSON List
  static List<Map<String, dynamic>> toJsonList(List<Site> sites) {
    return sites.map((site) => site.toJson()).toList();
  }

  // Convert single Site object to JSON
  Map<String, dynamic> toJson() {
    return {'serialNo': serialNo, 'siteName': siteName, 'address': address, 'packageName': packageName, "camCount": camCount, 'basicPrice': basicPrice, 'specialPrice': specialPrice};
  }

  dynamic getIndex(int col) {
    switch (col) {
      case 0:
        return serialNo;
      case 1:
        return packageName;
      case 2:
        return siteName;
      case 3:
        return address;
      case 4:
        return camCount.toString();
      case 5:
        return basicPrice.toString();
      case 6:
        return specialPrice.toString();
      default:
        return "";
    }
  }
}

class FinalCalculation {
  final double subtotal;
  final double cgst;
  final double sgst;
  final String roundOff;
  final String differene;
  final double total;
  // final double? pendingAmount;
  final double grandTotal;

  FinalCalculation({
    required this.subtotal,
    required this.cgst,
    required this.sgst,
    required this.roundOff,
    required this.differene,
    required this.total,
    // required this.pendingAmount,
    required this.grandTotal,
  });

  factory FinalCalculation.fromJson(List<Site> sites, int gstPercent) {
    double subtotal = sites.fold(0.0, (sum, site) => sum + site.specialPrice);
    double cgst = (subtotal * (gstPercent / 2)) / 100;
    double sgst = (subtotal * (gstPercent / 2)) / 100;
    double total = subtotal + cgst + sgst;
    double grandTotal = total;

    return FinalCalculation(
      subtotal: subtotal,
      cgst: cgst,
      sgst: sgst,
      roundOff: formatCurrencyRoundedPaisa(total),
      differene:
          '${((double.parse(formatCurrencyRoundedPaisa(total).replaceAll(',', '')) - total) >= 0 ? '+' : '')}${(double.parse(formatCurrencyRoundedPaisa(total).replaceAll(',', '')) - total).toStringAsFixed(2)}',
      total: total,
      // pendingAmount: pendingAmount,
      grandTotal: grandTotal,
    );
  }

  Map<String, dynamic> toJson() {
    return {'subtotal': subtotal, 'CGST': cgst, 'SGST': sgst, 'roundOff': roundOff, 'difference': differene, 'total': total, 'grandTotal': grandTotal};
  }
}
