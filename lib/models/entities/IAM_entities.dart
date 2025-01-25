class Login_Response {
  final bool code;
  final String? message;
  final int? userId;
  final String? sessionToken;

  Login_Response({
    required this.code,
    this.message,
    this.userId,
    this.sessionToken,
  });

  factory Login_Response.fromJson(Map<String, dynamic> json) {
    return Login_Response(
      code: json['code'] as bool,
      message: json['message'] as String?,
      userId: json['userid'] as int?,
      sessionToken: json['SESSIONTOKEN'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'userid': userId,
      'SESSIONTOKEN': sessionToken,
    };
  }
}
