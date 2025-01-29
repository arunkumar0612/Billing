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

class Register_Response {
  final bool code;
  final String? message;

  Register_Response({
    required this.code,
    this.message,
  });

  factory Register_Response.fromJson(Map<String, dynamic> json) {
    return Register_Response(
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

class Forgotpassword_Response {
  final bool code;
  final String? message;

  Forgotpassword_Response({
    required this.code,
    this.message,
  });

  factory Forgotpassword_Response.fromJson(Map<String, dynamic> json) {
    return Forgotpassword_Response(
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

class VerifyOTP_Response {
  final bool code;
  final String? message;

  VerifyOTP_Response({
    required this.code,
    this.message,
  });

  factory VerifyOTP_Response.fromJson(Map<String, dynamic> json) {
    return VerifyOTP_Response(
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

class Newpassword_Response {
  final bool code;
  final String? message;

  Newpassword_Response({
    required this.code,
    this.message,
  });

  factory Newpassword_Response.fromJson(Map<String, dynamic> json) {
    return Newpassword_Response(
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
