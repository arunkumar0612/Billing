class Login_Request {
  String? username;
  String? password;

  Login_Request({this.username, this.password});

  factory Login_Request.fromJson(Map<String, dynamic> json) {
    return Login_Request(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
    };
  }
}

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

class Register_Request {
  String? name;
  String? emailid;
  String? phoneno;
  String? password;

  Register_Request({this.name, this.emailid, this.phoneno, this.password});

  factory Register_Request.fromJson(Map<String, dynamic> json) {
    return Register_Request(
      name: json['name'],
      emailid: json['emailid'],
      phoneno: json['phoneno'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "emailid": emailid,
      "phoneno": phoneno,
      "password": password,
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

class Forgotpassword_Request {
  String? username;

  Forgotpassword_Request({this.username});

  factory Forgotpassword_Request.fromJson(Map<String, dynamic> json) {
    return Forgotpassword_Request(
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
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

class VerifyOTP_Request {
  String? username;
  String? otp;

  VerifyOTP_Request({this.username, this.otp});

  factory VerifyOTP_Request.fromJson(Map<String, dynamic> json) {
    return VerifyOTP_Request(
      username: json['username'],
      otp: json['OTP'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "OTP": otp,
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

class NewPassword_Request {
  String? username;
  String? password;

  NewPassword_Request({this.username, this.password});

  factory NewPassword_Request.fromJson(Map<String, dynamic> json) {
    return NewPassword_Request(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
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
