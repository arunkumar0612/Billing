class CMResponse {
  final bool code;
  final String? message;

  CMResponse({
    required this.code,
    this.message,
  });

  factory CMResponse.fromJson(Map<String, dynamic> json) {
    return CMResponse(
      code: json['code'] as bool,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
}

class CMDmResponse {
  final bool code;
  final String? message;
  final Map<String, dynamic> data; // Ensures `data` is always a valid map

  CMDmResponse({
    required this.code,
    this.message,
    Map<String, dynamic>? data,
  }) : data = data ?? {}; // Defaults to an empty map if `null`

  factory CMDmResponse.fromJson(Map<String, dynamic> json) {
    return CMDmResponse(
      code: json['code'] as bool? ?? false, // Defaults to `false` if missing
      message: json['message'] as String?,
      data: json['data'] is Map<String, dynamic> ? json['data'] : {}, // Ensures `data` is a map
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'data': data};
  }
}

class CMDlResponse {
  final bool code;
  final String? message;
  final List<Map<String, dynamic>> data;

  CMDlResponse({
    required this.code,
    this.message,
    List<Map<String, dynamic>>? data,
  }) : data = data ?? []; // Ensure `data` is never null

  factory CMDlResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'];
    List<Map<String, dynamic>> parsedData = [];

    if (list is List) {
      parsedData = List<Map<String, dynamic>>.from(list.map((e) => e is Map<String, dynamic> ? e : {}));
    }

    return CMDlResponse(
      code: json['code'] as bool? ?? false, // Default to `false` if `code` is missing
      message: json['message'] as String?,
      data: parsedData,
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'data': data};
  }
}
