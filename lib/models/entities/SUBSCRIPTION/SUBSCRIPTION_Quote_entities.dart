import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Sites_entities.dart';

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

class SUBSCRIPTION_QuotePost_Quotation {
  String? title;
  int? processid;
  String? ClientAddressname;
  String? ClientAddress;
  String? emailId;
  String? phoneNo;
  String? gst;
  String? billingAddressName;
  String? billingAddress;
  String? modeOfRequest;
  String? morReference;
  List<SUBSCRIPTION_QuoteSite>? site;
  List? notes;
  String? date;
  String? quotationGenID;
  int? messageType;
  String? feedback;
  String? ccEmail;

  SUBSCRIPTION_QuotePost_Quotation({
    required this.title,
    required this.processid,
    required this.ClientAddressname,
    required this.ClientAddress,
    required this.billingAddressName,
    required this.billingAddress,
    required this.emailId,
    required this.phoneNo,
    required this.gst,
    required this.date,
    required this.site,
    required this.notes,
    required this.quotationGenID,
    required this.messageType,
    required this.feedback,
    required this.ccEmail,
  });

  factory SUBSCRIPTION_QuotePost_Quotation.fromJson({
    required String title,
    required int processid,
    required String ClientAddressname,
    required String ClientAddress,
    required String billingAddressName,
    required String billingAddress,
    required String emailId,
    required String phoneNo,
    required String gst,
    required List<SUBSCRIPTION_QuoteSite> site,
    required List notes,
    required String date,
    required String quotationGenID,
    required int messageType,
    required String feedback,
    required String ccEmail,
  }) {
    return SUBSCRIPTION_QuotePost_Quotation(
        title: title,
        processid: processid,
        ClientAddressname: ClientAddressname,
        ClientAddress: ClientAddress,
        billingAddressName: billingAddressName,
        billingAddress: billingAddress,
        emailId: emailId,
        phoneNo: phoneNo,
        gst: gst,
        site: site,
        notes: notes,
        date: date,
        quotationGenID: quotationGenID,
        messageType: messageType,
        feedback: feedback,
        ccEmail: ccEmail);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "processid": processid,
      "clientaddressname": ClientAddressname,
      "clientaddress": ClientAddress,
      "billingaddressname": billingAddressName,
      "billingaddress": billingAddress,
      "emailid": emailId,
      "phoneno": phoneNo,
      "gst": gst,
      "site": site?.map((item) => item.toJson()).toList(),
      "notes": notes,
      "date": date,
      "quotationgenid": quotationGenID,
      "messagetype": messageType,
      "feedback": feedback,
      "ccemail": ccEmail,
    };
  }
}
