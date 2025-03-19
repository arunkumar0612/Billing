import 'dart:convert';

import 'package:ssipl_billing/utils/helpers/support_functions.dart';

class Subscription_CustomPDF_Invoice {
  String sNo;
  String siteID;
  String sitename;
  String address;
  String monthlycharges;

  Subscription_CustomPDF_Invoice({
    required this.sNo,
    required this.siteID,
    required this.sitename,
    required this.address,
    required this.monthlycharges,
  });
  String getIndex(int index) {
    switch (index) {
      case 0:
        return sNo;
      case 1:
        return siteID;
      case 2:
        return sitename;
      case 3:
        return address.toString();
      case 4:
        return formatCurrency(double.parse(monthlycharges));
      default:
        return '';
    }
  }

  // Convert JSON (Map<String, dynamic>) to Product Object
  factory Subscription_CustomPDF_Invoice.fromJson(Map<String, dynamic> json) {
    return Subscription_CustomPDF_Invoice(
      sNo: json['sNo'] ?? '',
      siteID: json['siteID'] ?? '',
      sitename: json['sitename'] ?? '',
      address: json['address'] ?? '',
      monthlycharges: json['monthlycharges'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sNo': sNo,
      'siteID': siteID,
      'sitename': sitename,
      'address': address,
      'monthlycharges': monthlycharges,
    };
  }

  static String encode(List<Subscription_CustomPDF_Invoice> products) => json.encode(
        products.map<Map<String, dynamic>>((product) => product.toJson()).toList(),
      );

  static List<Subscription_CustomPDF_Invoice> decode(String productsJson) =>
      (json.decode(productsJson) as List<dynamic>).map<Subscription_CustomPDF_Invoice>((item) => Subscription_CustomPDF_Invoice.fromJson(item)).toList();
}
