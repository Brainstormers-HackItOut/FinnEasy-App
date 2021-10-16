import 'dart:convert';

import 'package:finneasy/src/models/model_utilities.dart';

class Reward {
  Reward({
    this.coins,
    this.description,
    this.id,
    this.imageUrl,
    this.milestoneNumber,
    this.title,
  });

  factory Reward.fromJson(Map<String, dynamic> jsonRes) => Reward(
    coins: asT<int?>(jsonRes['coins']),
    description: asT<String?>(jsonRes['description']),
    id: asT<int?>(jsonRes['id']),
    imageUrl: asT<String?>(jsonRes['image_url']),
    milestoneNumber: asT<int?>(jsonRes['milestoneNumber']),
    title: asT<String?>(jsonRes['title']),
  );

  int? coins;
  String? description;
  int? id;
  String? imageUrl;
  int? milestoneNumber;
  String? title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'coins': coins,
    'description': description,
    'id': id,
    'image_url': imageUrl,
    'milestoneNumber': milestoneNumber,
    'title': title,
  };
}
