class BasicResponse {
  final bool code;
  final String? message;
  final List<Map<String, dynamic>> data;

  BasicResponse({
    required this.code,
    this.message,
    required this.data,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List<dynamic>? ?? [];
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(list.map((e) => e as Map<String, dynamic>));

    return BasicResponse(
      code: json['code'] as bool,
      message: json['message'] as String?,
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'data': data};
  }
}
