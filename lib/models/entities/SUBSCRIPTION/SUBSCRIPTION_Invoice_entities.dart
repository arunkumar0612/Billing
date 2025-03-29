import 'package:ssipl_billing/models/entities/Response_entities.dart';
import 'package:ssipl_billing/models/entities/SUBSCRIPTION/SUBSCRIPTION_Sites_entities.dart';

class SUBSCRIPTION_invoiceRecommendation {
  final String key;
  final String value;

  SUBSCRIPTION_invoiceRecommendation({
    required this.key,
    required this.value,
  });

  factory SUBSCRIPTION_invoiceRecommendation.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_invoiceRecommendation(
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
// class SUBSCRIPTION_invoiceInvoiceGSTtotals {
//   final double gst;
//   final double total;

//   SUBSCRIPTION_invoiceInvoiceGSTtotals({
//     required this.gst,
//     required this.total,
//   });

//   factory SUBSCRIPTION_invoiceInvoiceGSTtotals.fromJson(Map<String, dynamic> json) {
//     return SUBSCRIPTION_invoiceInvoiceGSTtotals(gst: json['GST'], total: json['total']);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'GST': gst,
//       'total': total,
//     };
//   }
// }

class SUBSCRIPTION_invoiceRequiredData {
  final String eventnumber;
  final String? title;
  final String? name;
  final String? emailId;
  final String? phoneNo;
  final String? address;
  final String? gst;
  final String? billingAddressName;
  final String? billingAddress;
  final List<SUBSCRIPTION_InvoiceSite> site;
  SUBSCRIPTION_invoiceRequiredData(
      {required this.eventnumber,
      required this.title,
      required this.name,
      required this.emailId,
      required this.phoneNo,
      required this.address,
      required this.gst,
      required this.billingAddressName,
      required this.billingAddress,
      required this.site});

  factory SUBSCRIPTION_invoiceRequiredData.fromJson(CMDmResponse json) {
    return SUBSCRIPTION_invoiceRequiredData(
      eventnumber: json.data['eventnumber'] as String,
      title: json.data['title'] as String,
      name: json.data['client_addressname'] as String,
      emailId: json.data['emailid'] as String,
      phoneNo: json.data['contact_number'] as String,
      address: json.data['client_address'] as String,
      gst: json.data['gstnumber'] as String,
      billingAddressName: json.data['billingaddress_name'] as String,
      billingAddress: json.data['billing_address'] as String,
      site: (json.data['site'] as List<dynamic>)
          .map((e) => SUBSCRIPTION_InvoiceSite.fromJson(e)) // ✅ Convert each item to InvoiceSite
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ID': eventnumber,
    };
  }
}

class SUBSCRIPTION_invoicePost_Invoice {
  String? title;
  int? processid;
  String? ClientAddressname;
  String? ClientAddress;
  String? emailId;
  String? phoneNo;
  String? gst;
  String? billingAddressName;
  String? billingAddress;
  List<SUBSCRIPTION_InvoiceSite>? site;
  List notes;
  String? date;
  String? invoiceGenID;
  int? messageType;
  String? feedback;
  String? ccEmail;
  double? total_amount;

  SUBSCRIPTION_invoicePost_Invoice({
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
    required this.invoiceGenID,
    required this.messageType,
    required this.feedback,
    required this.ccEmail,
    required this.total_amount,
  });

  factory SUBSCRIPTION_invoicePost_Invoice.fromJson({
    required String title,
    required int processid,
    required String ClientAddressname,
    required String ClientAddress,
    required String billingAddressName,
    required String billingAddress,
    required String emailId,
    required String phoneNo,
    required String gst,
    required List<SUBSCRIPTION_InvoiceSite> site,
    required List notes,
    required String date,
    required String invoiceGenID,
    required int messageType,
    required String feedback,
    required String ccEmail,
    required double total_amount,
  }) {
    return SUBSCRIPTION_invoicePost_Invoice(
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
        invoiceGenID: invoiceGenID,
        messageType: messageType,
        feedback: feedback,
        ccEmail: ccEmail,
        total_amount: total_amount);
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
      "gst_number": gst,
      "site": site?.map((item) => item.toJson()).toList(),
      "notes": notes,
      "date": date,
      "invoicegenid": invoiceGenID,
      "messagetype": messageType,
      "feedback": feedback,
      "ccemail": ccEmail,
      "invoice_amount": total_amount
    };
  }
}

class SUBSCRIPTION_invoiceSiteSuggestion {
  final String siteName;
  final String siteHsn;
  final double sitePrice;
  final double siteGst;

  SUBSCRIPTION_invoiceSiteSuggestion({
    required this.siteName,
    required this.siteHsn,
    required this.sitePrice,
    required this.siteGst,
  });

  /// Factory method to convert JSON to Site object
  factory SUBSCRIPTION_invoiceSiteSuggestion.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_invoiceSiteSuggestion(
      siteName: json['site_name'] as String,
      siteHsn: json['site_hsn'].toString(), // Ensure String type
      sitePrice: (json['site_price'] as num).toDouble(),
      siteGst: (json['site_gst'] as num).toDouble(),
    );
  }

  /// Method to convert Site object to JSON
  Map<String, dynamic> toJson() {
    return {
      'site_name': siteName,
      'site_hsn': siteHsn,
      'site_price': sitePrice,
      'site_gst': siteGst,
    };
  }
}
