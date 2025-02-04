class GetCustomerListResponse {
  final bool code;
  final String? message;
  final List<Customer> customers;

  GetCustomerListResponse({
    required this.code,
    this.message,
    required this.customers,
  });

  factory GetCustomerListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['Value'] as List<dynamic>? ?? [];
    List<Customer> customers = list.map((e) => Customer.fromJson(e)).toList();

    return GetCustomerListResponse(
      code: json['code'] as bool,
      message: json['message'] as String?,
      customers: customers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'Value': customers.map((e) => e.toJson()).toList(),
    };
  }
}

class Customer {
  final int customerId;
  final String customerName;

  Customer({required this.customerId, required this.customerName});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['Customer_id'] as int,
      customerName: json['customer_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Customer_id': customerId,
      'customer_name': customerName,
    };
  }
}
