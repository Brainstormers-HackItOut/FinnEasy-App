// Dart imports:
import 'dart:convert';

// Project imports:
import '../model_utilities.dart';

class LoginForm {
  LoginForm({
    required this.phoneNumber,
    required this.password,
  });

  factory LoginForm.fromJson(Map<String, dynamic> jsonRes) => LoginForm(
    phoneNumber: asT<String>(jsonRes['phoneNumber'])!,
    password: asT<String>(jsonRes['password'])!,
  );

  String phoneNumber;
  String password;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'phoneNumber': phoneNumber,
    'password': password,
  };

  LoginForm clone() =>
      LoginForm.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}