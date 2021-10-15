import 'dart:convert';

import 'package:finneasy/src/models/model_utilities.dart';

class FinNews {
  FinNews({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory FinNews.fromJson(Map<String, dynamic> jsonRes) {
    final List<Articles>? articles =
    jsonRes['articles'] is List ? <Articles>[] : null;
    if (articles != null) {
      for (final dynamic item in jsonRes['articles']!) {
        if (item != null) {
          articles.add(Articles.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return FinNews(
      status: asT<String?>(jsonRes['status']),
      totalResults: asT<int?>(jsonRes['totalResults']),
      articles: articles,
    );
  }

  String? status;
  int? totalResults;
  List<Articles>? articles;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'status': status,
    'totalResults': totalResults,
    'articles': articles,
  };
}

class Articles {
  Articles({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Articles.fromJson(Map<String, dynamic> jsonRes) => Articles(
    source: jsonRes['source'] == null
        ? null
        : Source.fromJson(asT<Map<String, dynamic>>(jsonRes['source'])!),
    author: asT<String?>(jsonRes['author']),
    title: asT<String?>(jsonRes['title']),
    description: asT<String?>(jsonRes['description']),
    url: asT<String?>(jsonRes['url']),
    urlToImage: asT<String?>(jsonRes['urlToImage']),
    publishedAt: asT<String?>(jsonRes['publishedAt']),
    content: asT<String?>(jsonRes['content']),
  );

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'source': source,
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'publishedAt': publishedAt,
    'content': content,
  };
}

class Source {
  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> jsonRes) => Source(
    id: asT<Object?>(jsonRes['id']),
    name: asT<String?>(jsonRes['name']),
  );

  Object? id;
  String? name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
  };
}
