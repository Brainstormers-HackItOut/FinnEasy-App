import 'dart:convert';

import 'package:finneasy/src/models/model_utilities.dart';


class Stock {
  Stock({
    this.companyCode,
    this.companyName,
    this.id,
    this.quantity,
    this.stockPrice,
    this.type,
    this.userId,
    this.reward,
  });

  factory Stock.fromJson(Map<String, dynamic> jsonRes) => Stock(
    companyCode: asT<String?>(jsonRes['companyCode']),
    companyName: asT<String?>(jsonRes['companyName']),
    id: asT<int?>(jsonRes['id']),
    quantity: asT<int?>(jsonRes['quantity']),
    stockPrice: asT<String?>(jsonRes['stockPrice']),
    type: asT<String?>(jsonRes['type']),
    userId: asT<int?>(jsonRes['userId']),
    reward: asT<int?>(jsonRes['reward']),
  );

  String? companyCode;
  String? companyName;
  int? id;
  int? quantity;
  String? stockPrice;
  String? type;
  int? userId;
  int? reward;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'companyCode': companyCode,
    'companyName': companyName,
    'id': id,
    'quantity': quantity,
    'stockPrice': stockPrice,
    'type': type,
    'userId': userId,
    'reward': reward,
  };
}