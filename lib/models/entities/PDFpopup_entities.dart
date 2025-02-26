import 'dart:convert';

class ManualProduct {
  String sNo;
  String description;
  String hsn;
  String gst;
  String price;
  String quantity;
  String total;

  ManualProduct({
    required this.sNo,
    required this.description,
    required this.hsn,
    required this.gst,
    required this.price,
    required this.quantity,
    required this.total,
  });

  // Convert JSON (Map<String, dynamic>) to Product Object
  factory ManualProduct.fromJson(Map<String, dynamic> json) {
    return ManualProduct(
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
  static String encode(List<ManualProduct> products) => json.encode(
        products.map<Map<String, dynamic>>((product) => product.toJson()).toList(),
      );

  // Decode a JSON string into a List of Products
  static List<ManualProduct> decode(String productsJson) => (json.decode(productsJson) as List<dynamic>).map<ManualProduct>((item) => ManualProduct.fromJson(item)).toList();
}
