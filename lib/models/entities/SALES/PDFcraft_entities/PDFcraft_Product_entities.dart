import 'dart:convert';

import 'package:ssipl_billing/utils/helpers/support_functions.dart';

class PDFcraft_InvoiceProduct {
  String sNo;
  String description;
  String hsn;
  String gst;
  String price;
  String quantity;
  String total;

  PDFcraft_InvoiceProduct({
    required this.sNo,
    required this.description,
    required this.hsn,
    required this.gst,
    required this.price,
    required this.quantity,
    required this.total,
  });
  String getIndex(int index) {
    switch (index) {
      case 0:
        return sNo;
      case 1:
        return description;
      case 2:
        return hsn.toString();
      case 3:
        return gst.toString();
      case 4:
        return formatCurrency(double.parse(price));
      case 5:
        return quantity.toString();
      case 6:
        return formatCurrency(double.parse(total));
      default:
        return '';
    }
  }

  // Convert JSON (Map<String, dynamic>) to Product Object
  factory PDFcraft_InvoiceProduct.fromJson(Map<String, dynamic> json) {
    return PDFcraft_InvoiceProduct(
      sNo: json['sNo'] ?? '',
      description: json['description'] ?? '',
      hsn: json['hsn'] ?? '',
      gst: json['gst'] ?? '',
      price: json['price'] ?? '',
      quantity: json['quantity'] ?? '',
      total: json['total'] ?? '',
    );
  }

  // Convert Product Object to JSON (Map<String, dynamic>)
  Map<String, dynamic> toJson() {
    return {
      'sNo': sNo,
      'description': description,
      'hsn': hsn,
      'gst': gst,
      'price': price,
      'quantity': quantity,
      'total': total,
    };
  }

  // Convert a List of Products to JSON
  static String encode(List<PDFcraft_InvoiceProduct> products) => json.encode(
        products.map<Map<String, dynamic>>((product) => product.toJson()).toList(),
      );

  // Decode a JSON string into a List of Products
  static List<PDFcraft_InvoiceProduct> decode(String productsJson) =>
      (json.decode(productsJson) as List<dynamic>).map<PDFcraft_InvoiceProduct>((item) => PDFcraft_InvoiceProduct.fromJson(item)).toList();
}
