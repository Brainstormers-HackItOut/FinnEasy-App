// Dart imports:
import 'dart:convert';

// Project imports:
import '../model_utilities.dart';

class User {
  User({
    this.id,
    this.emailId,
    this.firstName,
    this.lastName,
    this.password,
    this.phoneNumber,
    this.totalRewards,
  });

  factory User.fromJson(Map<String, dynamic> jsonRes) => User(
    id: asT<int?>(jsonRes['id']),
    emailId: asT<String?>(jsonRes['emailId']),
    firstName: asT<String?>(jsonRes['firstName']),
    lastName: asT<String?>(jsonRes['lastName']),
    password: asT<String?>(jsonRes['password']),
    phoneNumber: asT<String?>(jsonRes['phoneNumber']),
    totalRewards: asT<int?>(jsonRes['totalRewards']),
  );

  int? id;
  String? emailId;
  String? firstName;
  String? lastName;
  String? password;
  String? phoneNumber;
  int? totalRewards;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'emailId': emailId,
    'firstName': firstName,
    'id': id,
    'lastName': lastName,
    'password': password,
    'phoneNumber': phoneNumber,
    'totalRewards': totalRewards,
  };
}
