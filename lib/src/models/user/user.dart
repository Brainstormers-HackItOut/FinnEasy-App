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
    this.milestoneCounter,
    this.milestoneNumber,
    this.password,
    this.phoneNumber,
    this.totalRewards,
  });

  factory User.fromJson(Map<String, dynamic> jsonRes) => User(
    emailId: asT<String?>(jsonRes['emailId']),
    firstName: asT<String?>(jsonRes['firstName']),
    lastName: asT<String?>(jsonRes['lastName']),
    milestoneCounter: asT<int?>(jsonRes['milestoneCounter']),
    milestoneNumber: asT<int?>(jsonRes['milestoneNumber']),
    password: asT<String?>(jsonRes['password']),
    phoneNumber: asT<String?>(jsonRes['phoneNumber']),
    totalRewards: asT<int?>(jsonRes['totalRewards']),
    id: asT<int?>(jsonRes['id']),
  );

  String? emailId;
  String? firstName;
  String? lastName;
  int? milestoneCounter;
  int? milestoneNumber;
  String? password;
  String? phoneNumber;
  int? totalRewards;
  int? id;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'emailId': emailId,
    'firstName': firstName,
    'lastName': lastName,
    'id': id,
    'milestoneCounter': milestoneCounter,
    'milestoneNumber': milestoneNumber,
    'password': password,
    'phoneNumber': phoneNumber,
    'totalRewards': totalRewards,
  };
}
