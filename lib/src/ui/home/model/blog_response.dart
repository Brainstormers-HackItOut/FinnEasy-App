import 'dart:convert';

import 'package:finneasy/src/models/model_utilities.dart';

class BlogResponse {
  BlogResponse({
    this.body,
    this.dislikes,
    this.id,
    this.likes,
    this.publishedDate,
    this.publisher,
    this.title,
    this.userId,
  });

  factory BlogResponse.fromJson(Map<String, dynamic> jsonRes) => BlogResponse(
    body: asT<String?>(jsonRes['body']),
    dislikes: asT<int?>(jsonRes['dislikes']),
    id: asT<int?>(jsonRes['id']),
    likes: asT<int?>(jsonRes['likes']),
    publishedDate: asT<String?>(jsonRes['publishedDate']),
    publisher: asT<String?>(jsonRes['publisher']),
    title: asT<String?>(jsonRes['title']),
    userId: asT<int?>(jsonRes['userId']),
  );

  String? body;
  int? dislikes;
  int? id;
  int? likes;
  String? publishedDate;
  String? publisher;
  String? title;
  int? userId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'body': body,
    'dislikes': dislikes,
    'id': id,
    'likes': likes,
    'publishedDate': publishedDate,
    'publisher': publisher,
    'title': title,
    'userId': userId,
  };
}
