// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> profileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  String model;
  int pk;
  Fields fields;

  Profile({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
  int user;
  String name;
  String city;
  String favGenre;
  List<int> favoriteBooks;

  Fields({
    required this.user,
    required this.name,
    required this.city,
    required this.favGenre,
    required this.favoriteBooks,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        city: json["city"],
        favGenre: json["fav_genre"],
        favoriteBooks: List<int>.from(json["favorite_books"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "city": city,
        "fav_genre": favGenre,
        "favorite_books": List<dynamic>.from(favoriteBooks.map((x) => x)),
      };
}
