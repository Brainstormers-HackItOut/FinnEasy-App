// Dart imports:
import 'dart:convert';

// Project imports:
import '../model_utilities.dart';

class User {
  User({
    this.id,
    this.password,
    this.emailId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> jsonRes) => User(
    id: asT<int?>(jsonRes['id']),
    password: asT<String?>(jsonRes['password']),
    emailId: asT<String?>(jsonRes['emailId']),
    phoneNumber: asT<String?>(jsonRes['phoneNumber']),
    firstName: asT<String?>(jsonRes['firstName']),
    lastName: asT<String?>(jsonRes['lastName']),
  );

  int? id;
  String? password;
  String? emailId;
  String? phoneNumber;
  String? firstName;
  String? lastName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'password': password,
    'emailId': emailId,
    'phoneNumber': phoneNumber,
    'firstName': firstName,
    'lastName': lastName,
  };
}