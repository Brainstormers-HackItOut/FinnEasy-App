// Dart imports:
import 'dart:convert';

// Project imports:
import '../model_utilities.dart';

class User {
  User({
    this.id,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.emailId,
    this.referralCode,
    this.totalRewards,
    this.milestoneCounter,
    this.milestoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> jsonRes) => User(
    id: asT<int?>(jsonRes['id']),
    phoneNumber: asT<String?>(jsonRes['phoneNumber']),
    firstName: asT<String?>(jsonRes['firstName']),
    lastName: asT<String?>(jsonRes['lastName']),
    emailId: asT<String?>(jsonRes['emailId']),
    referralCode: asT<String?>(jsonRes['referralCode']),
    totalRewards: asT<int?>(jsonRes['totalRewards']),
    milestoneCounter: asT<int?>(jsonRes['milestoneCounter']),
    milestoneNumber: asT<int?>(jsonRes['milestoneNumber']),
  );

  int? id;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? emailId;
  String? referralCode;
  int? totalRewards;
  int? milestoneCounter;
  int? milestoneNumber;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'phoneNumber': phoneNumber,
    'firstName': firstName,
    'lastName': lastName,
    'emailId': emailId,
    'referralCode': referralCode,
    'totalRewards': totalRewards,
    'milestoneCounter': milestoneCounter,
    'milestoneNumber': milestoneNumber,
  };
}
