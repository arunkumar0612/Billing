import '../../../utils/helpers/support_functions.dart';

class DcProduct {
  final int sno;
  final String productName;
  final int hsn;
  final double gst;
  final double price;
  final int quantity;
  final int productid;
  const DcProduct({
    required this.sno,
    required this.productName,
    required this.hsn,
    required this.gst,
    required this.price,
    required this.quantity,
    required this.productid,
  });

  /// Calculates the total price for the product
  double get total => price * quantity;

  /// Returns specific values based on the given index
  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno.toString();
      case 1:
        return productName;
      case 2:
        return hsn.toString();
      case 3:
        return gst.toString();
      case 4:
        return formatCurrency(price);
      case 5:
        return quantity.toString();
      case 6:
        return formatCurrency(total);
      case 7:
        return productid.toString();
      default:
        return '';
    }
  }

  /// Converts object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'productsno': sno,
      'productname': productName,
      'producthsn': hsn,
      'productgst': gst,
      'productprice': price,
      'productquantity': quantity,
      'producttotal': total,
      'productid': productid,
    };
  }

  /// Factory constructor to create an instance from JSON
  factory DcProduct.fromJson(Map<String, dynamic> json) {
    return DcProduct(
      sno: json['productsno'] as int,
      productName: json['productname'] as String,
      hsn: json['producthsn'] as int,
      gst: (json['productgst'] as num).toDouble(),
      price: (json['productprice'] as num).toDouble(),
      quantity: json['productquantity'] as int,
      productid: json['productid'] as int,
    );
  }
}

class QuoteProduct {
  final int sno;
  final String productName;
  final int hsn;
  final double gst;
  final double price;
  final int quantity;

  const QuoteProduct({
    required this.sno,
    required this.productName,
    required this.hsn,
    required this.gst,
    required this.price,
    required this.quantity,
  });

  /// Calculates the total price for the product
  double get total => price * quantity;

  /// Returns specific values based on the given index
  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno.toString();
      case 1:
        return productName;
      case 2:
        return hsn.toString();
      case 3:
        return gst.toString();
      case 4:
        return formatCurrency(price);
      case 5:
        return quantity.toString();
      case 6:
        return formatCurrency(total);
      default:
        return '';
    }
  }

  /// Converts object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'productsno': sno,
      'productname': productName,
      'producthsn': hsn,
      'productgst': gst,
      'productprice': price,
      'productquantity': quantity,
      'producttotal': total,
    };
  }

  /// Factory constructor to create an instance from JSON
  factory QuoteProduct.fromJson(Map<String, dynamic> json) {
    return QuoteProduct(
      sno: json['productsno'], // Ensure it's a String
      productName: json['productname'].toString(),
      hsn: json['producthsn'],
      gst: double.tryParse(json['productgst'].toString()) ?? 0.0, // Convert String to double
      price: double.tryParse(json['productprice'].toString()) ?? 0.0,
      quantity: int.tryParse(json['productquantity'].toString()) ?? 0, // Convert String to int
    );
  }
}

class RFQProduct {
  const RFQProduct(
    this.sno,
    this.productName,
    this.quantity,
  );

  final String sno;
  final String productName;

  final int quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno;
      case 1:
        return productName;
      case 2:
        return quantity.toString();
    }
    return '';
  }
}

class CreditProduct {
  const CreditProduct(
    this.sno,
    this.productName,
    this.hsn,
    this.gst,
    this.price,
    this.quantity,
    this.remarks,
  );

  final String sno;
  final String productName;
  final String hsn;
  final double gst;
  final double price;
  final int quantity;
  final String remarks;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno;
      case 1:
        return productName;
      case 2:
        return hsn;
      case 3:
        return gst.toString();
      case 4:
        return formatCurrency(price);
      case 5:
        return quantity.toString();
      case 6:
        return formatCurrency(total);
      case 7:
        return remarks;
    }
    return '';
  }
}

class DebitProduct {
  const DebitProduct(
    this.sno,
    this.productName,
    this.hsn,
    this.gst,
    this.price,
    this.quantity,
    this.remarks,
  );

  final String sno;
  final String productName;
  final String hsn;
  final double gst;
  final double price;
  final int quantity;
  final String remarks;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno;
      case 1:
        return productName;
      case 2:
        return hsn;
      case 3:
        return gst.toString();
      case 4:
        return formatCurrency(price);
      case 5:
        return quantity.toString();
      case 6:
        return formatCurrency(total);
      case 7:
        return remarks;
    }
    return '';
  }
}

class InvoiceProduct {
  final int sno;
  final String productName;
  final int hsn;
  final double gst;
  final double price;
  final int quantity;

  const InvoiceProduct({
    required this.sno,
    required this.productName,
    required this.hsn,
    required this.gst,
    required this.price,
    required this.quantity,
  });

  /// Calculates the total price for the product
  double get total => price * quantity;

  /// Returns specific values based on the given index
  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno.toString();
      case 1:
        return productName;
      case 2:
        return hsn.toString();
      case 3:
        return gst.toString();
      case 4:
        return formatCurrency(price);
      case 5:
        return quantity.toString();
      case 6:
        return formatCurrency(total);
      default:
        return '';
    }
  }

  /// Converts object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'productsno': sno,
      'productname': productName,
      'producthsn': hsn,
      'productgst': gst,
      'productprice': price,
      'productquantity': quantity,
      'producttotal': total,
    };
  }

  /// Factory constructor to create an instance from JSON
  factory InvoiceProduct.fromJson(Map<String, dynamic> json) {
    return InvoiceProduct(
      sno: json['productsno'] as int,
      productName: json['productname'] as String,
      hsn: json['producthsn'] as int,
      gst: (json['productgst'] as num).toDouble(),
      price: (json['productprice'] as num).toDouble(),
      quantity: json['productquantity'] as int,
    );
  }
}

class ClientreqProduct {
  const ClientreqProduct(
    this.sno,
    this.productName,
    this.quantity,
  );

  final String sno;
  final String productName;
  final int quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno;
      case 1:
        return productName;
      case 2:
        return quantity.toString();
    }
    return '';
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      "sno": sno,
      "productName": productName,
      "quantity": quantity,
    };
  }
}
