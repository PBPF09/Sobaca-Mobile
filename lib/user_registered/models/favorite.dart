// To parse this JSON data, do
//
//     final favorite = favoriteFromJson(jsonString);

import 'dart:convert';

List<Favorite> favoriteFromJson(String str) =>
    List<Favorite>.from(json.decode(str).map((x) => Favorite.fromJson(x)));

String favoriteToJson(List<Favorite> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorite {
  String model;
  int pk;
  Fields fields;

  Favorite({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String isbn;
  String title;
  String categories;
  String author;
  int year;
  String publisher;
  String description;
  String images;

  Fields({
    required this.isbn,
    required this.title,
    required this.categories,
    required this.author,
    required this.year,
    required this.publisher,
    required this.description,
    required this.images,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn: json["isbn"],
        title: json["title"],
        categories: json["categories"],
        author: json["author"],
        year: json["year"],
        publisher: json["publisher"],
        description: json["description"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "isbn": isbn,
        "title": title,
        "categories": categories,
        "author": author,
        "year": year,
        "publisher": publisher,
        "description": description,
        "images": images,
      };
}
