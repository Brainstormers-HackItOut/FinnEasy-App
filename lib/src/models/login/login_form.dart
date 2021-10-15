// Dart imports:
import 'dart:convert';

// Project imports:
import '../model_utilities.dart';

class LoginForm {
  LoginForm({
    required this.mobile,
    required this.password,
  });

  factory LoginForm.fromJson(Map<String, dynamic> jsonRes) => LoginForm(
    mobile: asT<String>(jsonRes['mobile'])!,
    password: asT<String>(jsonRes['password'])!,
  );

  String mobile;
  String password;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'mobile': mobile,
    'password': password,
  };

  LoginForm clone() =>
      LoginForm.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}