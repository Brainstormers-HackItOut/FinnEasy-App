// Dart imports:
import 'dart:convert';

// Project imports:
import '../model_utilities.dart';

class LoginResponse {
  LoginResponse({
    this.token,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> jsonRes) => LoginResponse(
    token: asT<String?>(jsonRes['token']),
    message: asT<String?>(jsonRes['message']),
  );

  String? token;
  String? message;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'token': token,
    'message': message,
  };
}
