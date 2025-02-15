import 'package:ssipl_billing/models/entities/Response_entities.dart';

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

class Note {
  final String notename;

  Note({required this.notename});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      notename: json['notename'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notename': notename,
    };
  }
}

class QuoteGSTtotals {
  final double gst;
  final double total;

  QuoteGSTtotals({
    required this.gst,
    required this.total,
  });

  factory QuoteGSTtotals.fromJson(Map<String, dynamic> json) {
    return QuoteGSTtotals(gst: json['GST'], total: json['total']);
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
  final String? title;
  final String? name;
  final String? emailId;
  final String? phoneNo;
  final String? address;
  final String? gst;
  final String? billingAddressName;
  final String? billingAddress;
  RequiredData({
    required this.eventnumber,
    required this.title,
    required this.name,
    required this.emailId,
    required this.phoneNo,
    required this.address,
    required this.gst,
    required this.billingAddressName,
    required this.billingAddress,
  });

  factory RequiredData.fromJson(CMDmResponse json) {
    return RequiredData(
      eventnumber: json.data['eventnumber'] as String,
      title: json.data['title'] as String,
      name: json.data['client_addressname'] as String,
      emailId: json.data['emailid'] as String,
      phoneNo: json.data['contact_number'] as String,
      address: json.data['client_address'] as String,
      gst: json.data['gstnumber'] as String,
      billingAddressName: json.data['billingaddress_name'] as String,
      billingAddress: json.data['billing_address'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ID': eventnumber,
    };
  }
}
