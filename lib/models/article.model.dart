// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'package:hive/hive.dart';
import 'dart:convert';

part 'article.model.g.dart';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class Article {
  @HiveField(1)
  final Source source;
  @HiveField(2)
  final String author;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String url;
  @HiveField(6)
  final String urlToImage;
  @HiveField(7)
  final DateTime publishedAt;
  @HiveField(8)
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Article copyWith({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) =>
      Article(
        source: source ?? this.source,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        url: json["url"] ?? "",
        urlToImage: json["urlToImage"] ?? "",
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson() ,
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

@HiveType(typeId: 2)
class Source {
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  Source copyWith({
    String? id,
    String? name,
  }) =>
      Source(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
