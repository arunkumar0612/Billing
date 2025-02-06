import 'Response_entities.dart';

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

class LoginData {
  final int userid;
  final String SESSIONTOKEN;

  LoginData({
    required this.userid,
    required this.SESSIONTOKEN,
  });

  factory LoginData.fromJson(CMDmResponse json) {
    return LoginData(
      userid: json.data['userid'] as int,
      SESSIONTOKEN: json.data['SESSIONTOKEN'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'SESSIONTOKEN': SESSIONTOKEN,
    };
  }
}
