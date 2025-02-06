import 'package:flutter/foundation.dart';

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
  final Map<String, dynamic> data;

  CMDmResponse({
    required this.code,
    this.message,
    required this.data,
  });

  factory CMDmResponse.fromJson(Map<String, dynamic> json) {
    // var map = json['data'] as Map<String, dynamic>? ?? {};
    // Map<String, dynamic> data = Map<String, dynamic>.from(map.map((e) => e as Map<String, dynamic>));
    if (kDebugMode) {
      print(json['data']);
    }

    return CMDmResponse(
      code: json['code'] as bool,
      message: json['message'] as String?,
      data: json['data'],
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
    required this.data,
  });

  factory CMDlResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List<dynamic>? ?? [];
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(list.map((e) => e as Map<String, dynamic>));
    if (kDebugMode) {
      print(data);
    }

    return CMDlResponse(
      code: json['code'] as bool,
      message: json['message'] as String?,
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'data': data};
  }
}
