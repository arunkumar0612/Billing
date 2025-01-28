class Product {
  const Product(
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
