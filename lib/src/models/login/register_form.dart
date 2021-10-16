// Dart imports:
import 'dart:convert';

// Project imports:
import '../model_utilities.dart';

class RegisterForm {
  RegisterForm({
    this.password,
    this.emailId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.referralCode
  });

  factory RegisterForm.fromJson(Map<String, dynamic> jsonRes) => RegisterForm(
    password: asT<String?>(jsonRes['password']),
    emailId: asT<String?>(jsonRes['emailId']),
    phoneNumber: asT<String?>(jsonRes['phoneNumber']),
    firstName: asT<String?>(jsonRes['firstName']),
    lastName: asT<String?>(jsonRes['lastName']),
    referralCode: asT<String?>(jsonRes['referralCode']),
  );

  String? password;
  String? emailId;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? referralCode;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'password': password,
    'emailId': emailId,
    'phoneNumber': phoneNumber,
    'firstName': firstName,
    'lastName': lastName,
    'referralCode': referralCode,
  };
}
