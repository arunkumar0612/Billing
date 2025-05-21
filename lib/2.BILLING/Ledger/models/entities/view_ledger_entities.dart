class CustomerInfo {
  final String customerId;
  final String customerName;
  final String customerPhoneNo;
  final String customerGstNo;

  CustomerInfo({
    required this.customerId,
    required this.customerName,
    required this.customerPhoneNo,
    required this.customerGstNo,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      customerId: json['customer_id'] ?? '',
      customerName: json['customer_name'] ?? '',
      customerPhoneNo: json['customer_phoneno'] ?? '',
      customerGstNo: json['customer_gstno'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_phoneno': customerPhoneNo,
      'customer_gstno': customerGstNo,
    };
  }
}
