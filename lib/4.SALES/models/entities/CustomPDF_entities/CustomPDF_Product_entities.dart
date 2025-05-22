import 'dart:convert';

import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

class CustomPDF_InvoiceProduct {
  String sNo;
  String description;
  String hsn;
  String gst;
  String price;
  String quantity;
  String total;

  CustomPDF_InvoiceProduct({
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
  factory CustomPDF_InvoiceProduct.fromJson(Map<String, dynamic> json) {
    return CustomPDF_InvoiceProduct(
      sNo: json['sNo'] ?? '',
      description: json['description'] ?? '',
      hsn: json['hsn'] ?? '',
      gst: json['gst'] ?? '',
      price: json['price'] ?? '',
      quantity: json['quantity'] ?? '',
      total: json['total'] ?? '',
    );
  }

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

  static String encode(List<CustomPDF_InvoiceProduct> products) => json.encode(
        products.map<Map<String, dynamic>>((product) => product.toJson()).toList(),
      );

  static List<CustomPDF_InvoiceProduct> decode(String productsJson) =>
      (json.decode(productsJson) as List<dynamic>).map<CustomPDF_InvoiceProduct>((item) => CustomPDF_InvoiceProduct.fromJson(item)).toList();
}

class Post_CustomInvoice {
  // String? title;
  // int? processid;
  String? ClientAddressname;
  String? ClientAddress;
  String? emailId;
  String? phoneNo;
  String? gst;
  String? billingAddressName;
  String? billingAddress;
  // List<CustomPDF_InvoiceProduct>? product;
  // List notes;
  String? date;
  String? invoiceGenID;
  int? messageType;
  String? feedback;
  String? ccEmail;
  double? total_amount;

  Post_CustomInvoice({
    required this.ClientAddressname,
    required this.ClientAddress,
    required this.billingAddressName,
    required this.billingAddress,
    required this.emailId,
    required this.phoneNo,
    required this.gst,
    required this.date,
    required this.invoiceGenID,
    required this.messageType,
    required this.feedback,
    required this.ccEmail,
    required this.total_amount,
  });

  factory Post_CustomInvoice.fromJson({
    // required String title,
    // required int processid,
    required String ClientAddressname,
    required String ClientAddress,
    required String billingAddressName,
    required String billingAddress,
    required String emailId,
    required String phoneNo,
    required String gst,
    // required List<CustomPDF_InvoiceProduct> product,
    // required List notes,
    required String date,
    required String invoiceGenID,
    required int messageType,
    required String feedback,
    required String ccEmail,
    required double total_amount,
  }) {
    return Post_CustomInvoice(
        ClientAddressname: ClientAddressname,
        ClientAddress: ClientAddress,
        billingAddressName: billingAddressName,
        billingAddress: billingAddress,
        emailId: emailId,
        phoneNo: phoneNo,
        gst: gst,
        date: date,
        invoiceGenID: invoiceGenID,
        messageType: messageType,
        feedback: feedback,
        ccEmail: ccEmail,
        total_amount: total_amount);
  }

  Map<String, dynamic> toJson() {
    return {
      "clientaddressname": ClientAddressname,
      "clientaddress": ClientAddress,
      "billingaddressname": billingAddressName,
      "billingaddress": billingAddress,
      "emailid": emailId,
      "phoneno": phoneNo,
      "gst_number": gst,
      "date": date,
      "invoicegenid": invoiceGenID,
      "messagetype": messageType,
      "feedback": feedback,
      "ccemail": ccEmail,
      "invoice_amount": total_amount
    };
  }
}

class CustomPDF_DcProduct {
  String sNo;
  String description;
  String hsn;
  // String gst;
  // String price;
  String quantity;
  // String total;

  CustomPDF_DcProduct({
    required this.sNo,
    required this.description,
    required this.hsn,
    // required this.gst,
    // required this.price,
    required this.quantity,
    // required this.total,
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
        return quantity.toString();
      // case 4:
      //   return formatCurrency(double.parse(price));
      // case 5:
      //   return quantity.toString();
      // case 6:
      //   return formatCurrency(double.parse(total));
      default:
        return '';
    }
  }

  // Convert JSON (Map<String, dynamic>) to Product Object
  factory CustomPDF_DcProduct.fromJson(Map<String, dynamic> json) {
    return CustomPDF_DcProduct(
      sNo: json['sNo'] ?? '',
      description: json['description'] ?? '',
      hsn: json['hsn'] ?? '',
      // gst: json['gst'] ?? '',
      // price: json['price'] ?? '',
      quantity: json['quantity'] ?? '',
      // total: json['total'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sNo': sNo,
      'description': description,
      'hsn': hsn,
      // 'gst': gst,
      // 'price': price,
      'quantity': quantity,
      // 'total': total,
    };
  }

  static String encode(List<CustomPDF_DcProduct> products) => json.encode(
        products.map<Map<String, dynamic>>((product) => product.toJson()).toList(),
      );

  static List<CustomPDF_DcProduct> decode(String productsJson) => (json.decode(productsJson) as List<dynamic>).map<CustomPDF_DcProduct>((item) => CustomPDF_DcProduct.fromJson(item)).toList();
}

class Post_CustomDc {
  // String? title;
  // int? processid;
  String? ClientAddressname;
  String? ClientAddress;
  String? emailId;
  String? phoneNo;
  String? gst;
  String? billingAddressName;
  String? billingAddress;
  // List<CustomPDF_DcProduct>? product;
  // List notes;
  String? date;
  String? DcGenID;
  int? messageType;
  String? feedback;
  String? ccEmail;

  Post_CustomDc({
    required this.ClientAddressname,
    required this.ClientAddress,
    required this.billingAddressName,
    required this.billingAddress,
    required this.emailId,
    required this.phoneNo,
    required this.gst,
    required this.date,
    required this.DcGenID,
    required this.messageType,
    required this.feedback,
    required this.ccEmail,
  });

  factory Post_CustomDc.fromJson({
    // required String title,
    // required int processid,
    required String ClientAddressname,
    required String ClientAddress,
    required String billingAddressName,
    required String billingAddress,
    required String emailId,
    required String phoneNo,
    required String gst,
    // required List<CustomPDF_DcProduct> product,
    // required List notes,
    required String date,
    required String DcGenID,
    required int messageType,
    required String feedback,
    required String ccEmail,
  }) {
    return Post_CustomDc(
      ClientAddressname: ClientAddressname,
      ClientAddress: ClientAddress,
      billingAddressName: billingAddressName,
      billingAddress: billingAddress,
      emailId: emailId,
      phoneNo: phoneNo,
      gst: gst,
      date: date,
      DcGenID: DcGenID,
      messageType: messageType,
      feedback: feedback,
      ccEmail: ccEmail,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "clientaddressname": ClientAddressname,
      "clientaddress": ClientAddress,
      "billingaddressname": billingAddressName,
      "billingaddress": billingAddress,
      "emailid": emailId,
      "phoneno": phoneNo,
      "gst_number": gst,
      "date": date,
      "dcgenid": DcGenID,
      "messagetype": messageType,
      "feedback": feedback,
      "ccemail": ccEmail,
    };
  }
}

class CustomPDF_QuoteProduct {
  String sNo;
  String description;
  String hsn;
  String gst;
  String price;
  String quantity;
  String total;

  CustomPDF_QuoteProduct({
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
  factory CustomPDF_QuoteProduct.fromJson(Map<String, dynamic> json) {
    return CustomPDF_QuoteProduct(
      sNo: json['sNo'] ?? '',
      description: json['description'] ?? '',
      hsn: json['hsn'] ?? '',
      gst: json['gst'] ?? '',
      price: json['price'] ?? '',
      quantity: json['quantity'] ?? '',
      total: json['total'] ?? '',
    );
  }

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

  static String encode(List<CustomPDF_QuoteProduct> products) => json.encode(
        products.map<Map<String, dynamic>>((product) => product.toJson()).toList(),
      );

  static List<CustomPDF_QuoteProduct> decode(String productsJson) => (json.decode(productsJson) as List<dynamic>).map<CustomPDF_QuoteProduct>((item) => CustomPDF_QuoteProduct.fromJson(item)).toList();
}

class Post_CustomQuote {
  // String? title;
  // int? processid;
  String? ClientAddressname;
  String? ClientAddress;
  String? emailId;
  String? phoneNo;
  String? gst;
  String? billingAddressName;
  String? billingAddress;
  // List<CustomPDF_QuoteProduct>? product;
  // List notes;
  String? date;
  String? QuoteGenID;
  int? messageType;
  String? feedback;
  String? ccEmail;
  double? total_amount;

  Post_CustomQuote({
    required this.ClientAddressname,
    required this.ClientAddress,
    required this.billingAddressName,
    required this.billingAddress,
    required this.emailId,
    required this.phoneNo,
    required this.gst,
    required this.date,
    required this.QuoteGenID,
    required this.messageType,
    required this.feedback,
    required this.ccEmail,
    required this.total_amount,
  });

  factory Post_CustomQuote.fromJson({
    // required String title,
    // required int processid,
    required String ClientAddressname,
    required String ClientAddress,
    required String billingAddressName,
    required String billingAddress,
    required String emailId,
    required String phoneNo,
    required String gst,
    // required List<CustomPDF_QuoteProduct> product,
    // required List notes,
    required String date,
    required String QuoteGenID,
    required int messageType,
    required String feedback,
    required String ccEmail,
    required double total_amount,
  }) {
    return Post_CustomQuote(
        ClientAddressname: ClientAddressname,
        ClientAddress: ClientAddress,
        billingAddressName: billingAddressName,
        billingAddress: billingAddress,
        emailId: emailId,
        phoneNo: phoneNo,
        gst: gst,
        date: date,
        QuoteGenID: QuoteGenID,
        messageType: messageType,
        feedback: feedback,
        ccEmail: ccEmail,
        total_amount: total_amount);
  }

  Map<String, dynamic> toJson() {
    return {
      "clientaddressname": ClientAddressname,
      "clientaddress": ClientAddress,
      "billingaddressname": billingAddressName,
      "billingaddress": billingAddress,
      "emailid": emailId,
      "phoneno": phoneNo,
      "gst_number": gst,
      "date": date,
      "quotationgenid": QuoteGenID,
      "messagetype": messageType,
      "feedback": feedback,
      "ccemail": ccEmail,
      "Quote_amount": total_amount
    };
  }
}
