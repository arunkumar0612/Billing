import '../../utils/helpers/support_functions.dart';

class DCProduct {
  const DCProduct(
    this.sno,
    this.productName,
    this.hsn,
    this.quantity,
  );

  final String sno;
  final String productName;
  final String hsn;
  final int quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno;
      case 1:
        return productName;
      case 2:
        return hsn;
      case 3:
        return quantity.toString();
    }
    return '';
  }
}

class QuoteProduct {
  const QuoteProduct(
    this.sno,
    this.productName,
    this.hsn,
    this.gst,
    this.price,
    this.quantity,
  );

  final String sno;
  final String productName;
  final String hsn;
  final double gst;
  final double price;
  final int quantity;
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
    }
    return '';
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
  const InvoiceProduct(
    this.sno,
    this.productName,
    this.hsn,
    this.gst,
    this.price,
    this.quantity,
  );

  final String sno;
  final String productName;
  final String hsn;
  final double gst;
  final double price;
  final int quantity;
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
    }
    return '';
  }
}
